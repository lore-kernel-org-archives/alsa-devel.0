From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] alsa-info: provide more DMI information
Date: Mon,  9 Jan 2017 18:32:23 -0600
Message-ID: <1484008344-8262-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1484008344-8262-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 725B4267026
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

Some manufacturers don't provide useful information for Manufacturer
and Product Name but instead use Board Vendor and Board Name fields,
add them to alsa-info log

Example on Intel NUC:

!!DMI Information
!!---------------

Manufacturer:
Product Name:
Product Version:
Firmware Version:  KYSKLi70.86A.0042.2016.0929.1933
Board Vendor:      Intel Corporation
Board Name:        NUC6i7KYB

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 alsa-info/alsa-info.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/alsa-info/alsa-info.sh b/alsa-info/alsa-info.sh
index 0bc4cd0..9684c6f 100755
--- a/alsa-info/alsa-info.sh
+++ b/alsa-info/alsa-info.sh
@@ -430,11 +430,15 @@ if [ -d /sys/class/dmi/id ]; then
     DMI_SYSTEM_PRODUCT_NAME=$(cat /sys/class/dmi/id/product_name 2>/dev/null)
     DMI_SYSTEM_PRODUCT_VERSION=$(cat /sys/class/dmi/id/product_version 2>/dev/null)
     DMI_SYSTEM_FIRMWARE_VERSION=$(cat /sys/class/dmi/id/bios_version 2>/dev/null)
+    DMI_BOARD_VENDOR=$(cat /sys/class/dmi/id/board_vendor 2>/dev/null)
+    DMI_BOARD_NAME=$(cat /sys/class/dmi/id/board_name 2>/dev/null)
 elif [ -x $DMIDECODE ]; then
     DMI_SYSTEM_MANUFACTURER=$($DMIDECODE -s system-manufacturer 2>/dev/null)
     DMI_SYSTEM_PRODUCT_NAME=$($DMIDECODE -s system-product-name 2>/dev/null)
     DMI_SYSTEM_PRODUCT_VERSION=$($DMIDECODE -s system-version 2>/dev/null)
     DMI_SYSTEM_FIRMWARE_VERSION=$($DMIDECODE -s bios-version 2>/dev/null)
+    DMI_BOARD_VENDOR=$($DMIDECODE -s baseboard-manufacturer 2>/dev/null)
+    DMI_BOARD_NAME=$($DMIDECODE -s baseboard-product-name 2>/dev/null)
 fi
 
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>$TEMPDIR/alsamodules.tmp
@@ -479,6 +483,8 @@ echo "Manufacturer:      $DMI_SYSTEM_MANUFACTURER" >> $FILE
 echo "Product Name:      $DMI_SYSTEM_PRODUCT_NAME" >> $FILE
 echo "Product Version:   $DMI_SYSTEM_PRODUCT_VERSION" >> $FILE
 echo "Firmware Version:  $DMI_SYSTEM_FIRMWARE_VERSION" >> $FILE
+echo "Board Vendor:      $DMI_BOARD_VENDOR" >> $FILE
+echo "Board Name:        $DMI_BOARD_NAME" >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
 echo "!!Kernel Information" >> $FILE
-- 
2.7.4
