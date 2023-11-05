echo "User Name: Lee yuchan"
echo "User Number: 12223778"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action gener movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified bt specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.item'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user.id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"
read -p "Enter your choice [1-9] " num
echo ""
case $num in
	1)	
		read -p "Please enter 'movie.id' (1~1682)" M_id
		echo ""
		cat u.item | awk -v id=$M_id -F '|' '$1==id {print $0}'
		echo ""
		;;
	2) 
		read -p "Do you want to get the data of 'action' gener movies from 'u.item'?(y/n):" reply  
		echo ""
		if [ "$reply" = "y" ]
		then
			cat u.item | awk '$7==1 -F '|' {print $1" "$2}' head -n 10
			echo""
		fi 
		;;
	3)
		read -p "please enter the 'movie id' (1~1682):" M_id
		echo ""
		cat u.data | awk -v id=$M_id '{print "average rating of "id": "}' | awk sum=(sum+=$3) '{printf "%.5f\n", sum}'
		echo ""
		;;
	4)
		read -p "Do you want to delete the 'IMDb URL' from 'u.item'?(y/n): " reply	
		echo ""
		if [ $reply = "y" ]
		then
			cat u.item | sed -nE '/imdb\.com/p' | head -n 10 
		fi	
		;;
	5)
		read -p "Do you want to get the data about users from 'u.user'?(y/n):" reply
		echo ""
		if [ "$reply" = "y" ]
		then
			cat u.user | '{print "user " $1 " is "$2 " years old "$3" "$4}' | head -n 10
			echo""
		fi
		;;
	6)
		read -p "Do you want to modify the format of 'release data' in 'u.item'?(y/n):" reply
		echo ""
		if [ "$reply" = "y" ]
		then
			awk '{ 
				split{$3, date, "-"); 
				day=date[1];
				month=date[2];
				year=date[3];
				months="janfebmaraprmayjunjulaugsepoctnovdec";
				month_num=index(months, month) / 3 + 1;
				printf("%s%02d$s$02d\n", year, month_num, day, $4);
			}' u.item | tail -n 10
			echo ""
			fi
			;;
	7)
		read -p "Please enter the 'user id'(1-943): U_id
		echo "" 
		awk -v id=$U_id -F "|" '$1 == id { print $2 }' u.data| head -n 10
		echo ""
	8)
		read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n):" reply
		if [ "$reply" = "y" ]
		then
		cat u.user | awk -F "|" age=$2 

			
		echo ""
		fi
		;;
	9)
		echo "Bye!"
		exit 0
		;;
	esac
	 
