From: Travis Place <wishie@wishie.net>
Subject: Patch for alsa-info.sh - AC97 including regs
Date: Tue, 26 Feb 2008 02:05:50 +1000
Message-ID: <200802260205.50530.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eduwHMvOKAjfbRs"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F3E9243EA
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 17:05:58 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 86ADC4B89C
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 16:27:18 +1000 (EST)
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

--Boundary-00=_eduwHMvOKAjfbRs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Ok, ive added the +regs file aswell, but decided to store its output in a 
seperate tmp file (before being added to the complete output).

This way, we can change how its output if we'd like, with less stuffing around 
(and all tmp files are cleaned up after each run, anyway).


-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_eduwHMvOKAjfbRs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-info-ac97+regs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info-ac97+regs.diff"

diff -r 93cc5f0a20f1 alsa-info.sh
--- a/alsa-info.sh	Mon Feb 25 13:07:07 2008 +0100
+++ b/alsa-info.sh	Tue Feb 26 02:04:28 2008 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.38
+SCRIPT_VERSION=0.4.39
 CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
 
 #################################################################################
@@ -270,6 +270,10 @@ lspci |grep -i "multi\|audio">/tmp/alsai
 #Check for HDA-Intel cards codec#*
 cat /proc/asound/card*/codec\#* > /tmp/alsainfo/alsa-hda-intel.tmp 2> /dev/null
 
+#Check for AC97 cards codec
+cat /proc/asound/card*/codec97\#0/ac97\#0-0 > /tmp/alsainfo/alsa-ac97.tmp 2> /dev/null
+cat /proc/asound/card*/codec97\#0/ac97\#0-0+regs > /tmp/alsainfo/alsa-ac97-regs.tmp 2> /dev/null
+
 #Fetch the info, and put it in $FILE in a nice readable format.
 echo "name=$USER&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=" > $FILE
 echo "!!################################" >> $FILE
@@ -362,6 +366,21 @@ then
 	echo "" >> $FILE
 	echo "" >> $FILE
 fi
+
+if [ -s "/tmp/alsainfo/alsa-ac97.tmp" ]
+then
+        echo "!!AC97 Codec information" >> $FILE
+        echo "!!---------------------------" >> $FILE
+        echo "--startcollapse--" >> $FILE
+        echo "" >> $FILE
+        cat /tmp/alsainfo/alsa-ac97.tmp >> $FILE
+        echo "" >> $FILE
+        cat /tmp/alsainfo/alsa-ac97-regs.tmp >> $FILE
+        echo "--endcollapse--" >> $FILE
+	echo "" >> $FILE
+	echo "" >> $FILE
+fi
+
 
 #If no command line options are specified, then run as though --with-all was specified
 if [[ -z "$1" ]]

--Boundary-00=_eduwHMvOKAjfbRs
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_eduwHMvOKAjfbRs--
