From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Work around races of power
	up/down with runtime PM
Date: Wed,  8 Apr 2015 16:44:59 +0200
Message-ID: <1428504299-19763-2-git-send-email-tiwai@suse.de>
References: <1428504299-19763-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E759265388
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 16:45:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ED6E2AD4F
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 14:45:00 +0000 (UTC)
In-Reply-To: <1428504299-19763-1-git-send-email-tiwai@suse.de>
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

Currently, snd_hdac_power_up()/down() helpers checks whether the codec
is being in pm (suspend/resume), and skips the call of runtime get/put
during it.  This is needed as there are lots of power up/down
sequences called in the paths that are also used in the PM itself.  An
example is found in hda_codec.c::codec_exec_verb(), where this can
power up the codec while it may be called again in its power up
sequence, too.

The above works in most cases, but sometimes we really want to wait
for the real power up.  For example, the control element get/put may
want explicit power up so that the value change is assured to reach to
the hardware.   Using the current snd_hdac_power_up(), however,
results in a race, e.g. when it's called during the runtime suspend is
being performed.  In the worst case, as found in patch_ca0132.c, it
can even lead to the deadlock because the code assumes the power up
while it was skipped due to the check above.

For dealing with such cases, this patch makes snd_hdac_power_up() and
_down() to two variants: with and without in_pm flag check.  The
version with pm flag check is named as snd_hdac_power_up_pm() while
the version without pm flag check is still kept as
snd_hdac_power_up().  (Just because the usage of the former is fewer.)

Then finally, the patch replaces each call potentially done in PM with
the new _pm() variant.

In theory, we can implement a unified version -- if we can distinguish
the current context whether it's in the pm path.  But such an
implementation is cumbersome, so leave the code like this a bit messy
way for now...

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96271
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h      | 28 ++++++++++++++++++++++++++++
 sound/hda/hdac_device.c      | 16 +++++++---------
 sound/hda/hdac_regmap.c      |  8 ++++----
 sound/pci/hda/hda_codec.c    |  8 ++++----
 sound/pci/hda/hda_codec.h    |  2 ++
 sound/pci/hda/patch_ca0132.c | 12 ++++++------
 sound/pci/hda/patch_hdmi.c   |  4 ++--
 7 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 95acc337aea5..30446f17c6a6 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -144,6 +144,34 @@ static inline void snd_hdac_power_up(struct hdac_device *codec) {}
 static inline void snd_hdac_power_down(struct hdac_device *codec) {}
 #endif
 
+/**
+ * snd_hdac_power_up_pm - power up the codec
+ * @codec: the codec object
+ *
+ * This function can be called in a recursive code path like init code
+ * which may be called by PM suspend/resume again.  OTOH, if a power-up
+ * call must wake up the sleeper (e.g. in a kctl callback), use
+ * snd_hdac_power_up() instead.
+ */
+static inline void snd_hdac_power_up_pm(struct hdac_device *codec)
+{
+	if (!atomic_read(&codec->in_pm))
+		snd_hdac_power_up(codec);
+}
+
+/**
+ * snd_hdac_power_down_pm - power down the codec
+ * @codec: the codec object
+ *
+ * Like snd_hdac_power_up_pm(), this function is used in a recursive
+ * code path like init code which may be called by PM suspend/resume again.
+ */
+static inline void snd_hdac_power_down_pm(struct hdac_device *codec)
+{
+	if (!atomic_read(&codec->in_pm))
+		snd_hdac_power_down(codec);
+}
+
 /*
  * HD-audio codec base driver
  */
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index d4a0e723af2c..92604bbcee5f 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -494,29 +494,27 @@ EXPORT_SYMBOL_GPL(snd_hdac_get_connections);
 
 #ifdef CONFIG_PM
 /**
- * snd_hdac_power_up - increment the runtime pm counter
+ * snd_hdac_power_up - power up the codec
  * @codec: the codec object
+ *
+ * This function calls the runtime PM helper to power up the given codec.
+ * Unlike snd_hdac_power_up_pm(), you should call this only for the code
+ * path that isn't included in PM path.  Otherwise it gets stuck.
  */
 void snd_hdac_power_up(struct hdac_device *codec)
 {
-	struct device *dev = &codec->dev;
-
-	if (atomic_read(&codec->in_pm))
-		return;
-	pm_runtime_get_sync(dev);
+	pm_runtime_get_sync(&codec->dev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_power_up);
 
 /**
- * snd_hdac_power_up - decrement the runtime pm counter
+ * snd_hdac_power_down - power down the codec
  * @codec: the codec object
  */
 void snd_hdac_power_down(struct hdac_device *codec)
 {
 	struct device *dev = &codec->dev;
 
-	if (atomic_read(&codec->in_pm))
-		return;
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 1eb43209fe2c..64876fa357c9 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -402,9 +402,9 @@ int snd_hdac_regmap_write_raw(struct hdac_device *codec, unsigned int reg,
 
 	err = reg_raw_write(codec, reg, val);
 	if (err == -EAGAIN) {
-		snd_hdac_power_up(codec);
+		snd_hdac_power_up_pm(codec);
 		err = reg_raw_write(codec, reg, val);
-		snd_hdac_power_down(codec);
+		snd_hdac_power_down_pm(codec);
 	}
 	return err;
 }
@@ -434,9 +434,9 @@ int snd_hdac_regmap_read_raw(struct hdac_device *codec, unsigned int reg,
 
 	err = reg_raw_read(codec, reg, val);
 	if (err == -EAGAIN) {
-		snd_hdac_power_up(codec);
+		snd_hdac_power_up_pm(codec);
 		err = reg_raw_read(codec, reg, val);
-		snd_hdac_power_down(codec);
+		snd_hdac_power_down_pm(codec);
 	}
 	return err;
 }
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 16dfa1ed10dd..e70a7fb393dd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -137,7 +137,7 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 		return -1;
 
  again:
-	snd_hda_power_up(codec);
+	snd_hda_power_up_pm(codec);
 	mutex_lock(&bus->core.cmd_mutex);
 	if (flags & HDA_RW_NO_RESPONSE_FALLBACK)
 		bus->no_response_fallback = 1;
@@ -145,7 +145,7 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 					      cmd, res);
 	bus->no_response_fallback = 0;
 	mutex_unlock(&bus->core.cmd_mutex);
-	snd_hda_power_down(codec);
+	snd_hda_power_down_pm(codec);
 	if (!codec_in_pm(codec) && res && err < 0 && bus->rirb_error) {
 		if (bus->response_reset) {
 			codec_dbg(codec,
@@ -3951,7 +3951,7 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 			if (!(v & HDA_AMP_MUTE) && v > 0) {
 				if (!check->power_on) {
 					check->power_on = 1;
-					snd_hda_power_up(codec);
+					snd_hda_power_up_pm(codec);
 				}
 				return 1;
 			}
@@ -3959,7 +3959,7 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 	}
 	if (check->power_on) {
 		check->power_on = 0;
-		snd_hda_power_down(codec);
+		snd_hda_power_down_pm(codec);
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index acf868c6a785..9075ac28dc4b 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -508,7 +508,9 @@ const char *snd_hda_get_jack_location(u32 cfg);
  * power saving
  */
 #define snd_hda_power_up(codec)		snd_hdac_power_up(&(codec)->core)
+#define snd_hda_power_up_pm(codec)	snd_hdac_power_up_pm(&(codec)->core)
 #define snd_hda_power_down(codec)	snd_hdac_power_down(&(codec)->core)
+#define snd_hda_power_down_pm(codec)	snd_hdac_power_down_pm(&(codec)->core)
 #ifdef CONFIG_PM
 void snd_hda_set_power_save(struct hda_bus *bus, int delay);
 void snd_hda_update_power_acct(struct hda_codec *codec);
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5aff35a09fd4..4a4e7b282e4f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3131,7 +3131,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 
 	codec_dbg(codec, "ca0132_select_out\n");
 
-	snd_hda_power_up(codec);
+	snd_hda_power_up_pm(codec);
 
 	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
 
@@ -3215,7 +3215,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 	}
 
 exit:
-	snd_hda_power_down(codec);
+	snd_hda_power_down_pm(codec);
 
 	return err < 0 ? err : 0;
 }
@@ -3293,7 +3293,7 @@ static int ca0132_select_mic(struct hda_codec *codec)
 
 	codec_dbg(codec, "ca0132_select_mic\n");
 
-	snd_hda_power_up(codec);
+	snd_hda_power_up_pm(codec);
 
 	auto_jack = spec->vnode_lswitch[VNID_AMIC1_ASEL - VNODE_START_NID];
 
@@ -3326,7 +3326,7 @@ static int ca0132_select_mic(struct hda_codec *codec)
 		ca0132_effects_set(codec, VOICE_FOCUS, 0);
 	}
 
-	snd_hda_power_down(codec);
+	snd_hda_power_down_pm(codec);
 
 	return 0;
 }
@@ -4546,7 +4546,7 @@ static int ca0132_init(struct hda_codec *codec)
 		spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->curr_chip_addx = INVALID_CHIP_ADDRESS;
 
-	snd_hda_power_up(codec);
+	snd_hda_power_up_pm(codec);
 
 	ca0132_init_unsol(codec);
 
@@ -4577,7 +4577,7 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_jack_report_sync(codec);
 
-	snd_hda_power_down(codec);
+	snd_hda_power_down_pm(codec);
 
 	return 0;
 }
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ca0c05e1c42e..5f44f60a6389 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1545,7 +1545,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	bool eld_changed = false;
 	bool ret;
 
-	snd_hda_power_up(codec);
+	snd_hda_power_up_pm(codec);
 	present = snd_hda_pin_sense(codec, pin_nid);
 
 	mutex_lock(&per_pin->lock);
@@ -1631,7 +1631,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		jack->block_report = !ret;
 
 	mutex_unlock(&per_pin->lock);
-	snd_hda_power_down(codec);
+	snd_hda_power_down_pm(codec);
 	return ret;
 }
 
-- 
2.3.4
