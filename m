From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Added more 92HD71 codecs
Date: Thu, 13 Dec 2007 14:25:43 -0500
Message-ID: <47618737.5050602@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020203010606030806050106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp106.biz.mail.mud.yahoo.com (smtp106.biz.mail.mud.yahoo.com
	[68.142.200.254]) by alsa0.perex.cz (Postfix) with SMTP id 495C2245A9
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 20:25:52 +0100 (CET)
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

This is a multi-part message in MIME format.
--------------020203010606030806050106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added more codecs to the 92HD71 family, as well as support for several 
that don't have an analog mixer.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------020203010606030806050106
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac92hd71_analog_mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac92hd71_analog_mixer.patch"

diff -r 51415b2a4cbb pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Dec 13 17:51:00 2007 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Dec 13 14:10:59 2007 -0500
@@ -532,9 +532,24 @@ static struct hda_verb stac92hd71bxx_cor
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* connect headphone jack to dac1 */
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT}, /* Speaker */
+	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
+	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	/* unmute mono out node */
+	{ 0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+};
+
+static struct hda_verb stac92hd71bxx_analog_core_init[] = {
+	/* set master volume and direct control */
+	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* connect headphone jack to dac1 */
+	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
 	/* connect ports 0d and 0f to audio mixer */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x2},
 	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
+	{ 0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	/* unmute dac0 input in audio mixer */
 	{ 0x17, AC_VERB_SET_AMP_GAIN_MUTE, 0x701f},
 	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
@@ -714,9 +729,31 @@ static struct snd_kcontrol_new stac92hd7
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
+	STAC_DIGITAL_INPUT_SOURCE(1),
+	STAC_INPUT_SOURCE(2),
+
+	/* hardware gain controls */
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x18, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x1, 0x19, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x0, 0x1c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x0, 0x1a, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
+
+	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new stac92hd71bxx_mixer[] = {
 	STAC_DIGITAL_INPUT_SOURCE(1),
 	STAC_INPUT_SOURCE(2),
+	STAC_ANALOG_LOOPBACK(0xFA0, 0x7A0, 2),
 
 	/* hardware gain controls */
 	HDA_CODEC_VOLUME_IDX("Digital Mic Volume", 0x0, 0x18, 0x0, HDA_OUTPUT),
@@ -729,9 +766,6 @@ static struct snd_kcontrol_new stac92hd7
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),
-
-	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
-	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -3088,11 +3122,24 @@ again:
 		stac92xx_set_config_regs(codec);
 	}
 
+	switch (codec->vendor_id) {
+	case 0x111d76b6: /* 4 Port without Analog Mixer */
+	case 0x111d76b7:
+	case 0x111d76b4: /* 6 Port without Analog Mixer */
+	case 0x111d76b5:
+		spec->mixer = stac92hd71bxx_mixer;
+		spec->init = stac92hd71bxx_core_init;
+		break;
+	default:
+		spec->mixer = stac92hd71bxx_analog_mixer;
+		spec->init = stac92hd71bxx_analog_core_init;
+	}
+
+	spec->aloopback_mask = 0x20;
+	spec->aloopback_shift = 0;
+
 	spec->gpio_mask = spec->gpio_data = 0x00000001; /* GPIO0 High = EAPD */
 	stac92xx_enable_gpio_mask(codec);
-
-	spec->init = stac92hd71bxx_core_init;
-	spec->mixer = stac92hd71bxx_mixer;
 
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
@@ -3702,8 +3749,17 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x838476a5, .name = "STAC9255D", .patch = patch_stac9205 },
  	{ .id = 0x838476a6, .name = "STAC9254", .patch = patch_stac9205 },
  	{ .id = 0x838476a7, .name = "STAC9254D", .patch = patch_stac9205 },
+	{ .id = 0x111d7674, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
+	{ .id = 0x111d7675, .name = "92HD73C1X5", .patch = patch_stac92hd73xx },
 	{ .id = 0x111d7676, .name = "92HD73E1X5", .patch = patch_stac92hd73xx },
-	{ .id = 0x111d7675, .name = "92HD73D1X5", .patch = patch_stac92hd73xx },
-	{ .id = 0x111d76b0, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d7608, .name = "92HD71BXX", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b0, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b1, .name = "92HD71B8X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b2, .name = "92HD71B7X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b3, .name = "92HD71B7X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b4, .name = "92HD71B6X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b5, .name = "92HD71B6X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b6, .name = "92HD71B5X", .patch = patch_stac92hd71bxx },
+	{ .id = 0x111d76b7, .name = "92HD71B5X", .patch = patch_stac92hd71bxx },
 	{} /* terminator */
 };

--------------020203010606030806050106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020203010606030806050106--
