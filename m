From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 4/4] ALSA: hda/realtek: Fix mic issue on Acer AIO Veriton Z4860G/Z6860G
Date: Wed,  5 Dec 2018 14:48:56 +0800
Message-ID: <20181205064856.19380-4-jian-hong@endlessm.com>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205064856.19380-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Chris Chiu <chiu@endlessm.com>, Jian-Hong Pan <jian-hong@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Chiu <chiu@endlessm.com>

Acer AIO Veriton Z4860G/Z6860G with the same ALC286 codec has issues
with the input from external microphone. The issue can be fixed by
the fixup ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE for Veriton Z4660G.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 98f0abaa3540..bb40624fb6d5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6419,6 +6419,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.11.0
