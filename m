From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic detection problem for several Dell laptops
Date: Sun, 11 Sep 2016 11:26:16 +0800
Message-ID: <1473564376-6999-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

One of the laptops has the codec ALC256 on it, applying the
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE can fix the problem, the rest
of laptops have the codec ALC295 on them, they are similar to machines
with ALC225, applying the ALC269_FIXUP_DELL1_MIC_NO_PRESENCE can fix
the problem.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 575cefd..32cbcf8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5806,6 +5806,13 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{0x14, 0x90170110}, \
 	{0x15, 0x0221401f}
 
+#define ALC295_STANDARD_PINS \
+	{0x12, 0xb7a60130}, \
+	{0x14, 0x90170110}, \
+	{0x17, 0x21014020}, \
+	{0x18, 0x21a19030}, \
+	{0x21, 0x04211020}
+
 #define ALC298_STANDARD_PINS \
 	{0x12, 0x90a60130}, \
 	{0x21, 0x03211020}
@@ -5911,6 +5918,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0xb7a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
@@ -6021,6 +6032,8 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC295_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170110}),
-- 
1.9.1
