From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: [PATCH/RFC] alsa-info: add DMI data to the alsa-info
	output
Date: Sun, 31 May 2009 22:36:37 +0300
Message-ID: <4A22DC45.6000008@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (ns2.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 232151037F0
	for <alsa-devel@alsa-project.org>;
	Sun, 31 May 2009 21:36:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a working but not a clean/good patch for doing that because I'm
not very good at shell scripting but I'm posting it just to give a
possible idea.

dmidecode should be run as root because it reads /dev/mem. If alsa-info
is run as root, providing at least the system-manufacturer and
system-product-name in the output will be very useful for distro
maintainers.

Thanks,
Ozan Caglayan

Index: alsa-info.sh
===================================================================
--- alsa-info.sh        (revision 69253)
+++ alsa-info.sh        (working copy)
@@ -361,6 +361,18 @@
 ARTSINST=$(which artsd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)
 JACKINST=$(which jackd 2>/dev/null| sed 's|^[^/]*||' 2>/dev/null)

+DMIDECODE=$(which dmidecode)
+DMI_SYSTEM_MANUFACTURER="Not provided"
+DMI_SYSTEM_PRODUCT_NAME="Not provided"
+
+if [ -f $DMIDECODE ]; then
+    $DMIDECODE -q &> /dev/null
+    if [ x$? != "x1" ]; then
+        DMI_SYSTEM_MANUFACTURER=$($DMIDECODE -s system-manufacturer)
+        DMI_SYSTEM_PRODUCT_NAME=$($DMIDECODE -s system-product-name)
+    fi
+fi
+
 cat /proc/asound/modules 2>/dev/null|awk {'print
$2'}>$TEMPDIR/alsamodules.tmp
 cat /proc/asound/cards >$TEMPDIR/alsacards.tmp
 lspci |grep -i "multi\|audio">$TEMPDIR/lspci.tmp
@@ -391,6 +403,13 @@
 echo $DISTRO >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+echo "!!DMI Information" >> $FILE
+echo "!!---------------" >> $FILE
+echo "" >> $FILE
+echo "Manufacturer:      $DMI_SYSTEM_MANUFACTURER" >> $FILE
+echo "Product Name:      $DMI_SYSTEM_PRODUCT_NAME" >> $FILE
+echo "" >> $FILE
+echo "" >> $FILE
 echo "!!Kernel Information" >> $FILE
 echo "!!------------------" >> $FILE
 echo "" >> $FILE
