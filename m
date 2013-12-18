From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 15/15] ACPI/thinkpad: Fix wrong
	<acpi/acpi.h> inclusion in Thinkpad ACPI users.
Date: Wed, 18 Dec 2013 17:07:21 +0800
Message-ID: <f82182940fe88b1b6428eecc2df1cb1684f0ca80.1387336613.git.lv.zheng__25016.6282909506$1387552236$gmane$org@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 05DEE2651A3
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 10:07:37 +0100 (CET)
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: alsa-devel@alsa-project.org, ibm-acpi-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-kernel@vger.kernel.org, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CONFIG_ACPI dependent code should include <linux/acpi.h> instead of
directly including <acpi/acpi.h>.  This patch cleans up such wrong
inclusions for Thinkpad ACPI users.

Cc: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Cc: ibm-acpi-devel@lists.sourceforge.net
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    1 -
 include/linux/thinkpad_acpi.h        |    2 ++
 sound/pci/hda/patch_conexant.c       |    1 -
 sound/pci/hda/patch_realtek.c        |    1 -
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index defb6af..c114d7c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -76,7 +76,6 @@
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
-#include <linux/acpi.h>
 #include <linux/pci_ids.h>
 #include <linux/thinkpad_acpi.h>
 #include <sound/core.h>
diff --git a/include/linux/thinkpad_acpi.h b/include/linux/thinkpad_acpi.h
index 361de59..02928eb 100644
--- a/include/linux/thinkpad_acpi.h
+++ b/include/linux/thinkpad_acpi.h
@@ -1,6 +1,8 @@
 #ifndef __THINKPAD_ACPI_H__
 #define __THINKPAD_ACPI_H__
 
+#include <linux/acpi.h>
+
 /* These two functions return 0 if success, or negative error code
    (e g -ENODEV if no led present) */
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3fbf288..c2da489 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3243,7 +3243,6 @@ enum {
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 
 #include <linux/thinkpad_acpi.h>
-#include <acpi/acpi.h>
 
 static int (*led_set_func)(int, bool);
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 34de5dc..17306be 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3726,7 +3726,6 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 
 #include <linux/thinkpad_acpi.h>
-#include <acpi/acpi.h>
 
 static int (*led_set_func)(int, bool);
 
-- 
1.7.10.4
