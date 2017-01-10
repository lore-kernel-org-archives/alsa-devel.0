From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 2/2] alsa-info: add ACPI device status
Date: Mon,  9 Jan 2017 18:32:24 -0600
Message-ID: <1484008344-8262-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1484008344-8262-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 431A6267041
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 01:32:31 +0100 (CET)
In-Reply-To: <1484008344-8262-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

BIOS vendors typically reuse the same definitions between different
platforms and expose the relevant hardware by changing the value of
the _STA method.

For example on the Asus T100HA, there are 3 HID values for audio
codecs in the DSDT table but two have a zero status and will be
ignored by the ACPI subsystem.

$ more /sys/bus/acpi/devices/10EC*/status
::::::::::::::
/sys/bus/acpi/devices/10EC3270:00/status
::::::::::::::
15
::::::::::::::
/sys/bus/acpi/devices/10EC5640:00/status
::::::::::::::
0
::::::::::::::
/sys/bus/acpi/devices/10EC5648:00/status
::::::::::::::
0

This information is very useful to figure out which HIDs/quirks need
to be supported. Add log to alsa-info.sh to only expose non-zero
results of the ACPI _STA method, e.g.

!!ACPI Device Status Information
!!---------------

/sys/bus/acpi/devices/10EC3270:00/status 	 15

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 alsa-info/alsa-info.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 9684c6f..cda4125 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -441,6 +441,16 @@ elif [ -x $DMIDECODE ]; then
     DMI_BOARD_NAME=$($DMIDECODE -s baseboard-product-name 2>/dev/null)
 fi
 
+# Check for ACPI device status
+if [ -d /sys/bus/acpi/devices ]; then
+    for f in /sys/bus/acpi/devices/*/status; do
+	ACPI_STATUS=$(cat $f 2>/dev/null);
+	if [[ "$ACPI_STATUS" -ne 0 ]]; then
+	    echo $f $'\t' $ACPI_STATUS >>$TEMPDIR/acpidevicestatus.tmp;
+	fi
+    done
+fi
+
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>$TEMPDIR/alsamodules.tmp
 cat /proc/asound/cards >$TEMPDIR/alsacards.tmp
 if [[ ! -z "$LSPCI" ]]; then
@@ -487,6 +497,12 @@ echo "Board Vendor:      $DMI_BOARD_VENDOR" >> $FILE
 echo "Board Name:        $DMI_BOARD_NAME" >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
+echo "!!ACPI Device Status Information" >> $FILE
+echo "!!---------------" >> $FILE
+echo "" >> $FILE
+cat $TEMPDIR/acpidevicestatus.tmp >> $FILE
+echo "" >> $FILE
+echo "" >> $FILE
 echo "!!Kernel Information" >> $FILE
 echo "!!------------------" >> $FILE
 echo "" >> $FILE
-- 
2.7.4
