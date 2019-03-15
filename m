From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date: Fri, 15 Mar 2019 17:51:09 +0800
Message-ID: <20190315095108.9195-1-jian-hong@endlessm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot
record sound from headset MIC.  This patch adds the
ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2: According to Realtek's suggestion, change the COEF 0x4f from 0xd429 to
    0x5029.  Thanks to Realtek!

 sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 384719d5c44e..191830d4fa40 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5687,6 +5687,7 @@ enum {
 	ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
+	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6685,6 +6686,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC286_FIXUP_ACER_AIO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5029 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6701,9 +6712,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.20.1
