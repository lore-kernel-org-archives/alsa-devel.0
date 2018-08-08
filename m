From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 10/11] ALSA: hda/ca0132 - Change mixer controls for Recon3D
Date: Wed,  8 Aug 2018 13:34:21 -0400
Message-ID: <1533749663-8200-11-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Connor McAdams <conmanx360@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds changes to setup the Recon3D's mixer controls.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 18b97df..6f288d7 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5781,11 +5781,11 @@ static const struct snd_kcontrol_new ca0132_mixer[] = {
 };
 
 /*
- * SBZ specific control mixer. Removes auto-detect for mic, and adds surround
- * controls. Also sets both the Front Playback and Capture Volume controls to
- * alt so they set the DSP's decibel level.
+ * Desktop specific control mixer. Removes auto-detect for mic, and adds
+ * surround controls. Also sets both the Front Playback and Capture Volume
+ * controls to alt so they set the DSP's decibel level.
  */
-static const struct snd_kcontrol_new sbz_mixer[] = {
+static const struct snd_kcontrol_new desktop_mixer[] = {
 	CA0132_ALT_CODEC_VOL("Front Playback Volume", 0x02, HDA_OUTPUT),
 	CA0132_CODEC_MUTE("Front Playback Switch", VNID_SPK, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x04, 0, HDA_OUTPUT),
@@ -5856,8 +5856,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	for (i = 0; i < num_fx; i++) {
-		/* SBZ breaks if Echo Cancellation is used */
-		if (spec->quirk == QUIRK_SBZ) {
+		/* SBZ and R3D break if Echo Cancellation is used. */
+		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D) {
 			if (i == (ECHO_CANCELLATION - IN_EFFECT_START_NID +
 						OUT_EFFECTS_COUNT))
 				continue;
@@ -7609,9 +7609,13 @@ static int patch_ca0132(struct hda_codec *codec)
 	/* Set which mixers each quirk uses. */
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
-		spec->mixers[0] = sbz_mixer;
+		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound Blaster Z");
 		break;
+	case QUIRK_R3D:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Recon3D");
+		break;
 	case QUIRK_R3DI:
 		spec->mixers[0] = r3di_mixer;
 		snd_hda_codec_set_name(codec, "Recon3Di");
-- 
2.7.4
