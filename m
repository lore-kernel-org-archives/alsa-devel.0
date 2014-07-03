From: mengdong.lin@intel.com
Subject: [PATCH v2 2/2] ALSA: hda - restore BCLK M/N value as
	per CDCLK for HSW/BDW display HDA controller
Date: Thu,  3 Jul 2014 13:02:04 +0800
Message-ID: <1404363724-4496-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AE0D265610
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 06:59:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, jani.nikula@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

For HSW/BDW display HD-A controller, hda_set_bclk() is defined to set BCLK
by programming the M/N values as per the core display clock (CDCLK) queried from
i915 display driver.

And the audio driver will also set BCLK in azx_first_init() since the display
driver can turn off the shared power in boot phase if only eDP is connected
and M/N values will be lost and must be reprogrammed.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index e9e8a4a..8b4940b 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -20,10 +20,20 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <drm/i915_powerwell.h>
+#include "hda_priv.h"
 #include "hda_i915.h"
 
+/* Intel HSW/BDW display HDA controller Extended Mode registers.
+ * EM4 (M value) and EM5 (N Value) are used to convert CDClk (Core Display
+ * Clock) to 24MHz BCLK: BCLK = CDCLK * M / N
+ * The values will be lost when the display power well is disabled.
+ */
+#define ICH6_REG_EM4			0x100c
+#define ICH6_REG_EM5			0x1010
+
 static int (*get_power)(void);
 static int (*put_power)(void);
+static int (*get_cdclk)(void);
 
 int hda_display_power(bool enable)
 {
@@ -38,6 +48,43 @@ int hda_display_power(bool enable)
 		return put_power();
 }
 
+void haswell_set_bclk(struct azx *chip)
+{
+	int cdclk_freq;
+	unsigned int bclk_m, bclk_n;
+
+	if (!get_cdclk)
+		return;
+
+	cdclk_freq = get_cdclk();
+	switch (cdclk_freq) {
+	case 337500:
+		bclk_m = 16;
+		bclk_n = 225;
+		break;
+
+	case 450000:
+	default: /* default CDCLK 450MHz */
+		bclk_m = 4;
+		bclk_n = 75;
+		break;
+
+	case 540000:
+		bclk_m = 4;
+		bclk_n = 90;
+		break;
+
+	case 675000:
+		bclk_m = 8;
+		bclk_n = 225;
+		break;
+	}
+
+	azx_writew(chip, EM4, bclk_m);
+	azx_writew(chip, EM5, bclk_n);
+}
+
+
 int hda_i915_init(void)
 {
 	int err = 0;
@@ -55,6 +102,10 @@ int hda_i915_init(void)
 		return -ENODEV;
 	}
 
+	get_cdclk = symbol_request(i915_get_cdclk_freq);
+	if (!get_cdclk)	/* may have abnormal BCLK and audio playback rate */
+		pr_warn("hda-i915: get_cdclk symbol get fail\n");
+
 	pr_debug("HDA driver get symbol successfully from i915 module\n");
 
 	return err;
@@ -70,6 +121,10 @@ int hda_i915_exit(void)
 		symbol_put(i915_release_power_well);
 		put_power = NULL;
 	}
+	if (get_cdclk) {
+		symbol_put(i915_get_cdclk_freq);
+		get_cdclk = NULL;
+	}
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h
index bfd835f..9237340 100644
--- a/sound/pci/hda/hda_i915.h
+++ b/sound/pci/hda/hda_i915.h
@@ -18,6 +18,7 @@
 
 #ifdef CONFIG_SND_HDA_I915
 int hda_display_power(bool enable);
+void haswell_set_bclk(struct azx *chip);
 int hda_i915_init(void);
 int hda_i915_exit(void);
 #else
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 25753db..b6b4e71 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -62,9 +62,9 @@
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
 #include "hda_codec.h"
-#include "hda_i915.h"
 #include "hda_controller.h"
 #include "hda_priv.h"
+#include "hda_i915.h"
 
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
@@ -288,21 +288,8 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
-
-/* Intel HSW/BDW display HDA controller Extended Mode registers.
- * EM4 (M value) and EM5 (N Value) are used to convert CDClk (Core Display
- * Clock) to 24MHz BCLK: BCLK = CDCLK * M / N
- * The values will be lost when the display power well is disabled.
- */
-#define ICH6_REG_EM4			0x100c
-#define ICH6_REG_EM5			0x1010
-
 struct hda_intel {
 	struct azx chip;
-
-	/* HSW/BDW display HDA controller to restore BCLK from CDCLK */
-	unsigned int bclk_m;
-	unsigned int bclk_n;
 };
 
 
@@ -598,22 +585,6 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_PM */
 
-static void haswell_save_bclk(struct azx *chip)
-{
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
-
-	hda->bclk_m = azx_readw(chip, EM4);
-	hda->bclk_n = azx_readw(chip, EM5);
-}
-
-static void haswell_restore_bclk(struct azx *chip)
-{
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
-
-	azx_writew(chip, EM4, hda->bclk_m);
-	azx_writew(chip, EM5, hda->bclk_n);
-}
-
 #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
 /*
  * power management
@@ -641,12 +612,6 @@ static int azx_suspend(struct device *dev)
 		chip->irq = -1;
 	}
 
-	/* Save BCLK M/N values before they become invalid in D3.
-	 * Will test if display power well can be released now.
-	 */
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		haswell_save_bclk(chip);
-
 	if (chip->msi)
 		pci_disable_msi(chip->pci);
 	pci_disable_device(pci);
@@ -668,7 +633,7 @@ static int azx_resume(struct device *dev)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(true);
-		haswell_restore_bclk(chip);
+		haswell_set_bclk(chip);
 	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
@@ -713,10 +678,9 @@ static int azx_runtime_suspend(struct device *dev)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		haswell_save_bclk(chip);
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		hda_display_power(false);
-	}
+
 	return 0;
 }
 
@@ -736,7 +700,7 @@ static int azx_runtime_resume(struct device *dev)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(true);
-		haswell_restore_bclk(chip);
+		haswell_set_bclk(chip);
 	}
 
 	/* Read STATESTS before controller reset */
@@ -1426,6 +1390,10 @@ static int azx_first_init(struct azx *chip)
 
 	/* initialize chip */
 	azx_init_pci(chip);
+
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		haswell_set_bclk(chip);
+
 	azx_init_chip(chip, (probe_only[dev] & 2) == 0);
 
 	/* codec detection */
-- 
1.8.1.2
