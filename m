From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92hd73xx fixes
Date: Fri, 12 Sep 2008 13:29:52 -0400
Message-ID: <48CAA710.3090505@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 8558B24714
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Sep 2008 19:30:04 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

Added support for defining the number of amps and the creation
of the private_dimux dynamically for the 92hd73xx codec family.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index f41ba17..fff27cc 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -156,13 +156,11 @@ struct sigmatel_spec {
 	unsigned int num_pwrs;
 	unsigned int *pwr_mapping;
 	hda_nid_t *pwr_nids;
-	hda_nid_t *amp_nids;
 	hda_nid_t *dac_list;

 	/* playback */
 	struct hda_input_mux *mono_mux;
 	struct hda_input_mux *amp_mux;
-	unsigned int cur_amux;
 	unsigned int cur_mmux;
 	struct hda_multi_out multiout;
 	hda_nid_t dac_nids[5];
@@ -201,6 +199,9 @@ struct sigmatel_spec {
 	unsigned int cur_mux[3];
 	struct hda_input_mux *sinput_mux;
 	unsigned int cur_smux[2];
+	unsigned int cur_amux;
+	hda_nid_t *amp_nids;
+	unsigned int num_amps;
 	unsigned int powerdown_adcs;

 	/* i/o switches */
@@ -247,8 +248,9 @@ static hda_nid_t stac92hd73xx_adc_nids[2] = {
 	0x1a, 0x1b
 };

-static hda_nid_t stac92hd73xx_amp_nids[4] = {
-	0x0b, 0x0c, 0x0e, 0
+#define DELL_M6_AMP 2
+static hda_nid_t stac92hd73xx_amp_nids[3] = {
+	0x0b, 0x0c, 0x0e
 };

 #define STAC92HD73XX_NUM_DMICS	2
@@ -963,29 +965,33 @@ static struct snd_kcontrol_new stac9200_mixer[] = {
 	{ } /* end */
 };

+#define DELL_M6_MIXER 6
 static struct snd_kcontrol_new stac92hd73xx_6ch_mixer[] = {
-	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 3),
-
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
-
+	/* start of config #1 */
 	HDA_CODEC_VOLUME("Front Mic Mixer Capture Volume", 0x1d, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Front Mic Mixer Capture Switch", 0x1d, 0, HDA_INPUT),

-	HDA_CODEC_VOLUME("Mic Mixer Capture Volume", 0x1d, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Mixer Capture Switch", 0x1d, 0x1, HDA_INPUT),
-
 	HDA_CODEC_VOLUME("Line In Mixer Capture Volume", 0x1d, 0x2, HDA_INPUT),
 	HDA_CODEC_MUTE("Line In Mixer Capture Switch", 0x1d, 0x2, HDA_INPUT),

+	HDA_CODEC_VOLUME("CD Mixer Capture Volume", 0x1d, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Mixer Capture Switch", 0x1d, 0x4, HDA_INPUT),
+
+	/* start of config #2 */
+	HDA_CODEC_VOLUME("Mic Mixer Capture Volume", 0x1d, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Mixer Capture Switch", 0x1d, 0x1, HDA_INPUT),
+
 	HDA_CODEC_VOLUME("DAC Mixer Capture Volume", 0x1d, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("DAC Mixer Capture Switch", 0x1d, 0x3, HDA_INPUT),

-	HDA_CODEC_VOLUME("CD Mixer Capture Volume", 0x1d, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Mixer Capture Switch", 0x1d, 0x4, HDA_INPUT),
+	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A1, 3),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x20, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x20, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x21, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x21, 0x0, HDA_OUTPUT),
+
 	{ } /* end */
 };

@@ -2956,17 +2962,19 @@ static int stac92xx_auto_create_amp_input_ctls(struct hda_codec *codec)
 	struct hda_input_mux *amp_mux = &spec->private_amp_mux;
 	int i, err;

-	for (i = 0; i < ARRAY_SIZE(stac92xx_amp_labels); i++) {
+	for (i = 0; i < spec->num_amps; i++) {
 		amp_mux->items[amp_mux->num_items].label =
 					stac92xx_amp_labels[i];
 		amp_mux->items[amp_mux->num_items].index = i;
 		amp_mux->num_items++;
 	}

-	err = stac92xx_add_control(spec, STAC_CTL_WIDGET_AMP_MUX,
-		"Amp Selector Capture Switch", 0);
-	if (err < 0)
-		return err;
+	if (spec->num_amps > 1) {
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_AMP_MUX,
+			"Amp Selector Capture Switch", 0);
+		if (err < 0)
+			return err;
+	}
 	return stac92xx_add_control(spec, STAC_CTL_WIDGET_AMP_VOL,
 		"Amp Capture Volume",
 		HDA_COMPOSE_AMP_VAL(spec->amp_nids[0], 3, 0, HDA_INPUT));
@@ -3342,12 +3350,12 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		if (err < 0)
 			return err;
 	}
-	if (spec->amp_nids) {
+	if (spec->num_amps) {
 		err = stac92xx_auto_create_amp_input_ctls(codec);
 		if (err < 0)
 			return err;
 	}
-	if (spec->num_dmics > 0)
+	if (spec->num_dmics > 0 && !spec->dinput_mux)
 		if ((err = stac92xx_auto_create_dmic_input_ctls(codec,
 						&spec->autocfg)) < 0)
 			return err;
@@ -3375,8 +3383,7 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;

 	spec->input_mux = &spec->private_imux;
-	if (!spec->dinput_mux)
-		spec->dinput_mux = &spec->private_dimux;
+	spec->dinput_mux = &spec->private_dimux;
 	spec->sinput_mux = &spec->private_smux;
 	spec->mono_mux = &spec->private_mono_mux;
 	spec->amp_mux = &spec->private_amp_mux;
@@ -3975,9 +3982,9 @@ static struct hda_input_mux stac92hd73xx_dmux = {
 	.num_items = 4,
 	.items = {
 		{ "Analog Inputs", 0x0b },
-		{ "CD", 0x08 },
 		{ "Digital Mic 1", 0x09 },
 		{ "Digital Mic 2", 0x0a },
+		{ "CD", 0x08 },
 	}
 };

@@ -4048,12 +4055,14 @@ again:
 	spec->dmux_nids = stac92hd73xx_dmux_nids;
 	spec->smux_nids = stac92hd73xx_smux_nids;
 	spec->amp_nids = stac92hd73xx_amp_nids;
+	spec->num_amps = ARRAY_SIZE(stac92hd73xx_amp_nids);

 	spec->num_muxes = ARRAY_SIZE(stac92hd73xx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd73xx_adc_nids);
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd73xx_dmux_nids);
-	spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
-	spec->dinput_mux = &stac92hd73xx_dmux;
+	memcpy(&spec->private_dimux, &stac92hd73xx_dmux,
+			sizeof(stac92hd73xx_dmux));
+
 	/* GPIO0 High = Enable EAPD */
 	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
 	spec->gpio_data = 0x01;
@@ -4061,11 +4070,18 @@ again:
 	switch (spec->board_config) {
 	case STAC_DELL_M6:
 		spec->init = dell_eq_core_init;
+		spec->num_smuxes = 0;
+		spec->multiout.hp_nid =
+			spec->multiout.dac_nids[spec->multiout.num_dacs - 1];
+		spec->mixer = &stac92hd73xx_6ch_mixer[DELL_M6_MIXER];
+		spec->amp_nids = &stac92hd73xx_amp_nids[DELL_M6_AMP];
+		spec->num_amps = 1;
 		switch (codec->subsystem_id) {
 		case 0x1028025e: /* Analog Mics */
 		case 0x1028025f:
 			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
 			spec->num_dmics = 0;
+			spec->private_dimux.num_items = 1;
 			break;
 		case 0x10280271: /* Digital Mics */
 		case 0x10280272:
@@ -4075,18 +4091,22 @@ again:
 		case 0x10280255:
 			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
 			spec->num_dmics = 1;
+			spec->private_dimux.num_items = 2;
 			break;
 		case 0x10280256: /* Both */
 		case 0x10280057:
 			stac92xx_set_config_reg(codec, 0x0b, 0x90A70170);
 			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
 			spec->num_dmics = 1;
+			spec->private_dimux.num_items = 2;
 			break;
 		}
 		break;
 	default:
 		spec->num_dmics = STAC92HD73XX_NUM_DMICS;
+		spec->num_smuxes = ARRAY_SIZE(stac92hd73xx_smux_nids);
 	}
+	spec->dinput_mux = &spec->private_dimux;

 	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
 	spec->pwr_nids = stac92hd73xx_pwr_nids;
