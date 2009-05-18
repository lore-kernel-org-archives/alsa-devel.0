From: Torben Schulz <public@letorbi.de>
Subject: [PATCH 1/1] Improved MacBook 3,1 support
Date: Mon, 18 May 2009 12:52:43 +0200
Message-ID: <4A113DFB.1080106@letorbi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lvps87-230-79-166.dedicated.hosteurope.de
	(lvps87-230-79-166.dedicated.hosteurope.de [87.230.79.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F7A2103825
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 12:53:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This patch adds support for MacBook 3,1 sound by adding a model new "mb31" with the appropriate init verbs, mixers and channel modes to the ALC883 configuration. patch_alc882() and patch_alc883() are modified to handle the MacBook 3,1 sound-chip (Realtek ALC889A) correctly.

Note: Diff'ed against the 2009-05-16 snapshot (Soory, I don't have regular net access atm.)

Signed-off by: Torben Schulz <public@letorbi.de>

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2009-05-16 21:24:45.000000000 +0200
+++ alsa-driver-mod/alsa-kernel/pci/hda/patch_realtek.c	2009-05-17 19:45:48.000000000 +0200
@@ -240,6 +240,7 @@
	ALC883_3ST_6ch_INTEL,
	ALC888_ASUS_M90V,
	ALC888_ASUS_EEE1601,
+	ALC889A_MB31,
	ALC1200_ASUS_P5Q,
	ALC883_AUTO,
	ALC883_MODEL_LAST,
@@ -7290,7 +7291,7 @@
		case 0x106b00a1: /* Macbook (might be wrong - PCI SSID?) */
		case 0x106b00a4: /* MacbookPro4,1 */
		case 0x106b2c00: /* Macbook Pro rev3 */
-		case 0x106b3600: /* Macbook 3.1 */
+		/* Macbook 3.1 (0x106b3600) is handled by patch_alc883() */
		case 0x106b3800: /* MacbookPro4,1 - latter revision */
			board_config = ALC885_MBP3;
			break;
@@ -7491,6 +7492,17 @@
	},
};

+static struct hda_input_mux alc889A_mb31_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "Mic", 0x0 },
+		/* Front Mic (0x01) unused */
+		{ "Line", 0x2 },
+		/* Line 2 (0x03) unused */
+		/* CD (0x04) unsused? */
+	},
+};
+
/*
* 2ch mode
*/
@@ -7609,6 +7621,49 @@
	{ 8, alc883_sixstack_ch8_init },
};

+/* 2ch mode (Speaker:front, Subwoofer:CLFE, Line:input, Headphones:front) */
+static struct hda_verb alc889A_mb31_ch2_init[] = {
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},             /* Headphones as front */
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE}, /* Subwoofer output on */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},    /* Line as input*/
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},   /* Line output off */
+	{ } /* end */
+};
+
+/* 4ch mode (Speaker:front, Subwoofer:CLFE, Line:CLFE, Headphones:front) */
+static struct hda_verb alc889A_mb31_ch4_init[] = {
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},             /* Headphones as front */
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE}, /* Subwoofer output on */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},   /* Line as output */
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE}, /* Line output on */
+	{ } /* end */
+};
+
+/* 5ch mode (Speaker:front, Subwoofer:CLFE, Line:input, Headphones:rear) */
+static struct hda_verb alc889A_mb31_ch5_init[] = {
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},             /* Headphones as rear */
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE}, /* Subwoofer output on */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},    /* Line as input*/
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},   /* Line output off */
+	{ } /* end */
+};
+
+/* 6ch mode (Speaker:front, Subwoofer:off, Line:CLFE, Headphones:Rear) */
+static struct hda_verb alc889A_mb31_ch6_init[] = {
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},             /* Headphones as front */
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},   /* Subwoofer output off */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},   /* Line as output */
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE}, /* Line output on */
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc889A_mb31_6ch_modes[4] = {
+	{ 2, alc889A_mb31_ch2_init },
+	{ 4, alc889A_mb31_ch4_init },
+	{ 5, alc889A_mb31_ch5_init },
+	{ 6, alc889A_mb31_ch6_init },
+};
+
static struct hda_verb alc883_medion_eapd_verbs[] = {
     /* eanable EAPD on medion laptop */
	{0x20, AC_VERB_SET_COEF_INDEX, 0x07},
@@ -7887,6 +7942,31 @@
	{ } /* end */
};

+static struct snd_kcontrol_new alc889A_mb31_mixer[] = {
+	/* Output mixers */
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 0x02, HDA_INPUT),
+	/* Output switches */
+	HDA_CODEC_MUTE("Enable Speaker", 0x14, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Enable Headphones", 0x15, 0x00, HDA_OUTPUT),
+	HDA_CODEC_MUTE_MONO("Enable LFE", 0x16, 2, 0x00, HDA_OUTPUT),
+	/* Boost mixers */
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost", 0x1a, 0x00, HDA_INPUT),
+	/* Input mixers */
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x00, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	{ } /* end */
+};
+
static struct hda_bind_ctls alc883_bind_cap_vol = {
	.ops = &snd_hda_bind_vol,
	.values = {
@@ -8559,6 +8639,38 @@
	alc_automute_pin(codec);
}

+static struct hda_verb alc889A_mb31_verbs[] = {
+	/* Init rear pin (used as headphone output) */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc4},    /* Apple Headphones */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},           /* Connect to front */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	/* Init line pin (used as output in 4ch and 6ch mode) */
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x02},           /* Connect to CLFE */	
+	/* Init line 2 pin (used as headphone out by default) */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},  /* Use as input */
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE}, /* Mute output */
+	{ } /* end */
+};
+
+/* Mute speakers according to the headphone jack state */
+static void alc889A_mb31_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	/* Mute only in 2ch or 4ch mode */
+	if (snd_hda_codec_read(codec, 0x15, 0, AC_VERB_GET_CONNECT_SEL, 0) == 0x00) {
+	 	present = snd_hda_codec_read(codec, 0x15, 0, AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+		snd_hda_codec_amp_stereo(codec, 0x14,  HDA_OUTPUT, 0, HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0, HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+	}
+}
+
+static void alc889A_mb31_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc889A_mb31_automute(codec);
+}
+
#ifdef CONFIG_SND_HDA_POWER_SAVE
#define alc883_loopbacks	alc880_loopbacks
#endif
@@ -8599,6 +8711,7 @@
	[ALC888_FUJITSU_XA3530] = "fujitsu-xa3530",
	[ALC883_3ST_6ch_INTEL]	= "3stack-6ch-intel",
	[ALC1200_ASUS_P5Q]	= "asus-p5q",
+	[ALC889A_MB31]		= "mb31",
	[ALC883_AUTO]		= "auto",
};

@@ -9050,6 +9163,20 @@
		.channel_mode = alc883_sixstack_modes,
		.input_mux = &alc883_capture_source,
	},
+	[ALC889A_MB31] = {
+		.mixers = { alc889A_mb31_mixer, alc883_chmode_mixer},
+		.init_verbs = { alc883_init_verbs, alc889A_mb31_verbs, alc880_gpio1_init_verbs },
+		.adc_nids = alc883_adc_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.channel_mode = alc889A_mb31_6ch_modes,
+		.num_channel_mode = ARRAY_SIZE(alc889A_mb31_6ch_modes),
+		.input_mux = &alc889A_mb31_capture_source,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.unsol_event = alc889A_mb31_unsol_event,
+		.init_hook = alc889A_mb31_automute,
+	},
};


@@ -9195,11 +9322,19 @@
	board_config = snd_hda_check_board_config(codec, ALC883_MODEL_LAST,
						  alc883_models,
						  alc883_cfg_tbl);
-	if (board_config < 0) {
-		printk(KERN_INFO "hda_codec: Unknown model for ALC883, "
-		       "trying auto-probe from BIOS...\n");
-		board_config = ALC883_AUTO;
-	}
+	if (board_config < 0 || board_config >= ALC883_MODEL_LAST) {
+		/* Pick up systems that don't supply PCI SSID */
+		switch (codec->subsystem_id) {
+		case 0x106b3600: /* Macbook 3.1 */
+			board_config = ALC889A_MB31;
+			break;
+		default:
+			printk(KERN_INFO "hda_codec: Unknown model for ALC883, "
+			       "trying auto-probe from BIOS...\n");
+			board_config = ALC883_AUTO;
+		}
+  	}
+

	if (board_config == ALC883_AUTO) {
		/* automatic parse from the BIOS config */
