From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - fix headset mic detection issue on a Dell machine
Date: Fri, 22 Dec 2017 11:17:45 +0800
Message-ID: <1513912666-6869-2-git-send-email-hui.wang@canonical.com>
References: <1513912666-6869-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1513912666-6869-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

It has the codec alc256, and add its pin definition to pin quirk
table to let it apply ALC255_FIXUP_DELL1_MIC_NO_PRESENCE.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 921a10e..31d88fe 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6550,6 +6550,11 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1b, 0x01011020},
 		{0x21, 0x02211010}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x1b, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60160},
 		{0x14, 0x90170120},
 		{0x21, 0x02211030}),
-- 
2.7.4
