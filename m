From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add a headset quirk for Dell XPS 13
Date: Fri,  7 Feb 2014 11:00:16 +0100
Message-ID: <1391767216-4394-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, "3.10+" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This quirk is needed for the headset microphone to work.

Alsa-info at http://www.alsa-project.org/db/?f=8c7dfe857ceff462ca2de133e67023c0f68de9cb

Cc: stable@vger.kernel.org (3.10+)
Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bee4b8c..2cb6a39 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5146,6 +5146,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
 	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x060a, "Dell XPS 13", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0623, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0624, "Dell", ALC668_FIXUP_AUTO_MUTE),
 	SND_PCI_QUIRK(0x1028, 0x0625, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
-- 
1.7.9.5
