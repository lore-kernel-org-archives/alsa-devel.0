From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 1/5] ALSA: hda - hdmi: Allow HDA patches to
	customize more operations
Date: Thu, 24 Oct 2013 21:10:34 +0300
Message-ID: <1382638238-25055-2-git-send-email-anssi.hannula@iki.fi>
References: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirokuusama.dnainternet.net (sirokuusama.dnainternet.net
 [83.102.40.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 565EE261A3F
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 20:10:53 +0200 (CEST)
In-Reply-To: <1382638238-25055-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Langlois <olivier@trillion01.com>, alsa-devel@alsa-project.org, =?UTF-8?q?Peter=20Fr=C3=BChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

Upcoming AMD multichannel support requires many customized operations
(channel mapping, ELD, HBR) but can otherwise share most of its code
with the generic patch.

Add a local struct hdmi_ops containing customizable HDMI-specific
callbacks and move the current code to those callbacks. Functionality is
unaltered.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 275 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 195 insertions(+), 80 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a1fe4bb..b11cbe0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -82,6 +82,39 @@ struct hdmi_spec_per_pin {
 #endif
 };
 
+struct cea_channel_speaker_allocation;
+
+/* operations used by generic code that can be overridden by patches */
+struct hdmi_ops {
+	int (*pin_get_eld)(struct hda_codec *codec, hda_nid_t pin_nid,
+			   unsigned char *buf, int *eld_size);
+
+	/* get and set channel assigned to each HDMI ASP (audio sample packet) slot */
+	int (*pin_get_slot_channel)(struct hda_codec *codec, hda_nid_t pin_nid,
+				    int asp_slot);
+	int (*pin_set_slot_channel)(struct hda_codec *codec, hda_nid_t pin_nid,
+				    int asp_slot, int channel);
+
+	void (*pin_setup_infoframe)(struct hda_codec *codec, hda_nid_t pin_nid,
+				    int ca, int active_channels, int conn_type);
+
+	/* enable/disable HBR (HD passthrough) */
+	int (*pin_hbr_setup)(struct hda_codec *codec, hda_nid_t pin_nid, bool hbr);
+
+	int (*setup_stream)(struct hda_codec *codec, hda_nid_t cvt_nid,
+			    hda_nid_t pin_nid, u32 stream_tag, int format);
+
+	/* Helpers for producing the channel map TLVs. These can be overridden
+	 * for devices that have non-standard mapping requirements. */
+	int (*chmap_cea_alloc_validate_get_type)(struct cea_channel_speaker_allocation *cap,
+						 int channels);
+	void (*cea_alloc_to_tlv_chmap)(struct cea_channel_speaker_allocation *cap,
+				       unsigned int *chmap, int channels);
+
+	/* check that the user-given chmap is supported */
+	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
+};
+
 struct hdmi_spec {
 	int num_cvts;
 	struct snd_array cvts; /* struct hdmi_spec_per_cvt */
@@ -93,6 +126,7 @@ struct hdmi_spec {
 	unsigned int channels_max; /* max over all cvts */
 
 	struct hdmi_eld temp_eld;
+	struct hdmi_ops ops;
 	/*
 	 * Non-generic ATI/NVIDIA specific
 	 */
@@ -648,24 +682,24 @@ static void hdmi_debug_channel_mapping(struct hda_codec *codec,
 				       hda_nid_t pin_nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
+	struct hdmi_spec *spec = codec->spec;
 	int i;
-	int slot;
+	int channel;
 
 	for (i = 0; i < 8; i++) {
-		slot = snd_hda_codec_read(codec, pin_nid, 0,
-						AC_VERB_GET_HDMI_CHAN_SLOT, i);
+		channel = spec->ops.pin_get_slot_channel(codec, pin_nid, i);
 		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
-						slot >> 4, slot & 0xf);
+						channel, i);
 	}
 #endif
 }
 
-
 static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 				       hda_nid_t pin_nid,
 				       bool non_pcm,
 				       int ca)
 {
+	struct hdmi_spec *spec = codec->spec;
 	struct cea_channel_speaker_allocation *ch_alloc;
 	int i;
 	int err;
@@ -698,9 +732,10 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 	}
 
 	for (i = 0; i < 8; i++) {
-		err = snd_hda_codec_write(codec, pin_nid, 0,
-					  AC_VERB_SET_HDMI_CHAN_SLOT,
-					  non_pcm ? non_pcm_mapping[i] : hdmi_channel_mapping[ca][i]);
+		int slotsetup = non_pcm ? non_pcm_mapping[i] : hdmi_channel_mapping[ca][i];
+		int hdmi_slot = slotsetup & 0x0f;
+		int channel = (slotsetup & 0xf0) >> 4;
+		err = spec->ops.pin_set_slot_channel(codec, pin_nid, hdmi_slot, channel);
 		if (err) {
 			snd_printdd(KERN_NOTICE
 				    "HDMI: channel mapping failed\n");
@@ -810,6 +845,7 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 					     int chs, unsigned char *map,
 					     int ca)
 {
+	struct hdmi_spec *spec = codec->spec;
 	int ordered_ca = get_channel_allocation_order(ca);
 	int alsa_pos, hdmi_slot;
 	int assignments[8] = {[0 ... 7] = 0xf};
@@ -825,11 +861,10 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 	}
 
 	for (hdmi_slot = 0; hdmi_slot < 8; hdmi_slot++) {
-		int val, err;
+		int err;
 
-		val = (assignments[hdmi_slot] << 4) | hdmi_slot;
-		err = snd_hda_codec_write(codec, pin_nid, 0,
-					  AC_VERB_SET_HDMI_CHAN_SLOT, val);
+		err = spec->ops.pin_set_slot_channel(codec, pin_nid, hdmi_slot,
+						     assignments[hdmi_slot]);
 		if (err)
 			return -EINVAL;
 	}
@@ -865,6 +900,22 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 	hdmi_debug_channel_mapping(codec, pin_nid);
 }
 
+static int hdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
+				     int asp_slot, int channel)
+{
+	return snd_hda_codec_write(codec, pin_nid, 0,
+				   AC_VERB_SET_HDMI_CHAN_SLOT,
+				   (channel << 4) | asp_slot);
+}
+
+static int hdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
+				     int asp_slot)
+{
+	return (snd_hda_codec_read(codec, pin_nid, 0,
+				   AC_VERB_GET_HDMI_CHAN_SLOT,
+				   asp_slot) & 0xf0) >> 4;
+}
+
 /*
  * Audio InfoFrame routines
  */
@@ -986,16 +1037,64 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
 	return true;
 }
 
+static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
+				     hda_nid_t pin_nid,
+				     int ca, int active_channels,
+				     int conn_type)
+{
+	union audio_infoframe ai;
+
+	if (conn_type == 0) { /* HDMI */
+		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
+
+		hdmi_ai->type		= 0x84;
+		hdmi_ai->ver		= 0x01;
+		hdmi_ai->len		= 0x0a;
+		hdmi_ai->CC02_CT47	= active_channels - 1;
+		hdmi_ai->CA		= ca;
+		hdmi_checksum_audio_infoframe(hdmi_ai);
+	} else if (conn_type == 1) { /* DisplayPort */
+		struct dp_audio_infoframe *dp_ai = &ai.dp;
+
+		dp_ai->type		= 0x84;
+		dp_ai->len		= 0x1b;
+		dp_ai->ver		= 0x11 << 2;
+		dp_ai->CC02_CT47	= active_channels - 1;
+		dp_ai->CA		= ca;
+	} else {
+		snd_printd("HDMI: unknown connection type at pin %d\n",
+			    pin_nid);
+		return;
+	}
+
+	/*
+	 * sizeof(ai) is used instead of sizeof(*hdmi_ai) or
+	 * sizeof(*dp_ai) to avoid partial match/update problems when
+	 * the user switches between HDMI/DP monitors.
+	 */
+	if (!hdmi_infoframe_uptodate(codec, pin_nid, ai.bytes,
+					sizeof(ai))) {
+		snd_printdd("hdmi_pin_setup_infoframe: "
+			    "pin=%d channels=%d ca=0x%02x\n",
+			    pin_nid,
+			    active_channels, ca);
+		hdmi_stop_infoframe_trans(codec, pin_nid);
+		hdmi_fill_audio_infoframe(codec, pin_nid,
+					    ai.bytes, sizeof(ai));
+		hdmi_start_infoframe_trans(codec, pin_nid);
+	}
+}
+
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 				       struct hdmi_spec_per_pin *per_pin,
 				       bool non_pcm)
 {
+	struct hdmi_spec *spec = codec->spec;
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	int channels = per_pin->channels;
 	int active_channels;
 	struct hdmi_eld *eld;
 	int ca, ordered_ca;
-	union audio_infoframe ai;
 
 	if (!channels)
 		return;
@@ -1021,30 +1120,6 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 	hdmi_set_channel_count(codec, per_pin->cvt_nid, active_channels);
 
-	memset(&ai, 0, sizeof(ai));
-	if (eld->info.conn_type == 0) { /* HDMI */
-		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
-
-		hdmi_ai->type		= 0x84;
-		hdmi_ai->ver		= 0x01;
-		hdmi_ai->len		= 0x0a;
-		hdmi_ai->CC02_CT47	= active_channels - 1;
-		hdmi_ai->CA		= ca;
-		hdmi_checksum_audio_infoframe(hdmi_ai);
-	} else if (eld->info.conn_type == 1) { /* DisplayPort */
-		struct dp_audio_infoframe *dp_ai = &ai.dp;
-
-		dp_ai->type		= 0x84;
-		dp_ai->len		= 0x1b;
-		dp_ai->ver		= 0x11 << 2;
-		dp_ai->CC02_CT47	= active_channels - 1;
-		dp_ai->CA		= ca;
-	} else {
-		snd_printd("HDMI: unknown connection type at pin %d\n",
-			    pin_nid);
-		return;
-	}
-
 	/*
 	 * always configure channel mapping, it may have been changed by the
 	 * user in the meantime
@@ -1053,27 +1128,12 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 				   channels, per_pin->chmap,
 				   per_pin->chmap_set);
 
-	/*
-	 * sizeof(ai) is used instead of sizeof(*hdmi_ai) or
-	 * sizeof(*dp_ai) to avoid partial match/update problems when
-	 * the user switches between HDMI/DP monitors.
-	 */
-	if (!hdmi_infoframe_uptodate(codec, pin_nid, ai.bytes,
-					sizeof(ai))) {
-		snd_printdd("hdmi_setup_audio_infoframe: "
-			    "pin=%d channels=%d ca=0x%02x\n",
-			    pin_nid,
-			    active_channels, ca);
-		hdmi_stop_infoframe_trans(codec, pin_nid);
-		hdmi_fill_audio_infoframe(codec, pin_nid,
-					    ai.bytes, sizeof(ai));
-		hdmi_start_infoframe_trans(codec, pin_nid);
-	}
+	spec->ops.pin_setup_infoframe(codec, pin_nid, ca, active_channels,
+				      eld->info.conn_type);
 
 	per_pin->non_pcm = non_pcm;
 }
 
-
 /*
  * Unsolicited events
  */
@@ -1176,26 +1236,22 @@ static void haswell_verify_D0(struct hda_codec *codec,
 #define is_hbr_format(format) \
 	((format & AC_FMT_TYPE_NON_PCM) && (format & AC_FMT_CHAN_MASK) == 7)
 
-static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
-			      hda_nid_t pin_nid, u32 stream_tag, int format)
+static int hdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
+			      bool hbr)
 {
-	int pinctl;
-	int new_pinctl = 0;
-
-	if (is_haswell(codec))
-		haswell_verify_D0(codec, cvt_nid, pin_nid);
+	int pinctl, new_pinctl;
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
 					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 
 		new_pinctl = pinctl & ~AC_PINCTL_EPT;
-		if (is_hbr_format(format))
+		if (hbr)
 			new_pinctl |= AC_PINCTL_EPT_HBR;
 		else
 			new_pinctl |= AC_PINCTL_EPT_NATIVE;
 
-		snd_printdd("hdmi_setup_stream: "
+		snd_printdd("hdmi_pin_hbr_setup: "
 			    "NID=0x%x, %spinctl=0x%x\n",
 			    pin_nid,
 			    pinctl == new_pinctl ? "" : "new-",
@@ -1205,11 +1261,26 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 			snd_hda_codec_write(codec, pin_nid, 0,
 					    AC_VERB_SET_PIN_WIDGET_CONTROL,
 					    new_pinctl);
+	} else if (hbr)
+		return -EINVAL;
 
-	}
-	if (is_hbr_format(format) && !new_pinctl) {
+	return 0;
+}
+
+static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
+			      hda_nid_t pin_nid, u32 stream_tag, int format)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int err;
+
+	if (is_haswell(codec))
+		haswell_verify_D0(codec, cvt_nid, pin_nid);
+
+	err = spec->ops.pin_hbr_setup(codec, pin_nid, is_hbr_format(format));
+
+	if (err) {
 		snd_printdd("hdmi_setup_stream: HBR is not supported\n");
-		return -EINVAL;
+		return err;
 	}
 
 	snd_hda_codec_setup_stream(codec, cvt_nid, stream_tag, 0, format);
@@ -1424,7 +1495,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		codec->addr, pin_nid, pin_eld->monitor_present, eld->eld_valid);
 
 	if (eld->eld_valid) {
-		if (snd_hdmi_get_eld(codec, pin_nid, eld->eld_buffer,
+		if (spec->ops.pin_get_eld(codec, pin_nid, eld->eld_buffer,
 						     &eld->eld_size) < 0)
 			eld->eld_valid = false;
 		else {
@@ -1655,7 +1726,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
 	mutex_unlock(&per_pin->lock);
 
-	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
+	return spec->ops.setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
 }
 
 static int generic_hdmi_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -1727,6 +1798,34 @@ static int hdmi_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hdmi_chmap_cea_alloc_validate_get_type(struct cea_channel_speaker_allocation *cap,
+						  int channels)
+{
+	/* If the speaker allocation matches the channel count, it is OK.*/
+	if (cap->channels != channels)
+		return -1;
+
+	/* all channels are remappable freely */
+	return SNDRV_CTL_TLVT_CHMAP_VAR;
+}
+
+static void hdmi_cea_alloc_to_tlv_chmap(struct cea_channel_speaker_allocation *cap,
+					unsigned int *chmap, int channels)
+{
+	int count = 0;
+	int c;
+
+	for (c = 7; c >= 0; c--) {
+		int spk = cap->speakers[c];
+		if (!spk)
+			continue;
+
+		chmap[count++] = spk_to_chmap(spk);
+	}
+
+	WARN_ON(count != channels);
+}
+
 static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			      unsigned int size, unsigned int __user *tlv)
 {
@@ -1743,16 +1842,19 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	size -= 8;
 	dst = tlv + 2;
 	for (chs = 2; chs <= spec->channels_max; chs++) {
-		int i, c;
+		int i;
 		struct cea_channel_speaker_allocation *cap;
 		cap = channel_allocations;
 		for (i = 0; i < ARRAY_SIZE(channel_allocations); i++, cap++) {
 			int chs_bytes = chs * 4;
-			if (cap->channels != chs)
+			int type = spec->ops.chmap_cea_alloc_validate_get_type(cap, chs);
+			unsigned int tlv_chmap[8];
+
+			if (type < 0)
 				continue;
 			if (size < 8)
 				return -ENOMEM;
-			if (put_user(SNDRV_CTL_TLVT_CHMAP_VAR, dst) ||
+			if (put_user(type, dst) ||
 			    put_user(chs_bytes, dst + 1))
 				return -EFAULT;
 			dst += 2;
@@ -1762,14 +1864,10 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 				return -ENOMEM;
 			size -= chs_bytes;
 			count += chs_bytes;
-			for (c = 7; c >= 0; c--) {
-				int spk = cap->speakers[c];
-				if (!spk)
-					continue;
-				if (put_user(spk_to_chmap(spk), dst))
-					return -EFAULT;
-				dst++;
-			}
+			spec->ops.cea_alloc_to_tlv_chmap(cap, tlv_chmap, chs);
+			if (copy_to_user(dst, tlv_chmap, chs_bytes))
+				return -EFAULT;
+			dst += chs;
 		}
 	}
 	if (put_user(count, tlv + 1))
@@ -1803,7 +1901,7 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	unsigned int ctl_idx;
 	struct snd_pcm_substream *substream;
 	unsigned char chmap[8];
-	int i, ca, prepared = 0;
+	int i, err, ca, prepared = 0;
 
 	ctl_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	substream = snd_pcm_chmap_substream(info, ctl_idx);
@@ -1827,6 +1925,11 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	ca = hdmi_manual_channel_allocation(ARRAY_SIZE(chmap), chmap);
 	if (ca < 0)
 		return -EINVAL;
+	if (spec->ops.chmap_validate) {
+		err = spec->ops.chmap_validate(ca, ARRAY_SIZE(chmap), chmap);
+		if (err)
+			return err;
+	}
 	mutex_lock(&per_pin->lock);
 	per_pin->chmap_set = true;
 	memcpy(per_pin->chmap, chmap, sizeof(chmap));
@@ -2033,6 +2136,17 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 #endif
 };
 
+static const struct hdmi_ops generic_standard_hdmi_ops = {
+	.pin_get_eld				= snd_hdmi_get_eld,
+	.pin_get_slot_channel			= hdmi_pin_get_slot_channel,
+	.pin_set_slot_channel			= hdmi_pin_set_slot_channel,
+	.pin_setup_infoframe			= hdmi_pin_setup_infoframe,
+	.pin_hbr_setup				= hdmi_pin_hbr_setup,
+	.setup_stream				= hdmi_setup_stream,
+	.chmap_cea_alloc_validate_get_type	= hdmi_chmap_cea_alloc_validate_get_type,
+	.cea_alloc_to_tlv_chmap			= hdmi_cea_alloc_to_tlv_chmap,
+};
+
 
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 					     hda_nid_t nid)
@@ -2115,6 +2229,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	if (spec == NULL)
 		return -ENOMEM;
 
+	spec->ops = generic_standard_hdmi_ops;
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-- 
1.8.1.5
