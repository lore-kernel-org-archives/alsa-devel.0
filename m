From: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Fix silent headphone output on MacPro 4,1 (v2)
Date: Tue, 22 Dec 2015 00:45:43 +0100
Message-ID: <1450741543-1881-1-git-send-email-mario.kleiner.de@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, mario.kleiner.de@gmail.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Without this patch, internal speaker and line-out work,
but front headphone output jack stays silent on the
Mac Pro 4,1.

This code path also gets executed on the MacPro 5,1 due
to identical codec SSID, but i don't know if it has any
positive or adverse effects there or not.

(v2) Implement feedback from Takashi Iwai: Reuse
     alc889_fixup_mbp_vref and just add a new nid
     0x19 for the MacPro 4,1.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9bedf7c..0e654e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1755,6 +1755,7 @@ enum {
 	ALC889_FIXUP_MBA11_VREF,
 	ALC889_FIXUP_MBA21_VREF,
 	ALC889_FIXUP_MP11_VREF,
+	ALC889_FIXUP_MP41_VREF,
 	ALC882_FIXUP_INV_DMIC,
 	ALC882_FIXUP_NO_PRIMARY_HP,
 	ALC887_FIXUP_ASUS_BASS,
@@ -1843,7 +1844,7 @@ static void alc889_fixup_mbp_vref(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	static hda_nid_t nids[2] = { 0x14, 0x15 };
+	static hda_nid_t nids[3] = { 0x14, 0x15, 0x19 };
 	int i;
 
 	if (action != HDA_FIXUP_ACT_INIT)
@@ -2133,6 +2134,12 @@ static const struct hda_fixup alc882_fixups[] = {
 		.chained = true,
 		.chain_id = ALC885_FIXUP_MACPRO_GPIO,
 	},
+	[ALC889_FIXUP_MP41_VREF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc889_fixup_mbp_vref,
+		.chained = true,
+		.chain_id = ALC885_FIXUP_MACPRO_GPIO,
+	},
 	[ALC882_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -2215,7 +2222,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x3f00, "Macbook 5,1", ALC889_FIXUP_IMAC91_VREF),
 	SND_PCI_QUIRK(0x106b, 0x4000, "MacbookPro 5,1", ALC889_FIXUP_IMAC91_VREF),
 	SND_PCI_QUIRK(0x106b, 0x4100, "Macmini 3,1", ALC889_FIXUP_IMAC91_VREF),
-	SND_PCI_QUIRK(0x106b, 0x4200, "Mac Pro 5,1", ALC885_FIXUP_MACPRO_GPIO),
+	SND_PCI_QUIRK(0x106b, 0x4200, "Mac Pro 4,1/5,1", ALC889_FIXUP_MP41_VREF),
 	SND_PCI_QUIRK(0x106b, 0x4300, "iMac 9,1", ALC889_FIXUP_IMAC91_VREF),
 	SND_PCI_QUIRK(0x106b, 0x4600, "MacbookPro 5,2", ALC889_FIXUP_IMAC91_VREF),
 	SND_PCI_QUIRK(0x106b, 0x4900, "iMac 9,1 Aluminum", ALC889_FIXUP_IMAC91_VREF),
-- 
1.9.1
