From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 2/2] ALSA: hda/ca0132 - fix AE-5 pincfg
Date: Fri, 16 Nov 2018 14:24:56 -0500
Message-ID: <20181116192517.5128-2-conmanx360@gmail.com>
References: <20181116192517.5128-1-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116192517.5128-1-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes the pincfg assignment for the AE-5, which was
previously using the Recon3D pincfg's by mistake.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4c21bd24bcbd..eee432287c15 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8527,7 +8527,7 @@ static void ca0132_config(struct hda_codec *codec)
 		break;
 	case QUIRK_AE5:
 		codec_dbg(codec, "%s: QUIRK_AE5 applied.\n", __func__);
-		snd_hda_apply_pincfgs(codec, r3di_pincfgs);
+		snd_hda_apply_pincfgs(codec, ae5_pincfgs);
 		break;
 	default:
 		break;
-- 
2.18.1
