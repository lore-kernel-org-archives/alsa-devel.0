From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 04/15] ALSA: hda/ca0132 - Set AE-5 bools and select mixer
Date: Tue, 18 Sep 2018 14:33:32 -0400
Message-ID: <1537295625-8082-5-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch sets the bool values for the AE-5, as well as selects the
mixer it will use.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5f53c71..7c870c4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7597,7 +7597,11 @@ static int ca0132_prepare_verbs(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	spec->chip_init_verbs = ca0132_init_verbs0;
-	if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D)
+	/*
+	 * Since desktop cards use pci_mmio, this can be used to determine
+	 * whether or not to use these verbs instead of a separate bool.
+	 */
+	if (spec->use_pci_mmio)
 		spec->desktop_init_verbs = ca0132_init_verbs1;
 	spec->spec_init_verbs = kcalloc(NUM_SPEC_VERBS,
 					sizeof(struct hda_verb),
@@ -7671,6 +7675,10 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = r3di_mixer;
 		snd_hda_codec_set_name(codec, "Recon3Di");
 		break;
+	case QUIRK_AE5:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Sound BlasterX AE-5");
+		break;
 	default:
 		spec->mixers[0] = ca0132_mixer;
 		break;
@@ -7680,6 +7688,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
+	case QUIRK_AE5:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
 		spec->use_pci_mmio = true;
-- 
2.7.4
