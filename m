From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] ALSA: hda: Add Acer Aspire 5930G to the
	power_save blacklist
Date: Sun, 13 May 2018 14:48:12 +0100
Message-ID: <20180513134814.26845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F4A8267673
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:48:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Power-saving is causing plopping sounds on the Acer Aspire 5930G, add it
to the blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b0c8c79848a9..7ca29b890425 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2206,6 +2206,8 @@ static int azx_probe(struct pci_dev *pci,
  * to causes problems on these devices.
  */
 static struct snd_pci_quirk power_save_blacklist[] = {
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1025, 0x013f, "Acer Aspire 5930G", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
-- 
2.17.0
