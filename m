From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/4] alsa-info.sh: Do not automatically upload
	alsa info
Date: Wed, 08 Jul 2009 21:07:23 +0800
Message-ID: <20090708131503.905317376@intel.com>
References: <20090708130722.723912338@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B2141038AD
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 15:16:39 +0200 (CEST)
Content-Disposition: inline; filename=alsa-ask-upload.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

- the greeting dialog informs that the script collects info, waits
  for OK button. It affords a concrete listing of information to collect:
  /proc/asound/, aplay, etc. This not only shows respect for user privacy,
  but also serves as basic debugging tips for ALSA newbies.
- when --upload option is given, the data will be automatically uploaded.
- when --no-upload option is given, the data is just stored locally and quit.
- when neither options are given, show a dialog to ask to upload or not.

The above ideas mostly come from Takashi.

CC: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 utils/alsa-info.sh |  115 +++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 52 deletions(-)

--- alsa-driver.orig/utils/alsa-info.sh
+++ alsa-driver/utils/alsa-info.sh
@@ -36,10 +36,12 @@ PASTEBINKEY="C9cRIO8m/9y8Cs0nVs0FraRx7U0
 #Define some simple functions
 
 pbcheck(){
+	[[ $UPLOAD = "no" ]] && return
+
 	if [[ -z $PASTEBIN ]]; then
-		[[ $(ping -c1 www.alsa-project.org) ]] || KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes"
+		[[ $(ping -c1 www.alsa-project.org) ]] || KEEP_FILES="yes" UPLOAD="no" PBERROR="yes"
 	else
-		[[ $(ping -c1 www.pastebin.ca) ]] || KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes"
+		[[ $(ping -c1 www.pastebin.ca) ]] || KEEP_FILES="yes" UPLOAD="no" PBERROR="yes"
 	fi
 }
 
@@ -289,18 +291,24 @@ SNDOPTIONS=$(modprobe -c|sed -n 's/^opti
 
 PASTEBIN=""
 WWWSERVICE="www.alsa-project.org"
-QUESTION="yes"
+WELCOME="yes"
 PROCEED="yes"
+UPLOAD="ask"
 REPEAT=""
 while [ -z "$REPEAT" ]; do
 REPEAT="no"
 case "$1" in
 	--update|--help|--about)
-		QUESTION="no"
+		WELCOME="no"
 		PROCEED="no"
 		;;
+	--upload)
+		UPLOAD="yes"
+		WELCOME="no"
+		;;
 	--no-upload)
-		NOUPLOAD="yes"
+		UPLOAD="no"
+		WELCOME="no"
 		;;
 	--pastebin)
 		PASTEBIN="yes"
@@ -313,28 +321,18 @@ case "$1" in
 		;;
 	--stdout)
 		DIALOG=""
-		NOUPLOAD="yes"
-		QUESTION="no"
+		UPLOAD="no"
+		WELCOME="no"
 		TOSTDOUT="yes"
 		;;
 esac
 done
-		
+
 
 #Script header output.
-if [ "$QUESTION" = "yes" ]; then
-if [[ -n "$DIALOG" ]]
-then
-if [ -z "$NOUPLOAD" ]; then
-	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v $SCRIPT_VERSION" --yesno "\nThis script will collect information about your ALSA installation and sound related hardware, to help diagnose your problem\n\nBy default, this script will AUTOMATICALLY UPLOAD your information to a $WWWSERVICE site.\n\nSee $0 --help for options\n\nDo you want to run this script?" 0 0
-else
-	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v $SCRIPT_VERSION" --yesno "\nThis script will collect information about your ALSA installation and sound related hardware, to help diagnose your problem\n\nSee $0 --help for options\n\nDo you want to run this script?" 0 0
-fi
-DIALOG_EXIT_CODE=$?
-if [ $DIALOG_EXIT_CODE != 0 ]; then
-echo "Thank you for using the ALSA-Info Script"
-exit 0;
-fi
+if [ "$WELCOME" = "yes" ]; then
+if [[ -n "$DIALOG" ]]; then
+	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v $SCRIPT_VERSION" --msgbox "\nThis script visits the following commands/files to collect diagnostic information about your ALSA installation and sound related hardware.\n\n  lspci\n  lsmod\n  aplay\n  amixer\n  alsactl\n  /proc/asound/\n  /sys/class/sound/\n  ~/.asoundrc (etc.)\n\nSee '$0 --help' for command line options.\n" 20 80
 else
 
 echo "ALSA Information Script v $SCRIPT_VERSION"
@@ -342,27 +340,8 @@ echo "--------------------------------"
 echo ""
 echo "This script will collect information about your ALSA installation and sound related hardware, to help diagnose your problem."
 echo ""
-if [ -z "$NOUPLOAD" ]; then
-if [[ -n "$TPUT" ]]; then
-tput bold
-echo "By default, the collected information will be AUTOMATICALLY uploaded to a $WWWSERVICE site."
-echo "If you do not wish for this to occur, run the script with the --no-upload argument"
-tput sgr0
-else
-echo "By default, the collected information will be AUTOMATICALLY uploaded to a $WWWSERVICE site."
-echo "If you do not wish for this to occur, run the script with the --no-upload argument"
-fi
-echo ""
-fi # NOUPLOAD
-echo -n "Do you want to run this script? [y/n] : "
-read -e CONFIRM
-if [ "$CONFIRM" != "y" ]; then
-echo ""
-echo "Thank you for using the ALSA-Info Script"
-exit 0;
-fi
-fi
-fi # question
+fi # dialog
+fi # WELCOME
 
 #Set the output file
 TEMPDIR=`mktemp -p /tmp -d alsa-info.XXXXXXXXXX`
@@ -609,8 +588,18 @@ then
 			update
 			exit
 			;;
+		--upload)
+			UPLOAD="yes"
+			withdevices
+			withconfigs
+			withaplay
+			withamixer
+			withalsactl
+			withlsmod
+			withsysfs
+			;;
 		--no-upload)
-			NOUPLOAD="yes"
+			UPLOAD="no"
 			withdevices
 			withconfigs
 			withaplay
@@ -681,7 +670,7 @@ then
 			fi
 			;;
 		--stdout)
-			NOUPLOAD="yes"
+			UPLOAD="no"
 			withdevices
 			withconfigs
 			withaplay
@@ -714,6 +703,7 @@ then
 			echo "	--with-devices (shows the device nodes in /dev/snd/)"
 			echo ""
 			echo "	--update (check server for script updates)"
+			echo "	--upload (upload contents to remote server)"
 			echo "	--no-upload (do not upload contents to remote server)"
 			echo "	--pastebin (use http://pastebin.ca) as remote server"
 			echo "	    instead www.alsa-project.org"
@@ -733,7 +723,28 @@ if [ "$PROCEED" = "no" ]; then
 	exit 1
 fi
 
-if [ -n "$NOUPLOAD" ]; then
+if [ "$UPLOAD" = "ask" ]; then
+	if [[ -n "$DIALOG" ]]; then
+		dialog --backtitle "$BGTITLE" --title "Information collected" --yes-label " UPLOAD / SHARE " --no-label " SAVE LOCALLY " --defaultno --yesno "\n\nAutomatically upload ALSA information to $WWWSERVICE?" 10 80
+		DIALOG_EXIT_CODE=$?
+		if [ $DIALOG_EXIT_CODE != 0 ]; then
+			UPLOAD="no"
+		else
+			UPLOAD="yes"
+		fi
+	else
+		echo -n "Automatically upload ALSA information to $WWWSERVICE? [y/N] : "
+		read -e CONFIRM
+		if [ "$CONFIRM" != "y" ]; then
+			UPLOAD="no"
+		else
+			UPLOAD="yes"
+		fi
+	fi
+
+fi
+
+if [ "$UPLOAD" = "no" ]; then
 
 	if [ -z "$TOSTDOUT" ]; then
 		mv $FILE $NFILE || exit 1
@@ -742,23 +753,23 @@ if [ -n "$NOUPLOAD" ]; then
 	if [[ -n $DIALOG ]]
 	then
 		if [[ -n $PBERROR ]]; then
-			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "An error occurred while contacting the $WWWSERVICE. Your information was NOT automatically uploaded.\n\nYour ALSA information can be seen by looking in $NFILE" 10 100
+			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "An error occurred while contacting the $WWWSERVICE.\n Your information was NOT automatically uploaded.\n\nYour ALSA information is in $NFILE" 10 100
 		else
-			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "You requested that your information was NOT automatically uploaded to the $WWWSERVICE\n\nYour ALSA information can be seen by looking in $NFILE" 10 100
+			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "\n\nYour ALSA information is in $NFILE" 10 60
 		fi
 	else
 		echo
 
 		if [[ -n $PBERROR ]]; then
-			echo "An error occurred while contacting the $WWWSERVICE. Your information was NOT automatically uploaded."
+			echo "An error occurred while contacting the $WWWSERVICE."
+			echo "Your information was NOT automatically uploaded."
 			echo ""
-			echo "Your ALSA information can be seen by looking in $NFILE"
+			echo "Your ALSA information is in $NFILE"
 			echo ""
 		else
 			if [ -z "$TOSTDOUT" ]; then
-				echo "You requested that your information was NOT automatically uploaded to the $WWWSERVICE"
 				echo ""
-				echo "Your ALSA information can be seen by looking in $NFILE"
+				echo "Your ALSA information is in $NFILE"
 				echo ""
 			fi
 		fi
@@ -766,7 +777,7 @@ if [ -n "$NOUPLOAD" ]; then
 
 	exit
 
-fi # noupload
+fi # UPLOAD
 
 #Test that wget is installed, and supports --post-file. Upload $FILE if it does, and prompt user to upload file if it doesnt. 
 if

-- 
