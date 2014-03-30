From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 1/2] snd-ice1712: add suspend support for
	ICE1712 chip
Date: Sun, 30 Mar 2014 23:37:30 +0200
Message-ID: <1396215451-24128-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-1.atlantis.sk (mail-1.atlantis.sk [80.94.52.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 1519026508D
 for <alsa-devel@alsa-project.org>; Sun, 30 Mar 2014 23:37:52 +0200 (CEST)
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

Add suspend/resume support for ICE1712 chip.
Card-specific subdrivers need to enable it and provide callbacks that suspend/resume the codecs.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/ice1712/ice1712.c |   85 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 28ec872..dbb0f96 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2428,6 +2428,13 @@ static int snd_ice1712_chip_init(struct snd_ice1712 *ice)
 		snd_ice1712_write(ice, ICE1712_IREG_CONSUMER_POWERDOWN, 0);
 	}
 	snd_ice1712_set_pro_rate(ice, 48000, 1);
+	/* unmask used interrupts */
+	outb(((ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) == 0 ?
+	      ICE1712_IRQ_MPU2 : 0) |
+	     ((ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_NO_CON_AC97) ?
+	      ICE1712_IRQ_PBKDS | ICE1712_IRQ_CONCAP | ICE1712_IRQ_CONPBK : 0),
+	     ICEREG(ice, IRQMASK));
+	outb(0x00, ICEMT(ice, IRQ));
 
 	return 0;
 }
@@ -2589,6 +2596,7 @@ static int snd_ice1712_create(struct snd_card *card,
 	ice->pci = pci;
 	ice->irq = -1;
 	pci_set_master(pci);
+	/* disable legacy emulation */
 	pci_write_config_word(ice->pci, 0x40, 0x807f);
 	pci_write_config_word(ice->pci, 0x42, 0x0006);
 	snd_ice1712_proc_init(ice);
@@ -2625,14 +2633,6 @@ static int snd_ice1712_create(struct snd_card *card,
 		return -EIO;
 	}
 
-	/* unmask used interrupts */
-	outb(((ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) == 0 ?
-	      ICE1712_IRQ_MPU2 : 0) |
-	     ((ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_NO_CON_AC97) ?
-	      ICE1712_IRQ_PBKDS | ICE1712_IRQ_CONCAP | ICE1712_IRQ_CONPBK : 0),
-	     ICEREG(ice, IRQMASK));
-	outb(0x00, ICEMT(ice, IRQ));
-
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ice, &ops);
 	if (err < 0) {
 		snd_ice1712_free(ice);
@@ -2809,11 +2809,80 @@ static void snd_ice1712_remove(struct pci_dev *pci)
 	snd_card_free(card);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int snd_ice1712_suspend(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct snd_ice1712 *ice = card->private_data;
+
+	if (!ice->pm_suspend_enabled)
+		return 0;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+
+	snd_pcm_suspend_all(ice->pcm);
+	snd_pcm_suspend_all(ice->pcm_pro);
+	snd_pcm_suspend_all(ice->pcm_ds);
+	snd_ac97_suspend(ice->ac97);
+
+	if (ice->pm_suspend)
+		ice->pm_suspend(ice);
+
+	pci_disable_device(pci);
+	pci_save_state(pci);
+	pci_set_power_state(pci, PCI_D3hot);
+	return 0;
+}
+
+static int snd_ice1712_resume(struct device *dev)
+{
+	struct pci_dev *pci = to_pci_dev(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct snd_ice1712 *ice = card->private_data;
+
+	if (!ice->pm_suspend_enabled)
+		return 0;
+
+	pci_set_power_state(pci, PCI_D0);
+	pci_restore_state(pci);
+
+	if (pci_enable_device(pci) < 0) {
+		snd_card_disconnect(card);
+		return -EIO;
+	}
+
+	pci_set_master(pci);
+
+	if (snd_ice1712_chip_init(ice) < 0) {
+		snd_card_disconnect(card);
+		return -EIO;
+	}
+
+	if (ice->pm_resume)
+		ice->pm_resume(ice);
+
+	if (ice->ac97)
+		snd_ac97_resume(ice->ac97);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(snd_ice1712_pm, snd_ice1712_suspend, snd_ice1712_resume);
+#define SND_VT1712_PM_OPS	&snd_ice1712_pm
+#else
+#define SND_VT1712_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct pci_driver ice1712_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ice1712_ids,
 	.probe = snd_ice1712_probe,
 	.remove = snd_ice1712_remove,
+	.driver = {
+		.pm = SND_VT1712_PM_OPS,
+	},
 };
 
 module_pci_driver(ice1712_driver);
-- 
Ondrej Zary
