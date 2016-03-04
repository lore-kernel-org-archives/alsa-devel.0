From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 2/7] ALSA: hda - Register chmap obj as priv
	data instead of codec
Date: Fri,  4 Mar 2016 19:59:47 +0530
Message-ID: <1457101792-19441-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1457101792-19441-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 062242651CF
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 15:29:50 +0100 (CET)
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

With this chmap object is added as private data and new ops are
added to access driver specific chmap.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_chmap.h  |  6 +++
 sound/pci/hda/patch_hdmi.c | 93 +++++++++++++++++++++++++++++-----------------
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/include/sound/hda_chmap.h b/include/sound/hda_chmap.h
index 9ab20f0..713b2452 100644
--- a/include/sound/hda_chmap.h
+++ b/include/sound/hda_chmap.h
@@ -30,6 +30,12 @@ struct hdac_chmap_ops {
 
 	/* check that the user-given chmap is supported */
 	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
+
+	void (*get_chmap)(struct hdac_device *hdac, int pcm_idx,
+					unsigned char *chmap);
+	void (*set_chmap)(struct hdac_device *hdac, int pcm_idx,
+			unsigned char *chmap, int prepared);
+	bool (*is_pcm_attached)(struct hdac_device *hdac, int pcm_idx);
 };
 
 struct hdac_chmap {
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5f9d975..04333ec 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -100,8 +100,6 @@ struct hdmi_spec_per_pin {
 #endif
 };
 
-struct cea_channel_speaker_allocation;
-
 /* operations used by generic code that can be overridden by patches */
 struct hdmi_ops {
 	int (*pin_get_eld)(struct hda_codec *codec, hda_nid_t pin_nid,
@@ -2350,9 +2348,7 @@ static int hdmi_chmap_ctl_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	struct hda_codec *codec = info->private_data;
-	struct hdmi_spec *spec = codec->spec;
-	struct hdac_chmap *chmap = &spec->chmap;
+	struct hdac_chmap *chmap = info->private_data;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = chmap->channels_max;
@@ -2389,13 +2385,49 @@ static void hdmi_cea_alloc_to_tlv_chmap(struct cea_channel_speaker_allocation *c
 	WARN_ON(count != channels);
 }
 
+static void hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
+					unsigned char *chmap)
+{
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
+
+	/* chmap is already set to 0 in caller */
+	if (!per_pin)
+		return;
+
+	memcpy(chmap, per_pin->chmap, ARRAY_SIZE(per_pin->chmap));
+}
+
+static void hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
+				unsigned char *chmap, int prepared)
+{
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
+
+	mutex_lock(&per_pin->lock);
+	per_pin->chmap_set = true;
+	memcpy(per_pin->chmap, chmap, ARRAY_SIZE(per_pin->chmap));
+	if (prepared)
+		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
+	mutex_unlock(&per_pin->lock);
+}
+
+static bool is_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
+{
+	struct hda_codec *codec = container_of(hdac, struct hda_codec, core);
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
+
+	return per_pin ? true:false;
+}
+
 static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			      unsigned int size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	struct hda_codec *codec = info->private_data;
-	struct hdmi_spec *spec = codec->spec;
-	struct hdac_chmap *chmap = &spec->chmap;
+	struct hdac_chmap *chmap = info->private_data;
 	unsigned int __user *dst;
 	int chs, count = 0;
 
@@ -2444,21 +2476,17 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	struct hda_codec *codec = info->private_data;
-	struct hdmi_spec *spec = codec->spec;
-	struct hdac_chmap *chmap = &spec->chmap;
+	struct hdac_chmap *chmap = info->private_data;
 	int pcm_idx = kcontrol->private_value;
-	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
+	unsigned char pcm_chmap[8];
 	int i;
 
-	if (!per_pin) {
-		for (i = 0; i < chmap->channels_max; i++)
-			ucontrol->value.integer.value[i] = 0;
-		return 0;
-	}
+	memset(pcm_chmap, 0, sizeof(pcm_chmap));
+	chmap->ops.get_chmap(chmap->hdac, pcm_idx, pcm_chmap);
+
+	for (i = 0; i < sizeof(chmap); i++)
+		ucontrol->value.integer.value[i] = pcm_chmap[i];
 
-	for (i = 0; i < ARRAY_SIZE(per_pin->chmap); i++)
-		ucontrol->value.integer.value[i] = per_pin->chmap[i];
 	return 0;
 }
 
@@ -2466,20 +2494,17 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
-	struct hda_codec *codec = info->private_data;
-	struct hdmi_spec *spec = codec->spec;
-	struct hdac_chmap *hchmap = &spec->chmap;
+	struct hdac_chmap *hchmap = info->private_data;
 	int pcm_idx = kcontrol->private_value;
-	struct hdmi_spec_per_pin *per_pin = pcm_idx_to_pin(spec, pcm_idx);
 	unsigned int ctl_idx;
 	struct snd_pcm_substream *substream;
-	unsigned char chmap[8];
+	unsigned char chmap[8], per_pin_chmap[8];
 	int i, err, ca, prepared = 0;
 
 	/* No monitor is connected in dyn_pcm_assign.
 	 * It's invalid to setup the chmap
 	 */
-	if (!per_pin)
+	if (!hchmap->ops.is_pcm_attached(hchmap->hdac, pcm_idx))
 		return 0;
 
 	ctl_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
@@ -2499,7 +2524,9 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	memset(chmap, 0, sizeof(chmap));
 	for (i = 0; i < ARRAY_SIZE(chmap); i++)
 		chmap[i] = ucontrol->value.integer.value[i];
-	if (!memcmp(chmap, per_pin->chmap, sizeof(chmap)))
+
+	hchmap->ops.get_chmap(hchmap->hdac, pcm_idx, per_pin_chmap);
+	if (!memcmp(chmap, per_pin_chmap, sizeof(chmap)))
 		return 0;
 	ca = hdmi_manual_channel_allocation(ARRAY_SIZE(chmap), chmap);
 	if (ca < 0)
@@ -2509,12 +2536,8 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 		if (err)
 			return err;
 	}
-	mutex_lock(&per_pin->lock);
-	per_pin->chmap_set = true;
-	memcpy(per_pin->chmap, chmap, sizeof(chmap));
-	if (prepared)
-		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
-	mutex_unlock(&per_pin->lock);
+
+	hchmap->ops.set_chmap(hchmap->hdac, pcm_idx, chmap, prepared);
 
 	return 0;
 }
@@ -2672,7 +2695,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		/* override handlers */
-		chmap->private_data = codec;
+		chmap->private_data = &spec->chmap;
 		kctl = chmap->kctl;
 		for (i = 0; i < kctl->count; i++)
 			kctl->vd[i].access |= SNDRV_CTL_ELEM_ACCESS_WRITE;
@@ -2801,9 +2824,11 @@ static const struct hdmi_ops generic_standard_hdmi_ops = {
 static const struct hdac_chmap_ops chmap_ops = {
 	.chmap_cea_alloc_validate_get_type	= hdmi_chmap_cea_alloc_validate_get_type,
 	.cea_alloc_to_tlv_chmap			= hdmi_cea_alloc_to_tlv_chmap,
+	.get_chmap				= hdmi_get_chmap,
+	.set_chmap				= hdmi_set_chmap,
+	.is_pcm_attached			= is_hdmi_pcm_attached,
 };
 
-
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 					     hda_nid_t nid)
 {
-- 
1.9.1
