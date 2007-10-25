From: Tobin Davis <tdavis@dsl-only.net>
Subject: HDA: Add support for Samsung Q1 Ultra Vista edition.
Date: Thu, 25 Oct 2007 14:54:45 -0700
Message-ID: <1193349285.32561.154.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1PjWY9ZL7XpEGs9T2jR2"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AE50243E0
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Oct 2007 23:54:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--=-1PjWY9ZL7XpEGs9T2jR2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds full record and playback support for the Samsung Q1
Ultra - Vista model (different codec than the earlier Q1 Ultra models).


Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-1PjWY9ZL7XpEGs9T2jR2
Content-Disposition: attachment; filename=SamsungQ1Vista.patch
Content-Type: text/x-patch; name=SamsungQ1Vista.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 09088524dd7f pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu Oct 25 11:46:24 2007 +0200
+++ b/pci/hda/patch_realtek.c	Thu Oct 25 13:31:53 2007 -0700
@@ -95,6 +95,7 @@ enum {
 	ALC262_BENQ_ED8,
 	ALC262_SONY_ASSAMD,
 	ALC262_BENQ_T31,
+	ALC262_ULTRA,
 	ALC262_AUTO,
 	ALC262_MODEL_LAST /* last tag */
 };
@@ -8082,6 +8083,72 @@ static struct hda_verb alc262_benq_t31_E
 	{}
 };
 
+/* Samsung Q1 Ultra Vista model setup */
+static struct snd_kcontrol_new alc262_ultra_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0, HDA_INPUT),
+	{ } /* end */
+};
+
+static struct hda_verb alc262_ultra_verbs[] = {
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
+	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	/* Mic is on Node 0x19 */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},
+	{0x22, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x22, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8))},
+	{0x23, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x23, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8))},
+	{0x24, AC_VERB_SET_CONNECT_SEL, 0x01},
+	{0x24, AC_VERB_SET_AMP_GAIN_MUTE, (0x7000 | (0x01 << 8))},
+	{}
+};
+
+static struct hda_input_mux alc262_ultra_capture_source = {
+	.num_items = 1,
+	.items = {
+		{ "Mic", 0x1 },
+	},
+};
+
+/* mute/unmute internal speaker according to the hp jack and mute state */
+static void alc262_ultra_automute(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int mute;
+	unsigned int present;
+
+	/* need to execute and sync at first */
+	snd_hda_codec_read(codec, 0x15, 0, AC_VERB_SET_PIN_SENSE, 0);
+	present = snd_hda_codec_read(codec, 0x15, 0,
+				     AC_VERB_GET_PIN_SENSE, 0);
+	spec->jack_present = (present & 0x80000000) != 0;
+	if (spec->jack_present) {
+		/* mute internal speaker */
+		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, HDA_AMP_MUTE);
+	} else {
+		/* unmute internal speaker if necessary */
+		mute = snd_hda_codec_amp_read(codec, 0x15, 0, HDA_OUTPUT, 0);
+		snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
+					 HDA_AMP_MUTE, mute);
+	}
+}
+
+/* unsolicited event for HP jack sensing */
+static void alc262_ultra_unsol_event(struct hda_codec *codec,
+				       unsigned int res)
+{
+	if ((res >> 26) != ALC880_HP_EVENT)
+		return;
+	alc262_ultra_automute(codec);
+}
+
 /* add playback controls from the parsed DAC table */
 static int alc262_auto_create_multi_out_ctls(struct alc_spec *spec,
 					     const struct auto_pin_cfg *cfg)
@@ -8487,6 +8554,7 @@ static const char *alc262_models[ALC262_
 	[ALC262_BENQ_ED8]	= "benq",
 	[ALC262_BENQ_T31]	= "benq-t31",
 	[ALC262_SONY_ASSAMD]	= "sony-assamd",
+	[ALC262_ULTRA]		= "ultra",
 	[ALC262_AUTO]		= "auto",
 };
 
@@ -8517,6 +8585,7 @@ static struct snd_pci_quirk alc262_cfg_t
 	SND_PCI_QUIRK(0x104d, 0x9015, "Sony 0x9015", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x900e, "Sony ASSAMD", ALC262_SONY_ASSAMD),
 	SND_PCI_QUIRK(0x104d, 0x1f00, "Sony ASSAMD", ALC262_SONY_ASSAMD),
+	SND_PCI_QUIRK(0x144d, 0xc032, "Samsung Q1 Ultra", ALC262_ULTRA),
 	{}
 };
 
@@ -8635,6 +8704,19 @@ static struct alc_config_preset alc262_p
 		.unsol_event = alc262_hippo_unsol_event,
 		.init_hook = alc262_hippo_automute,
 	},	
+	[ALC262_ULTRA] = {
+		.mixers = { alc262_ultra_mixer },
+		.init_verbs = { alc262_init_verbs, alc262_ultra_verbs },
+		.num_dacs = ARRAY_SIZE(alc262_dac_nids),
+		.dac_nids = alc262_dac_nids,
+		.hp_nid = 0x03,
+		.dig_out_nid = ALC262_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc262_modes),
+		.channel_mode = alc262_modes,
+		.input_mux = &alc262_ultra_capture_source,
+		.unsol_event = alc262_ultra_unsol_event,
+		.init_hook = alc262_ultra_automute,
+	},
 };
 
 static int patch_alc262(struct hda_codec *codec)

--=-1PjWY9ZL7XpEGs9T2jR2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-1PjWY9ZL7XpEGs9T2jR2--
