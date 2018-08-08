From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 02/11] ALSA: hda/ca0132 - Clean up ca0132_init function.
Date: Wed,  8 Aug 2018 13:34:13 -0400
Message-ID: <1533749663-8200-3-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch cleans up ca0132_init by removing unnecessary commands and
ordering things better.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9a92a64..b3c2cae 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7250,14 +7250,12 @@ static int ca0132_init(struct hda_codec *codec)
 
 	ca0132_refresh_widget_caps(codec);
 
-	if (spec->quirk == QUIRK_SBZ)
-		ca0132_mmio_gpio_set(codec, 7, true);
-
 	switch (spec->quirk) {
 	case QUIRK_R3DI:
 		r3di_setup_defaults(codec);
 		break;
 	case QUIRK_SBZ:
+		sbz_setup_defaults(codec);
 		break;
 	default:
 		ca0132_setup_defaults(codec);
@@ -7288,20 +7286,12 @@ static int ca0132_init(struct hda_codec *codec)
 		ca0132_gpio_setup(codec);
 
 	snd_hda_sequence_write(codec, spec->spec_init_verbs);
-	switch (spec->quirk) {
-	case QUIRK_SBZ:
-		sbz_setup_defaults(codec);
-		ca0132_alt_select_out(codec);
-		ca0132_alt_select_in(codec);
-		break;
-	case QUIRK_R3DI:
+	if (spec->use_alt_functions) {
 		ca0132_alt_select_out(codec);
 		ca0132_alt_select_in(codec);
-		break;
-	default:
+	} else {
 		ca0132_select_out(codec);
 		ca0132_select_mic(codec);
-		break;
 	}
 
 	snd_hda_jack_report_sync(codec);
-- 
2.7.4
