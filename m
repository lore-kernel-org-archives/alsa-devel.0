From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 4/5] ALSA: atiixp: Allocate resources with
	device-managed APIs
Date: Thu, 13 Sep 2018 08:05:26 +0200
Message-ID: <20180913060527.24694-5-tiwai@suse.de>
References: <20180913060527.24694-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 02F14267815
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 08:05:31 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 432AEB004
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 06:05:31 +0000 (UTC)
In-Reply-To: <20180913060527.24694-1-tiwai@suse.de>
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

Like the previous patch, this patch converts the resource allocations
with device-managed API calls, so that we can reduce resource-free
calls.

The atiixp drivers are simpler than intel8x0, and even the irq can be
allocated with devres.

The end result is a good amount of code reduction.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/atiixp.c       | 104 +++++++++++----------------------------
 sound/pci/atiixp_modem.c | 104 +++++++++++----------------------------
 2 files changed, 60 insertions(+), 148 deletions(-)

diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index a1e4944dcfe8..3764f14d1bec 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1557,84 +1557,44 @@ static void snd_atiixp_proc_init(struct atiixp *chip)
  * destructor
  */
 
-static int snd_atiixp_free(struct atiixp *chip)
+static void snd_atiixp_free(struct snd_card *card)
 {
-	if (chip->irq < 0)
-		goto __hw_end;
-	snd_atiixp_chip_stop(chip);
-
-      __hw_end:
-	if (chip->irq >= 0)
-		free_irq(chip->irq, chip);
-	iounmap(chip->remap_addr);
-	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
-	kfree(chip);
-	return 0;
-}
-
-static int snd_atiixp_dev_free(struct snd_device *device)
-{
-	struct atiixp *chip = device->device_data;
-	return snd_atiixp_free(chip);
+	snd_atiixp_chip_stop(card->private_data);
 }
 
 /*
  * constructor for chip instance
  */
-static int snd_atiixp_create(struct snd_card *card,
-			     struct pci_dev *pci,
-			     struct atiixp **r_chip)
+static int snd_atiixp_init(struct snd_card *card, struct pci_dev *pci)
 {
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_atiixp_dev_free,
-	};
-	struct atiixp *chip;
+	struct atiixp *chip = card->private_data;
 	int err;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pcim_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
-
 	spin_lock_init(&chip->reg_lock);
 	mutex_init(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
-	if ((err = pci_request_regions(pci, "ATI IXP AC97")) < 0) {
-		pci_disable_device(pci);
-		kfree(chip);
+	err = pcim_iomap_regions(pci, 1 << 0, "ATI IXP AC97");
+	if (err < 0)
 		return err;
-	}
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = pci_ioremap_bar(pci, 0);
-	if (chip->remap_addr == NULL) {
-		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_atiixp_free(chip);
-		return -EIO;
-	}
+	chip->remap_addr = pcim_iomap_table(pci)[0];
 
-	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
+	if (devm_request_irq(&pci->dev, pci->irq, snd_atiixp_interrupt,
+			     IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_atiixp_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
+	card->private_free = snd_atiixp_free;
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_atiixp_free(chip);
-		return err;
-	}
-
-	*r_chip = chip;
 	return 0;
 }
 
@@ -1646,26 +1606,31 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	struct atiixp *chip;
 	int err;
 
-	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
+	err = snd_devm_card_new(&pci->dev, index, id, THIS_MODULE,
+				sizeof(*chip), &card);
 	if (err < 0)
 		return err;
+	chip = card->private_data;
 
 	strcpy(card->driver, spdif_aclink ? "ATIIXP" : "ATIIXP-SPDMA");
 	strcpy(card->shortname, "ATI IXP");
-	if ((err = snd_atiixp_create(card, pci, &chip)) < 0)
-		goto __error;
-	card->private_data = chip;
+	err = snd_atiixp_init(card, pci);
+	if (err < 0)
+		return err;
 
-	if ((err = snd_atiixp_aclink_reset(chip)) < 0)
-		goto __error;
+	err = snd_atiixp_aclink_reset(chip);
+	if (err < 0)
+		return err;
 
 	chip->spdif_over_aclink = spdif_aclink;
 
-	if ((err = snd_atiixp_mixer_new(chip, ac97_clock, ac97_quirk)) < 0)
-		goto __error;
+	err = snd_atiixp_mixer_new(chip, ac97_clock, ac97_quirk);
+	if (err < 0)
+		return err;
 
-	if ((err = snd_atiixp_pcm_new(chip)) < 0)
-		goto __error;
+	err = snd_atiixp_pcm_new(chip);
+	if (err < 0)
+		return err;
 	
 	snd_atiixp_proc_init(chip);
 
@@ -1677,27 +1642,18 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 		 chip->ac97[0] ? snd_ac97_get_short_name(chip->ac97[0]) : "?",
 		 chip->addr, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0)
-		goto __error;
+	err = snd_card_register(card);
+	if (err < 0)
+		return err;
 
 	pci_set_drvdata(pci, card);
 	return 0;
-
- __error:
-	snd_card_free(card);
-	return err;
-}
-
-static void snd_atiixp_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
 }
 
 static struct pci_driver atiixp_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_atiixp_ids,
 	.probe = snd_atiixp_probe,
-	.remove = snd_atiixp_remove,
 	.driver = {
 		.pm = SND_ATIIXP_PM_OPS,
 	},
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index dc1de860cedf..207f2be1d73e 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1183,84 +1183,44 @@ static void snd_atiixp_proc_init(struct atiixp_modem *chip)
  * destructor
  */
 
-static int snd_atiixp_free(struct atiixp_modem *chip)
+static void snd_atiixp_free(struct snd_card *card)
 {
-	if (chip->irq < 0)
-		goto __hw_end;
-	snd_atiixp_chip_stop(chip);
-
-      __hw_end:
-	if (chip->irq >= 0)
-		free_irq(chip->irq, chip);
-	iounmap(chip->remap_addr);
-	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
-	kfree(chip);
-	return 0;
-}
-
-static int snd_atiixp_dev_free(struct snd_device *device)
-{
-	struct atiixp_modem *chip = device->device_data;
-	return snd_atiixp_free(chip);
+	snd_atiixp_chip_stop(card->private_data);
 }
 
 /*
  * constructor for chip instance
  */
-static int snd_atiixp_create(struct snd_card *card,
-			     struct pci_dev *pci,
-			     struct atiixp_modem **r_chip)
+static int snd_atiixp_init(struct snd_card *card, struct pci_dev *pci)
 {
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_atiixp_dev_free,
-	};
-	struct atiixp_modem *chip;
+	struct atiixp_modem *chip = card->private_data;
 	int err;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pcim_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
-
 	spin_lock_init(&chip->reg_lock);
 	mutex_init(&chip->open_mutex);
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
-	if ((err = pci_request_regions(pci, "ATI IXP MC97")) < 0) {
-		kfree(chip);
-		pci_disable_device(pci);
+	err = pcim_iomap_regions(pci, 1 << 0, "ATI IXP MC97");
+	if (err < 0)
 		return err;
-	}
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = pci_ioremap_bar(pci, 0);
-	if (chip->remap_addr == NULL) {
-		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_atiixp_free(chip);
-		return -EIO;
-	}
+	chip->remap_addr = pcim_iomap_table(pci)[0];
 
-	if (request_irq(pci->irq, snd_atiixp_interrupt, IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
+	if (devm_request_irq(&pci->dev, pci->irq, snd_atiixp_interrupt,
+			     IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_atiixp_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
+	card->private_free = snd_atiixp_free;
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_atiixp_free(chip);
-		return err;
-	}
-
-	*r_chip = chip;
 	return 0;
 }
 
@@ -1272,24 +1232,29 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	struct atiixp_modem *chip;
 	int err;
 
-	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
+	err = snd_devm_card_new(&pci->dev, index, id, THIS_MODULE,
+				sizeof(*chip), &card);
 	if (err < 0)
 		return err;
+	chip = card->private_data;
 
 	strcpy(card->driver, "ATIIXP-MODEM");
 	strcpy(card->shortname, "ATI IXP Modem");
-	if ((err = snd_atiixp_create(card, pci, &chip)) < 0)
-		goto __error;
-	card->private_data = chip;
+	err = snd_atiixp_init(card, pci);
+	if (err < 0)
+		return err;
 
-	if ((err = snd_atiixp_aclink_reset(chip)) < 0)
-		goto __error;
+	err = snd_atiixp_aclink_reset(chip);
+	if (err < 0)
+		return err;
 
-	if ((err = snd_atiixp_mixer_new(chip, ac97_clock)) < 0)
-		goto __error;
+	err = snd_atiixp_mixer_new(chip, ac97_clock);
+	if (err < 0)
+		return err;
 
-	if ((err = snd_atiixp_pcm_new(chip)) < 0)
-		goto __error;
+	err = snd_atiixp_pcm_new(chip);
+	if (err < 0)
+		return err;
 	
 	snd_atiixp_proc_init(chip);
 
@@ -1298,27 +1263,18 @@ static int snd_atiixp_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s rev %x at 0x%lx, irq %i",
 		card->shortname, pci->revision, chip->addr, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0)
-		goto __error;
+	err = snd_card_register(card);
+	if (err < 0)
+		return err;
 
 	pci_set_drvdata(pci, card);
 	return 0;
-
- __error:
-	snd_card_free(card);
-	return err;
-}
-
-static void snd_atiixp_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
 }
 
 static struct pci_driver atiixp_modem_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_atiixp_ids,
 	.probe = snd_atiixp_probe,
-	.remove = snd_atiixp_remove,
 	.driver = {
 		.pm = SND_ATIIXP_PM_OPS,
 	},
-- 
2.18.0
