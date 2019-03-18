From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda - add Lenovo IdeaCentre B550 to the power_save_blacklist
Date: Mon, 18 Mar 2019 13:45:43 +0100
Message-ID: <20190318124543.30944-1-perex@perex.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, hs.guimaraes@outlook.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Another machine which does not like the power saving (noise):
  https://bugzilla.redhat.com/show_bug.cgi?id=1689623

Also, reorder the Lenovo C50 entry to keep the table sorted.

Reported-by: hs.guimaraes@outlook.com
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e5c49003e75f..4f502c92061f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2144,10 +2144,12 @@ static struct snd_pci_quirk power_save_blacklist[] = {
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
-	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
-	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
+	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
+	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	{}
 };
 #endif /* CONFIG_PM */
-- 
2.20.1
