From: Andy Shevchenko <andy@smile.org.ua>
Subject: [PATCH] Initial support of the Mitac 8252D (based on
	ALC883)
Date: Thu, 6 Dec 2007 11:46:12 +0200
Message-ID: <20071206094612.GB24527@serv.smile.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from serv.smile.org.ua (serv.smile.org.ua [193.178.237.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 2582D244E1
	for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2007 10:46:15 +0100 (CET)
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

Hi!

The attached patch adds initial support of the Mitac 8252D
(http://www.mitac-mtc.com.tw/English/products/8252Dspec.htm).

Working:
 - Front speakers (volume + mute)
 - Center/LFE speakers (volume + mute)
 - HP out (with Front Volume)
 - HP individual mute switch
 - HP Jack sense
 - Front Mic and its volume

Not tested:
 - external mic and its volume

Not working while now:
 - Mic Jack sense

Questionable:
 - is Mic have Jack sense?
 - one or two Mic volume controls?
 - CD/Line-in: presense in the mixer

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- alsa-kernel/pci/hda/patch_realtek.c.orig	2007-12-05 17:44:28.000000000 +0300
+++ alsa-kernel/pci/hda/patch_realtek.c	2007-12-05 20:16:46.000000000 +0300
@@ -185,6 +185,7 @@
 	ALC883_HAIER_W66,		
 	ALC888_6ST_HP,
 	ALC888_3ST_HP,
+	ALC883_MITAC,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6342,6 +6343,36 @@
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc883_mitac_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x09, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		/* .name = "Capture Source", */
+		.name = "Input Source",
+		.count = 2,
+		.info = alc883_mux_enum_info,
+		.get = alc883_mux_enum_get,
+		.put = alc883_mux_enum_put,
+	},
+	{ } /* end */
+};
+
 static struct snd_kcontrol_new alc883_3ST_2ch_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
@@ -6774,6 +6805,67 @@
 	{ }
 };
 
+/* toggle speaker-output according to the hp-jack state */
+static void alc883_mitac_hp_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+ 
+ 	present = snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+	snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
+}
+
+/* auto-toggle front mic */
+/*
+static void alc883_mitac_mic_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+	unsigned char bits;
+
+	present = snd_hda_codec_read(codec, 0x18, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1, HDA_AMP_MUTE, bits);
+}
+*/
+
+static void alc883_mitac_automute(struct hda_codec *codec)
+{
+	alc883_mitac_hp_automute(codec);
+	/* alc883_mitac_mic_automute(codec); */
+}
+
+static void alc883_mitac_unsol_event(struct hda_codec *codec,
+					   unsigned int res)
+{
+	switch (res >> 26) {
+	case ALC880_HP_EVENT:
+		alc883_mitac_hp_automute(codec);
+		break;
+	case ALC880_MIC_EVENT:
+		/* alc883_mitac_mic_automute(codec); */
+		break;
+	}
+}
+
+static struct hda_verb alc883_mitac_verbs[] = {
+	/* HP */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Subwoofer */
+	{0x17, AC_VERB_SET_CONNECT_SEL, 0x02},
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+
+	/* enable unsolicited event */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	/* {0x18, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_MIC_EVENT | AC_USRSP_EN}, */
+
+	{ } /* end */
+};
+
 static struct hda_verb alc883_tagra_verbs[] = {
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
@@ -7156,6 +7246,7 @@
 	[ALC883_HAIER_W66] 	= "haier-w66",
 	[ALC888_6ST_HP]		= "6stack-hp",
 	[ALC888_3ST_HP]		= "3stack-hp",
+	[ALC883_MITAC]		= "mitac",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -7190,6 +7281,7 @@
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
+	SND_PCI_QUIRK(0x1071, 0x8253, "Mitac 8252d", ALC883_MITAC),
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo 101e", ALC883_LENOVO_101E_2ch),
@@ -7437,6 +7529,19 @@
 		.need_dac_fix = 1,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_MITAC] = {
+		.mixers = { alc883_mitac_mixer },
+		.init_verbs = { alc883_init_verbs, alc883_mitac_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+		.unsol_event = alc883_mitac_unsol_event,
+		.init_hook = alc883_mitac_automute,
+	},
 };
 
 
-- 
With best regards,
Andy Shevchenko.      mailto: andy@smile.org.ua
