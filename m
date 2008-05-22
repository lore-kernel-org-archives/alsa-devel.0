From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Patch for alsa-info.sh to check if pastebin.ca
	is down, and handle with grace.
Date: Fri, 23 May 2008 04:08:33 +1000
Message-ID: <200805230408.33303.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_habNIG4KCVIpnkg"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-089.dial.usertools.net [202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F4D5243F9
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 20:09:19 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 403355CAE4
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 18:30:22 +1000 (EST)
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
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_habNIG4KCVIpnkg
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog: This patch will allow alsa-info.sh to check if the pastebin site 
(www.pastebin.ca) is down, before trying to upload to it. It will fail 
gracefully, with a message letting the user know what happened. The script 
will also keep the ALSA information it collected (same way it does 
with --no-upload).

Patch is attached.

Signed-off-by: Travis Place <wishie at wishie dot net>



-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_habNIG4KCVIpnkg
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-info.sh-0.4.45.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info.sh-0.4.45.patch"

diff -r 2ea9a8a108ea alsa-info.sh
--- a/alsa-info.sh	Mon May 19 18:29:17 2008 +0200
+++ b/alsa-info.sh	Fri May 23 04:06:32 2008 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.44
+SCRIPT_VERSION=0.4.45
 CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
 
 #################################################################################
@@ -31,6 +31,10 @@ BGTITLE="ALSA-Info v $SCRIPT_VERSION"
 BGTITLE="ALSA-Info v $SCRIPT_VERSION"
 PASTEBINKEY="C9cRIO8m/9y8Cs0nVs0FraRx7U0pHsuc"
 #Define some simple functions
+
+pbcheck(){
+	[[ $(ping -c1 www.pastebin.ca) ]] || KEEP_FILES="yes" NOUPLOAD="yes" PBERROR="yes"
+}
 
 update() {
 	wget -O /tmp/alsa-info.sh http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh >/dev/null 2>&1
@@ -190,7 +194,6 @@ SNDOPTIONS=$(modprobe -c|sed -n 's/^opti
 
 QUESTION="yes"
 PROCEED="yes"
-NOUPLOAD=""
 REPEAT=""
 while [ -z "$REPEAT" ]; do
 REPEAT="no"
@@ -411,9 +414,7 @@ then
 	withamixer
 	withalsactl
 	withlsmod
-	#Workaround, while we sort out pastebin location, since pastebin.ca blocked us.
-	#NOUPLOAD="yes"
-	
+	pbcheck	
 fi
 
 fi # proceed
@@ -457,17 +458,6 @@ then
 			withalsactl
 			withlsmod
 			;;
-		#### FIX ME
-		--secure)
-			withdevices
-			withconfigs
-			withaplay
-			withamixer
-			withalsactl
-			withlsmod
-			withsecure
-			;;
-		###########
 		--with-aplay)
 			withaplay
 			;;
@@ -598,7 +588,11 @@ if [[ -n $DIALOG ]]
 if [[ -n $DIALOG ]]
 then
 	if [[ -n $NOUPLOAD ]]; then
-		dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "You requested that your information was NOT automatically uploaded to the pastebin\n\nYour ALSA information can be seen by looking in $FILE" 10 100
+		if [[ -n $PBERROR ]]; then
+			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "An error occured while contacting the pastebin. Your information was NOT automatically uploaded.\n\nYour ALSA information can be seen by looking in $FILE" 10 100
+		else
+			dialog --backtitle "$BGTITLE" --title "Information collected" --msgbox "You requested that your information was NOT automatically uploaded to the pastebin\n\nYour ALSA information can be seen by looking in $FILE" 10 100
+		fi
 	else
 		dialog --backtitle "$BGTITLE" --title "Information uploaded" --yesno "Would you like to see the uploaded information?" 5 100 
 		DIALOG_EXIT_CODE=$?
@@ -610,10 +604,17 @@ fi
 fi 
 clear
 if [[ -n $NOUPLOAD ]]; then
-	echo "You requested that your information was NOT automatically uploaded to the pastebin"
-	echo ""
-	echo "Your ALSA information can be seen by looking in $FILE"
-	echo ""
+	if [[ -n $PBERROR ]]; then
+		echo "An error occured while contacting the pastebin. Your information was NOT automatically uploaded."
+		echo ""
+		echo "Your ALSA information can be seen by looking in $FILE"
+		echo ""
+	else
+		echo "You requested that your information was NOT automatically uploaded to the pastebin"
+		echo ""
+		echo "Your ALSA information can be seen by looking in $FILE"
+		echo ""
+	fi
 fi
 if [[ -z $NOUPLOAD ]]; then
 echo "Your ALSA information is located at $FINAL_URL"

--Boundary-00=_habNIG4KCVIpnkg
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_habNIG4KCVIpnkg--
