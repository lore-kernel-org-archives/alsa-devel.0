From: Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH] ALSA: hda - Add headset mic quirk for Dell Inspiron 5468
Date: Mon, 29 Aug 2016 15:19:27 +0800
Message-ID: <1472455167-13643-1-git-send-email-shrirang.bagul@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch enables headset microphone on some variants of
Dell Inspiron 5468. (Dell SSID 0x07ad)

BugLink: https://bugs.launchpad.net/bugs/1617900
Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7100f05..02fd252 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5895,6 +5895,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60170},
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell Inspiron 5468", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60180},
+		{0x14, 0x90170120},
+		{0x21, 0x02211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
-- 
2.7.4
