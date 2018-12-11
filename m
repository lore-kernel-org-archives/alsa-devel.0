From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 3/7] ALSA: hda/intel: Drop superfluous
	AZX_DCAPS_I915_POWERWELL checks
Date: Tue, 11 Dec 2018 14:53:37 +0100
Message-ID: <20181211135341.11383-4-tiwai@suse.de>
References: <20181211135341.11383-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E3330267BA3
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 14:53:49 +0100 (CET)
In-Reply-To: <20181211135341.11383-1-tiwai@suse.de>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

snd_hdac_display_power() can be called even for a HDA controller
without DRM binding.  The same is true for other helpers,
snd_hdac_i915_set_bclk() and snd_hdac_set_codec_wakeup().
So all superfluous AZX_DCAPS_I915_POWERWELL  checks in hda_intel.c can
be dropped, and the definition of AZX_DCAPS_I915_POWERWELL itself can
be removed as well.  This simplifies the code a lot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Drop AZX_DCAPS_I915_POWERWELL completely

 sound/pci/hda/hda_controller.h |  6 +--
 sound/pci/hda/hda_intel.c      | 73 +++++++++++++---------------------
 2 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c95097bb5a0c..7185ed574b41 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -50,11 +50,7 @@
 /* 24 unused */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
-#ifdef CONFIG_SND_HDA_I915
-#define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
-#else
-#define AZX_DCAPS_I915_POWERWELL 0		/* NOP */
-#endif
+/* 27 unused */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9f67425d5039..663e86effa1f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -310,31 +310,28 @@ enum {
 #define AZX_DCAPS_INTEL_HASWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_I915_POWERWELL | AZX_DCAPS_SNOOP_TYPE(SCH))
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* Broadwell HDMI can't use position buffer reliably, force to use LPIB */
 #define AZX_DCAPS_INTEL_BROADWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_POSFIX_LPIB |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_I915_POWERWELL | AZX_DCAPS_SNOOP_TYPE(SCH))
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_BAYTRAIL \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_I915_POWERWELL)
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_COMPONENT)
 
 #define AZX_DCAPS_INTEL_BRASWELL \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_I915_COMPONENT | AZX_DCAPS_I915_POWERWELL)
+	 AZX_DCAPS_I915_COMPONENT)
 
 #define AZX_DCAPS_INTEL_SKYLAKE \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_I915_POWERWELL)
+	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT)
 
 #define AZX_DCAPS_INTEL_BROXTON \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT |\
-	 AZX_DCAPS_I915_POWERWELL)
+	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT)
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
@@ -591,8 +588,7 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 	struct pci_dev *pci = chip->pci;
 	u32 val;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		snd_hdac_set_codec_wakeup(bus, true);
+	snd_hdac_set_codec_wakeup(bus, true);
 	if (chip->driver_type == AZX_DRIVER_SKL) {
 		pci_read_config_dword(pci, INTEL_HDA_CGCTL, &val);
 		val = val & ~INTEL_HDA_CGCTL_MISCBDCGE;
@@ -604,8 +600,8 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 		val = val | INTEL_HDA_CGCTL_MISCBDCGE;
 		pci_write_config_dword(pci, INTEL_HDA_CGCTL, val);
 	}
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		snd_hdac_set_codec_wakeup(bus, false);
+
+	snd_hdac_set_codec_wakeup(bus, false);
 
 	/* reduce dma latency to avoid noise */
 	if (IS_BXT(pci))
@@ -945,14 +941,10 @@ static bool azx_is_pm_ready(struct snd_card *card)
 
 static void __azx_runtime_suspend(struct azx *chip)
 {
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
-
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
-	    hda->need_i915_power)
-		display_power(chip, false);
+	display_power(chip, false);
 }
 
 static void __azx_runtime_resume(struct azx *chip)
@@ -962,11 +954,9 @@ static void __azx_runtime_resume(struct azx *chip)
 	struct hda_codec *codec;
 	int status;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		display_power(chip, true);
-		if (hda->need_i915_power)
-			snd_hdac_i915_set_bclk(bus);
-	}
+	display_power(chip, true);
+	if (hda->need_i915_power)
+		snd_hdac_i915_set_bclk(bus);
 
 	/* Read STATESTS before controller reset */
 	status = azx_readw(chip, STATESTS);
@@ -982,8 +972,7 @@ static void __azx_runtime_resume(struct azx *chip)
 	}
 
 	/* power down again for link-controlled chips */
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
-	    !hda->need_i915_power)
+	if (!hda->need_i915_power)
 		display_power(chip, false);
 }
 
@@ -1347,11 +1336,8 @@ static int azx_free(struct azx *chip)
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	release_firmware(chip->fw);
 #endif
+	display_power(chip, false);
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		if (hda->need_i915_power)
-			display_power(chip, false);
-	}
 	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT)
 		snd_hdac_i915_exit(bus);
 	kfree(hda);
@@ -1908,8 +1894,7 @@ static int azx_first_init(struct azx *chip)
 	/* initialize chip */
 	azx_init_pci(chip);
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		snd_hdac_i915_set_bclk(bus);
+	snd_hdac_i915_set_bclk(bus);
 
 	hda_intel_init_chip(chip, (probe_only[dev] & 2) == 0);
 
@@ -2217,10 +2202,13 @@ static int azx_probe_continue(struct azx *chip)
 				goto out_free;
 			} else {
 				/* don't bother any longer */
-				chip->driver_caps &=
-					~(AZX_DCAPS_I915_COMPONENT | AZX_DCAPS_I915_POWERWELL);
+				chip->driver_caps &= ~AZX_DCAPS_I915_COMPONENT;
 			}
 		}
+
+		/* HSW/BDW controllers need this power */
+		if (CONTROLLER_IN_GPU(pci))
+			hda->need_i915_power = 1;
 	}
 
 	/* Request display power well for the HDA controller or codec. For
@@ -2228,17 +2216,11 @@ static int azx_probe_continue(struct azx *chip)
 	 * this power. For other platforms, like Baytrail/Braswell, only the
 	 * display codec needs the power and it can be released after probe.
 	 */
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		/* HSW/BDW controllers need this power */
-		if (CONTROLLER_IN_GPU(pci))
-			hda->need_i915_power = 1;
-
-		err = display_power(chip, true);
-		if (err < 0) {
-			dev_err(chip->card->dev,
-				"Cannot turn on display power on i915\n");
-			goto i915_power_fail;
-		}
+	err = display_power(chip, true);
+	if (err < 0) {
+		dev_err(chip->card->dev,
+			"Cannot turn on display power on i915\n");
+		goto i915_power_fail;
 	}
 
 	err = azx_first_init(chip);
@@ -2287,8 +2269,7 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_autosuspend(&pci->dev);
 
 out_free:
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		&& !hda->need_i915_power)
+	if (!hda->need_i915_power)
 		display_power(chip, false);
 
 i915_power_fail:
-- 
2.19.2
