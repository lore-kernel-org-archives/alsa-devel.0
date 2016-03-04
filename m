From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 4/7] ALSA: hda - Add hdmi chmap verb
	programming ops to chmap object
Date: Fri,  4 Mar 2016 19:59:49 +0530
Message-ID: <1457101792-19441-5-git-send-email-subhransu.s.prusty@intel.com>
References: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3701D265767
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:29:52 +0100 (CET)
In-Reply-To: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Add slot and channel count programming to hdmi_chmap object and
move the chmap_ops to core. Use register_chmap_ops API to
register for default ops.  Override specific chmap ops in the
driver.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_chmap.h  | 10 ++++++
 sound/hda/Makefile         |  2 +-
 sound/hda/hdmi_chmap.c     | 49 ++++++++++++++++++++++++++
 sound/pci/hda/patch_hdmi.c | 87 +++++++++++++++-------------------------------
 4 files changed, 88 insertions(+), 60 deletions(-)
 create mode 100644 sound/hda/hdmi_chmap.c

diff --git a/include/sound/hda_chmap.h b/include/sound/hda_chmap.h
index d3f80e7..7afffb9 100644
--- a/include/sound/hda_chmap.h
+++ b/include/sound/hda_chmap.h
@@ -36,6 +36,14 @@ struct hdac_chmap_ops {
 	void (*set_chmap)(struct hdac_device *hdac, int pcm_idx,
 			unsigned char *chmap, int prepared);
 	bool (*is_pcm_attached)(struct hdac_device *hdac, int pcm_idx);
+
+	/* get and set channel assigned to each HDMI ASP (audio sample packet) slot */
+	int (*pin_get_slot_channel)(struct hdac_device *codec,
+			hda_nid_t pin_nid, int asp_slot);
+	int (*pin_set_slot_channel)(struct hdac_device *codec,
+			hda_nid_t pin_nid, int asp_slot, int channel);
+	void (*set_channel_count)(struct hdac_device *codec,
+				hda_nid_t cvt_nid, int chs);
 };
 
 struct hdac_chmap {
@@ -44,4 +52,6 @@ struct hdac_chmap {
 	struct hdac_device *hdac;
 };
 
+void snd_hdac_register_chmap_ops(struct hdac_device *hdac,
+				struct hdac_chmap *chmap);
 #endif /* __SOUND_HDA_CHMAP_H */
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 7e999c9..3b9bede 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,5 +1,5 @@
 snd-hda-core-objs := hda_bus_type.o hdac_bus.o hdac_device.o hdac_sysfs.o \
-	hdac_regmap.o hdac_controller.o hdac_stream.o array.o
+	hdac_regmap.o hdac_controller.o hdac_stream.o array.o hdmi_chmap.o
 
 snd-hda-core-objs += trace.o
 CFLAGS_trace.o := -I$(src)
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
new file mode 100644
index 0000000..6b98790
--- /dev/null
+++ b/sound/hda/hdmi_chmap.c
@@ -0,0 +1,49 @@
+/*
+ * HDMI Channel map support helpers
+ */
+
+#include <sound/hda_chmap.h>
+
+static int hdmi_pin_set_slot_channel(struct hdac_device *codec,
+		hda_nid_t pin_nid, int asp_slot, int channel)
+{
+	return snd_hdac_codec_write(codec, pin_nid, 0,
+				AC_VERB_SET_HDMI_CHAN_SLOT,
+				(channel << 4) | asp_slot);
+}
+
+static int hdmi_pin_get_slot_channel(struct hdac_device *codec,
+			hda_nid_t pin_nid, int asp_slot)
+{
+	return (snd_hdac_codec_read(codec, pin_nid, 0,
+				   AC_VERB_GET_HDMI_CHAN_SLOT,
+				   asp_slot) & 0xf0) >> 4;
+}
+
+static int hdmi_get_channel_count(struct hdac_device *codec, hda_nid_t cvt_nid)
+{
+	return 1 + snd_hdac_codec_read(codec, cvt_nid, 0,
+					AC_VERB_GET_CVT_CHAN_COUNT, 0);
+}
+
+static void hdmi_set_channel_count(struct hdac_device *codec,
+				   hda_nid_t cvt_nid, int chs)
+{
+	if (chs != hdmi_get_channel_count(codec, cvt_nid))
+		snd_hdac_codec_write(codec, cvt_nid, 0,
+				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
+}
+
+static const struct hdac_chmap_ops chmap_ops = {
+	.pin_get_slot_channel			= hdmi_pin_get_slot_channel,
+	.pin_set_slot_channel			= hdmi_pin_set_slot_channel,
+	.set_channel_count			= hdmi_set_channel_count,
+};
+
+void snd_hdac_register_chmap_ops(struct hdac_device *hdac,
+				struct hdac_chmap *chmap)
+{
+	chmap->ops = chmap_ops;
+	chmap->hdac = hdac;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_register_chmap_ops);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d73f54e..5dfc839 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -105,12 +105,6 @@ struct hdmi_ops {
 	int (*pin_get_eld)(struct hda_codec *codec, hda_nid_t pin_nid,
 			   unsigned char *buf, int *eld_size);
 
-	/* get and set channel assigned to each HDMI ASP (audio sample packet) slot */
-	int (*pin_get_slot_channel)(struct hda_codec *codec, hda_nid_t pin_nid,
-				    int asp_slot);
-	int (*pin_set_slot_channel)(struct hda_codec *codec, hda_nid_t pin_nid,
-				    int asp_slot, int channel);
-
 	void (*pin_setup_infoframe)(struct hda_codec *codec, hda_nid_t pin_nid,
 				    int ca, int active_channels, int conn_type);
 
@@ -596,20 +590,6 @@ static void hdmi_init_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 			    AC_VERB_SET_PIN_WIDGET_CONTROL, pin_out);
 }
 
-static int hdmi_get_channel_count(struct hda_codec *codec, hda_nid_t cvt_nid)
-{
-	return 1 + snd_hda_codec_read(codec, cvt_nid, 0,
-					AC_VERB_GET_CVT_CHAN_COUNT, 0);
-}
-
-static void hdmi_set_channel_count(struct hda_codec *codec,
-				   hda_nid_t cvt_nid, int chs)
-{
-	if (chs != hdmi_get_channel_count(codec, cvt_nid))
-		snd_hda_codec_write(codec, cvt_nid, 0,
-				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
-}
-
 /*
  * ELD proc files
  */
@@ -778,7 +758,8 @@ static void hdmi_debug_channel_mapping(struct hda_codec *codec,
 	int channel;
 
 	for (i = 0; i < 8; i++) {
-		channel = spec->ops.pin_get_slot_channel(codec, pin_nid, i);
+		channel = spec->chmap.ops.pin_get_slot_channel(
+				&codec->core, pin_nid, i);
 		codec_dbg(codec, "HDMI: ASP channel %d => slot %d\n",
 						channel, i);
 	}
@@ -826,7 +807,8 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 		int slotsetup = non_pcm ? non_pcm_mapping[i] : hdmi_channel_mapping[ca][i];
 		int hdmi_slot = slotsetup & 0x0f;
 		int channel = (slotsetup & 0xf0) >> 4;
-		err = spec->ops.pin_set_slot_channel(codec, pin_nid, hdmi_slot, channel);
+		err = spec->chmap.ops.pin_set_slot_channel(
+				&codec->core, pin_nid, hdmi_slot, channel);
 		if (err) {
 			codec_dbg(codec, "HDMI: channel mapping failed\n");
 			break;
@@ -953,8 +935,8 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 	for (hdmi_slot = 0; hdmi_slot < 8; hdmi_slot++) {
 		int err;
 
-		err = spec->ops.pin_set_slot_channel(codec, pin_nid, hdmi_slot,
-						     assignments[hdmi_slot]);
+		err = spec->chmap.ops.pin_set_slot_channel(&codec->core,
+				pin_nid, hdmi_slot, assignments[hdmi_slot]);
 		if (err)
 			return -EINVAL;
 	}
@@ -990,22 +972,6 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 	hdmi_debug_channel_mapping(codec, pin_nid);
 }
 
-static int hdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
-				     int asp_slot, int channel)
-{
-	return snd_hda_codec_write(codec, pin_nid, 0,
-				   AC_VERB_SET_HDMI_CHAN_SLOT,
-				   (channel << 4) | asp_slot);
-}
-
-static int hdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
-				     int asp_slot)
-{
-	return (snd_hda_codec_read(codec, pin_nid, 0,
-				   AC_VERB_GET_HDMI_CHAN_SLOT,
-				   asp_slot) & 0xf0) >> 4;
-}
-
 /*
  * Audio InfoFrame routines
  */
@@ -1181,6 +1147,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 				       bool non_pcm)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct hdac_chmap *chmap = &spec->chmap;
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	int channels = per_pin->channels;
 	int active_channels;
@@ -1207,7 +1174,8 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	ordered_ca = get_channel_allocation_order(ca);
 	active_channels = channel_allocations[ordered_ca].channels;
 
-	hdmi_set_channel_count(codec, per_pin->cvt_nid, active_channels);
+	chmap->ops.set_channel_count(&codec->core, per_pin->cvt_nid,
+						active_channels);
 
 	/*
 	 * always configure channel mapping, it may have been changed by the
@@ -2815,21 +2783,11 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 
 static const struct hdmi_ops generic_standard_hdmi_ops = {
 	.pin_get_eld				= snd_hdmi_get_eld,
-	.pin_get_slot_channel			= hdmi_pin_get_slot_channel,
-	.pin_set_slot_channel			= hdmi_pin_set_slot_channel,
 	.pin_setup_infoframe			= hdmi_pin_setup_infoframe,
 	.pin_hbr_setup				= hdmi_pin_hbr_setup,
 	.setup_stream				= hdmi_setup_stream,
 };
 
-static const struct hdac_chmap_ops chmap_ops = {
-	.chmap_cea_alloc_validate_get_type	= hdmi_chmap_cea_alloc_validate_get_type,
-	.cea_alloc_to_tlv_chmap			= hdmi_cea_alloc_to_tlv_chmap,
-	.get_chmap				= hdmi_get_chmap,
-	.set_chmap				= hdmi_set_chmap,
-	.is_pcm_attached			= is_hdmi_pcm_attached,
-};
-
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 					     hda_nid_t nid)
 {
@@ -2931,8 +2889,15 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 
 	spec->ops = generic_standard_hdmi_ops;
 	mutex_init(&spec->pcm_lock);
-	spec->chmap.ops = chmap_ops;
-	spec->chmap.hdac = &codec->core;
+	snd_hdac_register_chmap_ops(&codec->core, &spec->chmap);
+
+	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
+		hdmi_chmap_cea_alloc_validate_get_type;
+	spec->chmap.ops.cea_alloc_to_tlv_chmap = hdmi_cea_alloc_to_tlv_chmap;
+	spec->chmap.ops.get_chmap = hdmi_get_chmap;
+	spec->chmap.ops.set_chmap = hdmi_set_chmap;
+	spec->chmap.ops.is_pcm_attached = is_hdmi_pcm_attached;
+
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
@@ -3846,9 +3811,10 @@ static int atihdmi_paired_chmap_validate(int ca, int chs, unsigned char *map)
 	return 0;
 }
 
-static int atihdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
-					int hdmi_slot, int stream_channel)
+static int atihdmi_pin_set_slot_channel(struct hdac_device *hdac,
+		hda_nid_t pin_nid, int hdmi_slot, int stream_channel)
 {
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
 	int verb;
 	int ati_channel_setup = 0;
 
@@ -3881,9 +3847,10 @@ static int atihdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_n
 	return snd_hda_codec_write(codec, pin_nid, 0, verb, ati_channel_setup);
 }
 
-static int atihdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
-					int asp_slot)
+static int atihdmi_pin_get_slot_channel(struct hdac_device *hdac,
+				hda_nid_t pin_nid, int asp_slot)
 {
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
 	bool was_odd = false;
 	int ati_asp_slot = asp_slot;
 	int verb;
@@ -4053,8 +4020,6 @@ static int patch_atihdmi(struct hda_codec *codec)
 	spec = codec->spec;
 
 	spec->ops.pin_get_eld = atihdmi_pin_get_eld;
-	spec->ops.pin_get_slot_channel = atihdmi_pin_get_slot_channel;
-	spec->ops.pin_set_slot_channel = atihdmi_pin_set_slot_channel;
 	spec->ops.pin_setup_infoframe = atihdmi_pin_setup_infoframe;
 	spec->ops.pin_hbr_setup = atihdmi_pin_hbr_setup;
 	spec->ops.setup_stream = atihdmi_setup_stream;
@@ -4066,6 +4031,10 @@ static int patch_atihdmi(struct hda_codec *codec)
 		spec->chmap.ops.cea_alloc_to_tlv_chmap =
 				atihdmi_paired_cea_alloc_to_tlv_chmap;
 		spec->chmap.ops.chmap_validate = atihdmi_paired_chmap_validate;
+		spec->chmap.ops.pin_get_slot_channel =
+				atihdmi_pin_get_slot_channel;
+		spec->chmap.ops.pin_set_slot_channel =
+				atihdmi_pin_set_slot_channel;
 	}
 
 	/* ATI/AMD converters do not advertise all of their capabilities */
-- 
1.9.1
