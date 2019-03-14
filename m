From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda/realtek: merge
	alc_fixup_headset_jack to alc295_fixup_chromebook
Date: Thu, 14 Mar 2019 09:21:08 +0100
Message-ID: <20190314082108.27933-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5310FF80799
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2019 09:21:16 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

The ALC225_FIXUP_HEADSET_JACK fixup can be merged to alc295_fixup_chromebook.
There are no other users for ALC225_FIXUP_HEADSET_JACK other than
the chromebook hardware.

Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/patch_realtek.c | 45 +++++++++++------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a63670013943..eb4018469250 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5491,7 +5491,7 @@ static void alc_headset_btn_callback(struct hda_codec *codec,
 	jack->jack->button_state = report;
 }
 
-static void alc_fixup_headset_jack(struct hda_codec *codec,
+static void alc295_fixup_chromebook(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 
@@ -5501,6 +5501,16 @@ static void alc_fixup_headset_jack(struct hda_codec *codec,
 						    alc_headset_btn_callback);
 		snd_hda_jack_add_kctl(codec, 0x55, "Headset Jack", false,
 				      SND_JACK_HEADSET, alc_headset_btn_keymap);
+		switch (codec->core.vendor_id) {
+		case 0x10ec0295:
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
+			break;
+		case 0x10ec0236:
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
+			break;
+		}
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		switch (codec->core.vendor_id) {
@@ -5521,26 +5531,6 @@ static void alc_fixup_headset_jack(struct hda_codec *codec,
 	}
 }
 
-static void alc295_fixup_chromebook(struct hda_codec *codec,
-				    const struct hda_fixup *fix, int action)
-{
-
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		switch (codec->core.vendor_id) {
-		case 0x10ec0295:
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
-			break;
-		case 0x10ec0236:
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
-			break;
-		}
-		break;
-	}
-}
-
 static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
@@ -5690,11 +5680,10 @@ enum {
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
-	ALC225_FIXUP_HEADSET_JACK,
+	ALC295_FIXUP_CHROME_BOOK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
-	ALC295_FIXUP_CHROME_BOOK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6637,9 +6626,9 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
-	[ALC225_FIXUP_HEADSET_JACK] = {
+	[ALC295_FIXUP_CHROME_BOOK] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_headset_jack,
+		.v.func = alc295_fixup_chromebook,
 	},
 	[ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -6671,12 +6660,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
-	[ALC295_FIXUP_CHROME_BOOK] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc295_fixup_chromebook,
-		.chained = true,
-		.chain_id = ALC225_FIXUP_HEADSET_JACK
-	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
-- 
2.20.1
