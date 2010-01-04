From: knprox@mi.rr.com
Subject: [PATCH - hda intel conextant 1/1] Fixed microphone
	mixer for HP Compaq Presario F700 Added conextant patch for
	Hewlett-Packard Company Device Subsystem id - 103c:30ea
Date: Sun,  3 Jan 2010 19:40:56 -0500
Message-ID: <1262565656-2737-1-git-send-email-knprox@mi.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by alsa0.perex.cz (Postfix) with ESMTP id 51BF42448F
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 01:40:59 +0100 (CET)
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
Cc: knprox@mi.rr.com, Ken Prox <kprox@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

From: Ken Prox <kprox@users.sourceforge.net>


Signed-off-by: Ken Prox <kprox@users.sourceforge.net>
---
 pci/hda/patch_conexant.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index 947785f..6142d75 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -1723,6 +1723,22 @@ static struct snd_kcontrol_new cxt5051_hp_dv6736_mixers[] = {
 	{}
 };
 
+static struct snd_kcontrol_new cxt5051_f700_mixers[] = {
+    HDA_CODEC_VOLUME("Mic Volume", 0x14, 0x01, HDA_INPUT),
+    HDA_CODEC_MUTE("Mic Switch", 0x14, 0x01, HDA_INPUT),
+    HDA_CODEC_VOLUME("Master Playback Volume", 0x10, 0x00, HDA_OUTPUT),
+    {
+        .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name = "Master Playback Switch",
+        .info = cxt_eapd_info,
+        .get = cxt_eapd_get,
+        .put = cxt5051_hp_master_sw_put,
+        .private_value = 0x1a,
+    },
+
+    {}
+};
+
 static struct hda_verb cxt5051_init_verbs[] = {
 	/* Line in, Mic */
 	{0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x03},
@@ -1813,6 +1829,32 @@ static struct hda_verb cxt5051_lenovo_x200_init_verbs[] = {
 	{ } /* end */
 };
 
+static struct hda_verb cxt5051_f700_init_verbs[] = {
+    /* Line in, Mic */
+    {0x17, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x03},
+    {0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+    {0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0},
+    {0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0},
+    /* SPK  */
+    {0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
+    {0x1a, AC_VERB_SET_CONNECT_SEL, 0x00},
+    /* HP, Amp  */
+    {0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+    {0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
+    /* DAC1 */
+    {0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
+    /* Record selector: Int mic */
+    {0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1) | 0x44},
+    {0x14, AC_VERB_SET_CONNECT_SEL, 0x1},
+    /* SPDIF route: PCM */
+    {0x1c, AC_VERB_SET_CONNECT_SEL, 0x0},
+    /* EAPD */
+    {0x1a, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
+    {0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CONEXANT_HP_EVENT},
+    {0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CXT5051_PORTB_EVENT},
+    { } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5051_init(struct hda_codec *codec)
 {
@@ -1832,6 +1874,7 @@ enum {
 	CXT5051_HP,	/* no docking */
 	CXT5051_HP_DV6736,	/* HP without mic switch */
 	CXT5051_LENOVO_X200,	/* Lenovo X200 laptop */
+	CXT5051_F700,       /* HP Compaq Presario F700 */
 	CXT5051_MODELS
 };
 
@@ -1840,6 +1883,7 @@ static const char *cxt5051_models[CXT5051_MODELS] = {
 	[CXT5051_HP]		= "hp",
 	[CXT5051_HP_DV6736]	= "hp-dv6736",
 	[CXT5051_LENOVO_X200]	= "lenovo-x200",
+	[CXT5051_F700]          = "hp 700"
 };
 
 static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
@@ -1849,6 +1893,7 @@ static struct snd_pci_quirk cxt5051_cfg_tbl[] = {
 		      CXT5051_LAPTOP),
 	SND_PCI_QUIRK(0x14f1, 0x5051, "HP Spartan 1.1", CXT5051_HP),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT5051_LENOVO_X200),
+	SND_PCI_QUIRK(0x103c, 0x30ea, "Compaq Presario F700", CXT5051_F700),
 	{}
 };
 
@@ -1899,8 +1944,14 @@ static int patch_cxt5051(struct hda_codec *codec)
 	case CXT5051_LENOVO_X200:
 		spec->init_verbs[0] = cxt5051_lenovo_x200_init_verbs;
 		break;
+	case CXT5051_F700:
+	        spec->init_verbs[0] = cxt5051_f700_init_verbs;
+                spec->mixers[0] = cxt5051_f700_mixers;
+                spec->no_auto_mic = 1;      
+                break;
 	}
 
+
 	return 0;
 }
 
-- 
1.6.2.5
