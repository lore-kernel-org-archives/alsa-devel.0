From: woodrow.shen@canonical.com
Subject: [alsa-devel][PATCH] ALSA: hda - Fix the headset mic jack detection on Dell machine
Date: Fri, 24 Jun 2016 15:58:34 +0800
Message-ID: <1466755114-18477-1-git-send-email-woodrow.shen@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Woodrow Shen <woodrow.shen@gmail.com>

The new Dell laptop with codec 3246 can't detect headset mic when
headset was inserted on the machine. So adding pin configurations
into quirk table makes headset mic work correctly.

Codec: Realtek ALC3246
Vendor Id: 0x10ec0256
Subsystem Id: 0x10280781

Signed-off-by: Woodrow Shen <woodrow.shen@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1f652ca1..ac0d5bf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5847,6 +5847,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60170},
+		{0x14, 0x90170120},
+		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
-- 
2.7.4
