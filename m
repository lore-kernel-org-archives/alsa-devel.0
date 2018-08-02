From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry
Date: Thu,  2 Aug 2018 14:04:45 +0200
Message-ID: <20180802120445.4608-1-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I added the subsys product-id for the HDMI HDA device rather then for
the PCH one, this commit fixes this.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1ae1850b3bfd..647ae1a71e10 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2207,7 +2207,7 @@ static int azx_probe(struct pci_dev *pci,
  */
 static struct snd_pci_quirk power_save_blacklist[] = {
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
-	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
+	SND_PCI_QUIRK(0x1849, 0xc892, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0x7662, "Asrock H81M-HDS", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
-- 
2.18.0
