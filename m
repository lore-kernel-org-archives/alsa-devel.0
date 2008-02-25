From: Travis Place <wishie@wishie.net>
Subject: Patch for alsa-info.sh
Date: Mon, 25 Feb 2008 15:18:10 +1000
Message-ID: <200802251518.10693.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 27C6524519
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 06:18:18 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 9E1AE4B89C
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 05:39:34 +1000 (EST)
Content-Disposition: inline
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

The below patch should stop alsa-info.sh from running amixer on cards that 
dont exist (ie, if the user has no card0, but has a card1)
I realise its a generally a rare case, and cards are _usually_ consecutive, 
but we might aswell cover all bases if we can.


diff -r 7907cfbab11c alsa-info.sh
--- a/alsa-info.sh	Mon Feb 18 12:13:23 2008 +0100
+++ b/alsa-info.sh	Mon Feb 25 15:16:16 2008 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.37
+SCRIPT_VERSION=0.4.38
 CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
 
 
#################################################################################
@@ -98,7 +98,7 @@ withamixer() {
         echo "!!Amixer output" >> $FILE
         echo "!!-------------" >> $FILE
         echo "" >> $FILE
-        for i in `seq 0 $LAST_CARD`;do
+	for i in `grep "]: " /proc/asound/cards | awk -F ' ' '{ print $1} '` ; do
 	CARD_NAME=`grep "^ $i" /tmp/alsainfo/alsacards.tmp|awk {'print $2'}`
 	echo "!!-------Mixer controls for card $i $CARD_NAME]" >> $FILE
 	echo "" >>$FILE



-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
