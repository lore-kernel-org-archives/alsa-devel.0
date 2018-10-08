From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 2/4] ALSA: hda/ca0132 - Clean up patch_ca0132()
Date: Mon,  8 Oct 2018 15:39:58 -0400
Message-ID: <1539027601-20910-3-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch cleans up the patch_ca0132() function with suggestions from
Takashi Sakamoto.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 12a3581..07d50d6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8697,10 +8697,6 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->spec = spec;
 	spec->codec = codec;
 
-	codec->patch_ops = ca0132_patch_ops;
-	codec->pcm_format_first = 1;
-	codec->no_sticky_stream = 1;
-
 	/* Detect codec quirk */
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
 	if (quirk)
@@ -8711,6 +8707,15 @@ static int patch_ca0132(struct hda_codec *codec)
 	if (spec->quirk == QUIRK_SBZ)
 		sbz_detect_quirk(codec);
 
+	if (spec->quirk == QUIRK_ZXR_DBPRO)
+		codec->patch_ops = dbpro_patch_ops;
+	else
+		codec->patch_ops = ca0132_patch_ops;
+
+	codec->pcm_format_first = 1;
+	codec->no_sticky_stream = 1;
+
+
 	spec->dsp_state = DSP_DOWNLOAD_INIT;
 	spec->num_mixers = 1;
 
@@ -8725,7 +8730,6 @@ static int patch_ca0132(struct hda_codec *codec)
 		snd_hda_codec_set_name(codec, "Sound Blaster ZxR");
 		break;
 	case QUIRK_ZXR_DBPRO:
-		codec->patch_ops = dbpro_patch_ops;
 		break;
 	case QUIRK_R3D:
 		spec->mixers[0] = desktop_mixer;
-- 
2.7.4
