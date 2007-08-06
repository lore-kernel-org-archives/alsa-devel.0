From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA:  Add support for Acer Aspire laptops.
Date: Mon, 06 Aug 2007 13:29:04 -0700
Message-ID: <1186432144.16153.83.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-e+T5q3SVX+JF7HpDkyiX"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6693A103845
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 22:29:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-e+T5q3SVX+JF7HpDkyiX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds support for some Acer Aspire systems.


Signed off by Tobin Davis <tdavis@dsl-only.net>

I was actually sent this patch by someone on IRC.  They approved for it
to be submitted, and I don't see anything in the code to cause it to be
kept out.

--=-e+T5q3SVX+JF7HpDkyiX
Content-Disposition: attachment; filename=acer-aspire.patch
Content-Type: text/x-patch; name=acer-aspire.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN alsa-driver-1.0.14.orig/alsa-kernel/pci/hda/patch_realtek.c alsa-driver-1.0.14/alsa-kernel/pci/hda/patch_realtek.c
--- alsa-driver-1.0.14.orig/alsa-kernel/pci/hda/patch_realtek.c	2007-06-04 09:28:54.000000000 +0200
+++ alsa-driver-1.0.14/alsa-kernel/pci/hda/patch_realtek.c	2007-07-25 17:41:40.000000000 +0200
@@ -157,6 +157,7 @@
 	ALC883_TARGA_DIG,
 	ALC883_TARGA_2ch_DIG,
 	ALC883_ACER,
+	ALC883_ACER_ASPIRE,
 	ALC883_MEDION,
 	ALC883_MEDION_MD2,	
 	ALC883_LAPTOP_EAPD,
@@ -5995,6 +5996,33 @@
 	{ } /* end */
 };	
 
+static struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
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
 static struct snd_kcontrol_new alc883_chmode_mixer[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -6176,6 +6204,18 @@
 	{ } /* end */
 };
 
+static struct hda_verb alc883_acer_aspire_verbs[] = {
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0c, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
+	{0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
+
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT | AC_USRSP_EN},
+	{ } /* end */
+};
+
 /* toggle speaker-output according to the hp-jack state */
 static void alc883_medion_md2_automute(struct hda_codec *codec)
 {
@@ -6362,6 +6402,7 @@
 	[ALC883_TARGA_DIG]	= "targa-dig",
 	[ALC883_TARGA_2ch_DIG]	= "targa-2ch-dig",
 	[ALC883_ACER]		= "acer",
+	[ALC883_ACER_ASPIRE]	= "acer-aspire",
 	[ALC883_MEDION]		= "medion",
 	[ALC883_MEDION_MD2]	= "medion-md2",
 	[ALC883_LAPTOP_EAPD]	= "laptop-eapd",
@@ -6392,6 +6433,7 @@
 	SND_PCI_QUIRK(0x1462, 0x4319, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x4324, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0xa422, "MSI", ALC883_TARGA_2ch_DIG),
+	SND_PCI_QUIRK(0x1025, 0x0110, "Acer Aspire", ALC883_ACER_ASPIRE),
 	SND_PCI_QUIRK(0x1025, 0, "Acer laptop", ALC883_ACER),
 	SND_PCI_QUIRK(0x15d9, 0x8780, "Supermicro PDSBA", ALC883_3ST_6ch),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_MEDION),
@@ -6503,6 +6545,20 @@
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_ACER_ASPIRE] = {
+		.mixers = { alc883_acer_aspire_mixer},
+		.init_verbs = { alc883_init_verbs, alc883_acer_aspire_verbs},
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.input_mux = &alc883_capture_source,
+		.unsol_event = alc883_medion_md2_unsol_event,
+		.init_hook = alc883_medion_md2_automute,
+	},	
 	[ALC883_MEDION] = {
 		.mixers = { alc883_fivestack_mixer,
 			    alc883_chmode_mixer },

--=-e+T5q3SVX+JF7HpDkyiX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-e+T5q3SVX+JF7HpDkyiX--
