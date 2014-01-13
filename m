From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Prevent speaker from entering automute on some AIO models
Date: Mon, 13 Jan 2014 14:52:27 +0800
Message-ID: <1389595947-15038-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com, stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

On some AIO (All In One) models with the codec alc668
(Vendor ID: 0x10ec0668) on it, when we plug a headphone into the jack,
the system will switch the output to headphone and set the speaker to
automute as well as change the speaker Pin-ctls from 0x40 to 0x00,
this will bring loud noise to the headphone.

I tried to disable the corresponding EAPD, but it did not help to
eliminate the noise.

So far, the only way to eliminate the noise is preventing the speaker
from entering automute.

BugLink: https://bugs.launchpad.net/bugs/1268468
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
This problem has been reported on three Dell AIO models.

 sound/pci/hda/patch_realtek.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6a705a8..27111d0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3589,6 +3589,17 @@ static void alc_fixup_headset_mode_alc255(struct hda_codec *codec,
 	alc_fixup_headset_mode(codec, fix, action);
 }
 
+static void alc_fixup_spk_automute_alc668(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		struct alc_spec *spec = codec->spec;
+		/* On some AIO (All In One) machines, setting the speaker
+		   to audomute will bring the noise to the headphone. */
+		spec->gen.suppress_auto_mute = 1;
+	}
+}
+
 static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4935,6 +4946,7 @@ enum {
 	ALC662_FIXUP_BASS_CHMAP,
 	ALC662_FIXUP_BASS_1A,
 	ALC662_FIXUP_BASS_1A_CHMAP,
+	ALC668_FIXUP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -5095,6 +5107,12 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC668_FIXUP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_spk_automute_alc668,
+		.chained = true,
+		.chain_id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE
+	},
 	[ALC668_FIXUP_DELL_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5140,11 +5158,11 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0623, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0624, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0623, "Dell", ALC668_FIXUP_AUTO_MUTE),
+	SND_PCI_QUIRK(0x1028, 0x0624, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0625, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0626, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x0628, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x0628, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_BASS_1A_CHMAP),
 	SND_PCI_QUIRK(0x1043, 0x1477, "ASUS N56VZ", ALC662_FIXUP_BASS_CHMAP),
-- 
1.8.1.2
