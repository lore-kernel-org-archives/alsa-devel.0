From: mengdong.lin@intel.com
Subject: [RFC PATCH 1/2] ALSA: hda - divide controller and
	codec dependency on i915 gfx power well
Date: Fri, 24 Apr 2015 21:01:54 +0800
Message-ID: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 975F8266685
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:51:17 +0200 (CEST)
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
  power after probe. And if only the codec needs the power, its runtime PM ops
  will request/release the power.

Background:
- For Haswell/Broadwell, which has a separate HD-A controller for display audio,
  both the controller and the display codec are in the i915 power well.

- For Baytrail/Braswell, the display and analog audio share the same HDA
  controller and link, and only the display codec is in the i915 power well.

- For Skylake, the display and analog audio share the same HDA controller but
  use separate links. Only the display codec is in the i915 power well. And in
  legacy mode we take the two links as one. So it can follow Baytrail/Braswell.

Open questions:
- Move the hda_i915 to sound/hda at first? So both legacy and new drivers can
  use it as Takashi suggested?
  The PCI ID check in haswell_set_bclk will no longer be needed, since it's
  only called when chip's "need_i915_power" flag is set and so only called for
  Haswell & Broadwell.

- move flag "need_i915_power" from struct hda_codec to hdac_device, for the
  same reason as above?

- If the audio component moves from struct hda_intel to hdac_bus, how can the
  controller access the component? Need to add "bus" to struct azx?

- implement codec resume/suspend ops to get/put i915 power if only the codec
  needs the power?

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 2a8aa9d..baa01a0 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -169,6 +169,8 @@ struct hdac_bus_ops {
 	/* get a response from the last command */
 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
 			    unsigned int *res);
+	/* request/release display power */
+	int (*display_power)(struct hdac_bus *bus, bool enable);
 };
 
 #define HDA_UNSOL_QUEUE_SIZE	64
@@ -222,6 +224,11 @@ static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
 	clear_bit(codec->addr, &codec->bus->codec_powered);
 }
 
+static inline int snd_hdac_display_power(struct hdac_device *codec, bool enable)
+{
+	return codec->bus->ops->display_power(codec->bus, enable);
+}
+
 /*
  * generic array helpers
  */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
old mode 100755
new mode 100644
index 18a021a..034488e
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -524,9 +524,21 @@ static int _hda_bus_get_response(struct hdac_bus *_bus, unsigned int addr,
 	return bus->rirb_error ? -EIO : 0;
 }
 
+static int _hda_bus_display_power(struct hdac_bus *_bus, bool enable)
+{
+	struct hda_bus *bus = container_of(_bus, struct hda_bus, core);
+
+	if (bus->ops.display_power)
+		return bus->ops.display_power(bus, enable);
+	else
+		return -EINVAL;
+
+}
+
 static const struct hdac_bus_ops bus_ops = {
 	.command = _hda_bus_command,
 	.get_response = _hda_bus_get_response,
+	.display_power = _hda_bus_display_power,
 };
 
 /**
@@ -949,6 +961,10 @@ void snd_hda_codec_register(struct hda_codec *codec)
 		return;
 	if (device_is_registered(hda_codec_dev(codec))) {
 		snd_hda_register_beep_device(codec);
+
+		if (codec->need_i915_power)
+			snd_hdac_display_power(&codec->core, true);
+
 		pm_runtime_enable(hda_codec_dev(codec));
 		/* it was powered up in snd_hda_codec_new(), now all done */
 		snd_hda_power_down(codec);
@@ -3196,6 +3212,9 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	if (codec_has_clkstop(codec) && codec_has_epss(codec) &&
 	    (state & AC_PWRST_CLK_STOP_OK))
 		snd_hdac_codec_link_down(&codec->core);
+
+	if (codec->need_i915_power)
+		snd_hdac_display_power(&codec->core, false);
 	return 0;
 }
 
@@ -3205,6 +3224,9 @@ static int hda_codec_runtime_resume(struct device *dev)
 
 	printk("amanda: hda_codec_runtime_resume, codec addr %d \n", codec->addr);
 
+	if (codec->need_i915_power)
+		snd_hdac_display_power(&codec->core, true);
+
 	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 9075ac2..32d7fa7 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -64,6 +64,7 @@ struct hda_bus_ops {
 	void (*load_dsp_cleanup)(struct hda_bus *bus,
 				 struct snd_dma_buffer *dmab);
 #endif
+	int (*display_power)(struct hda_bus *bus, bool enable);
 };
 
 /*
@@ -281,6 +282,7 @@ struct hda_codec {
 	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 	unsigned int dump_coef:1; /* dump processing coefs in codec proc file */
 	unsigned int power_save_node:1; /* advanced PM for each widget */
+	unsigned int need_i915_power:1; /* only codec needs i915 power */
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
 	unsigned long power_off_acct;
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 26ce990..b7eaf2d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1354,6 +1354,17 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 		return azx_rirb_get_response(bus, addr);
 }
 
+
+static unsigned int azx_display_power(struct hda_bus *bus, bool enable)
+{
+	struct azx *chip = bus->private_data;
+
+	if (chip->ops->display_power)
+		return chip->ops->display_power(chip, enable);
+	else
+		return -EINVAL;
+}
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 /*
  * DSP loading code (e.g. for CA0132)
@@ -1819,6 +1830,7 @@ static struct hda_bus_ops bus_ops = {
 	.load_dsp_trigger = azx_load_dsp_trigger,
 	.load_dsp_cleanup = azx_load_dsp_cleanup,
 #endif
+	.display_power = azx_display_power,
 };
 
 /* HD-audio bus initialization */
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be1b7de..2d6c6c2 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -277,6 +277,7 @@ struct hda_controller_ops {
 				 struct vm_area_struct *area);
 	/* Check if current position is acceptable */
 	int (*position_check)(struct azx *chip, struct azx_dev *azx_dev);
+	int (*display_power)(struct azx *chip, bool enable);
 };
 
 struct azx_pcm {
@@ -358,6 +359,7 @@ struct azx {
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by VGA-switcher */
+	unsigned int need_i915_power:1; /* both controller & display codec needs i915 power */
 
 	/* for debugging */
 	unsigned int last_cmd[AZX_MAX_CODECS];
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 34040d2..f6c3e37 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -543,6 +543,13 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 	return 0;
 }
 
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
@@ -796,7 +803,8 @@ static int azx_suspend(struct device *dev)
 
 	if (chip->msi)
 		pci_disable_msi(chip->pci);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power)
 		hda_display_power(hda, false);
 	return 0;
 }
@@ -816,7 +824,8 @@ static int azx_resume(struct device *dev)
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -859,7 +868,8 @@ static int azx_runtime_suspend(struct device *dev)
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power)
 		hda_display_power(hda, false);
 
 	return 0;
@@ -885,7 +895,8 @@ static int azx_runtime_resume(struct device *dev)
 	if (!azx_has_pm_runtime(chip))
 		return 0;
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
+		&& chip->need_i915_power) {
 		hda_display_power(hda, true);
 		haswell_set_bclk(hda);
 	}
@@ -1105,7 +1116,8 @@ static int azx_free(struct azx *chip)
 	release_firmware(chip->fw);
 #endif
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		hda_display_power(hda, false);
+		if (chip->need_i915_power)
+			hda_display_power(hda, false);
 		hda_i915_exit(hda);
 	}
 	kfree(hda);
@@ -1757,6 +1769,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.substream_free_pages = substream_free_pages,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
 	.position_check = azx_position_check,
+	.display_power = azx_intel_display_power,
 };
 
 static int azx_probe(struct pci_dev *pci,
@@ -1855,12 +1868,12 @@ static int azx_probe_continue(struct azx *chip)
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
 		if (err < 0)
-			goto out_free;
+			goto i915_power_fail;
 		err = hda_display_power(hda, true);
 		if (err < 0) {
 			dev_err(chip->card->dev,
 				"Cannot turn on display power on i915\n");
-			goto out_free;
+			goto i915_power_fail;
 		}
 #endif
 	}
@@ -1911,6 +1924,10 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_noidle(&pci->dev);
 
 out_free:
+	if (!chip->need_i915_power)
+		hda_display_power(hda, false);
+
+i915_power_fail:
 	if (err < 0)
 		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
-- 
1.9.1
