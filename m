From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/7] ALSA: hda/intel: Drop superfluous
	AZX_DCAPS_I915_POWERWELL checks
Date: Sun,  9 Dec 2018 10:33:14 +0100
Message-ID: <20181209093318.27829-4-tiwai@suse.de>
References: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADCEA26751A
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 10:33:28 +0100 (CET)
In-Reply-To: <20181209093318.27829-1-tiwai@suse.de>
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

Since snd_hdac_display_power() can be called even for a HDA controller
without DRM binding, lots of superfluous AZX_DCAPS_I915_POWERWELL
checks in hda_intel.c can be dropped.  This simplifies the code a
lot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 43 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 151c6ca85ec6..cacee33a74a8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -948,9 +948,7 @@ static void __azx_runtime_suspend(struct azx *chip)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
-	    hda->need_i915_power)
-		display_power(chip, false);
+	display_power(chip, false);
 }
 
 static void __azx_runtime_resume(struct azx *chip)
@@ -960,11 +958,9 @@ static void __azx_runtime_resume(struct azx *chip)
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
@@ -980,8 +976,7 @@ static void __azx_runtime_resume(struct azx *chip)
 	}
 
 	/* power down again for link-controlled chips */
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
-	    !hda->need_i915_power)
+	if (!hda->need_i915_power)
 		display_power(chip, false);
 }
 
@@ -1345,11 +1340,8 @@ static int azx_free(struct azx *chip)
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
@@ -2219,6 +2211,10 @@ static int azx_probe_continue(struct azx *chip)
 					~(AZX_DCAPS_I915_COMPONENT | AZX_DCAPS_I915_POWERWELL);
 			}
 		}
+
+		/* HSW/BDW controllers need this power */
+		if (CONTROLLER_IN_GPU(pci))
+			hda->need_i915_power = 1;
 	}
 
 	/* Request display power well for the HDA controller or codec. For
@@ -2226,17 +2222,11 @@ static int azx_probe_continue(struct azx *chip)
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
@@ -2285,8 +2275,7 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_autosuspend(&pci->dev);
 
 out_free:
-	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
-		&& !hda->need_i915_power)
+	if (!hda->need_i915_power)
 		display_power(chip, false);
 
 i915_power_fail:
-- 
2.19.2
