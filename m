From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Force polling mode on CFL for
	fixing codec communication
Date: Wed, 21 Mar 2018 10:15:25 +0100
Message-ID: <20180321091525.1366-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 32E972671F9
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 10:15:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hui Wang <hui.wang@canonical.com>
List-Id: alsa-devel@alsa-project.org

We've observed too long probe time with Coffee Lake machines, and the
likely cause is some communication problem between the HD-audio
controller and the codec chips.  While the controller expects an IRQ
wakeup for each codec response, it seems sometimes missing, and it
takes one second for the controller driver to time out and read the
response in the polling mode.

Although we aren't sure about the real culprit yet, in this patch, we
put a workaround by forcing the polling mode as default for CFL
machines; the polling mode itself isn't too heavy, and much better
than other workarounds initially suggested (e.g. disabling
power-save), at least.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199007
Fixes: e79b0006c45c ("ALSA: hda - Add Coffelake PCI ID")
Reported-and-tested-by: Hui Wang <hui.wang@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d5017adf9feb..c507c69029e3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -375,6 +375,7 @@ enum {
 					((pci)->device == 0x160c))
 
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
@@ -1744,6 +1745,10 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	else
 		chip->bdl_pos_adj = bdl_pos_adj[dev];
 
+	/* Workaround for a communication error on CFL (bko#199007) */
+	if (IS_CFL(pci))
+		chip->polling_mode = 1;
+
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
 		kfree(hda);
-- 
2.16.2
