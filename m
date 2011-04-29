From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: hda - Add channel-mode support to
	Realtek auto-parser
Date: Fri, 29 Apr 2011 19:18:28 +0200
Message-ID: <1304097516-7258-3-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DE7A103A3C
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id E4EF38765C
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:09 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This patch adds the support of "Channel Mode" enum control to Realtek
auto-parser.  When line-in or mic-in jacks are capable to output and
free DACs are available, the driver allows to switch to multi-channel
mode via "Channel Mode" enum switch, as already implemented in some
preset cases.

Not implemented in all Realtek codecs.  Currently, ALC880, 882, 861,
662 and the compatible codecs are supported.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  269 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 249 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ed95dd..4c4d51a2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -299,6 +299,12 @@ struct alc_customize_define {
 
 struct alc_fixup;
 
+struct alc_multi_io {
+	hda_nid_t pin;		/* multi-io widget pin NID */
+	hda_nid_t dac;		/* DAC to be connected */
+	unsigned int ctl_in;	/* cached input-pin control value */
+};
+
 struct alc_spec {
 	/* codec parameterization */
 	struct snd_kcontrol_new *mixers[5];	/* mixer arrays */
@@ -404,6 +410,10 @@ struct alc_spec {
 	int fixup_id;
 	const struct alc_fixup *fixup_list;
 	const char *fixup_name;
+
+	/* multi-io */
+	int multi_ios;
+	struct alc_multi_io multi_io[4];
 };
 
 /*
@@ -4992,14 +5002,19 @@ static struct snd_kcontrol_new alc880_control_templates[] = {
 	HDA_BIND_MUTE(NULL, 0, 0, 0),
 };
 
+static struct snd_kcontrol_new *alc_kcontrol_new(struct alc_spec *spec)
+{
+	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
+	return snd_array_new(&spec->kctls);
+}
+
 /* add dynamic controls */
 static int add_control(struct alc_spec *spec, int type, const char *name,
 		       int cidx, unsigned long val)
 {
 	struct snd_kcontrol_new *knew;
 
-	snd_array_init(&spec->kctls, sizeof(*knew), 32);
-	knew = snd_array_new(&spec->kctls);
+	knew = alc_kcontrol_new(spec);
 	if (!knew)
 		return -ENOMEM;
 	*knew = alc880_control_templates[type];
@@ -5080,10 +5095,13 @@ static int alc880_auto_fill_dac_nids(struct alc_spec *spec,
 	return 0;
 }
 
-static const char *alc_get_line_out_pfx(const struct auto_pin_cfg *cfg,
+static const char *alc_get_line_out_pfx(struct alc_spec *spec,
 					bool can_be_master)
 {
-	if (!cfg->hp_outs && !cfg->speaker_outs && can_be_master)
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+
+	if (cfg->line_outs == 1 && !spec->multi_ios &&
+	    !cfg->hp_outs && !cfg->speaker_outs && can_be_master)
 		return "Master";
 
 	switch (cfg->line_out_type) {
@@ -5094,7 +5112,7 @@ static const char *alc_get_line_out_pfx(const struct auto_pin_cfg *cfg,
 	case AUTO_PIN_HP_OUT:
 		return "Headphone";
 	default:
-		if (cfg->line_outs == 1)
+		if (cfg->line_outs == 1 && !spec->multi_ios)
 			return "PCM";
 		break;
 	}
@@ -5108,11 +5126,15 @@ static int alc880_auto_create_multi_out_ctls(struct alc_spec *spec,
 	static const char * const chname[4] = {
 		"Front", "Surround", NULL /*CLFE*/, "Side"
 	};
-	const char *pfx = alc_get_line_out_pfx(cfg, false);
+	const char *pfx = alc_get_line_out_pfx(spec, false);
 	hda_nid_t nid;
-	int i, err;
+	int i, err, noutputs;
 
-	for (i = 0; i < cfg->line_outs; i++) {
+	noutputs = cfg->line_outs;
+	if (spec->multi_ios > 0)
+		noutputs += spec->multi_ios;
+
+	for (i = 0; i < noutputs; i++) {
 		if (!spec->multiout.dac_nids[i])
 			continue;
 		nid = alc880_idx_to_mixer(alc880_dac_to_idx(spec->multiout.dac_nids[i]));
@@ -5378,6 +5400,8 @@ static void alc880_auto_init_input_src(struct hda_codec *codec)
 	}
 }
 
+static int alc_auto_add_multi_channel_mode(struct hda_codec *codec);
+
 /* parse the BIOS configuration and set up the alc_spec */
 /* return 1 if successful, 0 if the proper config is not found,
  * or a negative error code
@@ -5398,6 +5422,9 @@ static int alc880_parse_auto_config(struct hda_codec *codec)
 	err = alc880_auto_fill_dac_nids(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	err = alc_auto_add_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
 	err = alc880_auto_create_multi_out_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
@@ -10949,6 +10976,9 @@ static int alc882_parse_auto_config(struct hda_codec *codec)
 	err = alc880_auto_fill_dac_nids(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	err = alc_auto_add_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
 	err = alc880_auto_create_multi_out_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
@@ -12165,7 +12195,7 @@ static int alc262_auto_create_multi_out_ctls(struct alc_spec *spec,
 	spec->multiout.dac_nids = spec->private_dac_nids;
 	spec->multiout.dac_nids[0] = 2;
 
-	pfx = alc_get_line_out_pfx(cfg, true);
+	pfx = alc_get_line_out_pfx(spec, true);
 	if (!pfx)
 		pfx = "Front";
 	for (i = 0; i < 2; i++) {
@@ -16020,11 +16050,15 @@ static int alc861_auto_create_multi_out_ctls(struct hda_codec *codec,
 	static const char * const chname[4] = {
 		"Front", "Surround", NULL /*CLFE*/, "Side"
 	};
-	const char *pfx = alc_get_line_out_pfx(cfg, true);
+	const char *pfx = alc_get_line_out_pfx(spec, true);
 	hda_nid_t nid;
-	int i, err;
+	int i, err, noutputs;
 
-	for (i = 0; i < cfg->line_outs; i++) {
+	noutputs = cfg->line_outs;
+	if (spec->multi_ios > 0)
+		noutputs += spec->multi_ios;
+
+	for (i = 0; i < noutputs; i++) {
 		nid = spec->multiout.dac_nids[i];
 		if (!nid)
 			continue;
@@ -16169,6 +16203,9 @@ static int alc861_parse_auto_config(struct hda_codec *codec)
 	err = alc861_auto_fill_dac_nids(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	err = alc_auto_add_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
 	err = alc861_auto_create_multi_out_ctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
@@ -17152,11 +17189,15 @@ static int alc861vd_auto_create_multi_out_ctls(struct alc_spec *spec,
 	static const char * const chname[4] = {
 		"Front", "Surround", "CLFE", "Side"
 	};
-	const char *pfx = alc_get_line_out_pfx(cfg, true);
+	const char *pfx = alc_get_line_out_pfx(spec, true);
 	hda_nid_t nid_v, nid_s;
-	int i, err;
+	int i, err, noutputs;
 
-	for (i = 0; i < cfg->line_outs; i++) {
+	noutputs = cfg->line_outs;
+	if (spec->multi_ios > 0)
+		noutputs += spec->multi_ios;
+
+	for (i = 0; i < noutputs; i++) {
 		if (!spec->multiout.dac_nids[i])
 			continue;
 		nid_v = alc861vd_idx_to_mixer_vol(
@@ -17281,6 +17322,9 @@ static int alc861vd_parse_auto_config(struct hda_codec *codec)
 	err = alc880_auto_fill_dac_nids(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	err = alc_auto_add_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
 	err = alc861vd_auto_create_multi_out_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
@@ -19176,6 +19220,27 @@ static hda_nid_t alc_auto_dac_to_mix(struct hda_codec *codec, hda_nid_t pin,
 	return 0;
 }
 
+/* select the connection from pin to DAC if needed */
+static int alc_auto_select_dac(struct hda_codec *codec, hda_nid_t pin,
+			       hda_nid_t dac)
+{
+	hda_nid_t mix[5];
+	int i, num;
+
+	pin = alc_go_down_to_selector(codec, pin);
+	num = snd_hda_get_connections(codec, pin, mix, ARRAY_SIZE(mix));
+	if (num < 2)
+		return 0;
+	for (i = 0; i < num; i++) {
+		if (alc_auto_mix_to_dac(codec, mix[i]) == dac) {
+			snd_hda_codec_update_cache(codec, pin, 0,
+						   AC_VERB_SET_CONNECT_SEL, i);
+			return 0;
+		}
+	}
+	return 0;
+}
+
 /* look for an empty DAC slot */
 static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 {
@@ -19247,15 +19312,23 @@ static int alc662_auto_create_multi_out_ctls(struct hda_codec *codec,
 	static const char * const chname[4] = {
 		"Front", "Surround", NULL /*CLFE*/, "Side"
 	};
-	const char *pfx = alc_get_line_out_pfx(cfg, true);
-	hda_nid_t nid, mix;
-	int i, err;
+	const char *pfx = alc_get_line_out_pfx(spec, true);
+	hda_nid_t nid, mix, pin;
+	int i, err, noutputs;
 
-	for (i = 0; i < cfg->line_outs; i++) {
+	noutputs = cfg->line_outs;
+	if (spec->multi_ios > 0)
+		noutputs += spec->multi_ios;
+
+	for (i = 0; i < noutputs; i++) {
 		nid = spec->multiout.dac_nids[i];
 		if (!nid)
 			continue;
-		mix = alc_auto_dac_to_mix(codec, cfg->line_out_pins[i], nid);
+		if (i >= cfg->line_outs)
+			pin = spec->multi_io[i - 1].pin;
+		else
+			pin = cfg->line_out_pins[i];
+		mix = alc_auto_dac_to_mix(codec, pin, nid);
 		if (!mix)
 			continue;
 		if (!pfx && i == 2) {
@@ -19406,6 +19479,159 @@ static void alc662_auto_init_analog_input(struct hda_codec *codec)
 
 #define alc662_auto_init_input_src	alc882_auto_init_input_src
 
+/*
+ * multi-io helper
+ */
+static int alc_auto_fill_multi_ios(struct hda_codec *codec,
+				   unsigned int location)
+{
+	struct alc_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int type, i, num_pins = 0;
+
+	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			hda_nid_t nid = cfg->inputs[i].pin;
+			hda_nid_t dac;
+			unsigned int defcfg, caps;
+			if (cfg->inputs[i].type != type)
+				continue;
+			defcfg = snd_hda_codec_get_pincfg(codec, nid);
+			if (get_defcfg_connect(defcfg) != AC_JACK_PORT_COMPLEX)
+				continue;
+			if (location && get_defcfg_location(defcfg) != location)
+				continue;
+			caps = snd_hda_query_pin_caps(codec, nid);
+			if (!(caps & AC_PINCAP_OUT))
+				continue;
+			dac = alc_auto_look_for_dac(codec, nid);
+			if (!dac)
+				continue;
+			spec->multi_io[num_pins].pin = nid;
+			spec->multi_io[num_pins].dac = dac;
+			num_pins++;
+			spec->multiout.dac_nids[spec->multiout.num_dacs++] = dac;
+		}
+	}
+	spec->multiout.num_dacs = 1;
+	if (num_pins < 2)
+		return 0;
+	return num_pins;
+}
+
+static int alc_auto_ch_mode_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = spec->multi_ios + 1;
+	if (uinfo->value.enumerated.item > spec->multi_ios)
+		uinfo->value.enumerated.item = spec->multi_ios;
+	sprintf(uinfo->value.enumerated.name, "%dch",
+		(uinfo->value.enumerated.item + 1) * 2);
+	return 0;
+}
+
+static int alc_auto_ch_mode_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = (spec->ext_channel_count - 1) / 2;
+	return 0;
+}
+
+static int alc_set_multi_io(struct hda_codec *codec, int idx, bool output)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t nid = spec->multi_io[idx].pin;
+
+	if (!spec->multi_io[idx].ctl_in)
+		spec->multi_io[idx].ctl_in =
+			snd_hda_codec_read(codec, nid, 0,
+					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	if (output) {
+		snd_hda_codec_update_cache(codec, nid, 0,
+					   AC_VERB_SET_PIN_WIDGET_CONTROL,
+					   PIN_OUT);
+		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
+			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
+						 HDA_AMP_MUTE, 0);
+		alc_auto_select_dac(codec, nid, spec->multi_io[idx].dac);
+	} else {
+		if (get_wcaps(codec, nid) & AC_WCAP_OUT_AMP)
+			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
+						 HDA_AMP_MUTE, HDA_AMP_MUTE);
+		snd_hda_codec_update_cache(codec, nid, 0,
+					   AC_VERB_SET_PIN_WIDGET_CONTROL,
+					   spec->multi_io[idx].ctl_in);
+	}
+	return 0;
+}
+
+static int alc_auto_ch_mode_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	int i, ch;
+
+	ch = ucontrol->value.enumerated.item[0];
+	if (ch < 0 || ch > spec->multi_ios)
+		return -EINVAL;
+	if (ch == (spec->ext_channel_count - 1) / 2)
+		return 0;
+	spec->ext_channel_count = (ch + 1) * 2;
+	for (i = 0; i < spec->multi_ios; i++)
+		alc_set_multi_io(codec, i, i < ch);
+	spec->multiout.max_channels = spec->ext_channel_count;
+	return 1;
+}
+
+static struct snd_kcontrol_new alc_auto_channel_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Channel Mode",
+	.info = alc_auto_ch_mode_info,
+	.get = alc_auto_ch_mode_get,
+	.put = alc_auto_ch_mode_put,
+};
+
+static int alc_auto_add_multi_channel_mode(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int location, defcfg;
+	int num_pins;
+
+	if (cfg->line_outs != 1 ||
+	    cfg->line_out_type != AUTO_PIN_LINE_OUT)
+		return 0;
+
+	defcfg = snd_hda_codec_get_pincfg(codec, cfg->line_out_pins[0]);
+	location = get_defcfg_location(defcfg);
+
+	num_pins = alc_auto_fill_multi_ios(codec, location);
+	if (num_pins > 0) {
+		struct snd_kcontrol_new *knew;
+
+		knew = alc_kcontrol_new(spec);
+		if (!knew)
+			return -ENOMEM;
+		*knew = alc_auto_channel_mode_enum;
+		knew->name = kstrdup("Channel Mode", GFP_KERNEL);
+		if (!knew->name)
+			return -ENOMEM;
+
+		spec->multi_ios = num_pins;
+		spec->ext_channel_count = 2;
+		spec->multiout.num_dacs = num_pins + 1;
+	}
+	return 0;
+}
+
 static int alc662_parse_auto_config(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -19422,6 +19648,9 @@ static int alc662_parse_auto_config(struct hda_codec *codec)
 	err = alc662_auto_fill_dac_nids(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	err = alc_auto_add_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
 	err = alc662_auto_create_multi_out_ctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
-- 
1.7.4.2
