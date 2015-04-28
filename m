From: mengdong.lin@intel.com
Subject: [PATCH v2 1/3] ALSA: hda - divide controller and codec
	dependency on i915 gfx power well
Date: Tue, 28 Apr 2015 20:43:00 +0800
Message-ID: <1430224980-22186-1-git-send-email-mengdong.lin@intel.com>
References: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E28162605DF
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 14:32:17 +0200 (CEST)
In-Reply-To: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
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

- divide the controller and codec dependency on i915 power well by adding
  flag "need_i915_power" for the chip (controller) and codec respectively.

- If the controller does not need the power well, the driver will release the
  power after probe, otherwise the power will be held until the controller is
  runtime suspended or S3.

-  And if only the codec needs the power, its runtime PM ops will request/
   release the power.

Background:
- For Haswell/Broadwell, which has a separate HD-A controller for display audio,
  both the controller and the display codec are in the i915 power well.

- For Baytrail/Braswell, the display and analog audio share the same HDA
  controller and link, and only the display codec is in the i915 power well.

- For Skylake, the display and analog audio share the same HDA controller but
  use separate links. Only the display codec is in the i915 power well. And in
  legacy mode we take the two links as one. So it can follow Baytrail/Braswell.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 6a2e030..4fa2d51 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -74,6 +74,7 @@ struct hdac_device {
 
 	/* misc flags */
 	atomic_t in_pm;		/* suspend/resume being performed */
+	unsigned int need_i915_power:1; /* only codec needs i915 power */
 
 	/* sysfs */
 	struct hdac_widget_tree *widgets;
@@ -184,6 +185,8 @@ struct hdac_bus_ops {
 	/* get a response from the last command */
 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
 			    unsigned int *res);
+	/* enable/disable the display power */
+	int (*display_power)(struct hdac_bus *bus, bool enable);
 };
 
 /*
@@ -308,6 +311,15 @@ static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 }
 
+/*
+ * Enable/disable the display power well, for HDMI/DP audio codecs that can be
+ * in the shared power well with GPU display engine.
+ */
+static inline int snd_hdac_display_power(struct hdac_device *codec, bool enable)
+{
+	return codec->bus->ops->display_power(codec->bus, enable);
+}
+
 int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val);
 int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 			      unsigned int *res);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2d8883f..2de9e84 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -857,6 +857,10 @@ void snd_hda_codec_register(struct hda_codec *codec)
 		return;
 	if (device_is_registered(hda_codec_dev(codec))) {
 		snd_hda_register_beep_device(codec);
+
+		if (codec->core.need_i915_power)
+			snd_hdac_display_power(&codec->core, true);
+
 		pm_runtime_enable(hda_codec_dev(codec));
 		/* it was powered up in snd_hda_codec_new(), now all done */
 		snd_hda_power_down(codec);
@@ -3102,6 +3106,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
 	    (state & AC_PWRST_CLK_STOP_OK))
 		snd_hdac_codec_link_down(&codec->core);
+
+	if (codec->core.need_i915_power)
+		snd_hdac_display_power(&codec->core, false);
 	return 0;
 }
 
@@ -3109,6 +3116,9 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
+	if (codec->core.need_i915_power)
+		snd_hdac_display_power(&codec->core, true);
+
 	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index e0bb623..e5bdf31 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -775,9 +775,20 @@ static int azx_get_response(struct hdac_bus *bus, unsigned int addr,
 		return azx_rirb_get_response(bus, addr, res);
 }
 
+static int azx_display_power(struct hdac_bus *bus, bool enable)
+{
+	struct azx *chip = bus_to_azx(bus);
+
+	if (chip->ops->display_power)
+		return chip->ops->display_power(chip, enable);
+	else
+		return -EINVAL;
+}
+
 static const struct hdac_bus_ops bus_core_ops = {
 	.command = azx_send_cmd,
 	.get_response = azx_get_response,
+	.display_power = azx_display_power,
 };
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 173bf7c..e2292e4 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -89,6 +89,8 @@ struct hda_controller_ops {
 				 struct vm_area_struct *area);
 	/* Check if current position is acceptable */
 	int (*position_check)(struct azx *chip, struct azx_dev *azx_dev);
+	/* enable/disable the shared display power */
+	int (*display_power)(struct azx *chip, bool enable);
 };
 
 struct azx_pcm {
@@ -152,6 +154,7 @@ struct azx {
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by VGA-switcher */
+	unsigned int need_i915_power:1; /* both controller & display codec needs i915 power */
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct azx_dev saved_azx_dev;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e615556..1b688ba 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -543,6 +543,14 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 	return 0;
 }
 
+/* Enable/disable display power  */
+static int azx_intel_display_power(struct azx *chip, bool enable)
+{
+	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+
+	return hda_display_power(hda, enable);
+}
+
 /*
  * Check whether the current DMA position is acceptable for updating
  * periods.  Returns non-zero if it's OK.
@@ -809,7 +817,8 @@ static int azx_suspend(struct device *dev)
 
 	if (chip->msi)
 		pci_disable_msi(chip->pci);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power)
 		hda_display_power(hda, false);
 	return 0;
 }
@@ -829,7 +838,8 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -872,7 +882,8 @@ static int azx_runtime_suspend(struct device *dev)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power)
 		hda_display_power(hda, false);
 
 	return 0;
@@ -897,7 +908,8 @@ static int azx_runtime_resume(struct device *dev)
 	if (!azx_has_pm_runtime(chip))
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -1118,7 +1130,8 @@ static int azx_free(struct azx *chip)
 	release_firmware(chip->fw);
 #endif
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		hda_display_power(hda, false);
+		if (chip->need_i915_power)
+			hda_display_power(hda, false);
 		hda_i915_exit(hda);
 	}
 	kfree(hda);
@@ -1789,6 +1802,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.substream_free_pages = substream_free_pages,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
 	.position_check = azx_position_check,
+	.display_power = azx_intel_display_power,
 };
 
 static int azx_probe(struct pci_dev *pci,
@@ -1882,17 +1896,26 @@ static int azx_probe_continue(struct azx *chip)
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
+		chip->need_i915_power = 1;
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
@@ -1939,6 +1962,11 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_noidle(&pci->dev);
 
 out_free:
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& !chip->need_i915_power)
+		hda_display_power(hda, false);
+
+i915_power_fail:
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
-- 
1.9.1
