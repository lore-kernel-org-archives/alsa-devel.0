From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/4] utils/alsa-info.sh: adding system firmware
	version to the defaults collected under "DMI Information"
Date: Mon, 11 Jun 2012 10:45:20 +0200
Message-ID: <1339404323-3770-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BA401041B6
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 10:45:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Chris Van Hoof <vanhoof@canonical.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Van Hoof <vanhoof@canonical.com>

Signed-off-by: Chris Van Hoof <vanhoof@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 utils/alsa-info.sh |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index fd7df96..46d2ebb 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -424,10 +424,12 @@ if [ -d /sys/class/dmi/id ]; then
     DMI_SYSTEM_MANUFACTURER=$(cat /sys/class/dmi/id/sys_vendor 2>/dev/null)
     DMI_SYSTEM_PRODUCT_NAME=$(cat /sys/class/dmi/id/product_name 2>/dev/null)
     DMI_SYSTEM_PRODUCT_VERSION=$(cat /sys/class/dmi/id/product_version 2>/dev/null)
+    DMI_SYSTEM_FIRMWARE_VERSION=$(cat /sys/class/dmi/id/bios_version 2>/dev/null)
 elif [ -x $DMIDECODE ]; then
     DMI_SYSTEM_MANUFACTURER=$($DMIDECODE -s system-manufacturer 2>/dev/null)
     DMI_SYSTEM_PRODUCT_NAME=$($DMIDECODE -s system-product-name 2>/dev/null)
     DMI_SYSTEM_PRODUCT_VERSION=$($DMIDECODE -s system-version 2>/dev/null)
+    DMI_SYSTEM_FIRMWARE_VERSION=$($DMIDECODE -s bios-version 2>/dev/null)
 fi
 
 cat /proc/asound/modules 2>/dev/null|awk {'print $2'}>$TEMPDIR/alsamodules.tmp
@@ -469,6 +471,7 @@ echo "" >> $FILE
 echo "Manufacturer:      $DMI_SYSTEM_MANUFACTURER" >> $FILE
 echo "Product Name:      $DMI_SYSTEM_PRODUCT_NAME" >> $FILE
 echo "Product Version:   $DMI_SYSTEM_PRODUCT_VERSION" >> $FILE
+echo "Firmware Version:  $DMI_SYSTEM_FIRMWARE_VERSION" >> $FILE
 echo "" >> $FILE
 echo "" >> $FILE
 echo "!!Kernel Information" >> $FILE
-- 
1.7.9.5
