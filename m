From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH 2/2] ALSA: hda - Fix click noises on Samsung Ativ Book 8
Date: Sat, 24 Dec 2016 19:50:01 +0100
Message-ID: <20161224185001.26824-2-gabriele.mzt@gmail.com>
References: <20161224185001.26824-1-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161224185001.26824-1-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Samsung Ativ Book 8 makes a loud click noise on boot, shutdown
and when the audio card enters or exits power saving states. All
these noises disappear applying ALC269_FIXUP_NO_SHUTUP.

In addition to that, fix the loud click noise that the laptop
makes when inserting or removing the headphone jack by automuting
via amp instead of pinctl.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d30cc49512e4..00df12b6695a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4856,6 +4856,7 @@ enum {
 	ALC292_FIXUP_TPT460,
 	ALC298_FIXUP_SPK_VOLUME,
 	ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER,
+	ALC269_FIXUP_ATIV_BOOK_8,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5528,6 +5529,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC269_FIXUP_ATIV_BOOK_8] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_NO_SHUTUP
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5664,6 +5671,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
-- 
2.11.0
