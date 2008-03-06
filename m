From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH] model for cx20549 to support laptop HP530
Date: Thu, 06 Mar 2008 16:30:35 +0800
Message-ID: <1204792235.30569.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id F12A61038AF
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 09:29:15 +0100 (CET)
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

Please refer to [0003821].
Currently the model laptop-hpsense use the 0x12 as ExtMic,
and use 0x14 as Internal IntMic.
But the hp530 only have one ExtMic, the Pin widget is 0x14.

In this patch, I changed the mixer item for them.
I still reserved the IntMic item, it will be helpful if 
other machine may use this model.

Best regards!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080306/alsa-kernel/pci/hda/patch_conexant.c
2008-03-01 09:00:07.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_conexant.c	2008-03-06 16:12:23.000000000
+0800
@@ -519,6 +519,14 @@ static struct hda_input_mux cxt5045_capt
 	}
 };
 
+static struct hda_input_mux cxt5045_capture_source_hp530 = {
+	.num_items = 2,
+	.items = {
+		{ "ExtMic", 0x1 },
+		{ "IntMic", 0x2 },
+	}
+};
+
 /* turn on/off EAPD (+ mute HP) as a master switch */
 static int cxt5045_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
@@ -647,6 +655,37 @@ static struct snd_kcontrol_new cxt5045_b
 	{}
 };
 
+static struct snd_kcontrol_new cxt5045_mixers_hp530[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.info = conexant_mux_enum_info,
+		.get = conexant_mux_enum_get,
+		.put = conexant_mux_enum_put
+	},
+	HDA_CODEC_VOLUME("Int Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
+	HDA_CODEC_VOLUME("Ext Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Ext Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
+	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Master Playback Switch",
+		.info = cxt_eapd_info,
+		.get = cxt_eapd_get,
+		.put = cxt5045_hp_master_sw_put,
+		.private_value = 0x10,
+	},
+
+	{}
+};
+
 static struct hda_verb cxt5045_init_verbs[] = {
 	/* Line in, Mic */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
@@ -841,6 +880,7 @@ enum {
 	CXT5045_LAPTOP_MICSENSE,
 	CXT5045_LAPTOP_HPMICSENSE,
 	CXT5045_BENQ,
+	CXT5045_LAPTOP_HP530,
 #ifdef CONFIG_SND_DEBUG
 	CXT5045_TEST,
 #endif
@@ -852,6 +892,7 @@ static const char *cxt5045_models[CXT504
 	[CXT5045_LAPTOP_MICSENSE]	= "laptop-micsense",
 	[CXT5045_LAPTOP_HPMICSENSE]	= "laptop-hpmicsense",
 	[CXT5045_BENQ]			= "benq",
+	[CXT5045_LAPTOP_HP530]		= "laptop-hp530",
 #ifdef CONFIG_SND_DEBUG
 	[CXT5045_TEST]		= "test",
 #endif
@@ -865,7 +906,7 @@ static struct snd_pci_quirk cxt5045_cfg_
 	SND_PCI_QUIRK(0x103c, 0x30bb, "HP DV8000", CXT5045_LAPTOP_HPSENSE),
 	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP_HPSENSE),
 	SND_PCI_QUIRK(0x103c, 0x30cf, "HP DV9533EG", CXT5045_LAPTOP_HPSENSE),
-	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP_HPSENSE),
+	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP_HP530),
 	SND_PCI_QUIRK(0x103c, 0x30d9, "HP Spartan", CXT5045_LAPTOP_HPSENSE),
 	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520",
CXT5045_LAPTOP_MICSENSE),
@@ -949,6 +990,14 @@ static int patch_cxt5045(struct hda_code
 		spec->num_mixers = 2;
 		codec->patch_ops.init = cxt5045_init;
 		break;
+	case CXT5045_LAPTOP_HP530:
+		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
+		spec->input_mux = &cxt5045_capture_source_hp530;
+		spec->num_init_verbs = 2;
+		spec->init_verbs[1] = cxt5045_hp_sense_init_verbs;
+		spec->mixers[0] = cxt5045_mixers_hp530;
+		codec->patch_ops.init = cxt5045_init;
+		break;
 #ifdef CONFIG_SND_DEBUG
 	case CXT5045_TEST:
 		spec->input_mux = &cxt5045_test_capture_source;
