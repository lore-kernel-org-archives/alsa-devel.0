From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ALSA: hda: Add ASRock N68C-S UCC the power_save blacklist
Date: Thu, 22 Nov 2018 12:38:12 +0100
Message-ID: <20181122113812.23930-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Power-saving is causing plops on audio start/stop on the built-in audio
of the nForce 430 based ASRock N68C-S UCC motherboard, add this model to
the power_save blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Cc: <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d8eb2b5f51ae..0bbdf1a01e76 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2169,6 +2169,8 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0xc892, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1849, 0x0397, "Asrock N68C-S UCC", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0x7662, "Asrock H81M-HDS", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1043, 0x8733, "Asus Prime X370-Pro", 0),
-- 
2.19.1
