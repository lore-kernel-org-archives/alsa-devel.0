From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]New model for conexant 5045 codec to support
	benq r55e
Date: Thu, 17 Jan 2008 10:48:11 +0800
Message-ID: <1200538091.30641.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B15A4245A8
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 03:47:08 +0100 (CET)
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

Please refer to bug 0003636.
The benq r55e laptop have 3 jacks on the front panel.
One for HP, one for Line In and one for Mic In.

This patch implemented a new model to support it.

Best regards!
Jiang,zhe

Signed-off-by: Jiang Zhe <zhe.jiang@intel.com>
--- alsa-driver-hg20080115/alsa-kernel/pci/hda/patch_conexant.c
2008-01-09 09:00:15.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_conexant.c	2008-01-17 10:33:44.000000000
+0800
@@ -457,6 +457,15 @@ static struct hda_input_mux cxt5045_capt
 	}
 };
 
+static struct hda_input_mux cxt5045_capture_source_benq = {
+	.num_items = 3,
+	.items = {
+		{ "IntMic", 0x1 },
+		{ "ExtMic", 0x2 },
+		{ "LineIn", 0x3 },
+	}
+};
+
 /* turn on/off EAPD (+ mute HP) as a master switch */
 static int cxt5045_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
@@ -576,6 +585,15 @@ static struct snd_kcontrol_new cxt5045_m
 	{}
 };
 
+static struct snd_kcontrol_new cxt5045_benq_mixers[] = {
+	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1a, 0x03, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Capture Switch", 0x1a, 0x03, HDA_INPUT),
+	HDA_CODEC_VOLUME("Line In Playback Volume", 0x17, 0x3, HDA_INPUT),
+	HDA_CODEC_MUTE("Line In Playback Switch", 0x17, 0x3, HDA_INPUT),
+	
+	{}
+};
+
 static struct hda_verb cxt5045_init_verbs[] = {
 	/* Line in, Mic */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN },
@@ -601,6 +619,30 @@ static struct hda_verb cxt5045_init_verb
 	{ } /* end */
 };
 
+static struct hda_verb cxt5045_benq_init_verbs[] = {
+	/* Int Mic, Mic */
+	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
+	/* Line In,HP, Amp  */
+	{0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x10, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x11, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x11, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
+	/* Record selector: Int mic */
+	{0x1a, AC_VERB_SET_CONNECT_SEL,0x1},
+	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE,
+	 AC_AMP_SET_INPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x17},
+	/* SPDIF route: PCM */
+	{ 0x13, AC_VERB_SET_CONNECT_SEL, 0x0 },
+	/* EAPD */
+	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
+	{ } /* end */
+};
 
 static struct hda_verb cxt5045_hp_sense_init_verbs[] = {
 	/* pin sensing on HP jack */
@@ -741,6 +783,7 @@ static int cxt5045_init(struct hda_codec
 enum {
 	CXT5045_LAPTOP,	 /* Laptops w/ EAPD support */
 	CXT5045_FUJITSU, /* Laptops w/ EAPD support */ 
+	CXT5045_BENQ,
 #ifdef CONFIG_SND_DEBUG
 	CXT5045_TEST,
 #endif
@@ -750,6 +793,7 @@ enum {
 static const char *cxt5045_models[CXT5045_MODELS] = {
 	[CXT5045_LAPTOP]	= "laptop",
 	[CXT5045_FUJITSU]	= "fujitsu",
+	[CXT5045_BENQ]		= "benq",
 #ifdef CONFIG_SND_DEBUG
 	[CXT5045_TEST]		= "test",
 #endif
@@ -763,6 +807,7 @@ static struct snd_pci_quirk cxt5045_cfg_
 	SND_PCI_QUIRK(0x103c, 0x30cd, "HP DV Series", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x103c, 0x30d9, "HP Spartan", CXT5045_LAPTOP),
+	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_FUJITSU),
 	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP),
 	SND_PCI_QUIRK(0x1734, 0x110e, "Fujitsu V5505", CXT5045_LAPTOP),
@@ -819,6 +864,16 @@ static int patch_cxt5045(struct hda_code
 		spec->mixers[0] = cxt5045_mixers;
 		codec->patch_ops.init = cxt5045_init;
 		break;
+	case CXT5045_BENQ:
+		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
+		spec->input_mux = &cxt5045_capture_source_benq;
+		spec->num_init_verbs = 1;
+		spec->init_verbs[0] =cxt5045_benq_init_verbs;
+		spec->mixers[0] = cxt5045_mixers;
+		spec->mixers[1] = cxt5045_benq_mixers;
+		spec->num_mixers = 2;
+		codec->patch_ops.init = cxt5045_init;
+		break;
 #ifdef CONFIG_SND_DEBUG
 	case CXT5045_TEST:
 		spec->input_mux = &cxt5045_test_capture_source;
