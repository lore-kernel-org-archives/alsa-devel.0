From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - restore BCLK M/N values when
	resuming HSW/BDW display controller
Date: Thu, 26 Jun 2014 15:37:16 +0800
Message-ID: <1403768236-3294-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B45F4264F23
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 09:34:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

For Intel Haswell/Broadwell display HD-A controller, the 24MHz HD-A link BCLK
is converted from Core Display Clock (CDCLK): BCLK = CDCLK * M / N
And there are two registers EM4 and EM5 to program M, N value respectively.
The EM4/EM5 values will be lost and when the display power well is disabled.

BIOS programs CDCLK selected by OEM and EM4/EM5, but BIOS has no idea about
display power well on/off at runtime. So the M/N can be wrong if non-default
CDCLK is used when the audio controller resumes, which results in an invalid
BCLK and abnormal audio playback rate. So this patch saves and restores valid
M/N values on controller suspend/resume.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index bb65a124..90a2750 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -580,6 +580,18 @@ static int param_set_xint(const char *val, const struct kernel_param *kp)
 #define azx_del_card_list(chip) /* NOP */
 #endif /* CONFIG_PM */
 
+static void haswell_save_bclk(struct azx *chip)
+{
+	chip->bclk_m = azx_readw(chip, EM4);
+	chip->bclk_n = azx_readw(chip, EM5);
+}
+
+static void haswell_restore_bclk(struct azx *chip)
+{
+	azx_writew(chip, EM4, chip->bclk_m);
+	azx_writew(chip, EM5, chip->bclk_n);
+}
+
 #if defined(CONFIG_PM_SLEEP) || defined(SUPPORT_VGA_SWITCHEROO)
 /*
  * power management
@@ -606,6 +618,13 @@ static int azx_suspend(struct device *dev)
 		free_irq(chip->irq, chip);
 		chip->irq = -1;
 	}
+
+	/* Save BCLK M/N values before they become invalid in D3.
+	 * Will test if display power well can be released now.
+	 */
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+		haswell_save_bclk(chip);
+
 	if (chip->msi)
 		pci_disable_msi(chip->pci);
 	pci_disable_device(pci);
@@ -625,8 +644,10 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled)
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(true);
+		haswell_restore_bclk(chip);
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
@@ -670,8 +691,10 @@ static int azx_runtime_suspend(struct device *dev)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		haswell_save_bclk(chip);
 		hda_display_power(false);
+	}
 	return 0;
 }
 
@@ -689,8 +712,10 @@ static int azx_runtime_resume(struct device *dev)
 	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(true);
+		haswell_restore_bclk(chip);
+	}
 
 	/* Read STATESTS before controller reset */
 	status = azx_readw(chip, STATESTS);
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 4a7cb01..1469edb 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -96,6 +96,14 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define ICH6_REG_SD_BDLPL		0x18
 #define ICH6_REG_SD_BDLPU		0x1c
 
+/* Intel HSW/BDW display HD-A controller Extended Mode registers.
+ * EM4 (M value) and EM5 (N Value) are used to convert CDClk (Core Display
+ * Clock) to 24MHz BCLK: BCLK = CDCLK * M / N
+ * The values will be lost when the display power well is disabled.
+ */
+#define ICH6_REG_EM4			0x100c
+#define ICH6_REG_EM5			0x1010
+
 /* PCI space */
 #define ICH6_PCIREG_TCSEL	0x44
 
@@ -417,6 +425,10 @@ struct azx {
 
 	/* secondary power domain for hdmi audio under vga device */
 	struct dev_pm_domain hdmi_pm_domain;
+
+	/* for HSW/BDW display HDA controller to restore BCLK from CDCLK */
+	unsigned int bclk_m;
+	unsigned int bclk_n;
 };
 
 #ifdef CONFIG_SND_VERBOSE_PRINTK
-- 
1.8.1.2
