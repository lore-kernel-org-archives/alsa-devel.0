From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add / fix kernel doc comments
Date: Wed, 28 Oct 2015 12:38:07 +0100
Message-ID: <1446032287-9686-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4383C261504
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 12:38:09 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D728DACAB
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 11:38:25 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Give some readable comment in kernel doc style for each exported
function, as I promised in the previous meetings.  While we're at it,
fix the wrong comments, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_bus.c    | 14 ++++++++++
 sound/hda/hdac_device.c | 10 ++++---
 sound/hda/hdac_i915.c   | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 sound/hda/hdac_regmap.c | 10 +++++++
 sound/hda/hdac_stream.c |  3 ++-
 5 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 27c447e4fe5c..0e81ea89a596 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -172,6 +172,15 @@ static void process_unsol_events(struct work_struct *work)
 	}
 }
 
+/**
+ * snd_hdac_bus_add_device - Add a codec to bus
+ * @bus: HDA core bus
+ * @codec: HDA core device to add
+ *
+ * Adds the given codec to the list in the bus.  The caddr_tbl array
+ * and codec_powered bits are updated, as well.
+ * Returns zero if success, or a negative error code.
+ */
 int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec)
 {
 	if (bus->caddr_tbl[codec->addr]) {
@@ -188,6 +197,11 @@ int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_add_device);
 
+/**
+ * snd_hdac_bus_remove_device - Remove a codec from bus
+ * @bus: HDA core bus
+ * @codec: HDA core device to remove
+ */
 void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 				struct hdac_device *codec)
 {
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index bbdb25f5bbb9..e361024eabb6 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -629,8 +629,10 @@ int snd_hdac_power_down_pm(struct hdac_device *codec)
 EXPORT_SYMBOL_GPL(snd_hdac_power_down_pm);
 #endif
 
-/*
- * Enable/disable the link power for a codec.
+/**
+ * snd_hdac_link_power - Enable/disable the link power for a codec
+ * @codec: the codec object
+ * @bool: enable or disable the link power
  */
 int snd_hdac_link_power(struct hdac_device *codec, bool enable)
 {
@@ -1048,8 +1050,8 @@ int snd_hdac_codec_write(struct hdac_device *hdac, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hdac_codec_write);
 
-/*
- * snd_hdac_check_power_state: check whether the actual power state matches
+/**
+ * snd_hdac_check_power_state - check whether the actual power state matches
  * with the target state
  *
  * @hdac: the HDAC device
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 55c3df4458f7..8fef1b8d1fd8 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -23,6 +23,19 @@
 
 static struct i915_audio_component *hdac_acomp;
 
+/**
+ * snd_hdac_set_codec_wakeup - Enable / disable HDMI/DP codec wakeup
+ * @bus: HDA core bus
+ * @enable: enable or disable the wakeup
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function should be called during the chip reset, also called at
+ * resume for updating STATESTS register read.
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
@@ -45,6 +58,19 @@ int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_set_codec_wakeup);
 
+/**
+ * snd_hdac_display_power - Power up / down the power refcount
+ * @bus: HDA core bus
+ * @enable: power up or down
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function manages a refcount and calls the i915 get_power() and
+ * put_power() ops accordingly, toggling the codec wakeup, too.
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
@@ -71,6 +97,16 @@ int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_display_power);
 
+/**
+ * snd_hdac_get_display_clk - Get CDCLK in kHz
+ * @bus: HDA core bus
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function queries CDCLK value in kHz from the graphics driver and
+ * returns the value.  A negative code is returned in error.
+ */
 int snd_hdac_get_display_clk(struct hdac_bus *bus)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
@@ -134,6 +170,17 @@ static int hdac_component_master_match(struct device *dev, void *data)
 	return !strcmp(dev->driver->name, "i915");
 }
 
+/**
+ * snd_hdac_i915_register_notifier - Register i915 audio component ops
+ * @aops: i915 audio component ops
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function sets the given ops to be called by the i915 graphics driver.
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops *aops)
 {
 	if (WARN_ON(!hdac_acomp))
@@ -144,6 +191,18 @@ int snd_hdac_i915_register_notifier(const struct i915_audio_component_audio_ops
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_register_notifier);
 
+/**
+ * snd_hdac_i915_init - Initialize i915 audio component
+ * @bus: HDA core bus
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function initializes and sets up the audio component to communicate
+ * with i915 graphics driver.
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_i915_init(struct hdac_bus *bus)
 {
 	struct component_match *match = NULL;
@@ -187,6 +246,17 @@ out_err:
 }
 EXPORT_SYMBOL_GPL(snd_hdac_i915_init);
 
+/**
+ * snd_hdac_i915_exit - Finalize i915 audio component
+ * @bus: HDA core bus
+ *
+ * This function is supposed to be used only by a HD-audio controller
+ * driver that needs the interaction with i915 graphics.
+ *
+ * This function releases the i915 audio component that has been used.
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_i915_exit(struct hdac_bus *bus)
 {
 	struct device *dev = bus->dev;
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index b0ed870ffb88..eb8f7c30cb09 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -339,6 +339,12 @@ static const struct regmap_config hda_regmap_cfg = {
 	.use_single_rw = true,
 };
 
+/**
+ * snd_hdac_regmap_init - Initialize regmap for HDA register accesses
+ * @codec: the codec object
+ *
+ * Returns zero for success or a negative error code.
+ */
 int snd_hdac_regmap_init(struct hdac_device *codec)
 {
 	struct regmap *regmap;
@@ -352,6 +358,10 @@ int snd_hdac_regmap_init(struct hdac_device *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_init);
 
+/**
+ * snd_hdac_regmap_init - Release the regmap from HDA codec
+ * @codec: the codec object
+ */
 void snd_hdac_regmap_exit(struct hdac_device *codec)
 {
 	if (codec->regmap) {
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 8981159813ef..38990a77d7b7 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -426,7 +426,8 @@ int snd_hdac_stream_setup_periods(struct hdac_stream *azx_dev)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_setup_periods);
 
-/* snd_hdac_stream_set_params - set stream parameters
+/**
+ * snd_hdac_stream_set_params - set stream parameters
  * @azx_dev: HD-audio core stream for which parameters are to be set
  * @format_val: format value parameter
  *
-- 
2.6.2
