From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Adding a new group of pin cfg into ALC295 pin quirk table
Date: Tue, 18 Oct 2016 10:59:09 +0800
Message-ID: <1476759549-4051-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have a new Dell laptop model which uses ALC295, the pin definition
is different from the existing ones in the pin quirk table, to fix the
headset mic detection and mic mute led's problem, we need to add the
new pin defintion into the pin quirk table.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b58e8c7..8483fc2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5811,8 +5811,6 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 #define ALC295_STANDARD_PINS \
 	{0x12, 0xb7a60130}, \
 	{0x14, 0x90170110}, \
-	{0x17, 0x21014020}, \
-	{0x18, 0x21a19030}, \
 	{0x21, 0x04211020}
 
 #define ALC298_STANDARD_PINS \
@@ -6039,7 +6037,13 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
-		ALC295_STANDARD_PINS),
+		ALC295_STANDARD_PINS,
+		{0x17, 0x21014020},
+		{0x18, 0x21a19030}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC295_STANDARD_PINS,
+		{0x17, 0x21014040},
+		{0x18, 0x21a19050}),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170110}),
-- 
1.9.1
