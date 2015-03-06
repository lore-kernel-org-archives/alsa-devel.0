From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - One more Dell macine needs DELL1_MIC_NO_PRESENCE quirk
Date: Fri,  6 Mar 2015 14:03:57 +0800
Message-ID: <1425621837-13754-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Cc: <stable@vger.kernel.org>
BugLink: https://bugs.launchpad.net/bugs/1428947
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b2b24a8..526398a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5209,6 +5209,13 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x17, 0x40000000},
 		{0x1d, 0x40700001},
 		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC255_STANDARD_PINS,
+		{0x12, 0x90a60170},
+		{0x14, 0x90170140},
+		{0x17, 0x40000000},
+		{0x1d, 0x40700001},
+		{0x21, 0x02211050}),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
 		{0x13, 0x40000000},
-- 
1.9.1
