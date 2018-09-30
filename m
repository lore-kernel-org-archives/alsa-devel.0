From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 04/11] ALSA: hda/ca0132 - Add ZxR pincfg
Date: Sat, 29 Sep 2018 23:03:19 -0400
Message-ID: <1538276607-30234-5-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds a pincfg for the ZxR, and defines which pins are used
for both.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 08dd85d..4d23eb9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1107,6 +1107,21 @@ static const struct hda_pintbl sbz_pincfgs[] = {
 	{}
 };
 
+/* Sound Blaster ZxR pin configs taken from Windows Driver */
+static const struct hda_pintbl zxr_pincfgs[] = {
+	{ 0x0b, 0x01047110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x414510f0 }, /* SPDIF Out 1 - Disabled*/
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x41c520f0 }, /* SPDIF In - Disabled*/
+	{ 0x0f, 0x0122711f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01017111 }, /* Port D -- Center/LFE */
+	{ 0x11, 0x01017114 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x01a271f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
 /* Recon3D pin configs taken from Windows Driver */
 static const struct hda_pintbl r3d_pincfgs[] = {
 	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
@@ -8202,6 +8217,10 @@ static void ca0132_config(struct hda_codec *codec)
 		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
 		break;
+	case QUIRK_ZXR:
+		codec_dbg(codec, "%s: QUIRK_ZXR applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, zxr_pincfgs);
+		break;
 	case QUIRK_R3D:
 		codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, r3d_pincfgs);
@@ -8261,6 +8280,37 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->multiout.dig_out_nid = spec->dig_out;
 		spec->dig_in = 0x09;
 		break;
+	case QUIRK_ZXR:
+		spec->num_outputs = 2;
+		spec->out_pins[0] = 0x0B; /* Line out */
+		spec->out_pins[1] = 0x0F; /* Rear headphone out */
+		spec->out_pins[2] = 0x10; /* Center/LFE */
+		spec->out_pins[3] = 0x11; /* Rear surround */
+		spec->shared_out_nid = 0x2;
+		spec->unsol_tag_hp = spec->out_pins[1];
+		spec->unsol_tag_front_hp = spec->out_pins[2];
+
+		spec->adcs[0] = 0x7; /* Rear Mic / Line-in */
+		spec->adcs[1] = 0x8; /* Not connected, no front mic */
+		spec->adcs[2] = 0xa; /* what u hear */
+
+		spec->num_inputs = 2;
+		spec->input_pins[0] = 0x12; /* Rear Mic / Line-in */
+		spec->input_pins[1] = 0x13; /* What U Hear */
+		spec->shared_mic_nid = 0x7;
+		spec->unsol_tag_amic1 = spec->input_pins[0];
+		break;
+	case QUIRK_ZXR_DBPRO:
+		spec->adcs[0] = 0x8; /* ZxR DBPro Aux In */
+
+		spec->num_inputs = 1;
+		spec->input_pins[0] = 0x11; /* RCA Line-in */
+
+		spec->dig_out = 0x05;
+		spec->multiout.dig_out_nid = spec->dig_out;
+
+		spec->dig_in = 0x09;
+		break;
 	case QUIRK_AE5:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
-- 
2.7.4
