From: Huacai Chen <chenhuacai@gmail.com>
Subject: [PATCH V2 13/16] ALSA: HDA: Make hda sound card usable
	for Loongson.
Date: Tue, 19 Jun 2012 14:50:21 +0800
Message-ID: <1340088624-25550-14-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id E153324526
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 08:58:39 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so10903988pbb.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2012 23:58:38 -0700 (PDT)
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>, Hongliang Tao <taohl@lemote.com>, Huacai Chen <chenhc@lemote.com>
List-Id: alsa-devel@alsa-project.org

Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
this patch make it usable:
1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
   doesn't support DMA address above 4GB).
2, Modify patch_conexant.c to add Lemote specific code.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
Cc: alsa-devel@alsa-project.org
---
 include/linux/pci_ids.h        |    2 +
 sound/pci/hda/hda_intel.c      |    5 ++++
 sound/pci/hda/patch_conexant.c |   52 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab741b0..d8b0a52 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2906,3 +2906,5 @@
 #define PCI_DEVICE_ID_XEN_PLATFORM	0x0001
 
 #define PCI_VENDOR_ID_OCZ		0x1b85
+
+#define PCI_VENDOR_ID_LEMOTE		0x1c06
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2b6392b..2b73ed4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3013,6 +3013,11 @@ static int DELAYED_INIT_MARK azx_first_init(struct azx *chip)
 		gcap &= ~ICH6_GCAP_64OK;
 	}
 
+#ifdef CONFIG_CPU_LOONGSON3
+	/* Workaround: Loongson 3 doesn't support 64-bit DMA */
+	gcap &= ~ICH6_GCAP_64OK;
+#endif
+
 	/* disable buffer size rounding to 128-byte multiples if supported */
 	if (align_buffer_size >= 0)
 		chip->align_buffer_size = !!align_buffer_size;
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3acb582..1c8dfb9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -142,6 +142,7 @@ struct conexant_spec {
 	unsigned int thinkpad:1;
 	unsigned int hp_laptop:1;
 	unsigned int asus:1;
+	unsigned int lemote:1;
 	unsigned int pin_eapd_ctrls:1;
 	unsigned int fixup_stereo_dmic:1;
 
@@ -2278,7 +2279,7 @@ static void cxt5066_automic(struct hda_codec *codec)
 		cxt5066_thinkpad_automic(codec);
 	else if (spec->hp_laptop)
 		cxt5066_hp_laptop_automic(codec);
-	else if (spec->asus)
+	else if (spec->asus || spec->lemote)
 		cxt5066_asus_automic(codec);
 }
 
@@ -2911,6 +2912,32 @@ static const struct hda_verb cxt5066_init_verbs_hp_laptop[] = {
 	{ } /* end */
 };
 
+static struct hda_verb cxt5066_init_verbs_lemote[] = {
+	{0x14, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1: Connection index: 0 */
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
+
+	/* DAC2: unused */
+	{0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
+
+	/* ADC2, ADC3: unused */
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
+	{0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+
+	/* Disable digital microphone port */
+	{0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+
+	/* Disable SPDIF */
+	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
+	{ } /* end */
+};
+
 /* initialize jack-sensing, too */
 static int cxt5066_init(struct hda_codec *codec)
 {
@@ -2948,6 +2975,8 @@ enum {
 	CXT5066_THINKPAD,	/* Lenovo ThinkPad T410s, others? */
 	CXT5066_ASUS,		/* Asus K52JU, Lenovo G560 - Int mic at 0x1a and Ext mic at 0x1b */
 	CXT5066_HP_LAPTOP,      /* HP Laptop */
+	CXT5066_LEMOTE_A1004,   /* Lemote Laptop A1004 */
+	CXT5066_LEMOTE_A1205,   /* Lemote All-In-One A1205 */
 	CXT5066_AUTO,		/* BIOS auto-parser */
 	CXT5066_MODELS
 };
@@ -2961,6 +2990,8 @@ static const char * const cxt5066_models[CXT5066_MODELS] = {
 	[CXT5066_THINKPAD]	= "thinkpad",
 	[CXT5066_ASUS]		= "asus",
 	[CXT5066_HP_LAPTOP]	= "hp-laptop",
+	[CXT5066_LEMOTE_A1004]  = "lemote-laptop-a1004",
+	[CXT5066_LEMOTE_A1205]  = "lemote-aio-a1205",
 	[CXT5066_AUTO]		= "auto",
 };
 
@@ -2993,6 +3024,8 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo U350", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
 	SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G565", CXT5066_AUTO),
+	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT5066_LEMOTE_A1004),
+	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT5066_LEMOTE_A1205),
 	SND_PCI_QUIRK(0x1b0a, 0x2092, "CyberpowerPC Gamer Xplorer N57001", CXT5066_AUTO),
 	{}
 };
@@ -3073,7 +3106,22 @@ static int patch_cxt5066(struct hda_codec *codec)
 		spec->port_d_mode = 0;
 		spec->mic_boost = 3; /* default 30dB gain */
 		break;
-
+	case CXT5066_LEMOTE_A1004:
+	case CXT5066_LEMOTE_A1205:
+		codec->patch_ops.init = cxt5066_init;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
+		spec->init_verbs[spec->num_init_verbs] =
+			cxt5066_init_verbs_lemote;
+		spec->num_init_verbs++;
+		spec->lemote = 1;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
+		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
+		/* no S/PDIF out */
+		/* input source automatically selected */
+		spec->input_mux = NULL;
+		spec->port_d_mode = 0;
+		spec->mic_boost = 3; /* default 30dB gain */
+		break;
 	case CXT5066_OLPC_XO_1_5:
 		codec->patch_ops.init = cxt5066_olpc_init;
 		codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
-- 
1.7.7.3
