From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add support for 92HD73xxx codecs
Date: Thu, 12 Jun 2008 15:19:31 -0400
Message-ID: <485176C3.80402@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 5244424786
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 21:19:42 +0200 (CEST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Added support for new family of IDT codecs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a4f44a0..115cee6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -349,7 +349,7 @@ static hda_nid_t stac92hd73xx_pin_nids[13] = {

 static hda_nid_t stac92hd71bxx_pin_nids[10] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
-	0x0f, 0x14, 0x18, 0x19, 0x1e,
+	0x14, 0x18, 0x19, 0x1e, 0x0f
 };

 static hda_nid_t stac927x_pin_nids[14] = {
@@ -641,15 +641,21 @@ static struct hda_verb stac92hd71bxx_analog_core_init[] = {
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
-	/* connect ports 0d and 0f to audio mixer */
-	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
-	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
+	/* connect port 0d to audio mixer */
+	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x02},
 	/* unmute dac0 input in audio mixer */
 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
-	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+	/* unmute right and left channels for nodes 0x0a, 0x0d */
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{}
+};
+
+static struct hda_verb stac92hd71bxx_enable_portf[] = {
+	/* connect port 0f to audio mixer */
+	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
+	/* unmute right and left channels for nodes 0x0f */
 	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };
@@ -1313,20 +1319,20 @@ static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {

 static unsigned int ref92hd71bxx_pin_configs[10] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
-	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
-	0x90a000f0, 0x01452050,
+	0x0181302e, 0x01019020, 0x90a000f0, 0x90a000f0,
+	0x01452050, 0x01114010,
 };

-static unsigned int dell_m4_1_pin_configs[13] = {
+static unsigned int dell_m4_1_pin_configs[10] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
-	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x4f0000f0,
+	0x23a1902e, 0x40f000f0, 0x90a000f0, 0x40f000f0,
+	0x4f0000f0, 0x23014250,
 };

-static unsigned int dell_m4_2_pin_configs[13] = {
+static unsigned int dell_m4_2_pin_configs[10] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
-	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
-	0x40f000f0, 0x044413b0,
+	0x23a1902e, 0x40f000f0, 0x40f000f0, 0x40f000f0,
+	0x044413b0, 0x23014250,
 };

 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
@@ -2633,7 +2639,7 @@ static int stac92xx_auto_create_dmic_input_ctls(struct
hda_codec *codec,
 					      0,
 					      AC_VERB_GET_CONFIG_DEFAULT,
 					      0);
-		if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE)
+		if (def_conf && (def_conf == AC_JACK_PORT_NONE))
 			continue;

 		nid = spec->dmic_nids[i];
@@ -3103,13 +3109,14 @@ static int stac92xx_init(struct hda_codec *codec)
 					0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 		int def_conf = snd_hda_codec_read(codec, spec->pwr_nids[i],
 					0, AC_VERB_GET_CONFIG_DEFAULT, 0);
+		def_conf = get_defcfg_connect(def_conf);
 		/* outputs are only ports capable of power management
 		 * any attempts on powering down a input port cause the
 		 * referenced VREF to act quirky.
 		 */
 		if (pinctl & AC_PINCTL_IN_EN)
 			continue;
-		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED)
+		if (def_conf && def_conf != AC_JACK_PORT_FIXED)
 			continue;
 		enable_pin_detect(codec, spec->pwr_nids[i], event | i);
 		codec->patch_ops.unsol_event(codec, (event | i) << 26);
@@ -3614,12 +3621,39 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)

 	codec->spec = spec;
 	spec->num_pins = ARRAY_SIZE(stac92hd71bxx_pin_nids);
+	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pin_nids = stac92hd71bxx_pin_nids;
 	spec->board_config = snd_hda_check_board_config(codec,
 							STAC_92HD71BXX_MODELS,
 							stac92hd71bxx_models,
 							stac92hd71bxx_cfg_tbl);
 again:
+	switch (codec->vendor_id) {
+	case 0x111d76b6: /* 4 Port without Analog Mixer */
+	case 0x111d76b7:
+	case 0x111d76b4: /* 6 Port without Analog Mixer */
+	case 0x111d76b5:
+		spec->mixer = stac92hd71bxx_mixer;
+		spec->init = stac92hd71bxx_core_init;
+		break;
+	case 0x111d7603: /* 6 Port with Analog Mixer */
+	case 0x111d7608:
+		/* no output amps */
+		spec->num_pwrs = 0;
+		/* fallthru */
+	default:
+		spec->mixer = stac92hd71bxx_analog_mixer;
+		spec->init = stac92hd71bxx_analog_core_init;
+	}
+
+	if (codec->vendor_id != 0x111d7608)
+		snd_hda_sequence_write(codec, stac92hd71bxx_enable_portf);
+	else {
+		/* skip the VSW on port f */
+		spec->num_pins--;
+		stac92xx_set_config_reg(codec, 0xf, 0x40f000f0);
+	}
+
 	if (spec->board_config < 0) {
 		snd_printdd(KERN_INFO "hda_codec: Unknown model for"
 			" STAC92HD71BXX, using BIOS defaults\n");
@@ -3634,19 +3668,6 @@ again:
 		stac92xx_set_config_regs(codec);
 	}

-	switch (codec->vendor_id) {
-	case 0x111d76b6: /* 4 Port without Analog Mixer */
-	case 0x111d76b7:
-	case 0x111d76b4: /* 6 Port without Analog Mixer */
-	case 0x111d76b5:
-		spec->mixer = stac92hd71bxx_mixer;
-		spec->init = stac92hd71bxx_core_init;
-		break;
-	default:
-		spec->mixer = stac92hd71bxx_analog_mixer;
-		spec->init = stac92hd71bxx_analog_core_init;
-	}
-
 	spec->aloopback_mask = 0x20;
 	spec->aloopback_shift = 0;

@@ -3666,7 +3687,6 @@ again:
 	spec->num_dmics = STAC92HD71BXX_NUM_DMICS;
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);

-	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
 	spec->pwr_nids = stac92hd71bxx_pwr_nids;

 	spec->multiout.num_dacs = 1;
@@ -4306,10 +4326,11 @@ struct hda_codec_preset snd_hda_preset_sigmatel[] = {
  	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
+	{ .id = 0x111d7603, .name = "92HD75B3X5", .patch = patch_stac92hd71bxx},
+	{ .id = 0x111d7608, .name = "92HD75B2X5", .patch = patch_stac92hd71bxx},
 	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7676, .name = "92HD73E1X5", .patch = patch_stac92hd73xx },
-	{ .id = 0x111d7608, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b0, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b1, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
 	{ .id = 0x111d76b2, .name = "92HD71B7X", .patch = patch_stac92hd71bxx },
