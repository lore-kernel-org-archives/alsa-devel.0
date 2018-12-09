From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: hda: Refactor display power
	management
Date: Sun,  9 Dec 2018 10:33:13 +0100
Message-ID: <20181209093318.27829-3-tiwai@suse.de>
References: <20181209093318.27829-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E6A267AB0
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

The current HD-audio code manages the DRM audio power via too complex
redirections, and this seems even still unbalanced in a corner case as
Intel DRM CI has been intermittently reporting.  This patch is a big
surgery for addressing the complexity and the possible unbalance.

Basically the patch changes the display PM in the following ways:

- Both HD-audio controller and codec drivers call a single helper,
  snd_hdac_display_power().  (Formerly, the display power control from
  a codec was done indirectly via link_power bus ops.)

- snd_hdac_display_power() receives the codec address index.  For
  turning on/off from the controller, pass HDA_CODEC_IDX_CONTROLLER.

- snd_hdac_display_power() doesn't manage refcounts any longer, but
  keeps the power status in bitmap.  If any of controller or codecs is
  turned on, the function updates the DRM power state via get_power()
  or put_power().

Also this refactor allows us more cleanup:

- The link_power bus ops is dropped, so there is no longer indirect
  management, as mentioned in the above.

- hdac_device link_power_control flag is moved to hda_codec
  display_power_control flag, as it's only for HDA legacy.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=106525
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_codec.h      |  1 +
 include/sound/hda_component.h  |  8 ++++++--
 include/sound/hdaudio.h        |  7 ++-----
 sound/hda/hdac_component.c     | 35 +++++++++++++++++++++-------------
 sound/hda/hdac_device.c        | 17 -----------------
 sound/pci/hda/hda_codec.c      | 16 ++++++++++++----
 sound/pci/hda/hda_controller.c | 11 -----------
 sound/pci/hda/hda_intel.c      | 24 ++++++++---------------
 sound/pci/hda/patch_hdmi.c     |  4 ++--
 sound/soc/codecs/hdac_hdmi.c   |  7 +++----
 sound/soc/intel/skylake/skl.c  | 10 +++++-----
 11 files changed, 61 insertions(+), 79 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 0d98bb9068b1..7fa48b100936 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -236,6 +236,7 @@ struct hda_codec {
 	/* misc flags */
 	unsigned int in_freeing:1; /* being released */
 	unsigned int registered:1; /* codec was registered */
+	unsigned int display_power_control:1; /* needs display power */
 	unsigned int spdif_status_reset :1; /* needs to toggle SPDIF for each
 					     * status change
 					     * (e.g. Realtek codecs)
diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index 78626cde7081..b78add315b1f 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -6,9 +6,12 @@
 
 #include <drm/drm_audio_component.h>
 
+#define HDA_CODEC_IDX_CONTROLLER	16	/* virtual idx for controller */
+
 #ifdef CONFIG_SND_HDA_COMPONENT
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
-int snd_hdac_display_power(struct hdac_bus *bus, bool enable);
+int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx,
+			   bool enable);
 int snd_hdac_sync_audio_rate(struct hdac_device *codec, hda_nid_t nid,
 			     int dev_id, int rate);
 int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid, int dev_id,
@@ -25,7 +28,8 @@ static inline int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
 	return 0;
 }
-static inline int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
+static inline int snd_hdac_display_power(struct hdac_bus *bus,
+					 unsigned int idx, bool enable)
 {
 	return 0;
 }
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index cd1773d0e08f..940e2b282133 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -79,7 +79,6 @@ struct hdac_device {
 
 	/* misc flags */
 	atomic_t in_pm;		/* suspend/resume being performed */
-	bool  link_power_control:1;
 
 	/* sysfs */
 	struct hdac_widget_tree *widgets;
@@ -237,8 +236,6 @@ struct hdac_bus_ops {
 	/* get a response from the last command */
 	int (*get_response)(struct hdac_bus *bus, unsigned int addr,
 			    unsigned int *res);
-	/* control the link power  */
-	int (*link_power)(struct hdac_bus *bus, bool enable);
 };
 
 /*
@@ -363,7 +360,8 @@ struct hdac_bus {
 
 	/* DRM component interface */
 	struct drm_audio_component *audio_component;
-	int drm_power_refcount;
+	long display_power_status;
+	bool display_power_active;
 
 	/* parameters required for enhanced capabilities */
 	int num_streams;
@@ -404,7 +402,6 @@ int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val);
 int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 			      unsigned int *res);
 int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus);
-int snd_hdac_link_power(struct hdac_device *codec, bool enable);
 
 bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset);
 void snd_hdac_bus_stop_chip(struct hdac_bus *bus);
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index 6e46a9c73aed..dd766414436b 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -54,38 +54,45 @@ EXPORT_SYMBOL_GPL(snd_hdac_set_codec_wakeup);
 /**
  * snd_hdac_display_power - Power up / down the power refcount
  * @bus: HDA core bus
+ * @idx: HDA codec address, pass HDA_CODEC_IDX_CONTROLLER for controller
  * @enable: power up or down
  *
- * This function is supposed to be used only by a HD-audio controller
- * driver that needs the interaction with graphics driver.
+ * This function is used by either HD-audio controller or codec driver that
+ * needs the interaction with graphics driver.
  *
- * This function manages a refcount and calls the get_power() and
+ * This function updates the power status, and calls the get_power() and
  * put_power() ops accordingly, toggling the codec wakeup, too.
  *
  * Returns zero for success or a negative error code.
  */
-int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
+int snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 {
 	struct drm_audio_component *acomp = bus->audio_component;
 
-	if (!acomp || !acomp->ops)
-		return -ENODEV;
-
 	dev_dbg(bus->dev, "display power %s\n",
 		enable ? "enable" : "disable");
+	if (enable)
+		set_bit(idx, &bus->display_power_status);
+	else
+		clear_bit(idx, &bus->display_power_status);
 
-	if (enable) {
-		if (!bus->drm_power_refcount++) {
+	if (!acomp || !acomp->ops)
+		return 0;
+
+	if (bus->display_power_status) {
+		if (!bus->display_power_active) {
 			if (acomp->ops->get_power)
 				acomp->ops->get_power(acomp->dev);
 			snd_hdac_set_codec_wakeup(bus, true);
 			snd_hdac_set_codec_wakeup(bus, false);
+			bus->display_power_active = true;
 		}
 	} else {
-		WARN_ON(!bus->drm_power_refcount);
-		if (!--bus->drm_power_refcount)
+		if (bus->display_power_active) {
 			if (acomp->ops->put_power)
 				acomp->ops->put_power(acomp->dev);
+			bus->display_power_active = false;
+		}
 	}
 
 	return 0;
@@ -321,10 +328,12 @@ int snd_hdac_acomp_exit(struct hdac_bus *bus)
 	if (!acomp)
 		return 0;
 
-	WARN_ON(bus->drm_power_refcount);
-	if (bus->drm_power_refcount > 0 && acomp->ops)
+	if (WARN_ON(bus->display_power_active) && acomp->ops)
 		acomp->ops->put_power(acomp->dev);
 
+	bus->display_power_active = false;
+	bus->display_power_status = 0;
+
 	component_master_del(dev, &hdac_component_master_ops);
 
 	bus->audio_component = NULL;
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index dbf02a3a8d2f..95b073ee4b32 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -622,23 +622,6 @@ int snd_hdac_power_down_pm(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
 
-/**
- * snd_hdac_link_power - Enable/disable the link power for a codec
- * @codec: the codec object
- * @bool: enable or disable the link power
- */
-int snd_hdac_link_power(struct hdac_device *codec, bool enable)
-{
-	if  (!codec->link_power_control)
-		return 0;
-
-	if  (codec->bus->ops->link_power)
-		return codec->bus->ops->link_power(codec->bus, enable);
-	else
-		return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(snd_hdac_link_power);
-
 /* codec vendor labels */
 struct hda_vendor_id {
 	unsigned int id;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0957813939e5..9f8d59e7e89f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -36,6 +36,7 @@
 #include "hda_beep.h"
 #include "hda_jack.h"
 #include <sound/hda_hwdep.h>
+#include <sound/hda_component.h>
 
 #define codec_in_pm(codec)		snd_hdac_is_in_pm(&codec->core)
 #define hda_codec_is_power_on(codec)	snd_hdac_is_power_on(&codec->core)
@@ -799,6 +800,13 @@ void snd_hda_codec_cleanup_for_unbind(struct hda_codec *codec)
 static unsigned int hda_set_power_state(struct hda_codec *codec,
 				unsigned int power_state);
 
+/* enable/disable display power per codec */
+static void codec_display_power(struct hda_codec *codec, bool enable)
+{
+	if (codec->display_power_control)
+		snd_hdac_display_power(&codec->bus->core, codec->addr, enable);
+}
+
 /* also called from hda_bind.c */
 void snd_hda_codec_register(struct hda_codec *codec)
 {
@@ -806,7 +814,7 @@ void snd_hda_codec_register(struct hda_codec *codec)
 		return;
 	if (device_is_registered(hda_codec_dev(codec))) {
 		snd_hda_register_beep_device(codec);
-		snd_hdac_link_power(&codec->core, true);
+		codec_display_power(codec, true);
 		pm_runtime_enable(hda_codec_dev(codec));
 		/* it was powered up in snd_hda_codec_new(), now all done */
 		snd_hda_power_down(codec);
@@ -834,7 +842,7 @@ static int snd_hda_codec_dev_free(struct snd_device *device)
 
 	codec->in_freeing = 1;
 	snd_hdac_device_unregister(&codec->core);
-	snd_hdac_link_power(&codec->core, false);
+	codec_display_power(codec, false);
 	put_device(hda_codec_dev(codec));
 	return 0;
 }
@@ -2926,7 +2934,7 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	    (codec_has_clkstop(codec) && codec_has_epss(codec) &&
 	     (state & AC_PWRST_CLK_STOP_OK)))
 		snd_hdac_codec_link_down(&codec->core);
-	snd_hdac_link_power(&codec->core, false);
+	codec_display_power(codec, false);
 	return 0;
 }
 
@@ -2934,7 +2942,7 @@ static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
-	snd_hdac_link_power(&codec->core, true);
+	codec_display_power(codec, true);
 	snd_hdac_codec_link_up(&codec->core);
 	hda_call_codec_resume(codec);
 	pm_runtime_mark_last_busy(dev);
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index fe2506672a72..532e081f8b8a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -989,20 +989,9 @@ static int azx_get_response(struct hdac_bus *bus, unsigned int addr,
 		return azx_rirb_get_response(bus, addr, res);
 }
 
-static int azx_link_power(struct hdac_bus *bus, bool enable)
-{
-	struct azx *chip = bus_to_azx(bus);
-
-	if (chip->ops->link_power)
-		return chip->ops->link_power(chip, enable);
-	else
-		return -EINVAL;
-}
-
 static const struct hdac_bus_ops bus_core_ops = {
 	.command = azx_send_cmd,
 	.get_response = azx_get_response,
-	.link_power = azx_link_power,
 };
 
 #ifdef CONFIG_SND_HDA_DSP_LOADER
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cc06a323c817..151c6ca85ec6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -667,13 +667,8 @@ static int azx_position_check(struct azx *chip, struct azx_dev *azx_dev)
 	return 0;
 }
 
-/* Enable/disable i915 display power for the link */
-static int azx_intel_link_power(struct azx *chip, bool enable)
-{
-	struct hdac_bus *bus = azx_bus(chip);
-
-	return snd_hdac_display_power(bus, enable);
-}
+#define display_power(chip, enable) \
+	snd_hdac_display_power(azx_bus(chip), HDA_CODEC_IDX_CONTROLLER, enable)
 
 /*
  * Check whether the current DMA position is acceptable for updating
@@ -950,14 +945,12 @@ static bool azx_is_pm_ready(struct snd_card *card)
 
 static void __azx_runtime_suspend(struct azx *chip)
 {
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
-
 	azx_stop_chip(chip);
 	azx_enter_link_reset(chip);
 	azx_clear_irq_pending(chip);
 	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
 	    hda->need_i915_power)
-		snd_hdac_display_power(azx_bus(chip), false);
+		display_power(chip, false);
 }
 
 static void __azx_runtime_resume(struct azx *chip)
@@ -968,7 +961,7 @@ static void __azx_runtime_resume(struct azx *chip)
 	int status;
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		snd_hdac_display_power(bus, true);
+		display_power(chip, true);
 		if (hda->need_i915_power)
 			snd_hdac_i915_set_bclk(bus);
 	}
@@ -989,7 +982,7 @@ static void __azx_runtime_resume(struct azx *chip)
 	/* power down again for link-controlled chips */
 	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL) &&
 	    !hda->need_i915_power)
-		snd_hdac_display_power(bus, false);
+		display_power(chip, false);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1355,7 +1348,7 @@ static int azx_free(struct azx *chip)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		if (hda->need_i915_power)
-			snd_hdac_display_power(bus, false);
+			display_power(chip, false);
 	}
 	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT)
 		snd_hdac_i915_exit(bus);
@@ -2056,7 +2049,6 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.disable_msi_reset_irq = disable_msi_reset_irq,
 	.pcm_mmap_prepare = pcm_mmap_prepare,
 	.position_check = azx_position_check,
-	.link_power = azx_intel_link_power,
 };
 
 static int azx_probe(struct pci_dev *pci,
@@ -2239,7 +2231,7 @@ static int azx_probe_continue(struct azx *chip)
 		if (CONTROLLER_IN_GPU(pci))
 			hda->need_i915_power = 1;
 
-		err = snd_hdac_display_power(bus, true);
+		err = display_power(chip, true);
 		if (err < 0) {
 			dev_err(chip->card->dev,
 				"Cannot turn on display power on i915\n");
@@ -2295,7 +2287,7 @@ static int azx_probe_continue(struct azx *chip)
 out_free:
 	if ((chip->driver_caps & AZX_DCAPS_I915_POWERWELL)
 		&& !hda->need_i915_power)
-		snd_hdac_display_power(bus, false);
+		display_power(chip, false);
 
 i915_power_fail:
 	if (err < 0)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 67099cbb6be2..30fe4dbdb0ae 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2620,7 +2620,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 	 * can cover the codec power request, and so need not set this flag.
 	 */
 	if (!is_haswell(codec) && !is_broadwell(codec))
-		codec->core.link_power_control = 1;
+		codec->display_power_control = 1;
 
 	codec->patch_ops.set_power_state = haswell_set_power_state;
 	codec->depop_delay = 0;
@@ -2656,7 +2656,7 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 	/* For Valleyview/Cherryview, only the display codec is in the display
 	 * power well and can use link_power ops to request/release the power.
 	 */
-	codec->core.link_power_control = 1;
+	codec->display_power_control = 1;
 
 	codec->depop_delay = 0;
 	codec->auto_runtime_pm = 1;
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e63d6e33df48..c3d551d2af7f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2031,14 +2031,13 @@ static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 	 * Turned off in the runtime_suspend during the first explicit
 	 * pm_runtime_suspend call.
 	 */
-	ret = snd_hdac_display_power(hdev->bus, true);
+	ret = snd_hdac_display_power(hdev->bus, hdev->addr, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev,
 			"Cannot turn on display power on i915 err: %d\n",
 			ret);
 		return ret;
 	}
-
 	ret = hdac_hdmi_parse_and_map_nid(hdev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
 		dev_err(&hdev->dev,
@@ -2196,7 +2195,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	err = snd_hdac_display_power(bus, false);
+	err = snd_hdac_display_power(bus, hdev->addr, false);
 	if (err < 0)
 		dev_err(dev, "Cannot turn off display power on i915\n");
 
@@ -2224,7 +2223,7 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 	snd_hdac_ext_bus_link_get(bus, hlink);
 
-	err = snd_hdac_display_power(bus, true);
+	err = snd_hdac_display_power(bus, hdev->addr, true);
 	if (err < 0) {
 		dev_err(dev, "Cannot turn on display power on i915\n");
 		return err;
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 7487f388e65d..64f8433ae921 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -334,7 +334,7 @@ static int skl_suspend(struct device *dev)
 	}
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		ret = snd_hdac_display_power(bus, false);
+		ret = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 		if (ret < 0)
 			dev_err(bus->dev,
 				"Cannot turn OFF display power on i915\n");
@@ -353,7 +353,7 @@ static int skl_resume(struct device *dev)
 
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		ret = snd_hdac_display_power(bus, true);
+		ret = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"Cannot turn on display power on i915\n");
@@ -783,7 +783,7 @@ static int skl_i915_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
-	err = snd_hdac_display_power(bus, true);
+	err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
 	if (err < 0)
 		dev_err(bus->dev, "Cannot turn on display power on i915\n");
 
@@ -838,7 +838,7 @@ static void skl_probe_work(struct work_struct *work)
 		snd_hdac_ext_bus_link_put(bus, hlink);
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = snd_hdac_display_power(bus, false);
+		err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 		if (err < 0) {
 			dev_err(bus->dev, "Cannot turn off display power on i915\n");
 			skl_machine_device_unregister(skl);
@@ -855,7 +855,7 @@ static void skl_probe_work(struct work_struct *work)
 
 out_err:
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
-		err = snd_hdac_display_power(bus, false);
+		err = snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, false);
 }
 
 /*
-- 
2.19.2
