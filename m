From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda - factorize an automute_mic realtek
	quirk function
Date: Thu, 16 Dec 2010 12:19:47 +0100
Message-ID: <1292498387-31274-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id D13D42434C
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 12:20:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Anisse Astier <anisse@astier.eu>
List-Id: alsa-devel@alsa-project.org

Multiple quirk functions were using the exact same code to verify if the Mic
jack was plugged and mute the Mic accordingly

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi,

I'm not sure that's the way to go since we loose track of why these functions
were written, but sending anyway, it might help see how to have a better
quirk management (or best: no quirk at all).

Regards,

Anisse
---
 sound/pci/hda/patch_realtek.c |   35 +++++++----------------------------
 1 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 371f698..d58a181 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3356,7 +3356,7 @@ static struct hda_verb alc880_beep_init_verbs[] = {
 };
 
 /* auto-toggle front mic */
-static void alc880_uniwill_mic_automute(struct hda_codec *codec)
+static void alc88x_simple_mic_automute(struct hda_codec *codec)
 {
  	unsigned int present;
 	unsigned char bits;
@@ -3378,7 +3378,7 @@ static void alc880_uniwill_setup(struct hda_codec *codec)
 static void alc880_uniwill_init_hook(struct hda_codec *codec)
 {
 	alc_automute_amp(codec);
-	alc880_uniwill_mic_automute(codec);
+	alc88x_simple_mic_automute(codec);
 }
 
 static void alc880_uniwill_unsol_event(struct hda_codec *codec,
@@ -3389,7 +3389,7 @@ static void alc880_uniwill_unsol_event(struct hda_codec *codec,
 	 */
 	switch (res >> 28) {
 	case ALC880_MIC_EVENT:
-		alc880_uniwill_mic_automute(codec);
+		alc88x_simple_mic_automute(codec);
 		break;
 	default:
 		alc_automute_amp_unsol_event(codec, res);
@@ -9522,15 +9522,6 @@ static void alc883_lenovo_nb0763_setup(struct hda_codec *codec)
 #define alc883_targa_init_hook		alc882_targa_init_hook
 #define alc883_targa_unsol_event	alc882_targa_unsol_event
 
-static void alc883_clevo_m720_mic_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-
-	present = snd_hda_jack_detect(codec, 0x18);
-	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
-}
-
 static void alc883_clevo_m720_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -9542,7 +9533,7 @@ static void alc883_clevo_m720_setup(struct hda_codec *codec)
 static void alc883_clevo_m720_init_hook(struct hda_codec *codec)
 {
 	alc_automute_amp(codec);
-	alc883_clevo_m720_mic_automute(codec);
+	alc88x_simple_mic_automute(codec);
 }
 
 static void alc883_clevo_m720_unsol_event(struct hda_codec *codec,
@@ -9550,7 +9541,7 @@ static void alc883_clevo_m720_unsol_event(struct hda_codec *codec,
 {
 	switch (res >> 26) {
 	case ALC880_MIC_EVENT:
-		alc883_clevo_m720_mic_automute(codec);
+		alc88x_simple_mic_automute(codec);
 		break;
 	default:
 		alc_automute_amp_unsol_event(codec, res);
@@ -16806,18 +16797,6 @@ static struct hda_verb alc861vd_lenovo_unsol_verbs[] = {
 	{}
 };
 
-static void alc861vd_lenovo_mic_automute(struct hda_codec *codec)
-{
-	unsigned int present;
-	unsigned char bits;
-
-	present = snd_hda_jack_detect(codec, 0x18);
-	bits = present ? HDA_AMP_MUTE : 0;
-
-	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1,
-				 HDA_AMP_MUTE, bits);
-}
-
 static void alc861vd_lenovo_setup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -16828,7 +16807,7 @@ static void alc861vd_lenovo_setup(struct hda_codec *codec)
 static void alc861vd_lenovo_init_hook(struct hda_codec *codec)
 {
 	alc_automute_amp(codec);
-	alc861vd_lenovo_mic_automute(codec);
+	alc88x_simple_mic_automute(codec);
 }
 
 static void alc861vd_lenovo_unsol_event(struct hda_codec *codec,
@@ -16836,7 +16815,7 @@ static void alc861vd_lenovo_unsol_event(struct hda_codec *codec,
 {
 	switch (res >> 26) {
 	case ALC880_MIC_EVENT:
-		alc861vd_lenovo_mic_automute(codec);
+		alc88x_simple_mic_automute(codec);
 		break;
 	default:
 		alc_automute_amp_unsol_event(codec, res);
-- 
1.7.3.2
