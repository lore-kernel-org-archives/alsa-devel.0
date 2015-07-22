From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - remove one pin from ALC292_STANDARD_PINS
Date: Wed, 22 Jul 2015 10:33:34 +0800
Message-ID: <1437532414-24091-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

One more Dell laptop with alc293 codec needs
ALC293_FIXUP_DELL1_MIC_NO_PRESENCE, but the pin 0x1e does not match
the corresponding one in the ALC292_STANDARD_PINS. To use this macro
for this machine, we need to remove pin 0x1e from it.

BugLink: https://bugs.launchpad.net/bugs/1476888
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index caba66b..ee6f13a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5430,8 +5430,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{0x15, 0x0221401f}, \
 	{0x1a, 0x411111f0}, \
 	{0x1b, 0x411111f0}, \
-	{0x1d, 0x40700001}, \
-	{0x1e, 0x411111f0}
+	{0x1d, 0x40700001}
 
 #define ALC298_STANDARD_PINS \
 	{0x18, 0x411111f0}, \
@@ -5690,35 +5689,48 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x13, 0x411111f0},
 		{0x16, 0x01014020},
 		{0x18, 0x411111f0},
-		{0x19, 0x01a19030}),
+		{0x19, 0x01a19030},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x12, 0x90a60140},
 		{0x13, 0x411111f0},
 		{0x16, 0x01014020},
 		{0x18, 0x02a19031},
-		{0x19, 0x01a1903e}),
+		{0x19, 0x01a1903e},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0292, 0x1028, "Dell", ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x12, 0x90a60140},
 		{0x13, 0x411111f0},
 		{0x16, 0x411111f0},
 		{0x18, 0x411111f0},
-		{0x19, 0x411111f0}),
+		{0x19, 0x411111f0},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x12, 0x40000000},
 		{0x13, 0x90a60140},
 		{0x16, 0x21014020},
 		{0x18, 0x411111f0},
-		{0x19, 0x21a19030}),
+		{0x19, 0x21a19030},
+		{0x1e, 0x411111f0}),
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x12, 0x40000000},
 		{0x13, 0x90a60140},
 		{0x16, 0x411111f0},
 		{0x18, 0x411111f0},
-		{0x19, 0x411111f0}),
+		{0x19, 0x411111f0},
+		{0x1e, 0x411111f0}),
+	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC292_STANDARD_PINS,
+		{0x12, 0x40000000},
+		{0x13, 0x90a60140},
+		{0x16, 0x21014020},
+		{0x18, 0x411111f0},
+		{0x19, 0x21a19030},
+		{0x1e, 0x411111ff}),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x12, 0x90a60130},
-- 
1.9.1
