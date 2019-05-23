From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH] ALSA: Enable micmute LED for Huawei laptops
Date: Thu, 23 May 2019 05:30:11 -0400
Message-ID: <20190523093014.21019-1-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Jian-Hong Pan <jian-hong@endlessm.com>, Daniel Drake <drake@endlessm.com>, Chris Chiu <chiu@endlessm.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ayman.bagabas@gmail.com
List-Id: alsa-devel@alsa-project.org

Since this LED is found on all Huawei laptops, we can hook it to
huawei-wmi platform driver to control it.

Also, some renames have been made to use product name instead of common
name to avoid confusions.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f83f21d64dd4..ab6a856ec614 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5747,7 +5747,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
-	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_MACH_WX9_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
@@ -6038,7 +6038,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
-	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
+	[ALC256_FIXUP_HUAWEI_MACH_WX9_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{0x12, 0x90a60130},
@@ -7063,9 +7063,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
@@ -7124,6 +7122,7 @@ static const struct snd_pci_quirk alc269_fixup_vendor_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
+	SND_PCI_QUIRK_VENDOR(0x19e5, "Huawei Matebook", ALC255_FIXUP_MIC_MUTE_LED),
 	{}
 };
 
-- 
2.20.1
