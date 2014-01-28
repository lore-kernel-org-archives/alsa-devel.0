From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/11] ALSA: hda/conexant - Use generic parser
	for HP 530
Date: Tue, 28 Jan 2014 11:06:36 +0100
Message-ID: <1390903600-22772-8-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C82D2651E3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1204FAC89
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This laptop with CX20549 codec misses the internal mic at NID 0x12.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 53 ++++++++++--------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3fdb04f0bbaf..afb76fe75dbb 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -662,14 +662,6 @@ static const struct hda_input_mux cxt5045_capture_source_benq = {
 	}
 };
 
-static const struct hda_input_mux cxt5045_capture_source_hp530 = {
-	.num_items = 2,
-	.items = {
-		{ "Mic",          0x1 },
-		{ "Internal Mic", 0x2 },
-	}
-};
-
 /* turn on/off EAPD (+ mute HP) as a master switch */
 static int cxt5045_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
@@ -785,28 +777,6 @@ static const struct snd_kcontrol_new cxt5045_benq_mixers[] = {
 	{}
 };
 
-static const struct snd_kcontrol_new cxt5045_mixers_hp530[] = {
-	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x00, HDA_INPUT),
-	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x17, 0x2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x17, 0x1, HDA_INPUT),
-	HDA_BIND_VOL("Master Playback Volume", &cxt5045_hp_bind_master_vol),
-	{
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Master Playback Switch",
-		.info = cxt_eapd_info,
-		.get = cxt_eapd_get,
-		.put = cxt5045_hp_master_sw_put,
-		.private_value = 0x10,
-	},
-
-	{}
-};
-
 static const struct hda_verb cxt5045_init_verbs[] = {
 	/* Line in, Mic */
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_80 },
@@ -989,7 +959,6 @@ enum {
 	CXT5045_LAPTOP_MICSENSE,
 	CXT5045_LAPTOP_HPMICSENSE,
 	CXT5045_BENQ,
-	CXT5045_LAPTOP_HP530,
 #ifdef CONFIG_SND_DEBUG
 	CXT5045_TEST,
 #endif
@@ -1002,7 +971,6 @@ static const char * const cxt5045_models[CXT5045_MODELS] = {
 	[CXT5045_LAPTOP_MICSENSE]	= "laptop-micsense",
 	[CXT5045_LAPTOP_HPMICSENSE]	= "laptop-hpmicsense",
 	[CXT5045_BENQ]			= "benq",
-	[CXT5045_LAPTOP_HP530]		= "laptop-hp530",
 #ifdef CONFIG_SND_DEBUG
 	[CXT5045_TEST]		= "test",
 #endif
@@ -1010,7 +978,6 @@ static const char * const cxt5045_models[CXT5045_MODELS] = {
 };
 
 static const struct snd_pci_quirk cxt5045_cfg_tbl[] = {
-	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT5045_LAPTOP_HP530),
 	SND_PCI_QUIRK(0x152d, 0x0753, "Benq R55E", CXT5045_BENQ),
 	SND_PCI_QUIRK(0x1734, 0x10ad, "Fujitsu Si1520", CXT5045_LAPTOP_MICSENSE),
 	SND_PCI_QUIRK(0x1734, 0x10cb, "Fujitsu Si3515", CXT5045_LAPTOP_HPMICSENSE),
@@ -1101,14 +1068,6 @@ static int patch_cxt5045(struct hda_codec *codec)
 		spec->num_mixers = 2;
 		codec->patch_ops.init = cxt5045_init;
 		break;
-	case CXT5045_LAPTOP_HP530:
-		codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
-		spec->input_mux = &cxt5045_capture_source_hp530;
-		spec->num_init_verbs = 2;
-		spec->init_verbs[1] = cxt5045_hp_sense_init_verbs;
-		spec->mixers[0] = cxt5045_mixers_hp530;
-		codec->patch_ops.init = cxt5045_init;
-		break;
 #ifdef CONFIG_SND_DEBUG
 	case CXT5045_TEST:
 		spec->input_mux = &cxt5045_test_capture_source;
@@ -2873,6 +2832,7 @@ enum {
 	CXT_FIXUP_OLPC_XO,
 	CXT_FIXUP_CAP_MIX_AMP,
 	CXT_FIXUP_TOSHIBA_P105,
+	CXT_FIXUP_HP_530,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -3320,9 +3280,19 @@ static const struct hda_fixup cxt_fixups[] = {
 			{}
 		},
 	},
+	[CXT_FIXUP_HP_530] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x12, 0x90a60160 }, /* int mic */
+			{}
+		},
+		.chained = true,
+		.chain_id = CXT_FIXUP_CAP_MIX_AMP,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
+	SND_PCI_QUIRK(0x103c, 0x30d5, "HP 530", CXT_FIXUP_HP_530),
 	SND_PCI_QUIRK(0x1179, 0xff31, "Toshiba P105", CXT_FIXUP_TOSHIBA_P105),
 	/* HP, Packard Bell, Fujitsu-Siemens & Lenovo laptops have
 	 * really bad sound over 0dB on NID 0x17.
@@ -3337,6 +3307,7 @@ static const struct snd_pci_quirk cxt5045_fixups[] = {
 static const struct hda_model_fixup cxt5045_fixup_models[] = {
 	{ .id = CXT_FIXUP_CAP_MIX_AMP, .name = "cap-mix-amp" },
 	{ .id = CXT_FIXUP_TOSHIBA_P105, .name = "toshiba-p105" },
+	{ .id = CXT_FIXUP_HP_530, .name = "hp-530" },
 	{}
 };
 
-- 
1.8.5.2
