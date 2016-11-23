From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - fix headset-mic problem on a Dell laptop
Date: Wed, 23 Nov 2016 16:05:38 +0800
Message-ID: <1479888338-5085-2-git-send-email-hui.wang@canonical.com>
References: <1479888338-5085-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1479888338-5085-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

This group of new pins is not in the pin quirk table yet, adding
them to the pin quirk table to fix the headset-mic problem.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48b8701..64c22cc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5917,6 +5917,9 @@ enum {
 		{0x12, 0x90a60180},
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x1b, 0x01011020},
+		{0x21, 0x02211010}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60160},
 		{0x14, 0x90170120},
-- 
1.9.1
