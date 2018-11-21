From: Girija Kumar Kasinadhuni <gkumar@neverware.com>
Subject: [PATCH v2] ALSA: hda/realtek - Add auto-mute quirk for HP Spectre x360 laptop
Date: Wed, 21 Nov 2018 12:49:11 -0500
Message-ID: <1542822552-110314-1-git-send-email-gkumar@neverware.com>
References: <s5hlg5mbch9.wl-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hlg5mbch9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Girija Kumar Kasinadhuni <gkumar@neverware.com>
List-Id: alsa-devel@alsa-project.org

This device makes a loud buzzing sound when a headphone is inserted while
playing audio at full volume through the speaker.

Signed-off-by: Girija Kumar Kasinadhuni <gkumar@neverware.com>
---
Changes in v2:
	- changed commit message
	- removed "disable" from description

 sound/pci/hda/patch_realtek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fa61674..69bb005 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5495,6 +5495,7 @@ enum {
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
+	ALC295_FIXUP_HP_AUTO_MUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6362,6 +6363,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC295_FIXUP_HP_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6486,6 +6491,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre X360 ", ALC295_FIXUP_HP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.7.4
