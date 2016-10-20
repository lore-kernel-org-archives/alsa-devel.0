From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic detection problem for two Dell laptops
Date: Thu, 20 Oct 2016 14:03:33 +0800
Message-ID: <1476943413-7155-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

They uses the codec ALC255, and have the different pin cfg definition
from the ones in the existing pin quirk table. Now adding them into
the table to fix the problem.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8483fc2..b582d57 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5857,11 +5857,19 @@ enum {
 		{0x1b, 0x02011020},
 		{0x21, 0x0221101f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x1b, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x14, 0x90170130},
 		{0x1b, 0x01014020},
 		{0x21, 0x0221103f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x14, 0x90170130},
+		{0x1b, 0x01011020},
+		{0x21, 0x0221103f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170130},
 		{0x1b, 0x02011020},
 		{0x21, 0x0221103f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
-- 
1.9.1
