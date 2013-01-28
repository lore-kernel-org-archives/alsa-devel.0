From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - fix inverted internal mic on Acer AOA150/ZG5
Date: Mon, 28 Jan 2013 05:45:47 +0100
Message-ID: <1359348347-7990-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, 1107477@bugs.launchpad.net, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch enables internal mic input on the machine.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1107477
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc75607..de512c5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2363,6 +2363,7 @@ static const struct hda_model_fixup alc268_fixup_models[] = {
 };
 
 static const struct snd_pci_quirk alc268_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x1025, 0x015b, "Acer AOA 150 (ZG5)", ALC268_FIXUP_INV_DMIC),
 	/* below is codec SSID since multiple Toshiba laptops have the
 	 * same PCI SSID 1179:ff00
 	 */
-- 
1.7.9.5
