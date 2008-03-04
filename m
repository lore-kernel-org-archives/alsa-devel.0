From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH] model for alc883 to support M720R
Date: Tue, 04 Mar 2008 17:16:25 +0800
Message-ID: <1204622185.13743.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id EDADF243BB
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 10:22:32 +0100 (CET)
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

Hi,

Please refer to [0003781] on the alsa mantis.
There is no suitable model for M720R.
This patch is to support HP jack-sensing and mixer. 

The reporter complained that there was a constant noise when
he recorded from Mic, It existed even after he muted the input.
I checked the codec info carefully, the input widget was muted
indeed.

It's strange, Is there anything special for this codec?

Thanks!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080304/alsa-kernel/pci/hda/patch_realtek.c
2008-03-01 09:00:07.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-04 16:49:09.000000000
+0800
@@ -201,6 +201,7 @@ enum {
 	ALC888_3ST_HP,
 	ALC888_6ST_DELL,
 	ALC883_MITAC,
+	ALC883_CLEVO_M720R,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6645,6 +6646,33 @@ static struct snd_kcontrol_new alc883_mi
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc883_clevo_m720r_mixer[] = {
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
@@ -7178,6 +7206,20 @@ static struct hda_verb alc883_mitac_verb
 	{ } /* end */
 };
 
+static struct hda_verb alc883_clevo_m720r_verbs[] = {
+	/* HP */
+	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	/* Int speaker */
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+
+	/* enable unsolicited event */
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+
+	{ } /* end */
+};
+
 static struct hda_verb alc883_tagra_verbs[] = {
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
@@ -7361,6 +7403,25 @@ static void alc883_tagra_unsol_event(str
 		alc883_tagra_automute(codec);
 }
 
+/* toggle speaker-output according to the hp-jack state */
+static void alc883_clevo_m720r_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+	unsigned char bits;
+
+ 	present = snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	bits = present ? HDA_AMP_MUTE : 0;
+	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+				 HDA_AMP_MUTE, bits);
+}
+
+static void alc883_clevo_m720r_unsol_event(struct hda_codec *codec,
unsigned int res)
+{
+	if ((res >> 26) == ALC880_HP_EVENT)
+		alc883_clevo_m720r_automute(codec);
+}
+
 static void alc883_haier_w66_automute(struct hda_codec *codec)
 {
 	unsigned int present;
@@ -7598,6 +7659,7 @@ static const char *alc883_models[ALC883_
 	[ALC888_3ST_HP]		= "3stack-hp",
 	[ALC888_6ST_DELL]	= "6stack-dell",
 	[ALC883_MITAC]		= "mitac",
+	[ALC883_CLEVO_M720R]	= "clevo-m720r",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -7638,6 +7700,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x147b, 0x1083, "Abit IP35-PRO", ALC883_6ST_DIG),
+	SND_PCI_QUIRK(0x1558, 0x0721, "Clevo laptop M720R",
ALC883_CLEVO_M720R),
 	SND_PCI_QUIRK(0x1558, 0, "Clevo laptop", ALC883_LAPTOP_EAPD),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
@@ -7780,6 +7843,18 @@ static struct alc_config_preset alc883_p
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_CLEVO_M720R] = {
+		.mixers = { alc883_clevo_m720r_mixer },
+		.init_verbs = { alc883_init_verbs, alc883_clevo_m720r_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+		.unsol_event = alc883_clevo_m720r_unsol_event,
+		.init_hook = alc883_clevo_m720r_automute,
+	},
 	[ALC883_LENOVO_101E_2ch] = {
 		.mixers = { alc883_lenovo_101e_2ch_mixer},
 		.init_verbs = { alc883_init_verbs, alc883_lenovo_101e_verbs},
