From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic detection problem for one Dell machine
Date: Wed, 25 May 2016 12:12:32 +0800
Message-ID: <1464149552-7225-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Add the pin configuration value of this machine into the pin_quirk
table to make DELL1_MIC_NO_PRESENCE apply to this machine.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a7f7df1..d53c25e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5720,6 +5720,9 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170130},
+		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60140},
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
-- 
1.9.1
