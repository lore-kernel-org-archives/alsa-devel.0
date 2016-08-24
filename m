From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] ALSA: hda/realtek - fix headset mic detection
	for MSI MS-B120
Date: Wed, 24 Aug 2016 09:14:13 +0200
Message-ID: <1472022853-12371-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4802661BF
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 09:14:22 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o80so1295245wme.0
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 00:14:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Anisse Astier <anisse@astier.eu>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

MSI Cubi MS-B120 needs the same fixup as the Gigabyte BXBT-2807 for its
mic to work.

They both use a single 3-way jack for both mic and headset with an
ALC283 codec, with the same pins used.

Cc: Daniel Drake <drake@endlessm.com>
Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 sound/pci/hda/patch_realtek.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 574b1b4..7100f05 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4828,7 +4828,7 @@ enum {
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC292_FIXUP_TPT440_DOCK,
 	ALC292_FIXUP_TPT440,
-	ALC283_FIXUP_BXBT2807_MIC,
+	ALC283_FIXUP_HEADSET_MIC,
 	ALC255_FIXUP_DELL_WMI_MIC_MUTE_LED,
 	ALC282_FIXUP_ASPIRE_V5_PINS,
 	ALC280_FIXUP_HP_GPIO4,
@@ -5321,7 +5321,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC292_FIXUP_TPT440_DOCK,
 	},
-	[ALC283_FIXUP_BXBT2807_MIC] = {
+	[ALC283_FIXUP_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x04a110f0 },
@@ -5651,7 +5651,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
-	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_BXBT2807_MIC),
+	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x21b8, "Thinkpad Edge 14", ALC269_FIXUP_SKU_IGNORE),
-- 
2.5.5
