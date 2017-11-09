From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - fix headset mic problem for Dell machines with alc274
Date: Thu,  9 Nov 2017 08:48:08 +0800
Message-ID: <1510188488-3953-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org, hui.wang@canonical.com, kailang@realtek.com
List-Id: alsa-devel@alsa-project.org

Confirmed with Kailang of Realtek, the pin 0x19 is for Headset Mic, and
the pin 0x1a is for Headphone Mic, he suggested to apply
ALC269_FIXUP_DELL1_MIC_NO_PRESENCE to fix this problem. And we
verified applying this FIXUP can fix this problem.

Cc: <stable@vger.kernel.org>
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9b77d43..db1a376 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6568,6 +6568,11 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0xb7a60130},
+		{0x13, 0xb8a61140},
+		{0x16, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
 		{0x14, 0x90170110},
-- 
2.7.4
