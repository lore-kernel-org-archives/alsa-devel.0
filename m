From: libin.yang@linux.intel.com
Subject: [PATCH 2/4] ALSA: hda - add hdmi_pcm to manage hdmi
	pcm related features
Date: Thu, 31 Dec 2015 09:22:20 +0800
Message-ID: <1451524942-17288-3-git-send-email-libin.yang@linux.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C685265ADE
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 02:25:24 +0100 (CET)
In-Reply-To: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Use struct hdmi_pcm wrapper for hdmi pcm management.
All PCM related features, like jack,  will be put in this structure.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6d6dba4..5549ddf 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -86,7 +86,7 @@ struct hdmi_spec_per_pin {
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
 	struct snd_jack *acomp_jack; /* jack via audio component */
-	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
+	struct hdmi_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
 	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
@@ -132,6 +132,11 @@ struct hdmi_ops {
 	int (*chmap_validate)(int ca, int channels, unsigned char *chmap);
 };
 
+struct hdmi_pcm {
+	struct hda_pcm *pcm;
+	struct snd_jack *jack;
+};
+
 struct hdmi_spec {
 	int num_cvts;
 	struct snd_array cvts; /* struct hdmi_spec_per_cvt */
@@ -139,7 +144,7 @@ struct hdmi_spec {
 
 	int num_pins;
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
-	struct hda_pcm *pcm_rec[16];
+	struct hdmi_pcm pcm_rec[16];
 	struct mutex pcm_lock;
 	/* pcm_bitmap means which pcms have been assigned to pins*/
 	unsigned long pcm_bitmap;
@@ -403,7 +408,7 @@ static int hinfo_to_pcm_index(struct hda_codec *codec,
 	int pcm_idx;
 
 	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++)
-		if (get_pcm_rec(spec, pcm_idx)->stream == hinfo)
+		if (get_pcm_rec(spec, pcm_idx).pcm->stream == hinfo)
 			return pcm_idx;
 
 	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
@@ -419,7 +424,8 @@ static int hinfo_to_pin_index(struct hda_codec *codec,
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		per_pin = get_pin(spec, pin_idx);
-		if (per_pin->pcm && per_pin->pcm->stream == hinfo)
+		if (per_pin->pcm &&
+			per_pin->pcm->pcm->stream == hinfo)
 			return pin_idx;
 	}
 
@@ -1721,7 +1727,7 @@ static void hdmi_attach_hda_pcm(struct hdmi_spec *spec,
 	if (idx == -ENODEV)
 		return;
 	per_pin->pcm_idx = idx;
-	per_pin->pcm = spec->pcm_rec[idx];
+	per_pin->pcm = &spec->pcm_rec[idx];
 	set_bit(idx, &spec->pcm_bitmap);
 }
 
@@ -1764,7 +1770,7 @@ static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
 	bool non_pcm;
 
 	if (per_pin->pcm_idx >= 0 && per_pin->pcm_idx < spec->pcm_used)
-		pcm = spec->pcm_rec[per_pin->pcm_idx];
+		pcm = spec->pcm_rec[per_pin->pcm_idx].pcm;
 	else
 		return;
 	if (!test_bit(per_pin->pcm_idx, &spec->pcm_in_use))
@@ -2028,8 +2034,10 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	per_pin->non_pcm = false;
 	if (spec->dyn_pcm_assign)
 		per_pin->pcm_idx = -1;
-	else
+	else {
+		per_pin->pcm = &spec->pcm_rec[pin_idx];
 		per_pin->pcm_idx = pin_idx;
+	}
 	per_pin->pin_nid_idx = pin_idx;
 
 	err = hdmi_read_pin_conn(codec, pin_idx);
@@ -2439,7 +2447,6 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 static int generic_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_spec_per_pin *per_pin;
 	int pin_idx;
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
@@ -2449,11 +2456,8 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 		info = snd_hda_codec_pcm_new(codec, "HDMI %d", pin_idx);
 		if (!info)
 			return -ENOMEM;
-		if (!spec->dyn_pcm_assign) {
-			per_pin = get_pin(spec, pin_idx);
-			per_pin->pcm = info;
-		}
-		spec->pcm_rec[pin_idx] = info;
+
+		spec->pcm_rec[pin_idx].pcm = info;
 		spec->pcm_used++;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
@@ -2496,7 +2500,7 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
 	char hdmi_str[32] = "HDMI/DP";
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-	int pcmdev = get_pcm_rec(spec, pin_idx)->device;
+	int pcmdev = get_pcm_rec(spec, pin_idx).pcm->device;
 	bool phantom_jack;
 
 	if (pcmdev > 0)
@@ -2536,7 +2540,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 		/* add control for ELD Bytes */
 		err = hdmi_create_eld_ctl(codec, pin_idx,
-					  get_pcm_rec(spec, pin_idx)->device);
+				get_pcm_rec(spec, pin_idx).pcm->device);
 
 		if (err < 0)
 			return err;
@@ -2551,7 +2555,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 		struct snd_kcontrol *kctl;
 		int i;
 
-		pcm = spec->pcm_rec[pin_idx];
+		pcm = spec->pcm_rec[pin_idx].pcm;
 		if (!pcm || !pcm->pcm)
 			break;
 		err = snd_pcm_add_chmap_ctls(pcm->pcm,
@@ -2857,7 +2861,7 @@ static int simple_playback_build_pcms(struct hda_codec *codec)
 	info = snd_hda_codec_pcm_new(codec, "HDMI 0");
 	if (!info)
 		return -ENOMEM;
-	spec->pcm_rec[0] = info;
+	spec->pcm_rec[0].pcm = info;
 	info->pcm_type = HDA_PCM_TYPE_HDMI;
 	pstr = &info->stream[SNDRV_PCM_STREAM_PLAYBACK];
 	*pstr = spec->pcm_playback;
@@ -3306,7 +3310,7 @@ static int nvhdmi_7x_8ch_build_pcms(struct hda_codec *codec)
 	struct hdmi_spec *spec = codec->spec;
 	int err = simple_playback_build_pcms(codec);
 	if (!err) {
-		struct hda_pcm *info = get_pcm_rec(spec, 0);
+		struct hda_pcm *info = get_pcm_rec(spec, 0).pcm;
 		info->own_chmap = true;
 	}
 	return err;
@@ -3324,7 +3328,7 @@ static int nvhdmi_7x_8ch_build_controls(struct hda_codec *codec)
 		return err;
 
 	/* add channel maps */
-	info = get_pcm_rec(spec, 0);
+	info = get_pcm_rec(spec, 0).pcm;
 	err = snd_pcm_add_chmap_ctls(info->pcm,
 				     SNDRV_PCM_STREAM_PLAYBACK,
 				     snd_pcm_alt_chmaps, 8, 0, &chmap);
@@ -3522,7 +3526,7 @@ static struct hda_pcm *hda_find_pcm_by_type(struct hda_codec *codec, int type)
 	unsigned int i;
 
 	for (i = 0; i < spec->num_pins; i++) {
-		struct hda_pcm *pcm = get_pcm_rec(spec, i);
+		struct hda_pcm *pcm = get_pcm_rec(spec, i).pcm;
 
 		if (pcm->pcm_type == type)
 			return pcm;
-- 
1.9.1
