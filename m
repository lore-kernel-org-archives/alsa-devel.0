From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432 headset mic
Date: Thu, 21 Mar 2019 17:17:31 +0800
Message-ID: <20190321091730.18638-1-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Chiu <chiu@endlessm.com>

The Acer laptop Aspire E5-523G and ES1-432 with ALC255 can't detect
the headset microphone until ALC255_FIXUP_ACER_MIC_NO_PRESENCE quirk
applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 191830d4fa40..89a96442eb07 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6712,6 +6712,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
-- 
2.20.1
