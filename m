From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 028/112] ALSA: hda/realtek - Clean up some spec
	fields
Date: Tue,  8 Jan 2013 12:38:21 +0100
Message-ID: <1357645185-7645-29-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F2BD2651AE
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 90E44A5213
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Remove some fields from struct alc_spec, and clean up the usage.
Namely,
- spec->input_mux becomes a single element, private_imux[] is removed
- spec->adc_nids becomes an array by itself, and private_adc_nids[]
  gets removed, too

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 56 ++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 111b82c..77045e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -128,7 +128,6 @@ struct alc_spec {
 	/* codec parameterization */
 	const struct snd_kcontrol_new *mixers[5];	/* mixer arrays */
 	unsigned int num_mixers;
-	const struct snd_kcontrol_new *cap_mixer;	/* capture mixer */
 	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
 
 	char stream_name_analog[32];	/* analog PCM stream */
@@ -152,8 +151,7 @@ struct alc_spec {
 
 	/* capture */
 	unsigned int num_adc_nids;
-	const hda_nid_t *adc_nids;
-	const hda_nid_t *capsrc_nids;
+	hda_nid_t adc_nids[AUTO_CFG_MAX_OUTS];
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
 	hda_nid_t mixer_nid;		/* analog-mixer NID */
 
@@ -164,7 +162,7 @@ struct alc_spec {
 
 	/* capture source */
 	unsigned int num_mux_defs;
-	const struct hda_input_mux *input_mux;
+	struct hda_input_mux input_mux;
 	unsigned int cur_mux[3];
 	hda_nid_t ext_mic_pin;
 	hda_nid_t dock_mic_pin;
@@ -184,10 +182,7 @@ struct alc_spec {
 	struct auto_pin_cfg autocfg;
 	struct alc_customize_define cdefine;
 	struct snd_array kctls;
-	struct hda_input_mux private_imux[3];
 	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
-	hda_nid_t private_adc_nids[AUTO_CFG_MAX_OUTS];
-	hda_nid_t private_capsrc_nids[AUTO_CFG_MAX_OUTS];
 	hda_nid_t imux_pins[HDA_MAX_NUM_INPUTS];
 	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
 	int int_mic_idx, ext_mic_idx, dock_mic_idx; /* for auto-mic */
@@ -291,7 +286,7 @@ static int alc_mux_enum_info(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	return snd_hda_input_mux_info(&spec->input_mux[0], uinfo);
+	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
 }
 
 static int alc_mux_enum_get(struct snd_kcontrol *kcontrol,
@@ -374,8 +369,8 @@ static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	const struct hda_input_mux *imux;
 	struct nid_path *path;
 
-	imux = spec->input_mux;
-	if (!imux || !imux->num_items)
+	imux = &spec->input_mux;
+	if (!imux->num_items)
 		return 0;
 
 	if (idx >= imux->num_items)
@@ -632,8 +627,6 @@ static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 
 	if (!spec->auto_mic || !spec->auto_mic_valid_imux)
 		return;
-	if (snd_BUG_ON(!spec->adc_nids))
-		return;
 	if (snd_BUG_ON(spec->int_mic_idx < 0 || spec->ext_mic_idx < 0))
 		return;
 
@@ -998,7 +991,7 @@ static bool alc_auto_mic_check_imux(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	const struct hda_input_mux *imux;
 
-	imux = spec->input_mux;
+	imux = &spec->input_mux;
 	spec->ext_mic_idx = find_idx_in_nid_list(spec->ext_mic_pin,
 					spec->imux_pins, imux->num_items);
 	spec->int_mic_idx = find_idx_in_nid_list(spec->int_mic_pin,
@@ -1441,7 +1434,7 @@ static int alc_cap_put_caller(struct snd_kcontrol *kcontrol,
 	struct nid_path *path;
 	int i, adc_idx, err = 0;
 
-	imux = spec->input_mux;
+	imux = &spec->input_mux;
 	adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	mutex_lock(&codec->control_mutex);
 	codec->cached_write = 1;
@@ -1488,7 +1481,7 @@ static int alc_cap_sw_put(struct snd_kcontrol *kcontrol,
 static void alc_inv_dmic_sync_adc(struct hda_codec *codec, int adc_idx)
 {
 	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux[0];
+	struct hda_input_mux *imux = &spec->input_mux;
 	struct nid_path *path;
 	hda_nid_t nid;
 	int i, dir, parm;
@@ -1650,11 +1643,6 @@ static int __alc_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
-	if (spec->cap_mixer) {
-		err = snd_hda_add_new_ctls(codec, spec->cap_mixer);
-		if (err < 0)
-			return err;
-	}
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_dig_out_ctls(codec,
 						  spec->multiout.dig_out_nid,
@@ -2014,7 +2002,7 @@ static int alc_build_pcms(struct hda_codec *codec)
 			info->stream[SNDRV_PCM_STREAM_PLAYBACK].chmap =
 				snd_pcm_2_1_chmaps;
 	}
-	if (spec->adc_nids) {
+	if (spec->num_adc_nids) {
 		p = spec->stream_analog_capture;
 		if (!p) {
 			if (spec->dyn_adc_switch)
@@ -2074,8 +2062,7 @@ static int alc_build_pcms(struct hda_codec *codec)
 	 * model, configure a second analog capture-only PCM.
 	 */
 	have_multi_adcs = (spec->num_adc_nids > 1) &&
-		!spec->dyn_adc_switch && !spec->auto_mic &&
-		(!spec->input_mux || spec->input_mux->num_items > 1);
+		!spec->dyn_adc_switch && !spec->auto_mic;
 	/* Additional Analaog capture for index #2 */
 	if (spec->alt_dac_nid || have_multi_adcs) {
 		codec->num_pcms = 3;
@@ -2442,8 +2429,8 @@ static int alc_auto_fill_adc_nids(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t nid;
-	hda_nid_t *adc_nids = spec->private_adc_nids;
-	int max_nums = ARRAY_SIZE(spec->private_adc_nids);
+	hda_nid_t *adc_nids = spec->adc_nids;
+	int max_nums = ARRAY_SIZE(spec->adc_nids);
 	int i, nums = 0;
 
 	nid = codec->start_nid;
@@ -2457,7 +2444,6 @@ static int alc_auto_fill_adc_nids(struct hda_codec *codec)
 		if (++nums >= max_nums)
 			break;
 	}
-	spec->adc_nids = spec->private_adc_nids;
 	spec->num_adc_nids = nums;
 	return nums;
 }
@@ -2468,8 +2454,8 @@ static int alc_auto_fill_adc_nids(struct hda_codec *codec)
 static int check_dyn_adc_switch(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux[0];
-	hda_nid_t adc_nids[ARRAY_SIZE(spec->private_adc_nids)];
+	struct hda_input_mux *imux = &spec->input_mux;
+	hda_nid_t adc_nids[ARRAY_SIZE(spec->adc_nids)];
 	int i, n, nums;
 	hda_nid_t pin, adc;
 
@@ -2489,7 +2475,7 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 	if (!nums) {
 		if (spec->shared_mic_hp) {
 			spec->shared_mic_hp = 0;
-			spec->private_imux[0].num_items = 1;
+			imux->num_items = 1;
 			goto again;
 		}
 
@@ -2508,12 +2494,11 @@ static int check_dyn_adc_switch(struct hda_codec *codec)
 		snd_printdd("realtek: enabling ADC switching\n");
 		spec->dyn_adc_switch = 1;
 	} else if (nums != spec->num_adc_nids) {
-		memcpy(spec->private_adc_nids, adc_nids,
-		       nums * sizeof(hda_nid_t));
+		memcpy(spec->adc_nids, adc_nids, nums * sizeof(hda_nid_t));
 		spec->num_adc_nids = nums;
 	}
 
-	if (spec->input_mux->num_items == 1 || spec->shared_mic_hp) {
+	if (imux->num_items == 1 || spec->shared_mic_hp) {
 		snd_printdd("realtek: reducing to a single ADC\n");
 		spec->num_adc_nids = 1; /* reduce to a single ADC */
 	}
@@ -2592,7 +2577,7 @@ static int parse_capvol_in_path(struct hda_codec *codec, struct nid_path *path)
 static int create_capture_mixers(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux[0];
+	struct hda_input_mux *imux = &spec->input_mux;
 	struct snd_kcontrol_new *knew;
 	int i, n, nums;
 
@@ -2654,7 +2639,7 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	const struct auto_pin_cfg *cfg = &spec->autocfg;
 	hda_nid_t mixer = spec->mixer_nid;
-	struct hda_input_mux *imux = &spec->private_imux[0];
+	struct hda_input_mux *imux = &spec->input_mux;
 	int num_adcs;
 	int i, c, err, type_idx = 0;
 	const char *prev_label = NULL;
@@ -2718,7 +2703,6 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec)
 		}
 	}
 
-	spec->input_mux = imux;
 	return 0;
 }
 
@@ -4187,7 +4171,7 @@ static void alc_auto_init_multi_io(struct hda_codec *codec)
 static void alc_auto_init_input_src(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	struct hda_input_mux *imux = &spec->private_imux[0];
+	struct hda_input_mux *imux = &spec->input_mux;
 	struct nid_path *path;
 	int i, c, nums;
 
-- 
1.8.0.1
