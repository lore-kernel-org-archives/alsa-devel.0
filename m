From: Aristeu Sergio Rozanski Filho <aris@ruivo.org>
Subject: [PATCH] snd-hda-intel: add quirk for Lenovo X200
	laptop dock
Date: Thu, 12 Feb 2009 17:50:37 -0500
Message-ID: <20090212225037.GA1846@jake.ruivo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lobo.ruivo.org (lobo.ruivo.org [66.92.68.119])
	by alsa0.perex.cz (Postfix) with ESMTP id D4B2C1037FF
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2009 23:50:49 +0100 (CET)
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
Cc: aris@redhat.com
List-Id: alsa-devel@alsa-project.org

Currently the HP connector on X200 dock doesn't detect when a HP is connected
nor allows sound to be played using it. This patch fixes the problem by adding
a quirk for this specific model. It's possible that others have the same NID
(0x19) to report when dock HP is connected, but I don't have access to any.
Please Cc me in the reply since I'm not subscribed to alsa-devel@.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

---
 sound/pci/hda/patch_conexant.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/sound/pci/hda/patch_conexant.c	2009-02-12 17:03:19.000000000 -0500
+++ b/sound/pci/hda/patch_conexant.c	2009-02-12 17:33:20.000000000 -0500
@@ -1806,6 +1806,40 @@ static struct hda_verb cxt5051_init_verb
 	{ } /* end */
 };
 
+static struct hda_verb cxt5051_lenovo_x200_init_verbs[] = {
+	/* Line in, Mic */
+	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
+	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
+	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
+	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
+	/* SPK  */
+	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* HP, Amp  */
+	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* Docking HP */
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x19, AC_VERB_SET_CONNECT_SEL, 0x00},
+	/* DAC1 */
+	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+	/* Record selector: Int mic */
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
+	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
+	/* SPDIF route: PCM */
+	{0x1c, AC_VERB_SET_CONNECT_SEL, 0x0},
+	/* EAPD */
+	{0x1a, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CONEXANT_HP_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CXT5051_PORTB_EVENT},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CXT5051_PORTC_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CONEXANT_HP_EVENT},
+	{ } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5051_init(struct hda_codec *codec)
 {
@@ -1823,18 +1857,21 @@ static int cxt5051_init(struct hda_codec
 enum {
 	CXT5051_LAPTOP,	 /* Laptops w/ EAPD support */
 	CXT5051_HP,	/* no docking */
+	CXT5051_LENOVO_X200,	/* Lenovo X200 laptop */
 	CXT5051_MODELS
 };
 
 static const char *cxt5051_models[CXT5051_MODELS] = {
 	[CXT5051_LAPTOP]	= "laptop",
 	[CXT5051_HP]		= "hp",
+	[CXT5051_LENOVO_X200]	= "Lenovo X200",
 };
 
 static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x14f1, 0x0101, "Conexant Reference board",
 		      CXT5051_LAPTOP),
 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
+	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT5051_LENOVO_X200),
 	{}
 };
 
@@ -1875,6 +1912,8 @@ static int patch_cxt5051(struct hda_code
 		codec->patch_ops.unsol_event = cxt5051_hp_unsol_event;
 		spec->mixers[0] = cxt5051_hp_mixers;
 		break;
+	case CXT5051_LENOVO_X200:
+		spec->init_verbs[0] = cxt5051_lenovo_x200_init_verbs;
 	default:
 	case CXT5051_LAPTOP:
 		codec->patch_ops.unsol_event = cxt5051_hp_unsol_event;
