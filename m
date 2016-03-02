From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 5/7] ALSA: hda - Use ops instead of directly
	accessing chmap helpers
Date: Wed,  2 Mar 2016 17:33:26 +0530
Message-ID: <1456920208-1172-6-git-send-email-subhransu.s.prusty@intel.com>
References: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4499B2652AA
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 13:03:24 +0100 (CET)
In-Reply-To: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
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

Added more ops to the chmap object, so most of the helpers can be
accessed through ops instead instead of directly calling them.
With this moving the chmap helpers to core will be easy.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdmi_chmap.h |  20 ++++++--
 sound/pci/hda/patch_hdmi.c | 121 ++++++++++++++++++++++++++++-----------------
 2 files changed, 94 insertions(+), 47 deletions(-)

diff --git a/include/sound/hdmi_chmap.h b/include/sound/hdmi_chmap.h
index 1ce630d..7b824b6 100644
--- a/include/sound/hdmi_chmap.h
+++ b/include/sound/hdmi_chmap.h
@@ -7,6 +7,8 @@
 
 #include <sound/hdaudio.h>
 
+#define SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE 80
+
 struct hdmi_cea_channel_speaker_allocation {
 	int ca_index;
 	int speakers[8];
@@ -24,12 +26,13 @@ struct hdmi_chmap_ops {
 	 */
 	int (*chmap_cea_alloc_validate_get_type)(struct hdmi_chmap *chmap,
 		struct hdmi_cea_channel_speaker_allocation *cap, int channels);
-	void (*cea_alloc_to_tlv_chmap)
-		(struct hdmi_cea_channel_speaker_allocation *cap,
+	void (*cea_alloc_to_tlv_chmap)(struct hdmi_chmap *hchmap,
+		struct hdmi_cea_channel_speaker_allocation *cap,
 		unsigned int *chmap, int channels);
 
 	/* check that the user-given chmap is supported */
-	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
+	int (*chmap_validate)(struct hdmi_chmap *hchmap, int ca,
+			int channels, unsigned char *chmap);
 
 	void (*get_chmap)(struct hdac_device *hdac, int pcm_idx,
 					unsigned char *chmap);
@@ -44,6 +47,17 @@ struct hdmi_chmap_ops {
 			hda_nid_t pin_nid, int asp_slot, int channel);
 	void (*set_channel_count)(struct hdac_device *codec,
 				hda_nid_t cvt_nid, int chs);
+	int (*get_active_channels)(int ca);
+	void (*setup_channel_mapping)(struct hdmi_chmap *chmap,
+			hda_nid_t pin_nid, bool non_pcm, int ca,
+			int channels, unsigned char *map,
+			bool chmap_set);
+	int (*channel_allocation)(struct hdac_device *hdac, int spk_alloc,
+				int channels, bool chmap_set,
+				bool non_pcm, unsigned char *map);
+	struct hdmi_cea_channel_speaker_allocation *(*get_cap_from_ca)(int ca);
+	int (*alsa_chmap_to_spk_mask)(unsigned char c);
+	int (*spk_to_alsa_chmap)(int spk);
 };
 
 struct hdmi_chmap {
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0f35945..5e81319 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -696,8 +696,8 @@ static int get_channel_allocation_order(int ca)
  *
  * TODO: it could select the wrong CA from multiple candidates.
 */
-static int hdmi_channel_allocation(struct hda_codec *codec,
-				   struct hdmi_eld *eld, int channels)
+static int hdmi_channel_allocation_spk_alloc_blk(struct hdac_device *codec,
+				   int spk_alloc, int channels)
 {
 	int i;
 	int ca = 0;
@@ -717,7 +717,7 @@ static int hdmi_channel_allocation(struct hda_codec *codec,
 	 * expand ELD's notions to match the ones used by Audio InfoFrame.
 	 */
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (eld->info.spk_alloc & (1 << i))
+		if (spk_alloc & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -742,36 +742,34 @@ static int hdmi_channel_allocation(struct hda_codec *codec,
 		}
 	}
 
-	snd_print_channel_allocation(eld->info.spk_alloc, buf, sizeof(buf));
-	codec_dbg(codec, "HDMI: select CA 0x%x for %d-channel allocation: %s\n",
+	snd_print_channel_allocation(spk_alloc, buf, sizeof(buf));
+	dev_dbg(&codec->dev, "HDMI: select CA 0x%x for %d-channel allocation: %s\n",
 		    ca, channels, buf);
 
 	return ca;
 }
 
-static void hdmi_debug_channel_mapping(struct hda_codec *codec,
+static void hdmi_debug_channel_mapping(struct hdmi_chmap *chmap,
 				       hda_nid_t pin_nid)
 {
 #ifdef CONFIG_SND_DEBUG_VERBOSE
-	struct hdmi_spec *spec = codec->spec;
 	int i;
 	int channel;
 
 	for (i = 0; i < 8; i++) {
-		channel = spec->chmap.ops.pin_get_slot_channel(
-				&codec->core, pin_nid, i);
-		codec_dbg(codec, "HDMI: ASP channel %d => slot %d\n",
+		channel = chmap->ops.pin_get_slot_channel(
+				chmap->hdac, pin_nid, i);
+		dev_dbg(&chmap->hdac->dev, "HDMI: ASP channel %d => slot %d\n",
 						channel, i);
 	}
 #endif
 }
 
-static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
+static void hdmi_std_setup_channel_mapping(struct hdmi_chmap *chmap,
 				       hda_nid_t pin_nid,
 				       bool non_pcm,
 				       int ca)
 {
-	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_cea_channel_speaker_allocation *ch_alloc;
 	int i;
 	int err;
@@ -807,10 +805,10 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 		int slotsetup = non_pcm ? non_pcm_mapping[i] : hdmi_channel_mapping[ca][i];
 		int hdmi_slot = slotsetup & 0x0f;
 		int channel = (slotsetup & 0xf0) >> 4;
-		err = spec->chmap.ops.pin_set_slot_channel(
-				&codec->core, pin_nid, hdmi_slot, channel);
+		err = chmap->ops.pin_set_slot_channel(chmap->hdac,
+				pin_nid, hdmi_slot, channel);
 		if (err) {
-			codec_dbg(codec, "HDMI: channel mapping failed\n");
+			dev_dbg(&chmap->hdac->dev, "HDMI: channel mapping failed\n");
 			break;
 		}
 	}
@@ -912,12 +910,11 @@ static int hdmi_manual_channel_allocation(int chs, unsigned char *map)
 }
 
 /* set up the channel slots for the given ALSA API channel map */
-static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
+static int hdmi_manual_setup_channel_mapping(struct hdmi_chmap *chmap,
 					     hda_nid_t pin_nid,
 					     int chs, unsigned char *map,
 					     int ca)
 {
-	struct hdmi_spec *spec = codec->spec;
 	int ordered_ca = get_channel_allocation_order(ca);
 	int alsa_pos, hdmi_slot;
 	int assignments[8] = {[0 ... 7] = 0xf};
@@ -935,7 +932,7 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 	for (hdmi_slot = 0; hdmi_slot < 8; hdmi_slot++) {
 		int err;
 
-		err = spec->chmap.ops.pin_set_slot_channel(&codec->core,
+		err = chmap->ops.pin_set_slot_channel(chmap->hdac,
 				pin_nid, hdmi_slot, assignments[hdmi_slot]);
 		if (err)
 			return -EINVAL;
@@ -956,20 +953,20 @@ static void hdmi_setup_fake_chmap(unsigned char *map, int ca)
 	}
 }
 
-static void hdmi_setup_channel_mapping(struct hda_codec *codec,
+static void hdmi_setup_channel_mapping(struct hdmi_chmap *chmap,
 				       hda_nid_t pin_nid, bool non_pcm, int ca,
 				       int channels, unsigned char *map,
 				       bool chmap_set)
 {
 	if (!non_pcm && chmap_set) {
-		hdmi_manual_setup_channel_mapping(codec, pin_nid,
+		hdmi_manual_setup_channel_mapping(chmap, pin_nid,
 						  channels, map, ca);
 	} else {
-		hdmi_std_setup_channel_mapping(codec, pin_nid, non_pcm, ca);
+		hdmi_std_setup_channel_mapping(chmap, pin_nid, non_pcm, ca);
 		hdmi_setup_fake_chmap(map, ca);
 	}
 
-	hdmi_debug_channel_mapping(codec, pin_nid);
+	hdmi_debug_channel_mapping(chmap, pin_nid);
 }
 
 /*
@@ -1142,6 +1139,35 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
 	}
 }
 
+static int hdmi_get_active_channels(int ca)
+{
+	int ordered_ca = get_channel_allocation_order(ca);
+
+	return channel_allocations[ordered_ca].channels;
+}
+
+static struct hdmi_cea_channel_speaker_allocation *hdmi_get_ch_alloc_from_ca(int ca)
+{
+	return &channel_allocations[get_channel_allocation_order(ca)];
+}
+
+static int hdmi_channel_allocation(struct hdac_device *hdac, int spk_alloc,
+		int channels, bool chmap_set, bool non_pcm, unsigned char *map)
+{
+	int ca;
+
+	if (!non_pcm && chmap_set)
+		ca = hdmi_manual_channel_allocation(channels, map);
+	else
+		ca = hdmi_channel_allocation_spk_alloc_blk(hdac,
+					spk_alloc, channels);
+
+	if (ca < 0)
+		ca = 0;
+
+	return ca;
+}
+
 static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 				       struct hdmi_spec_per_pin *per_pin,
 				       bool non_pcm)
@@ -1152,7 +1178,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	int channels = per_pin->channels;
 	int active_channels;
 	struct hdmi_eld *eld;
-	int ca, ordered_ca;
+	int ca;
 
 	if (!channels)
 		return;
@@ -1164,15 +1190,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 	eld = &per_pin->sink_eld;
 
-	if (!non_pcm && per_pin->chmap_set)
-		ca = hdmi_manual_channel_allocation(channels, per_pin->chmap);
-	else
-		ca = hdmi_channel_allocation(codec, eld, channels);
-	if (ca < 0)
-		ca = 0;
+	ca = spec->chmap.ops.channel_allocation(&codec->core,
+			eld->info.spk_alloc, channels,
+			per_pin->chmap_set, non_pcm, per_pin->chmap);
 
-	ordered_ca = get_channel_allocation_order(ca);
-	active_channels = channel_allocations[ordered_ca].channels;
+	active_channels = spec->chmap.ops.get_active_channels(ca);
 
 	chmap->ops.set_channel_count(&codec->core, per_pin->cvt_nid,
 						active_channels);
@@ -1181,9 +1203,9 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	 * always configure channel mapping, it may have been changed by the
 	 * user in the meantime
 	 */
-	hdmi_setup_channel_mapping(codec, pin_nid, non_pcm, ca,
-				   channels, per_pin->chmap,
-				   per_pin->chmap_set);
+	chmap->ops.setup_channel_mapping(&spec->chmap,
+				pin_nid, non_pcm, ca, channels,
+				per_pin->chmap, per_pin->chmap_set);
 
 	spec->ops.pin_setup_infoframe(codec, pin_nid, ca, active_channels,
 				      eld->info.conn_type);
@@ -2336,7 +2358,7 @@ static int hdmi_chmap_cea_alloc_validate_get_type(struct hdmi_chmap *chmap,
 	return SNDRV_CTL_TLVT_CHMAP_VAR;
 }
 
-static void hdmi_cea_alloc_to_tlv_chmap(
+static void hdmi_cea_alloc_to_tlv_chmap(struct hdmi_chmap *hchmap,
 		struct hdmi_cea_channel_speaker_allocation *cap,
 		unsigned int *chmap, int channels)
 {
@@ -2430,7 +2452,8 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 				return -ENOMEM;
 			size -= chs_bytes;
 			count += chs_bytes;
-			chmap->ops.cea_alloc_to_tlv_chmap(cap, tlv_chmap, chs);
+			chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap,
+						tlv_chmap, chs);
 			if (copy_to_user(dst, tlv_chmap, chs_bytes))
 				return -EFAULT;
 			dst += chs;
@@ -2501,7 +2524,8 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	if (ca < 0)
 		return -EINVAL;
 	if (hchmap->ops.chmap_validate) {
-		err = hchmap->ops.chmap_validate(ca, ARRAY_SIZE(chmap), chmap);
+		err = hchmap->ops.chmap_validate(hchmap, ca,
+				ARRAY_SIZE(chmap), chmap);
 		if (err)
 			return err;
 	}
@@ -2897,6 +2921,12 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	spec->chmap.ops.get_chmap = hdmi_get_chmap;
 	spec->chmap.ops.set_chmap = hdmi_set_chmap;
 	spec->chmap.ops.is_monitor_connected = is_hdmi_monitor_connected;
+	spec->chmap.ops.get_active_channels = hdmi_get_active_channels;
+	spec->chmap.ops.setup_channel_mapping = hdmi_setup_channel_mapping;
+	spec->chmap.ops.channel_allocation = hdmi_channel_allocation;
+	spec->chmap.ops.get_cap_from_ca = hdmi_get_ch_alloc_from_ca;
+	spec->chmap.ops.alsa_chmap_to_spk_mask = to_spk_mask;
+	spec->chmap.ops.spk_to_alsa_chmap = spk_to_chmap;
 
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
@@ -3494,7 +3524,8 @@ static int nvhdmi_chmap_cea_alloc_validate_get_type(struct hdmi_chmap *chmap,
 				chmap, cap, channels);
 }
 
-static int nvhdmi_chmap_validate(int ca, int chs, unsigned char *map)
+static int nvhdmi_chmap_validate(struct hdmi_chmap *chmap,
+		int ca, int chs, unsigned char *map)
 {
 	if (ca == 0x00 && (map[0] != SNDRV_CHMAP_FL || map[1] != SNDRV_CHMAP_FR))
 		return -EINVAL;
@@ -3767,16 +3798,17 @@ static int atihdmi_paired_swap_fc_lfe(int pos)
 	return pos;
 }
 
-static int atihdmi_paired_chmap_validate(int ca, int chs, unsigned char *map)
+static int atihdmi_paired_chmap_validate(struct hdmi_chmap *chmap,
+			int ca, int chs, unsigned char *map)
 {
 	struct hdmi_cea_channel_speaker_allocation *cap;
 	int i, j;
 
 	/* check that only channel pairs need to be remapped on old pre-rev3 ATI/AMD */
 
-	cap = &channel_allocations[get_channel_allocation_order(ca)];
+	cap = chmap->ops.get_cap_from_ca(ca);
 	for (i = 0; i < chs; ++i) {
-		int mask = to_spk_mask(map[i]);
+		int mask = chmap->ops.alsa_chmap_to_spk_mask(map[i]);
 		bool ok = false;
 		bool companion_ok = false;
 
@@ -3792,7 +3824,8 @@ static int atihdmi_paired_chmap_validate(int ca, int chs, unsigned char *map)
 				if (i % 2 == 0 && i + 1 < chs) {
 					/* even channel, check the odd companion */
 					int comp_chan_idx = 7 - atihdmi_paired_swap_fc_lfe(j + 1);
-					int comp_mask_req = to_spk_mask(map[i+1]);
+					int comp_mask_req =
+						chmap->ops.alsa_chmap_to_spk_mask(map[i+1]);
 					int comp_mask_act = cap->speakers[comp_chan_idx];
 
 					if (comp_mask_req == comp_mask_act)
@@ -3910,7 +3943,7 @@ static int atihdmi_paired_chmap_cea_alloc_validate_get_type(
 	return SNDRV_CTL_TLVT_CHMAP_PAIRED;
 }
 
-static void atihdmi_paired_cea_alloc_to_tlv_chmap(
+static void atihdmi_paired_cea_alloc_to_tlv_chmap(struct hdmi_chmap *hchmap,
 		struct hdmi_cea_channel_speaker_allocation *cap,
 		unsigned int *chmap, int channels)
 {
@@ -3929,7 +3962,7 @@ static void atihdmi_paired_cea_alloc_to_tlv_chmap(
 			continue;
 		}
 
-		chmap[count++] = spk_to_chmap(spk);
+		chmap[count++] = hchmap->ops.spk_to_alsa_chmap(spk);
 	}
 
 	WARN_ON(count != channels);
-- 
1.9.1
