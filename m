From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add mute LED quirk for HP Spectre x360
Date: Sat,  4 Aug 2018 11:44:44 -0500
Message-ID: <20180804164448.7152-1-mr.nuke.me@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, Peisen <pshou@realtek.com>, Tom Briden <tom@decompile.me.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This device has the same issues as the HP x360 wrt the MUTE LED and
the front speakers not working. This patch fixes the MUTE LED issue,
but doesn't touch the HDA verbs. The fix for the x360 does not work
on the Spectre.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6af3e1c2b93..d14b05f68d6d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6530,6 +6530,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.17.1
