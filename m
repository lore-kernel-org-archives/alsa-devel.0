From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 07/11] ALSA: hda/ca0132 - Add ZxR DSP post-download commands
Date: Sat, 29 Sep 2018 23:03:22 -0400
Message-ID: <1538276607-30234-8-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds commands for setting up the ZxR after the DSP is
downloaded. The ZxR already shares most of the post-download commands
from the regular Sound Blaster Z.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6e48c3d..729766a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6854,19 +6854,29 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 	chipio_set_stream_channels(codec, 0x0C, 6);
 	chipio_set_stream_control(codec, 0x0C, 1);
 	/* No clue what these control */
-	chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
-	chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
-	chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
-	chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
-	chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
-	chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
-	chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
-	chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
-	chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
-	chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
-	chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
-	chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
-
+	if (spec->quirk == QUIRK_SBZ) {
+		chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
+		chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
+		chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
+		chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
+		chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
+		chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
+		chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
+		chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
+		chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
+		chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
+		chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
+		chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
+	} else if (spec->quirk == QUIRK_ZXR) {
+		chipio_write_no_mutex(codec, 0x190038, 0x000140c2);
+		chipio_write_no_mutex(codec, 0x19003c, 0x000141c3);
+		chipio_write_no_mutex(codec, 0x190040, 0x000150c4);
+		chipio_write_no_mutex(codec, 0x190044, 0x000151c5);
+		chipio_write_no_mutex(codec, 0x190050, 0x000142c8);
+		chipio_write_no_mutex(codec, 0x190054, 0x000143c9);
+		chipio_write_no_mutex(codec, 0x190058, 0x000152ca);
+		chipio_write_no_mutex(codec, 0x19005c, 0x000153cb);
+	}
 	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
 
 	codec_dbg(codec, "Startup Data exited, mutex released.\n");
@@ -8161,6 +8171,7 @@ static int ca0132_init(struct hda_codec *codec)
 		r3d_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
+	case QUIRK_ZXR:
 		sbz_setup_defaults(codec);
 		break;
 	case QUIRK_AE5:
-- 
2.7.4
