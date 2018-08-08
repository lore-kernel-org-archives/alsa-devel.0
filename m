From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 05/11] ALSA: hda/ca0132 - Add Recon3D pincfg
Date: Wed,  8 Aug 2018 13:34:16 -0400
Message-ID: <1533749663-8200-6-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds pin configs from the Recon3D, taken from the Window's
driver.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bec31b2..2ee9549 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1026,6 +1026,21 @@ static const struct hda_pintbl sbz_pincfgs[] = {
 	{}
 };
 
+/* Recon3D pin configs taken from Windows Driver */
+static const struct hda_pintbl r3d_pincfgs[] = {
+	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
+	{ 0x0c, 0x014510f0 }, /* SPDIF Out 1 */
+	{ 0x0d, 0x014510f0 }, /* Digital Out */
+	{ 0x0e, 0x01c520f0 }, /* SPDIF In */
+	{ 0x0f, 0x0221401f }, /* Port A -- BackPanel HP */
+	{ 0x10, 0x01016011 }, /* Port D -- Center/LFE or FP Hp */
+	{ 0x11, 0x01011014 }, /* Port B -- LineMicIn2 / Rear L/R */
+	{ 0x12, 0x02a090f0 }, /* Port C -- LineIn1 */
+	{ 0x13, 0x908700f0 }, /* What U Hear In*/
+	{ 0x18, 0x50d000f0 }, /* N/A */
+	{}
+};
+
 /* Recon3D integrated pin configs taken from Windows Driver */
 static const struct hda_pintbl r3di_pincfgs[] = {
 	{ 0x0b, 0x01014110 }, /* Port G -- Lineout FRONT L/R */
@@ -7397,8 +7412,15 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->unsol_tag_amic1 = 0x11;
 		break;
 	case QUIRK_SBZ:
-		codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
-		snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+	case QUIRK_R3D:
+		if (spec->quirk == QUIRK_SBZ) {
+			codec_dbg(codec, "%s: QUIRK_SBZ applied.\n", __func__);
+			snd_hda_apply_pincfgs(codec, sbz_pincfgs);
+		}
+		if (spec->quirk == QUIRK_R3D) {
+			codec_dbg(codec, "%s: QUIRK_R3D applied.\n", __func__);
+			snd_hda_apply_pincfgs(codec, r3d_pincfgs);
+		}
 
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
-- 
2.7.4
