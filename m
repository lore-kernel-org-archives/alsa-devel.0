From: Luke Yelavich <themuso@ubuntu.com>
Subject: [PATCH] ALSA: hda - Add Macmini 3,1 support
Date: Wed, 17 Feb 2010 14:54:05 +1100
Message-ID: <1266378845-12900-1-git-send-email-themuso@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
	[150.101.137.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D7C57103810
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 04:54:21 +0100 (CET)
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
Cc: Luke Yelavich <luke.yelavich@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Luke Yelavich <luke.yelavich@canonical.com>

BugLink: https://bugs.edge.launchpad.net/ubuntu/+source/linux/+bug/343989

Add a model quirk for the NVIDIA based Macmini hardware, aka Macmini 3,1. The
pinout is almost identical to the mb5 quirk, except for no microphone and
the line-in mixer controls being on a different index. Everything works in
2ch mode, but as I am not sure what needs to be changed for 6ch mode, or
whether the Mac Mini's chip supports 6ch mode, I have simply duplicated
the code from the mb5 quirk for the mac mini chmode management. The new
model parameter for this quirk is "macmini3".

Signed-off-by: Luke Yelavich <luke.yelavich@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |  136 ++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 8f06f20..0bbdbb8 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -124,6 +124,7 @@ ALC882/883/885/888/889
   asus-a7m	ASUS A7M
   macpro	MacPro support
   mb5		Macbook 5,1
+  macmini3	Macmini 3,1
   mbp3		Macbook Pro rev3
   imac24	iMac 24'' with jack detection
   imac91	iMac 9,1
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0c22497..b5a6ba0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -211,6 +211,7 @@ enum {
 	ALC885_MACPRO,
 	ALC885_MBP3,
 	ALC885_MB5,
+	ALC885_MACMINI3,
 	ALC885_IMAC24,
 	ALC885_IMAC91,
 	ALC883_3ST_2ch_DIG,
@@ -6751,6 +6752,14 @@ static struct hda_input_mux mb5_capture_source = {
 	},
 };
 
+static struct hda_input_mux macmini3_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "Line", 0x2 },
+		{ "CD", 0x4 },
+	},
+};
+
 static struct hda_input_mux alc883_3stack_6ch_intel = {
 	.num_items = 4,
 	.items = {
@@ -6999,6 +7008,35 @@ static struct hda_channel_mode alc885_mb5_6ch_modes[2] = {
 	{ 6, alc885_mb5_ch6_init },
 };
 
+/*
+ * 2ch
+ * Speakers/Woofer/HP = Front
+ * LineIn = Input
+ */
+static struct hda_verb alc885_macmini3_ch2_init[] = {
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+	{ } /* end */
+};
+
+/*
+ * 6ch mode
+ * Speakers/HP = Front
+ * Woofer = LFE
+ * LineIn = Surround
+ */
+static struct hda_verb alc885_macmini3_ch6_init[] = {
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc885_macmini3_6ch_modes[2] = {
+	{ 2, alc885_mb5_ch2_init },
+	{ 6, alc885_mb5_ch6_init },
+};
+
 
 /*
  * 2ch mode
@@ -7243,6 +7281,21 @@ static struct snd_kcontrol_new alc885_mb5_mixer[] = {
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc885_macmini3_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE   ("Front Playback Switch", 0x0c, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE   ("Surround Playback Switch", 0x0d, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("LFE Playback Volume", 0x0e, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE   ("LFE Playback Switch", 0x0e, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0f, 0x00, HDA_OUTPUT),
+	HDA_BIND_MUTE   ("Headphone Playback Switch", 0x0f, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x07, HDA_INPUT),
+	HDA_CODEC_MUTE  ("Line Playback Switch", 0x0b, 0x07, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Boost", 0x15, 0x00, HDA_INPUT),
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc885_imac91_mixer[] = {
 	HDA_CODEC_VOLUME("Line-Out Playback Volume", 0x0c, 0x00, HDA_OUTPUT),
 	HDA_BIND_MUTE   ("Line-Out Playback Switch", 0x0c, 0x02, HDA_INPUT),
@@ -7617,6 +7670,53 @@ static struct hda_verb alc885_mb5_init_verbs[] = {
 	{ }
 };
 
+/* Macmini 3,1 */
+static struct hda_verb alc885_macmini3_init_verbs[] = {
+	/* DACs */
+	{0x02, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x03, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x04, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x05, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Front mixer */
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* Surround mixer */
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* LFE mixer */
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0e, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* HP mixer */
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	/* Front Pin (0x0c) */
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT | 0x01},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x18, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* LFE Pin (0x0e) */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT | 0x01},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x02},
+	/* HP Pin (0x0f) */
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x03},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	/* Line In pin */
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	{ }
+};
+
 /* Macbook Pro rev3 */
 static struct hda_verb alc885_mbp3_init_verbs[] = {
 	/* Front mixer: unmute input/output amp left and right (volume = 0) */
@@ -7800,6 +7900,18 @@ static void alc885_mb5_automute(struct hda_codec *codec)
 
 }
 
+static void alc885_macmini3_automute(struct hda_codec *codec)
+{
+	unsigned int present;
+
+	present = snd_hda_codec_read(codec, 0x14, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_stereo(codec, 0x18, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+	snd_hda_codec_amp_stereo(codec, 0x1a, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+}
+
 static void alc885_mb5_unsol_event(struct hda_codec *codec,
 				    unsigned int res)
 {
@@ -7808,6 +7920,14 @@ static void alc885_mb5_unsol_event(struct hda_codec *codec,
 		alc885_mb5_automute(codec);
 }
 
+static void alc885_macmini3_unsol_event(struct hda_codec *codec,
+				    unsigned int res)
+{
+	/* Headphone insertion or removal. */
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc885_mb5_automute(codec);
+}
+
 static void alc885_imac91_automute(struct hda_codec *codec)
 {
  	unsigned int present;
@@ -8974,6 +9094,7 @@ static const char *alc882_models[ALC882_MODEL_LAST] = {
 	[ALC882_ASUS_A7M]	= "asus-a7m",
 	[ALC885_MACPRO]		= "macpro",
 	[ALC885_MB5]		= "mb5",
+	[ALC885_MACMINI3]	= "macmini3",
 	[ALC885_MBP3]		= "mbp3",
 	[ALC885_IMAC24]		= "imac24",
 	[ALC885_IMAC91]		= "imac91",
@@ -9157,6 +9278,7 @@ static struct snd_pci_quirk alc882_ssid_cfg_tbl[] = {
 	 */
 	SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC885_MB5),
 	SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC885_MB5),
+	SND_PCI_QUIRK(0x106b, 0x4100, "Macmini 3,1", ALC885_MACMINI3),
 	{} /* terminator */
 };
 
@@ -9238,6 +9360,20 @@ static struct alc_config_preset alc882_presets[] = {
 		.unsol_event = alc885_mb5_unsol_event,
 		.init_hook = alc885_mb5_automute,
 	},
+	[ALC885_MACMINI3] = {
+		.mixers = { alc885_macmini3_mixer, alc882_chmode_mixer },
+		.init_verbs = { alc885_macmini3_init_verbs,
+				alc880_gpio1_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc882_dac_nids),
+		.dac_nids = alc882_dac_nids,
+		.channel_mode = alc885_macmini3_6ch_modes,
+		.num_channel_mode = ARRAY_SIZE(alc885_macmini3_6ch_modes),
+		.input_mux = &macmini3_capture_source,
+		.dig_out_nid = ALC882_DIGOUT_NID,
+		.dig_in_nid = ALC882_DIGIN_NID,
+		.unsol_event = alc885_macmini3_unsol_event,
+		.init_hook = alc885_macmini3_automute,
+	},
 	[ALC885_MACPRO] = {
 		.mixers = { alc882_macpro_mixer },
 		.init_verbs = { alc882_macpro_init_verbs },
-- 
1.6.6.1
