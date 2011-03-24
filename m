From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: New AD1984A model for Dell
	Precision R5500
Date: Thu, 24 Mar 2011 10:20:10 +0100
Message-ID: <4D8B0CCA.6000705@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040907030604030002090009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F90610397B
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 10:20:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040907030604030002090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

For codec AD1984A, add a new model to support Dell Precision R5500
or the microphone jack won't work correctly.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040907030604030002090009
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-New-AD1984A-model-for-Dell-Precision-R5500.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-New-AD1984A-model-for-Dell-Precision-R5500.pat";
 filename*1="ch"

>From 97698bbfac0272bb6654393bb38e596094aa59d1 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 7 Feb 2011 15:19:34 +0100
Subject: [PATCH] ALSA: HDA: New AD1984A model for Dell Precision R5500

For codec AD1984A, add a new model to support Dell Precision R5500
or the microphone jack won't work correctly.

BugLink: http://bugs.launchpad.net/bugs/741516
Tested-by: Kent Baxley <kent.baxley@canonical.com>
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_analog.c |   89 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 734c6ee..2942d2a 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -4256,6 +4256,84 @@ static int ad1984a_thinkpad_init(struct hda_codec *codec)
 }
 
 /*
+ * Precision R5500
+ * 0x12 - HP/line-out
+ * 0x13 - speaker (mono)
+ * 0x15 - mic-in
+ */
+
+static struct hda_verb ad1984a_precision_verbs[] = {
+	/* Unmute main output path */
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, 0x27}, /* 0dB */
+	{0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE + 0x1f}, /* 0dB */
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5) + 0x17}, /* 0dB */
+	/* Analog mixer; mute as default */
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	/* Select mic as input */
+	{0x0c, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE + 0x27}, /* 0dB */
+	/* Configure as mic */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, 0x7002}, /* raise mic as default */
+	/* HP unmute */
+	{0x12, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* turn on EAPD */
+	{0x13, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	/* unsolicited event for pin-sense */
+	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | AD1884A_HP_EVENT},
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new ad1984a_precision_mixers[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0x21, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Master Playback Switch", 0x21, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("PCM Playback Volume", 0x20, 0x5, HDA_INPUT),
+	HDA_CODEC_MUTE("PCM Playback Switch", 0x20, 0x5, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x20, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x20, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost Volume", 0x15, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x12, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x13, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x0c, 0x0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+
+/* mute internal speaker if HP is plugged */
+static void ad1984a_precision_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_jack_detect(codec, 0x12);
+	snd_hda_codec_amp_stereo(codec, 0x13, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+}
+
+
+/* unsolicited event for HP jack sensing */
+static void ad1984a_precision_unsol_event(struct hda_codec *codec,
+					 unsigned int res)
+{
+	if ((res >> 26) != AD1884A_HP_EVENT)
+		return;
+	ad1984a_precision_automute(codec);
+}
+
+/* initialize jack-sensing, too */
+static int ad1984a_precision_init(struct hda_codec *codec)
+{
+	ad198x_init(codec);
+	ad1984a_precision_automute(codec);
+	return 0;
+}
+
+
+/*
  * HP Touchsmart
  * port-A (0x11)      - front hp-out
  * port-B (0x14)      - unused
@@ -4384,6 +4462,7 @@ enum {
 	AD1884A_MOBILE,
 	AD1884A_THINKPAD,
 	AD1984A_TOUCHSMART,
+	AD1984A_PRECISION,
 	AD1884A_MODELS
 };
 
@@ -4393,9 +4472,11 @@ static const char * const ad1884a_models[AD1884A_MODELS] = {
 	[AD1884A_MOBILE]	= "mobile",
 	[AD1884A_THINKPAD]	= "thinkpad",
 	[AD1984A_TOUCHSMART]	= "touchsmart",
+	[AD1984A_PRECISION]	= "precision",
 };
 
 static struct snd_pci_quirk ad1884a_cfg_tbl[] = {
+	SND_PCI_QUIRK(0x1028, 0x04ac, "Precision R5500", AD1984A_PRECISION),
 	SND_PCI_QUIRK(0x103c, 0x3030, "HP", AD1884A_MOBILE),
 	SND_PCI_QUIRK(0x103c, 0x3037, "HP 2230s", AD1884A_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x3056, "HP", AD1884A_MOBILE),
@@ -4489,6 +4570,14 @@ static int patch_ad1884a(struct hda_codec *codec)
 		codec->patch_ops.unsol_event = ad1984a_thinkpad_unsol_event;
 		codec->patch_ops.init = ad1984a_thinkpad_init;
 		break;
+	case AD1984A_PRECISION:
+		spec->mixers[0] = ad1984a_precision_mixers;
+		spec->init_verbs[spec->num_init_verbs++] =
+			ad1984a_precision_verbs;
+		spec->multiout.dig_out_nid = 0;
+		codec->patch_ops.unsol_event = ad1984a_precision_unsol_event;
+		codec->patch_ops.init = ad1984a_precision_init;
+		break;
 	case AD1984A_TOUCHSMART:
 		spec->mixers[0] = ad1984a_touchsmart_mixers;
 		spec->init_verbs[0] = ad1984a_touchsmart_verbs;
-- 
1.7.1


--------------040907030604030002090009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040907030604030002090009--
