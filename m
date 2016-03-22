From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/7] ALSA: hda - Add the pin / port mapping on
	Intel ILK and VLV
Date: Tue, 22 Mar 2016 12:29:32 +0100
Message-ID: <1458646173-14520-7-git-send-email-tiwai@suse.de>
References: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 288A42658EE
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 12:29:36 +0100 (CET)
In-Reply-To: <1458646173-14520-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Intel IronLake and ValleyView platforms have different HDMI widget pin
and digital port mapping from other newer ones.  The recent ones
(HSW+) have NID 0x05 to 0x07 for port B to port D, while these chips
have NID 0x04 to 0x06.

For adapting this mapping, pass the codec object instead of the bus
object to snd_hdac_sync_audio_rate() and snd_hdac_acomp_get_eld() so
that they can check the codec ID and calculate the mapping properly.

The changes in the HDMI codec driver side will follow in the later
patch.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_i915.h   | 10 +++++-----
 sound/hda/hdac_i915.c      | 45 ++++++++++++++++++++++++++++++++++-----------
 sound/pci/hda/patch_hdmi.c |  4 ++--
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/sound/hda_i915.h b/include/sound/hda_i915.h
index fa341fcb5829..eed87a7559b7 100644
--- a/include/sound/hda_i915.h
+++ b/include/sound/hda_i915.h
@@ -10,8 +10,8 @@
 int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable);
 int snd_hdac_display_power(struct hdac_bus *bus, bool enable);
 int snd_hdac_get_display_clk(struct hdac_bus *bus);
-int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid, int rate);
-int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
+int snd_hdac_sync_audio_rate(struct hdac_device *codec, hda_nid_t nid, int rate);
+int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
 			   bool *audio_enabled, char *buffer, int max_bytes);
 int snd_hdac_i915_init(struct hdac_bus *bus);
 int snd_hdac_i915_exit(struct hdac_bus *bus);
@@ -29,12 +29,12 @@ static inline int snd_hdac_get_display_clk(struct hdac_bus *bus)
 {
 	return 0;
 }
-static inline int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid,
-					   int rate)
+static inline int snd_hdac_sync_audio_rate(struct hdac_device *codec,
+					   hda_nid_t nid, int rate)
 {
 	return 0;
 }
-static inline int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
+static inline int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
 					 bool *audio_enabled, char *buffer,
 					 int max_bytes)
 {
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index fb96aead8257..750a4ea49fa9 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -118,22 +118,40 @@ int snd_hdac_get_display_clk(struct hdac_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hdac_get_display_clk);
 
-/* There is a fixed mapping between audio pin node and display port
- * on current Intel platforms:
+/* There is a fixed mapping between audio pin node and display port.
+ * on SNB, IVY, HSW, BSW, SKL, BXT, KBL:
  * Pin Widget 5 - PORT B (port = 1 in i915 driver)
  * Pin Widget 6 - PORT C (port = 2 in i915 driver)
  * Pin Widget 7 - PORT D (port = 3 in i915 driver)
+ *
+ * on VLV, ILK:
+ * Pin Widget 4 - PORT B (port = 1 in i915 driver)
+ * Pin Widget 5 - PORT C (port = 2 in i915 driver)
+ * Pin Widget 6 - PORT D (port = 3 in i915 driver)
  */
-static int pin2port(hda_nid_t pin_nid)
+static int pin2port(struct hdac_device *codec, hda_nid_t pin_nid)
 {
-	if (WARN_ON(pin_nid < 5 || pin_nid > 7))
+	int base_nid;
+
+	switch (codec->vendor_id) {
+	case 0x80860054: /* ILK */
+	case 0x80862804: /* ILK */
+	case 0x80862882: /* VLV */
+		base_nid = 3;
+		break;
+	default:
+		base_nid = 4;
+		break;
+	}
+
+	if (WARN_ON(pin_nid <= base_nid || pin_nid > base_nid + 3))
 		return -1;
-	return pin_nid - 4;
+	return pin_nid - base_nid;
 }
 
 /**
  * snd_hdac_sync_audio_rate - Set N/CTS based on the sample rate
- * @bus: HDA core bus
+ * @codec: HDA codec
  * @nid: the pin widget NID
  * @rate: the sample rate to set
  *
@@ -143,14 +161,15 @@ static int pin2port(hda_nid_t pin_nid)
  * This function sets N/CTS value based on the given sample rate.
  * Returns zero for success, or a negative error code.
  */
-int snd_hdac_sync_audio_rate(struct hdac_bus *bus, hda_nid_t nid, int rate)
+int snd_hdac_sync_audio_rate(struct hdac_device *codec, hda_nid_t nid, int rate)
 {
+	struct hdac_bus *bus = codec->bus;
 	struct i915_audio_component *acomp = bus->audio_component;
 	int port;
 
 	if (!acomp || !acomp->ops || !acomp->ops->sync_audio_rate)
 		return -ENODEV;
-	port = pin2port(nid);
+	port = pin2port(codec, nid);
 	if (port < 0)
 		return -EINVAL;
 	return acomp->ops->sync_audio_rate(acomp->dev, port, rate);
@@ -159,7 +178,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_sync_audio_rate);
 
 /**
  * snd_hdac_acomp_get_eld - Get the audio state and ELD via component
- * @bus: HDA core bus
+ * @codec: HDA codec
  * @nid: the pin widget NID
  * @audio_enabled: the pointer to store the current audio state
  * @buffer: the buffer pointer to store ELD bytes
@@ -177,16 +196,17 @@ EXPORT_SYMBOL_GPL(snd_hdac_sync_audio_rate);
  * thus it may be over @max_bytes.  If it's over @max_bytes, it implies
  * that only a part of ELD bytes have been fetched.
  */
-int snd_hdac_acomp_get_eld(struct hdac_bus *bus, hda_nid_t nid,
+int snd_hdac_acomp_get_eld(struct hdac_device *codec, hda_nid_t nid,
 			   bool *audio_enabled, char *buffer, int max_bytes)
 {
+	struct hdac_bus *bus = codec->bus;
 	struct i915_audio_component *acomp = bus->audio_component;
 	int port;
 
 	if (!acomp || !acomp->ops || !acomp->ops->get_eld)
 		return -ENODEV;
 
-	port = pin2port(nid);
+	port = pin2port(codec, nid);
 	if (port < 0)
 		return -EINVAL;
 	return acomp->ops->get_eld(acomp->dev, port, audio_enabled,
@@ -286,6 +306,9 @@ int snd_hdac_i915_init(struct hdac_bus *bus)
 	struct i915_audio_component *acomp;
 	int ret;
 
+	if (WARN_ON(hdac_acomp))
+		return -EBUSY;
+
 	acomp = kzalloc(sizeof(*acomp), GFP_KERNEL);
 	if (!acomp)
 		return -ENOMEM;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 09eb26c5730c..7e09f5e584c6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1486,7 +1486,7 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 
 	mutex_lock(&per_pin->lock);
 	eld->monitor_present = false;
-	size = snd_hdac_acomp_get_eld(&codec->bus->core, per_pin->pin_nid,
+	size = snd_hdac_acomp_get_eld(&codec->core, per_pin->pin_nid,
 				      &eld->monitor_present, eld->eld_buffer,
 				      ELD_MAX_SIZE);
 	if (size > 0) {
@@ -1740,7 +1740,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	/* Call sync_audio_rate to set the N/CTS/M manually if necessary */
 	/* Todo: add DP1.2 MST audio support later */
 	if (codec_has_acomp(codec))
-		snd_hdac_sync_audio_rate(&codec->bus->core, pin_nid, runtime->rate);
+		snd_hdac_sync_audio_rate(&codec->core, pin_nid, runtime->rate);
 
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
 	mutex_lock(&per_pin->lock);
-- 
2.7.4
