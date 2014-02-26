From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: rme96: Convert to the new pm_ops
Date: Wed, 26 Feb 2014 16:46:09 +0100
Message-ID: <1393429569-26451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A9E326572B
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:46:10 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E15B975018
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:46:09 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

This driver slipped from the last rewrite.  Just convert to the new
standard pm ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 00d46116e04a..f5014a8e69ad 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -240,7 +240,7 @@ struct rme96 {
 
 	u8 rev; /* card revision number */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	u32 playback_pointer;
 	u32 capture_pointer;
 	void *playback_suspend_buffer;
@@ -1570,7 +1570,7 @@ snd_rme96_free(void *private_data)
 		pci_release_regions(rme96->pci);
 		rme96->port = 0;
 	}
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	vfree(rme96->playback_suspend_buffer);
 	vfree(rme96->capture_suspend_buffer);
 #endif
@@ -2372,13 +2372,12 @@ snd_rme96_create_switches(struct snd_card *card,
  * Card initialisation
  */
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
-static int
-snd_rme96_suspend(struct pci_dev *pci,
-		  pm_message_t state)
+static int rme96_suspend(struct device *dev)
 {
-	struct snd_card *card = pci_get_drvdata(pci);
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct rme96 *rme96 = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
@@ -2407,10 +2406,10 @@ snd_rme96_suspend(struct pci_dev *pci,
 	return 0;
 }
 
-static int
-snd_rme96_resume(struct pci_dev *pci)
+static int rme96_resume(struct device *dev)
 {
-	struct snd_card *card = pci_get_drvdata(pci);
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct rme96 *rme96 = card->private_data;
 
 	pci_restore_state(pci);
@@ -2451,7 +2450,11 @@ snd_rme96_resume(struct pci_dev *pci)
 	return 0;
 }
 
-#endif
+static SIMPLE_DEV_PM_OPS(rme96_pm, rme96_suspend, rme96_resume);
+#define RME96_PM_OPS	&rme96_pm
+#else
+#define RME96_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
 
 static void snd_rme96_card_free(struct snd_card *card)
 {
@@ -2488,7 +2491,7 @@ snd_rme96_probe(struct pci_dev *pci,
 		return err;
 	}
 	
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
 	if (!rme96->playback_suspend_buffer) {
 		snd_printk(KERN_ERR
@@ -2547,10 +2550,9 @@ static struct pci_driver rme96_driver = {
 	.id_table = snd_rme96_ids,
 	.probe = snd_rme96_probe,
 	.remove = snd_rme96_remove,
-#ifdef CONFIG_PM
-	.suspend = snd_rme96_suspend,
-	.resume = snd_rme96_resume,
-#endif
+	.driver = {
+		.pm = RME96_PM_OPS,
+	},
 };
 
 module_pci_driver(rme96_driver);
-- 
1.9.0
