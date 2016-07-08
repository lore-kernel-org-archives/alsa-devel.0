From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - add new pin definition in alc225 pin quirk table
Date: Fri,  8 Jul 2016 14:26:57 +0800
Message-ID: <1467959217-22214-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have some Dell laptops which can't detect headset mic, the machines
use the codec ALC225, they have some new pin configuration values,
after adding them in the alc225 pin quirk table, they work well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
comparing with the previous patch (I said the patch should be skipped),
this patch adds one more group of pin definition in the pin quirk table.

 sound/pci/hda/patch_realtek.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 45d4dc1..ddd29b9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5753,7 +5753,6 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{}
 };
 #define ALC225_STANDARD_PINS \
-	{0x12, 0xb7a60130}, \
 	{0x21, 0x04211020}
 
 #define ALC256_STANDARD_PINS \
@@ -5778,10 +5777,24 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC225_STANDARD_PINS,
+		{0x12, 0xb7a60130},
 		{0x14, 0x901701a0}),
 	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC225_STANDARD_PINS,
+		{0x12, 0xb7a60130},
 		{0x14, 0x901701b0}),
+	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC225_STANDARD_PINS,
+		{0x12, 0xb7a60150},
+		{0x14, 0x901701a0}),
+	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC225_STANDARD_PINS,
+		{0x12, 0xb7a60150},
+		{0x14, 0x901701b0}),
+	SND_HDA_PIN_QUIRK(0x10ec0225, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC225_STANDARD_PINS,
+		{0x12, 0xb7a60130},
+		{0x1b, 0x90170110}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
-- 
1.9.1
