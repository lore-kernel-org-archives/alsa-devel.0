From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Add a conexant codec entry to let mute led work
Date: Thu, 25 Jul 2019 14:57:37 +0800
Message-ID: <20190725065737.5238-1-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This conexant codec isn't in the supported codec list yet, the hda
generic driver can drive this codec well, but on a Lenovo machine
with mute/mic-mute leds, we need to apply CXT_FIXUP_THINKPAD_ACPI
to make the leds work. After adding this codec to the list, the
driver patch_conexant.c will apply THINKPAD_ACPI to this machine.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4f8d0845ee1e..f299f137eaea 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -1083,6 +1083,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
  */
 
 static const struct hda_device_id snd_hda_id_conexant[] = {
+	HDA_CODEC_ENTRY(0x14f11f86, "CX8070", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f12008, "CX8200", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15045, "CX20549 (Venice)", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15047, "CX20551 (Waikiki)", patch_conexant_auto),
-- 
2.17.1
