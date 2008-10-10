From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add mixers for analog mixer on 92hd75xx
	codecs
Date: Fri, 10 Oct 2008 09:07:23 -0400
Message-ID: <48EF538B.4020809@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 69E6524733
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 15:07:50 +0200 (CEST)
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

Add support for mixers on the analog mixer on some 92hd75xx codecs,
along with adding a 'Mixer' entry for it's connection on the dmux.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index b5c1449..1f18d32 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -320,8 +320,8 @@ static hda_nid_t stac92hd71bxx_mux_nids[2] = {
 	0x1a, 0x1b
 };

-static hda_nid_t stac92hd71bxx_dmux_nids[1] = {
-	0x1c,
+static hda_nid_t stac92hd71bxx_dmux_nids[2] = {
+	0x1c, 0x1d,
 };

 static hda_nid_t stac92hd71bxx_smux_nids[2] = {
@@ -837,20 +837,18 @@ static struct hda_verb stac92hd71bxx_core_init[] = {
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
-	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
 	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 };

-#define HD_DISABLE_PORTF 3
+#define HD_DISABLE_PORTF 2
 static struct hda_verb stac92hd71bxx_analog_core_init[] = {
 	/* start of config #1 */

 	/* connect port 0f to audio mixer */
 	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
 	/* unmute right and left channels for node 0x0f */
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	/* start of config #2 */
@@ -859,10 +857,6 @@ static struct hda_verb stac92hd71bxx_analog_core_init[] = {
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
-	/* connect port 0d to audio mixer */
-	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
-	/* unmute dac0 input in audio mixer */
-	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
 	/* unmute right and left channels for nodes 0x0a, 0xd */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
@@ -1083,6 +1077,7 @@ static struct snd_kcontrol_new stac92hd83xxx_mixer[] = {

 static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	STAC_INPUT_SOURCE(2),
+	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),

 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
@@ -1095,8 +1090,17 @@ static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
 	*/

-	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
+	HDA_CODEC_MUTE("Import0 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Import0 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
+
+	HDA_CODEC_MUTE("Import1 Mux Capture Switch", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("Import1 Mux Capture Volume", 0x17, 0x3, HDA_INPUT),
+
+	HDA_CODEC_MUTE("DAC0 Capture Switch", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_VOLUME("DAC0 Capture Volume", 0x17, 0x3, HDA_INPUT),
+
+	HDA_CODEC_MUTE("DAC1 Capture Switch", 0x17, 0x4, HDA_INPUT),
+	HDA_CODEC_VOLUME("DAC1 Capture Volume", 0x17, 0x4, HDA_INPUT),
 	{ } /* end */
 };

@@ -1616,7 +1620,7 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {

 static unsigned int ref92hd71bxx_pin_configs[11] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
-	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
+	0x0181302e, 0x01014010, 0x01019020, 0x90a000f0,
 	0x90a000f0, 0x01452050, 0x01452050,
 };

@@ -2961,7 +2965,7 @@ static int stac92xx_auto_create_mono_output_ctls(struct hda_codec *codec)

 /* labels for amp mux outputs */
 static const char *stac92xx_amp_labels[3] = {
-	"Front Microphone", "Microphone", "Line In"
+	"Front Microphone", "Microphone", "Line In",
 };

 /* create amp out controls mux on capable codecs */
@@ -4275,6 +4279,16 @@ static struct hda_codec_ops stac92hd71bxx_patch_ops = {
 #endif
 };

+static struct hda_input_mux stac92hd71bxx_dmux = {
+	.num_items = 4,
+	.items = {
+		{ "Analog Inputs", 0x00 },
+		{ "Mixer", 0x01 },
+		{ "Digital Mic 1", 0x02 },
+		{ "Digital Mic 2", 0x03 },
+	}
+};
+
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -4289,6 +4303,8 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
 	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pin_nids = stac92hd71bxx_pin_nids;
+	memcpy(&spec->private_dimux, &stac92hd71bxx_dmux,
+			sizeof(stac92hd71bxx_dmux));
 	spec->board_config = snd_hda_check_board_config(codec,
 							STAC_92HD71BXX_MODELS,
 							stac92hd71bxx_models,
@@ -4329,6 +4345,7 @@ again:
 		/* no output amps */
 		spec->num_pwrs = 0;
 		spec->mixer = stac92hd71bxx_analog_mixer;
+		spec->dinput_mux = &spec->private_dimux;

 		/* disable VSW */
 		spec->init = &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
@@ -4346,12 +4363,13 @@ again:
 		spec->num_pwrs = 0;
 		/* fallthru */
 	default:
+		spec->dinput_mux = &spec->private_dimux;
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 	}

-	spec->aloopback_mask = 0x20;
+	spec->aloopback_mask = 0x50;
 	spec->aloopback_shift = 0;

 	/* GPIO0 High = EAPD */
@@ -4370,7 +4388,6 @@ again:

 	spec->num_muxes = ARRAY_SIZE(stac92hd71bxx_mux_nids);
 	spec->num_adcs = ARRAY_SIZE(stac92hd71bxx_adc_nids);
-	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);

 	switch (spec->board_config) {
 	case STAC_HP_M4:
@@ -4391,6 +4408,10 @@ again:
 	spec->multiout.num_dacs = 1;
 	spec->multiout.hp_nid = 0x11;
 	spec->multiout.dac_nids = stac92hd71bxx_dac_nids;
+	if (spec->dinput_mux)
+		spec->private_dimux.num_items +=
+			spec->num_dmics -
+				(ARRAY_SIZE(stac92hd71bxx_dmic_nids) - 1);

 	err = stac92xx_parse_auto_config(codec, 0x21, 0x23);
 	if (!err) {
