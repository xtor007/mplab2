fun is_older (date1:int*int*int, date2:int*int*int) =
  if (#1 date2) > (#1 date1)
    then true
    else if (#1 date1) > (#1 date2)
      then false
      else if (#2 date2) > (#2 date1)
        then true
        else if (#2 date1) > (#2 date2)
          then false
          else if (#3 date2) > (#3 date1)
            then true
            else false;

fun number_in_month (datas:(int*int*int) list, month:int) =
  if null datas
    then 0
    else if #2 (hd datas) = month
      then number_in_month(tl datas, month) + 1
      else number_in_month(tl datas, month);

fun number_in_months (datas:(int*int*int) list, months:int list) = 
  if null months
    then 0
    else number_in_months(datas, tl months)+number_in_month(datas, hd months);

fun dates_in_month (datas:(int*int*int) list, month:int) =
  if null datas
    then []
    else (#1 (hd datas), month, #3 (hd datas)) :: dates_in_month(tl datas, month);

fun dates_in_months (datas:(int*int*int) list, months:int list) =
  if null months
    then []
    else dates_in_month(datas,hd months) :: dates_in_months(datas,tl months);

fun get_nth_dop (lines:string list, n:int, i:int) =
  if n=i
    then lines
    else if null (tl lines)
      then lines
      else get_nth_dop(tl lines, n, i+1);

fun get_nth (lines:string list, n:int) = (hd (get_nth_dop(lines, n, 1)));

fun date_to_string (date:int*int*int) = get_nth(["January ","February ","March ","April ","May ","June ","July ","August ","September ","October ","November ","December "],#2 date)^Int.toString(#3 date)^","^Int.toString(#1 date);

fun sum_list (xs : int list) =
  if null xs
    then 0
    else hd(xs) + sum_list(tl xs);

fun append (xs : int list, ys : int list) =
   if null xs
    then ys
    else (hd xs) :: append(tl xs, ys);

fun find_n (sum:int, left: int list, right: int list, n:int) = 
  if (sum_list(left) < sum)
    then find_n(sum,append(left,[(hd right)]),(tl right),(n+1))
    else n-1;

fun number_before_reaching_sum (sum:int, data:int list) = find_n(sum,[(hd data)],(tl data),1);

fun what_month(day:int) = number_before_reaching_sum(day,[31,28,31,30,31,30,31,31,30,31,30,31])+1;

fun month_range(day1:int, day2:int) =
  if day1>day2
    then []
    else what_month(day1)::month_range(day1+1,day2);

fun find_max_date(dates:(int*int*int) list,max:int*int*int) =
  if null dates
    then max
    else if is_older((hd dates),max)
      then find_max_date((tl dates),(hd dates))
      else find_max_date((tl dates),max);

fun find_older(dates:(int*int*int) list) =
  if null dates
    then NONE
    else SOME (find_max_date((tl dates),(hd dates)));