From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda/realtek - fix headset mic detection for MSI MS-B171
Date: Fri, 23 Nov 2018 17:59:11 +0100
Message-ID: <20181123165911.4095-1-anisse@astier.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Anisse Astier <anisse@astier.eu>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

MSI Cubi N 8GL (MS-B171) needs the same fixup as its older model, the
MS-B120, in order for the headset mic to be properly detected.

They both use a single 3-way jack for both mic and headset with an
ALC283 codec, with the same pins used.

Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa61674a5605..1e789e43a5f4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6531,6 +6531,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC233_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
-- 
2.11.0
