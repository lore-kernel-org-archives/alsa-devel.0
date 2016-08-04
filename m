From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Fix headset mic detection problem for two dell machines
Date: Thu,  4 Aug 2016 15:28:04 +0800
Message-ID: <1470295684-25642-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

One of the machines has ALC255 on it, another one has ALC298 on it.

On the machine with the codec ALC298, it also has the speaker volume
problem, so we add the fixup chained to ALC298_FIXUP_SPK_VOLUME rather
than adding a group of pin definition in the pin quirk table, since
the speak volume problem does not happen on other machines yet.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ce5f1ba..574b1b4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5513,6 +5513,8 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC298_FIXUP_SPK_VOLUME] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_speaker_volume,
+		.chained = true,
+		.chain_id = ALC298_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
 };
 
@@ -5836,6 +5838,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x1b, 0x01014020},
 		{0x21, 0x0221103f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170130},
+		{0x1b, 0x02011020},
+		{0x21, 0x0221103f}),
+	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x14, 0x90170150},
 		{0x1b, 0x02011020},
 		{0x21, 0x0221105f}),
-- 
1.9.1
