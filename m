From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - Add two more machines to the power_save_blacklist
Date: Mon,  8 Apr 2019 09:35:35 +0800
Message-ID: <20190408013535.6423-1-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Recently we set CONFIG_SND_HDA_POWER_SAVE_DEFAULT to 1 when
configuring the kernel, then two machines were reported to have noise
after installing the new kernel. Put them in the blacklist, the
noise disappears.

https://bugs.launchpad.net/bugs/1821663
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ece256a3b48f..f62fb8b16c49 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2150,6 +2150,9 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
+	/* https://bugs.launchpad.net/bugs/1821663 */
+	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	SND_PCI_QUIRK(0x8086, 0x2064, "Intel Laptop 8086:2064", 0),
 	{}
 };
 #endif /* CONFIG_PM */
-- 
2.17.1
