From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Add some system information to alsa-info.sh
	output
Date: Tue, 01 Jul 2008 02:31:37 +1000
Message-ID: <1214843497.11032.4.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Faw1UXb9YdD09c8oexxf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-99-053.dial.usertools.net
	[202.137.99.53]) by alsa0.perex.cz (Postfix) with ESMTP id 75DD12437A
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jun 2008 18:31:32 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-Faw1UXb9YdD09c8oexxf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

First some information about this..
I was planning on using dmidecode to fetch this information, but that
required 1) the script be run as root, and 2) requires the user to have
dmidecode installed (most people wouldnt). So we fetch from /sys/ (if
available).

Patch attached.

Changelog: Fetch the board_vendor, product_version and product_name from
DMI in /sys/ (if available). Increased alsa-info.sh version to 0.4.49.

Signed-off-by: Travis Place <wishie@wishie.net>


--=-Faw1UXb9YdD09c8oexxf
Content-Disposition: attachment; filename=alsa-info.sh-0.4.49.patch
Content-Type: text/x-patch; name=alsa-info.sh-0.4.49.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-info.sh	2008-06-17 02:53:27.000000000 +1000
+++ alsa-info.sh.wishie	2008-07-01 02:25:46.000000000 +1000
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-SCRIPT_VERSION=0.4.48
+SCRIPT_VERSION=0.4.49
 CHANGELOG="http://www.alsa-project.org/alsa-info.sh.changelog"
 
 #################################################################################
@@ -288,6 +288,12 @@
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>/tmp/alsainfo/alsamodules.tmp
 cat /proc/asound/cards >/tmp/alsainfo/alsacards.tmp
 lspci |grep -i "multi\|audio">/tmp/alsainfo/lspci.tmp
+if [ -d $SYSFS ]
+then
+BOARD_VENDOR=`cat /sys/devices/virtual/dmi/id/board_vendor`
+PRODUCT_VERSION=`cat /sys/devices/virtual/dmi/id/product_version`
+PRODUCT_NAME=`cat /sys/devices/virtual/dmi/id/product_name`
+fi
 
 #Check for HDA-Intel cards codec#*
 cat /proc/asound/card*/codec\#* > /tmp/alsainfo/alsa-hda-intel.tmp 2> /dev/null
@@ -311,6 +317,15 @@
 echo $DISTRO >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+if [ -d $SYSFS ]
+then
+echo "!!Hardware Information" >> $FILE
+echo "!!--------------------" >> $FILE
+echo "Board Vendor:		$BOARD_VENDOR" >> $FILE
+echo "Product:		$PRODUCT_VERSION ($PRODUCT_NAME)" >> $FILE
+echo "" >> $FILE
+echo "" >> $FILE
+fi
 echo "!!Kernel Information" >> $FILE
 echo "!!------------------" >> $FILE
 echo "" >> $FILE

--=-Faw1UXb9YdD09c8oexxf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-Faw1UXb9YdD09c8oexxf--
