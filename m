From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] alsa-info.sh: add command-line flag to print
	alsa info to stdout
Date: Mon, 30 Mar 2009 11:03:44 +1100
Message-ID: <1238371425-6762-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl2.internode.on.net (ipmail05.adl2.internode.on.net
	[203.16.214.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A2451037F5
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Mar 2009 02:03:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Luke Yelavich <themuso@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Add the --stdout command-line flag to allow displaying the collected alsa
information directly to standard output. This is useful for bug information
collecting systems, such as Ubuntu's apport.

Signed-off-by: Luke Yelavich <themuso@ubuntu.com>
---
 utils/alsa-info.sh |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index b62c4d5..8340019 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -250,6 +250,12 @@ case "$1" in
 		REPEAT=""
 		shift
 		;;
+	--stdout)
+		DIALOG=""
+		NOUPLOAD="yes"
+		QUESTION="no"
+		TOSTDOUT="yes"
+		;;
 esac
 done
 		
@@ -596,6 +602,17 @@ then
 				fi
 			fi
 			;;
+		--stdout)
+			NOUPLOAD="yes"
+			withdevices
+			withconfigs
+			withaplay
+			withamixer
+			withalsactl
+			withlsmod
+			cat $FILE
+			rm $FILE
+			;;
 		--about)
 			echo "Written/Tested by the following users of #alsa on irc.freenode.net:"
 			echo ""
@@ -604,6 +621,7 @@ then
 			echo "	gnubien - Various script ideas / Testing"
 			echo "	GrueMaster - HDA Intel specific items / Testing"
 			echo "	olegfink - Script update function"
+			echo "  TheMuso - display to stdout functionality"
 			exit 0
 			;;
 		*)
@@ -621,6 +639,8 @@ then
 			echo "	--no-upload (do not upload contents to remote server)"
 			echo "	--pastebin (use http://pastebin.ca) as remote server"
 			echo "	    instead www.alsa-project.org"
+			echo "  --stdout (print alsa information to standard output"
+			echo "      instead of a file)"
 			echo "	--about (show some information about the script)"
 			echo "	--debug (will run the script as normal, but will not"
 			echo "	     delete $FILE)"
@@ -637,7 +657,9 @@ fi
 
 if [ -n "$NOUPLOAD" ]; then
 
-	mv $FILE $NFILE || exit 1
+	if [ -z "$TOSTDOUT" ]; then
+		mv $FILE $NFILE || exit 1
+	fi
 
 	if [[ -n $DIALOG ]]
 	then
@@ -655,10 +677,12 @@ if [ -n "$NOUPLOAD" ]; then
 			echo "Your ALSA information can be seen by looking in $NFILE"
 			echo ""
 		else
-			echo "You requested that your information was NOT automatically uploaded to the $WWWSERVICE"
-			echo ""
-			echo "Your ALSA information can be seen by looking in $NFILE"
-			echo ""
+			if [ -z "$TOSTDOUT" ]; then
+				echo "You requested that your information was NOT automatically uploaded to the $WWWSERVICE"
+				echo ""
+				echo "Your ALSA information can be seen by looking in $NFILE"
+				echo ""
+			fi
 		fi
 	fi
 
-- 
1.6.0.4
