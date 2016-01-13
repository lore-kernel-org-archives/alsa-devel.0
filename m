From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - fix the headset mic detection problem for a Dell laptop
Date: Wed, 13 Jan 2016 11:51:38 +0800
Message-ID: <1452657098-5887-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

The machine uses codec alc255, and the pin configuration value for
pin 0x14 on this machine is 0x90171130 which is not in the pin quirk
table yet.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1533461
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f0ed41e..61d8502 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5626,6 +5626,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x21, 0x02211040}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60170},
+		{0x14, 0x90171130},
+		{0x21, 0x02211040}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60170},
 		{0x14, 0x90170140},
 		{0x21, 0x02211050}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell Inspiron 5548", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-- 
1.9.1
