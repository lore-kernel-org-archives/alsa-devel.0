From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Adding one more ALC255 pin definition for headset problem
Date: Mon, 26 Sep 2016 10:59:38 +0800
Message-ID: <1474858778-22986-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

We have two new Dell laptop models, they have the same ALC255 pin
definition, but not in the pin quirk table yet, as a result, the
headset microphone can't work. After adding the definition in the
table, the headset microphone works well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1fe8750..b58e8c7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5855,6 +5855,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x1b, 0x02011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x14, 0x90170130},
 		{0x1b, 0x01014020},
 		{0x21, 0x0221103f}),
-- 
1.9.1
