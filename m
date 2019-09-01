From: Sam Bazley <sambazley@fastmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add quirk for HP Pavilion 15
Date: Sun, 1 Sep 2019 03:31:30 +0100
Message-ID: <20190901023130.GA15295@SamLinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, sambazley@fastmail.com
List-Id: alsa-devel@alsa-project.org

HP Pavilion 15 (AMD Ryzen-based model) with 103c:84e7 needs the same
quirk like HP Envy/Spectre x360 for enabling the mute LED over Mic3 pin.

Signed-off-by: Sam Bazley <sambazley@fastmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..31ba8d68c16d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6973,6 +6973,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802e, "HP Z240 SFF", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.23.0
