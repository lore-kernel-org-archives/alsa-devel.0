From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 06/11] ALSA: hda/ca0132 - Add ZxR init commands
Date: Sat, 29 Sep 2018 23:03:21 -0400
Message-ID: <1538276607-30234-7-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds init commands for the main Sound Blaster ZxR card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index a543b23..6e48c3d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7953,7 +7953,10 @@ static void ca0132_mmio_init(struct hda_codec *codec)
 	else
 		writel(0x00000000, spec->mem_base + 0x40C);
 
-	writel(0x00880680, spec->mem_base + 0x01C);
+	if (spec->quirk == QUIRK_ZXR)
+		writel(0x00880640, spec->mem_base + 0x01C);
+	else
+		writel(0x00880680, spec->mem_base + 0x01C);
 
 	if (spec->quirk == QUIRK_AE5)
 		writel(0x00000080, spec->mem_base + 0xC0C);
@@ -8091,6 +8094,10 @@ static void ca0132_alt_init(struct hda_codec *codec)
 		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
 		ca0113_mmio_command_set(codec, 0x30, 0x32, 0x3f);
 		break;
+	case QUIRK_ZXR:
+		snd_hda_sequence_write(codec, spec->chip_init_verbs);
+		snd_hda_sequence_write(codec, spec->desktop_init_verbs);
+		break;
 	}
 }
 
@@ -8585,6 +8592,10 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound Blaster Z");
 		break;
+	case QUIRK_ZXR:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Sound Blaster ZxR");
+		break;
 	case QUIRK_ZXR_DBPRO:
 		codec->patch_ops = dbpro_patch_ops;
 		break;
@@ -8610,6 +8621,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
 	case QUIRK_AE5:
+	case QUIRK_ZXR:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4
