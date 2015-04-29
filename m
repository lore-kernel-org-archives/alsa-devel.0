From: mengdong.lin@intel.com
Subject: [PATCH v3 4/5] ALSA: hda - divide controller and codec
	dependency on i915 gfx power well
Date: Wed, 29 Apr 2015 17:43:36 +0800
Message-ID: <077fe61f0236a60538693a5ea5e80a65996d9790.1430300071.git.mengdong.lin@intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A46DC2604EA
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:53 +0200 (CEST)
In-Reply-To: <cover.1430300071.git.mengdong.lin@intel.com>
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

This patch can improve power saving for Intel platforms on which only the
display audio codec is in the shared i915 power well:

- Add a flag "need_i915_power" to indicate whether the controller needs the
  i915 power well.

- The driver will always request the i915 power when probing the controller
  and codecs if AZX_DCAPS_I915_POWERWELL is set (either the controller or a
  codec needs this power).

- If the controller needs the i915 power, the power will be held after probe
  until the controller is runtime suspended or S3. If the controller doesn't
  need the power, the power will be released the after probe, and a codec
  that needs the power can request/release the power via bus link_power ops.

Background:
- For Haswell/Broadwell, which has a separate HD-A controller for display audio,
  both the controller and the display codec are in the i915 power well.

- For Baytrail/Braswell, the display and analog audio share the same HDA
  controller and link, and only the display codec is in the i915 power well.

- For Skylake, the display and analog audio share the same HDA controller but
  use separate links. Only the display codec is in the i915 power well. And in
  legacy mode we take the two links as one. So it can follow Baytrail/Braswell.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d70b405..98e721b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -817,7 +817,8 @@ static int azx_suspend(struct device *dev)
 
 	if (chip->msi)
 		pci_disable_msi(chip->pci);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& hda->need_i915_power)
 		hda_display_power(hda, false);
 	return 0;
 }
@@ -837,7 +838,8 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& hda->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -880,7 +882,8 @@ static int azx_runtime_suspend(struct device *dev)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& hda->need_i915_power)
 		hda_display_power(hda, false);
 
 	return 0;
@@ -905,7 +908,8 @@ static int azx_runtime_resume(struct device *dev)
 	if (!azx_has_pm_runtime(chip))
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& hda->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -1126,7 +1130,8 @@ static int azx_free(struct azx *chip)
 	release_firmware(chip->fw);
 #endif
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		hda_display_power(hda, false);
+		if (hda->need_i915_power)
+			hda_display_power(hda, false);
 		hda_i915_exit(hda);
 	}
 	kfree(hda);
@@ -1891,17 +1896,26 @@ static int azx_probe_continue(struct azx *chip)
 	int err;
 
 	hda->probe_continued = 1;
-	/* Request power well for Haswell HDA controller and codec */
+
+	/* Request display power well for the HDA controller or codec. For
+	 * Haswell/Broadwell, both the display HDA controller and codec need
+	 * this power. For other platforms, like Baytrail/Braswell, only the
+	 * display codec needs the power and it can be released after probe.
+	 */
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		/* Assume the controller needs the power by default */
+		hda->need_i915_power = 1;
+
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
 		if (err < 0)
-			goto out_free;
+			goto i915_power_fail;
+
 		err = hda_display_power(hda, true);
 		if (err < 0) {
 			dev_err(chip->card->dev,
 				"Cannot turn on display power on i915\n");
-			goto out_free;
+			goto i915_power_fail;
 		}
 #endif
 	}
@@ -1948,6 +1962,11 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_noidle(&pci->dev);
 
 out_free:
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& !hda->need_i915_power)
+		hda_display_power(hda, false);
+
+i915_power_fail:
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
diff --git a/sound/pci/hda/hda_intel.h b/sound/pci/hda/hda_intel.h
index dc1d3ff..505f987 100644
--- a/sound/pci/hda/hda_intel.h
+++ b/sound/pci/hda/hda_intel.h
@@ -45,6 +45,7 @@ struct hda_intel {
 	struct dev_pm_domain hdmi_pm_domain;
 
 	/* i915 component interface */
+	bool need_i915_power:1; /* the hda controller needs i915 power */
 	struct i915_audio_component audio_component;
 	int i915_power_refcount;
 };
-- 
1.9.1
