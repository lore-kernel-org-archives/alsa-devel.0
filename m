From: mengdong.lin@intel.com
Subject: [PATCH 3/3] ALSA: hda - restore BCLK M/N value as per
	CDCLK for HSW/BDW display HDA controller
Date: Wed,  2 Jul 2014 22:44:07 +0800
Message-ID: <54aede59c2ab488ffff3c92c45798efb38a5e0d2.1404311751.git.mengdong.lin@intel.com>
References: <cover.1404311751.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BDDB62652F1
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:41:37 +0200 (CEST)
In-Reply-To: <cover.1404311751.git.mengdong.lin@intel.com>
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

For HSW/BDW display HD-A controller, this patch restores BCLK by setting the
M/N values as per the core display clock (CDCLK) queried from i915 display
driver.

And the audio driver will also restore BCLK in azx_first_init() since the
display driver can turn off the shared power in boot phase if only eDP is
connected and M/N values will be lost and must be reprogrammed.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 25753db..c7dfd1d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -299,10 +299,6 @@ static char *driver_short_names[] = {
 
 struct hda_intel {
 	struct azx chip;
-
-	/* HSW/BDW display HDA controller to restore BCLK from CDCLK */
-	unsigned int bclk_m;
-	unsigned int bclk_n;
 };
 
 
@@ -598,20 +594,41 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_PM */
 
-static void haswell_save_bclk(struct azx *chip)
-{
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
-
-	hda->bclk_m = azx_readw(chip, EM4);
-	hda->bclk_n = azx_readw(chip, EM5);
-}
 
 static void haswell_restore_bclk(struct azx *chip)
 {
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	int cdclk_freq;
+	unsigned int bclk_m, bclk_n;
+
+	cdclk_freq = hda_get_display_clk();
+	switch (cdclk_freq) {
+	case 337500:
+		bclk_m = 16;
+		bclk_n = 225;
+		break;
+
+	case 450000: /* default CDCLK 450MHz */
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
 
-	azx_writew(chip, EM4, hda->bclk_m);
-	azx_writew(chip, EM5, hda->bclk_n);
+	default:
+		bclk_m = 4;
+		bclk_n = 75;
+	}
+
+	azx_writew(chip, EM4, bclk_m);
+	azx_writew(chip, EM5, bclk_n);
 }
 
 #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
@@ -641,12 +658,6 @@ static int azx_suspend(struct device *dev)
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
@@ -713,10 +724,9 @@ static int azx_runtime_suspend(struct device *dev)
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
 
@@ -1426,6 +1436,10 @@ static int azx_first_init(struct azx *chip)
 
 	/* initialize chip */
 	azx_init_pci(chip);
+
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		haswell_restore_bclk(chip);
+
 	azx_init_chip(chip, (probe_only[dev] & 2) == 0);
 
 	/* codec detection */
-- 
1.8.1.2
