From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 4/4] ALSA: hda/ca0132 - Fix input effect controls for desktop cards
Date: Mon,  8 Oct 2018 15:40:00 -0400
Message-ID: <1539027601-20910-5-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch removes the echo cancellation control for desktop cards, and
makes use of the special 0x47 SCP command for noise reduction.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 693b063..1a13cea 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4857,7 +4857,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 			val = 0;
 
 		/* If Voice Focus on SBZ, set to two channel. */
-		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == VOICE_FOCUS) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -4876,7 +4876,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		 * For SBZ noise reduction, there's an extra command
 		 * to module ID 0x47. No clue why.
 		 */
-		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == NOISE_REDUCTION) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -6374,8 +6374,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	for (i = 0; i < num_fx; i++) {
-		/* SBZ and R3D break if Echo Cancellation is used. */
-		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D) {
+		/* Desktop cards break if Echo Cancellation is used. */
+		if (spec->use_pci_mmio) {
 			if (i == (ECHO_CANCELLATION - IN_EFFECT_START_NID +
 						OUT_EFFECTS_COUNT))
 				continue;
-- 
2.7.4
