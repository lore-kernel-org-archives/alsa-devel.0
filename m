From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add enable_msi=0 workaround for four HP machines
Date: Thu, 12 Dec 2013 09:52:03 +0100
Message-ID: <1386838323-3692-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1260225@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

While enabling these machines, we found we would sometimes lose an
interrupt if we change hardware volume during playback, and that
disabling msi fixed this issue. (Losing the interrupt caused underruns
and crackling audio, as the one second timeout is usually bigger than
the period size.)

The machines were all machines from HP, running AMD Hudson controller,
and Realtek ALC282 codec.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1260225
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index af86c71..440c355 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3446,6 +3446,10 @@ static void check_probe_mask(struct azx *chip, int dev)
  * white/black-list for enable_msi
  */
 static struct snd_pci_quirk msi_black_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x2191, "HP", 0), /* AMD Hudson */
+	SND_PCI_QUIRK(0x103c, 0x2192, "HP", 0), /* AMD Hudson */
+	SND_PCI_QUIRK(0x103c, 0x21f7, "HP", 0), /* AMD Hudson */
+	SND_PCI_QUIRK(0x103c, 0x21fa, "HP", 0), /* AMD Hudson */
 	SND_PCI_QUIRK(0x1043, 0x81f2, "ASUS", 0), /* Athlon64 X2 + nvidia */
 	SND_PCI_QUIRK(0x1043, 0x81f6, "ASUS", 0), /* nvidia */
 	SND_PCI_QUIRK(0x1043, 0x822d, "ASUS", 0), /* Athlon64 X2 + nvidia MCP55 */
-- 
1.7.9.5
