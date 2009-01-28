From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - Consider additional capture
	source/selector in ALC889
Date: Wed, 28 Jan 2009 09:16:33 -0200
Message-ID: <200901280916.37234.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B9B24389
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 12:16:36 +0100 (CET)
Received: from localhost (perninha.conectiva.com.br [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id CED083EBD
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 06:16:48 -0500 (EST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new,
	port 10025)
	with LMTP id lULrU33q1ZER for <alsa-devel@alsa-project.org>;
	Wed, 28 Jan 2009 06:16:48 -0500 (EST)
Received: from fox.conectiva (fox.conectiva [10.0.2.195])
	by perninha.conectiva.com.br (Postfix) with ESMTP id E51013EAE
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 06:16:47 -0500 (EST)
Received: from gotham.conectiva (gotham.conectiva [10.0.2.23])
	by fox.conectiva (Postfix) with ESMTP id 8403C2F543
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 08:16:29 -0300 (BRT)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Currently code for capture source support in ALC889 only considers
capture mixers. This change adds aditional support for ADC+selector
present in ALC889, taking into account also the presence of an
additional DMIC connection item in the selector.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |  105 ++++++++++++++++++++++++++++++-----------
 1 files changed, 77 insertions(+), 28 deletions(-)

Note: I did this patch without hardware to test on, just based on alsa-info.txt
from one machine with ALC889 plus the ALC889 datasheet available from
Realtek website, so this is just build tested.

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 863ab95..d81cb5e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -238,6 +238,13 @@ enum {
 	ALC883_MODEL_LAST,
 };
 
+/* styles of capture selection */
+enum {
+	CAPT_MUX = 0,	/* only mux based */
+	CAPT_MIX,	/* only mixer based */
+	CAPT_1MUX_MIX,	/* first mux and other mixers */
+};
+
 /* for GPIO Poll */
 #define GPIO_MASK	0x03
 
@@ -276,7 +283,7 @@ struct alc_spec {
 	hda_nid_t *adc_nids;
 	hda_nid_t *capsrc_nids;
 	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
-	unsigned char is_mix_capture;	/* matrix-style capture (non-mux) */
+	int capture_style;		/* capture style (CAPT_*) */
 
 	/* capture source */
 	unsigned int num_mux_defs;
@@ -294,7 +301,7 @@ struct alc_spec {
 	/* dynamic controls, init_verbs and input_mux */
 	struct auto_pin_cfg autocfg;
 	struct snd_array kctls;
-	struct hda_input_mux private_imux;
+	struct hda_input_mux private_imux[3];
 	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
 
 	/* hooks */
@@ -396,7 +403,8 @@ static int alc_mux_enum_put(struct snd_kcontrol *kcontrol,
 	mux_idx = adc_idx >= spec->num_mux_defs ? 0 : adc_idx;
 	imux = &spec->input_mux[mux_idx];
 
-	if (spec->is_mix_capture) {
+	if (spec->capture_style &&
+	    !(spec->capture_style == CAPT_1MUX_MIX && !adc_idx)) {
 		/* Matrix-mixer style (e.g. ALC882) */
 		unsigned int *cur_val = &spec->cur_mux[adc_idx];
 		unsigned int i, idx;
@@ -4130,7 +4138,7 @@ static int new_analog_input(struct alc_spec *spec, hda_nid_t pin,
 static int alc880_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
@@ -4279,7 +4287,7 @@ static int alc880_parse_auto_config(struct hda_codec *codec)
 	add_verb(spec, alc880_volume_init_verbs);
 
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	store_pin_configs(codec);
 	return 1;
@@ -5487,7 +5495,7 @@ static int alc260_auto_create_multi_out_ctls(struct alc_spec *spec,
 static int alc260_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
@@ -5647,7 +5655,7 @@ static int alc260_parse_auto_config(struct hda_codec *codec)
 	add_verb(spec, alc260_volume_init_verbs);
 
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	store_pin_configs(codec);
 	return 1;
@@ -7087,7 +7095,7 @@ static int patch_alc882(struct hda_codec *codec)
 	spec->stream_digital_playback = &alc882_pcm_digital_playback;
 	spec->stream_digital_capture = &alc882_pcm_digital_capture;
 
-	spec->is_mix_capture = 1; /* matrix-style capture */
+	spec->capture_style = CAPT_MIX; /* matrix-style capture */
 	if (!spec->adc_nids && spec->input_mux) {
 		/* check whether NID 0x07 is valid */
 		unsigned int wcap = get_wcaps(codec, 0x07);
@@ -7155,10 +7163,14 @@ static hda_nid_t alc883_adc_nids_rev[2] = {
 	0x09, 0x08
 };
 
+#define alc889_adc_nids		alc880_adc_nids
+
 static hda_nid_t alc883_capsrc_nids[2] = { 0x23, 0x22 };
 
 static hda_nid_t alc883_capsrc_nids_rev[2] = { 0x22, 0x23 };
 
+#define alc889_capsrc_nids	alc882_capsrc_nids
+
 /* input MUX */
 /* FIXME: should be a matrix-type input source selection */
 
@@ -8977,6 +8989,8 @@ static int alc883_parse_auto_config(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	int err = alc880_parse_auto_config(codec);
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
 
 	if (err < 0)
 		return err;
@@ -8990,6 +9004,26 @@ static int alc883_parse_auto_config(struct hda_codec *codec)
 	/* hack - override the init verbs */
 	spec->init_verbs[0] = alc883_auto_init_verbs;
 
+	/* setup input_mux for ALC889 */
+	if (codec->vendor_id == 0x10ec0889) {
+		/* digital-mic input pin is excluded in alc880_auto_create..()
+		 * because it's under 0x18
+		 */
+		if (cfg->input_pins[AUTO_PIN_MIC] == 0x12 ||
+		    cfg->input_pins[AUTO_PIN_FRONT_MIC] == 0x12) {
+			struct hda_input_mux *imux = &spec->private_imux[0];
+			for (i = 1; i < 3; i++)
+				memcpy(&spec->private_imux[i],
+				       &spec->private_imux[0],
+				       sizeof(spec->private_imux[0]));
+			imux->items[imux->num_items].label = "Int DMic";
+			imux->items[imux->num_items].index = 0x0b;
+			imux->num_items++;
+			spec->num_mux_defs = 3;
+			spec->input_mux = spec->private_imux;
+		}
+	}
+
 	return 1; /* config found */
 }
 
@@ -9053,14 +9087,36 @@ static int patch_alc883(struct hda_codec *codec)
 			spec->stream_name_analog = "ALC888 Analog";
 			spec->stream_name_digital = "ALC888 Digital";
 		}
+		if (!spec->num_adc_nids) {
+			spec->num_adc_nids = ARRAY_SIZE(alc883_adc_nids);
+			spec->adc_nids = alc883_adc_nids;
+		}
+		if (!spec->capsrc_nids)
+			spec->capsrc_nids = alc883_capsrc_nids;
+		spec->capture_style = CAPT_MIX; /* matrix-style capture */
 		break;
 	case 0x10ec0889:
 		spec->stream_name_analog = "ALC889 Analog";
 		spec->stream_name_digital = "ALC889 Digital";
+		if (!spec->num_adc_nids) {
+			spec->num_adc_nids = ARRAY_SIZE(alc889_adc_nids);
+			spec->adc_nids = alc889_adc_nids;
+		}
+		if (!spec->capsrc_nids)
+			spec->capsrc_nids = alc889_capsrc_nids;
+		spec->capture_style = CAPT_1MUX_MIX; /* 1mux/Nmix-style
+							capture */
 		break;
 	default:
 		spec->stream_name_analog = "ALC883 Analog";
 		spec->stream_name_digital = "ALC883 Digital";
+		if (!spec->num_adc_nids) {
+			spec->num_adc_nids = ARRAY_SIZE(alc883_adc_nids);
+			spec->adc_nids = alc883_adc_nids;
+		}
+		if (!spec->capsrc_nids)
+			spec->capsrc_nids = alc883_capsrc_nids;
+		spec->capture_style = CAPT_MIX; /* matrix-style capture */
 		break;
 	}
 
@@ -9071,13 +9127,6 @@ static int patch_alc883(struct hda_codec *codec)
 	spec->stream_digital_playback = &alc883_pcm_digital_playback;
 	spec->stream_digital_capture = &alc883_pcm_digital_capture;
 
-	if (!spec->num_adc_nids) {
-		spec->num_adc_nids = ARRAY_SIZE(alc883_adc_nids);
-		spec->adc_nids = alc883_adc_nids;
-	}
-	if (!spec->capsrc_nids)
-		spec->capsrc_nids = alc883_capsrc_nids;
-	spec->is_mix_capture = 1; /* matrix-style capture */
 	if (!spec->cap_mixer)
 		set_capture_mixer(spec);
 
@@ -10512,7 +10561,7 @@ static int alc262_parse_auto_config(struct hda_codec *codec)
 
 	add_verb(spec, alc262_volume_init_verbs);
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	err = alc_auto_add_mic_boost(codec);
 	if (err < 0)
@@ -10881,7 +10930,7 @@ static int patch_alc262(struct hda_codec *codec)
 	spec->stream_digital_playback = &alc262_pcm_digital_playback;
 	spec->stream_digital_capture = &alc262_pcm_digital_capture;
 
-	spec->is_mix_capture = 1;
+	spec->capture_style = CAPT_MIX;
 	if (!spec->adc_nids && spec->input_mux) {
 		/* check whether NID 0x07 is valid */
 		unsigned int wcap = get_wcaps(codec, 0x07);
@@ -11539,7 +11588,7 @@ static int alc268_auto_create_multi_out_ctls(struct alc_spec *spec,
 static int alc268_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, idx1;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
@@ -11657,7 +11706,7 @@ static int alc268_parse_auto_config(struct hda_codec *codec)
 
 	add_verb(spec, alc268_volume_init_verbs);
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	err = alc_auto_add_mic_boost(codec);
 	if (err < 0)
@@ -12511,7 +12560,7 @@ static int alc269_auto_create_analog_input_ctls(struct alc_spec *spec,
 	 */
 	if (cfg->input_pins[AUTO_PIN_MIC] == 0x12 ||
 	    cfg->input_pins[AUTO_PIN_FRONT_MIC] == 0x12) {
-		struct hda_input_mux *imux = &spec->private_imux;
+		struct hda_input_mux *imux = &spec->private_imux[0];
 		imux->items[imux->num_items].label = "Int Mic";
 		imux->items[imux->num_items].index = 0x05;
 		imux->num_items++;
@@ -12567,7 +12616,7 @@ static int alc269_parse_auto_config(struct hda_codec *codec)
 
 	add_verb(spec, alc269_init_verbs);
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 	/* set default input source */
 	snd_hda_codec_write_cache(codec, alc269_capsrc_nids[0],
 				  0, AC_VERB_SET_CONNECT_SEL,
@@ -13483,7 +13532,7 @@ static int alc861_auto_create_hp_ctls(struct alc_spec *spec, hda_nid_t pin)
 static int alc861_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx, idx1;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
@@ -13620,7 +13669,7 @@ static int alc861_parse_auto_config(struct hda_codec *codec)
 	add_verb(spec, alc861_auto_init_verbs);
 
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	spec->adc_nids = alc861_adc_nids;
 	spec->num_adc_nids = ARRAY_SIZE(alc861_adc_nids);
@@ -14724,7 +14773,7 @@ static int alc861vd_parse_auto_config(struct hda_codec *codec)
 	add_verb(spec, alc861vd_volume_init_verbs);
 
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	err = alc_auto_add_mic_boost(codec);
 	if (err < 0)
@@ -14803,7 +14852,7 @@ static int patch_alc861vd(struct hda_codec *codec)
 	spec->adc_nids = alc861vd_adc_nids;
 	spec->num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids);
 	spec->capsrc_nids = alc861vd_capsrc_nids;
-	spec->is_mix_capture = 1;
+	spec->capture_style = CAPT_MIX;
 
 	set_capture_mixer(spec);
 
@@ -16397,7 +16446,7 @@ static int alc662_auto_create_extra_out(struct alc_spec *spec, hda_nid_t pin,
 static int alc662_auto_create_analog_input_ctls(struct alc_spec *spec,
 						const struct auto_pin_cfg *cfg)
 {
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx;
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
@@ -16528,7 +16577,7 @@ static int alc662_parse_auto_config(struct hda_codec *codec)
 		add_mixer(spec, spec->kctls.list);
 
 	spec->num_mux_defs = 1;
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	add_verb(spec, alc662_auto_init_verbs);
 	if (codec->vendor_id == 0x10ec0663)
@@ -16613,7 +16662,7 @@ static int patch_alc662(struct hda_codec *codec)
 	spec->adc_nids = alc662_adc_nids;
 	spec->num_adc_nids = ARRAY_SIZE(alc662_adc_nids);
 	spec->capsrc_nids = alc662_capsrc_nids;
-	spec->is_mix_capture = 1;
+	spec->capture_style = CAPT_MIX;
 
 	if (!spec->cap_mixer)
 		set_capture_mixer(spec);
-- 
1.6.1
