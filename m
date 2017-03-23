From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Adding a group of pin definition to fix headset problem
Date: Thu, 23 Mar 2017 10:00:25 +0800
Message-ID: <1490234425-32189-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

A new Dell laptop needs to apply ALC269_FIXUP_DELL1_MIC_NO_PRESENCE to
fix the headset problem, and the pin definiton of this machine is not
in the pin quirk table yet, now adding it to the table.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1561076..efa657f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6191,6 +6191,8 @@ enum {
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014040},
 		{0x18, 0x21a19050}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		ALC295_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0298, 0x1028, "Dell", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC298_STANDARD_PINS,
 		{0x17, 0x90170110}),
-- 
1.9.1
