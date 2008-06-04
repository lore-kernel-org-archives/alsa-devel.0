From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]model for alc888 to support intel DG33
	motherboards
Date: Wed, 04 Jun 2008 14:44:40 +0800
Message-ID: <1212561880.16582.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XmonJrE/JPWsIm59AySc"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 0295124467
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 08:41:37 +0200 (CEST)
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
Cc: tiwai@suse.de, zhe.jiang@intel.com
List-Id: alsa-devel@alsa-project.org


--=-XmonJrE/JPWsIm59AySc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Please see the attachment.

These two motherboards's pin configuration are not covered by driver.
I wrote a new model to support them.

Thanks!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>

--=-XmonJrE/JPWsIm59AySc
Content-Disposition: attachment; filename=intel_dg33_alc888.patch
Content-Type: text/x-patch; name=intel_dg33_alc888.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-20080603/alsa-kernel/pci/hda/patch_realtek.c	2008-06-03 06:05:08.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-06-04 13:38:18.000000000 +0800
@@ -209,6 +209,7 @@ enum {
 	ALC883_MITAC,
 	ALC883_CLEVO_M720,
 	ALC883_FUJITSU_PI2515,
+	ALC883_3ST_6ch_INTEL,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -6604,6 +6605,16 @@ static struct hda_input_mux alc883_captu
 	},
 };
 
+static struct hda_input_mux alc883_3stack_6ch_intel = {
+	.num_items = 4,
+	.items = {
+		{ "Mic", 0x1 },
+		{ "Front Mic", 0x0 },
+		{ "Line", 0x2 },
+		{ "CD", 0x4 },
+	},
+};
+
 static struct hda_input_mux alc883_lenovo_101e_capture_source = {
 	.num_items = 2,
 	.items = {
@@ -6685,6 +6696,48 @@ static struct hda_channel_mode alc883_3S
 };
 
 /*
+ * 2ch mode
+ */
+static struct hda_verb alc883_3ST_ch2_intel_init[] = {
+	{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ } /* end */
+};
+
+/*
+ * 4ch mode
+ */
+static struct hda_verb alc883_3ST_ch4_intel_init[] = {
+	{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80 },
+	{ 0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x1a, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ } /* end */
+};
+
+/*
+ * 6ch mode
+ */
+static struct hda_verb alc883_3ST_ch6_intel_init[] = {
+	{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x19, AC_VERB_SET_CONNECT_SEL, 0x02 },
+	{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{ 0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE },
+	{ 0x1a, AC_VERB_SET_CONNECT_SEL, 0x01 },
+	{ } /* end */
+};
+
+static struct hda_channel_mode alc883_3ST_6ch_intel_modes[3] = {
+	{ 2, alc883_3ST_ch2_intel_init },
+	{ 4, alc883_3ST_ch4_intel_init },
+	{ 6, alc883_3ST_ch6_intel_init },
+};
+
+/*
  * 6ch mode
  */
 static struct hda_verb alc883_sixstack_ch6_init[] = {
@@ -6916,6 +6969,44 @@ static struct snd_kcontrol_new alc883_3S
 	{ } /* end */
 };
 
+static struct snd_kcontrol_new alc883_3ST_6ch_intel_mixer[] = {
+	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0d, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
+	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
+	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
+	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Headphone Playback Switch", 0x15, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("PC Speaker Playback Volume", 0x0b, 0x05, HDA_INPUT),
+	HDA_CODEC_MUTE("PC Speaker Playback Switch", 0x0b, 0x05, HDA_INPUT),
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
 static struct snd_kcontrol_new alc883_fivestack_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Front Playback Switch", 0x14, 0x0, HDA_OUTPUT),
@@ -7764,6 +7855,7 @@ static const char *alc883_models[ALC883_
 	[ALC883_MITAC]		= "mitac",
 	[ALC883_CLEVO_M720]	= "clevo-m720",
 	[ALC883_FUJITSU_PI2515] = "fujitsu-pi2515",
+	[ALC883_3ST_6ch_INTEL]	= "3stack-6ch-intel",
 	[ALC883_AUTO]		= "auto",
 };
 
@@ -7821,6 +7913,8 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x17c0, 0x4071, "MEDION MD2", ALC883_MEDION_MD2),
 	SND_PCI_QUIRK(0x17f2, 0x5000, "Albatron KI690-AM2", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1991, 0x5625, "Haier W66", ALC883_HAIER_W66),
+	SND_PCI_QUIRK(0x8086, 0x0001, "DG33BUC", ALC883_3ST_6ch_INTEL),
+	SND_PCI_QUIRK(0x8086, 0x0002, "DG33FBC", ALC883_3ST_6ch_INTEL),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC883_3ST_6ch),
 	{}
 };
@@ -7859,6 +7953,18 @@ static struct alc_config_preset alc883_p
 		.need_dac_fix = 1,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_3ST_6ch_INTEL] = {
+		.mixers = { alc883_3ST_6ch_intel_mixer, alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.dig_out_nid = ALC883_DIGOUT_NID,
+		.dig_in_nid = ALC883_DIGIN_NID,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_6ch_intel_modes),
+		.channel_mode = alc883_3ST_6ch_intel_modes,
+		.need_dac_fix = 1,
+		.input_mux = &alc883_3stack_6ch_intel,
+	},
 	[ALC883_6ST_DIG] = {
 		.mixers = { alc883_base_mixer, alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs },

--=-XmonJrE/JPWsIm59AySc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-XmonJrE/JPWsIm59AySc--
