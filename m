From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH] model for alc883 to support FUJITSU Pi2515
Date: Thu, 06 Mar 2008 15:31:30 +0800
Message-ID: <1204788690.30569.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id D676B103803
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 08:30:49 +0100 (CET)
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
Cc: tiwai@suse.de, cmatsuoka@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

Please refer to [0003800] on the alsa mantis.
There is no suitable model for Pi2515.
This model is to support it. 

Thanks!
Best regards!
Jiang,zhe

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080306/alsa-kernel/pci/hda/patch_realtek.c
2008-03-05 09:00:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-06 15:20:46.000000000
+0800
@@ -202,6 +202,7 @@ enum {
 	ALC888_6ST_DELL,
 	ALC883_MITAC,
 	ALC883_CLEVO_M720R,
+	ALC883_FUJITSU_PI2515,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6484,6 +6485,14 @@ static struct hda_input_mux alc883_lenov
 	},
 };
 
+static struct hda_input_mux alc883_fujitsu_pi2515_capture_source = {
+	.num_items = 2,
+	.items = {
+		{ "Mic", 0x0 },
+		{ "Int Mic", 0x1 },
+	},
+};
+
 #define alc883_mux_enum_info alc_mux_enum_info
 #define alc883_mux_enum_get alc_mux_enum_get
 /* ALC883 has the ALC882-type input selection */
@@ -6673,6 +6682,33 @@ static struct snd_kcontrol_new alc883_cl
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc883_2ch_fujitsu_pi2515_mixer[] = {
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Headphone Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Speaker Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
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
@@ -7220,6 +7256,20 @@ static struct hda_verb alc883_clevo_m720
 	{ } /* end */
 };
 
+static struct hda_verb alc883_2ch_fujitsu_pi2515_verbs[] = {
+	/* HP */
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Subwoofer */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+
+	/* enable unsolicited event */
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+
+	{ } /* end */
+};
+
 static struct hda_verb alc883_tagra_verbs[] = {
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
@@ -7423,6 +7473,25 @@ static void alc883_clevo_m720r_unsol_eve
 		alc883_clevo_m720r_automute(codec);
 }
 
+/* toggle speaker-output according to the hp-jack state */
+static void alc883_2ch_fujitsu_pi2515_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+	unsigned char bits;
+
+ 	present = snd_hda_codec_read(codec, 0x14, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+}
+
+static void alc883_2ch_fujitsu_pi2515_unsol_event(struct hda_codec
*codec, unsigned int res)
+{
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc883_2ch_fujitsu_pi2515_automute(codec);
+}
+
 static void alc883_haier_w66_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -7661,6 +7730,7 @@ static const char *alc883_models[ALC883_
 	[ALC888_6ST_DELL]	= "6stack-dell",
 	[ALC883_MITAC]		= "mitac",
 	[ALC883_CLEVO_M720R]	= "clevo-m720r",
+	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -7706,6 +7776,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1558, 0, "Clevo laptop", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
+	SND_PCI_QUIRK(0x1734, 0x1108, "Fujitsu AMILO Pi2515",
ALC883_FUJITSU_PI2515),
 	SND_PCI_QUIRK(0x17aa, 0x101e, "Lenovo 101e", ALC883_LENOVO_101E_2ch),
 	SND_PCI_QUIRK(0x17aa, 0x2085, "Lenovo NB0763", ALC883_LENOVO_NB0763),
 	SND_PCI_QUIRK(0x17aa, 0x3bfc, "Lenovo NB0763", ALC883_LENOVO_NB0763),
@@ -7950,6 +8021,18 @@ static struct alc_config_preset alc883_p
 		.unsol_event = alc883_mitac_unsol_event,
 		.init_hook = alc883_mitac_automute,
 	},
+	[ALC883_FUJITSU_PI2515] = {
+		.mixers = { alc883_2ch_fujitsu_pi2515_mixer },
+		.init_verbs = { alc883_init_verbs, alc883_2ch_fujitsu_pi2515_verbs},
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_fujitsu_pi2515_capture_source,
+		.unsol_event = alc883_2ch_fujitsu_pi2515_unsol_event,
+		.init_hook = alc883_2ch_fujitsu_pi2515_automute,
+	},
 };
