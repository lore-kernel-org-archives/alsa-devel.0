From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 3/5] ALSA: intel8x0: Allocate resources
	with device-managed APIs
Date: Thu, 13 Sep 2018 08:05:25 +0200
Message-ID: <20180913060527.24694-4-tiwai@suse.de>
References: <20180913060527.24694-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 044A326781A
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 08:05:31 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 34616AFF6
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

This patch refactors the intel8x0 and intel8x0m driver codes using
devres and gets rid of the driver remove callback.

The conversion is fairly straightforward: each API call is replaced
with the device-managed API function, e.g. pci_enable_device() ->
pcim_enable_device(), and so on.  The buffer descriptor list is
allocated with a new API, snd_devm_alloc_pages().

A slight code structure change is that the intel8x0 object is
allocated as a card's private_data instead of the own lowlevel
snd_device object.  This simplifies the resource management.
And, the take-down procedure is triggered via card->private_free, and
it's registered at the end of the whole initialization, i.e. after the
all resources get properly managed.

The only not-devres-managed resource is the irq handler.  Since we
need to release at suspend and re-acquire at resume (otherwise
something weird happens on some machines), this is still managed
manually.  But the rest are all freed automatically.

The end result is a good amount of code reduction.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/intel8x0.c  | 143 ++++++++++++++----------------------------
 sound/pci/intel8x0m.c | 143 ++++++++++++++----------------------------
 2 files changed, 92 insertions(+), 194 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 9517f9b8f1d4..662d5c9109f5 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -415,7 +415,7 @@ struct intel8x0 {
 	spinlock_t reg_lock;
 	
 	u32 bdbars_count;
-	struct snd_dma_buffer bdbars;
+	struct snd_dma_buffer *bdbars;
 	u32 int_sta_reg;		/* interrupt status register */
 	u32 int_sta_mask;		/* interrupt status mask */
 };
@@ -2567,8 +2567,9 @@ static int snd_intel8x0_chip_init(struct intel8x0 *chip, int probing)
 	return 0;
 }
 
-static int snd_intel8x0_free(struct intel8x0 *chip)
+static void snd_intel8x0_free(struct snd_card *card)
 {
+	struct intel8x0 *chip = card->private_data;
 	unsigned int i;
 
 	if (chip->irq < 0)
@@ -2591,16 +2592,6 @@ static int snd_intel8x0_free(struct intel8x0 *chip)
       __hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	if (chip->bdbars.area)
-		snd_dma_free_pages(&chip->bdbars);
-	if (chip->addr)
-		pci_iounmap(chip->pci, chip->addr);
-	if (chip->bmaddr)
-		pci_iounmap(chip->pci, chip->bmaddr);
-	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
-	kfree(chip);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2871,12 +2862,6 @@ static void snd_intel8x0_proc_init(struct intel8x0 *chip)
 		snd_info_set_text_ops(entry, chip, snd_intel8x0_proc_read);
 }
 
-static int snd_intel8x0_dev_free(struct snd_device *device)
-{
-	struct intel8x0 *chip = device->device_data;
-	return snd_intel8x0_free(chip);
-}
-
 struct ich_reg_info {
 	unsigned int int_sta_mask;
 	unsigned int offset;
@@ -2920,19 +2905,15 @@ static int snd_intel8x0_inside_vm(struct pci_dev *pci)
 	return result;
 }
 
-static int snd_intel8x0_create(struct snd_card *card,
-			       struct pci_dev *pci,
-			       unsigned long device_type,
-			       struct intel8x0 **r_intel8x0)
+static int snd_intel8x0_init(struct snd_card *card,
+			     struct pci_dev *pci,
+			     unsigned long device_type)
 {
-	struct intel8x0 *chip;
+	struct intel8x0 *chip = card->private_data;
 	int err;
 	unsigned int i;
 	unsigned int int_sta_masks;
 	struct ichdev *ichdev;
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_intel8x0_dev_free,
-	};
 
 	static unsigned int bdbars[] = {
 		3, /* DEVICE_INTEL */
@@ -2965,16 +2946,10 @@ static int snd_intel8x0_create(struct snd_card *card,
 	};
 	struct ich_reg_info *tbl;
 
-	*r_intel8x0 = NULL;
-
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pcim_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
 	spin_lock_init(&chip->reg_lock);
 	chip->device_type = device_type;
 	chip->card = card;
@@ -2999,38 +2974,24 @@ static int snd_intel8x0_create(struct snd_card *card,
 	    pci->device == PCI_DEVICE_ID_INTEL_440MX)
 		chip->fix_nocache = 1; /* enable workaround */
 
-	if ((err = pci_request_regions(pci, card->shortname)) < 0) {
-		kfree(chip);
-		pci_disable_device(pci);
+	err = pcim_iomap_regions(pci, -1, card->shortname);
+	if (err < 0)
 		return err;
-	}
 
 	if (device_type == DEVICE_ALI) {
 		/* ALI5455 has no ac97 region */
-		chip->bmaddr = pci_iomap(pci, 0, 0);
-		goto port_inited;
-	}
-
-	if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) /* ICH4 and Nforce */
-		chip->addr = pci_iomap(pci, 2, 0);
-	else
-		chip->addr = pci_iomap(pci, 0, 0);
-	if (!chip->addr) {
-		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_intel8x0_free(chip);
-		return -EIO;
+		chip->bmaddr = pcim_iomap_table(pci)[0];
+	} else {
+		if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) /* ICH4 and Nforce */
+			chip->addr = pcim_iomap_table(pci)[2];
+		else
+			chip->addr = pcim_iomap_table(pci)[0];
+		if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
+			chip->bmaddr = pcim_iomap_table(pci)[3];
+		else
+			chip->bmaddr = pcim_iomap_table(pci)[1];
 	}
-	if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
-		chip->bmaddr = pci_iomap(pci, 3, 0);
-	else
-		chip->bmaddr = pci_iomap(pci, 1, 0);
 
- port_inited:
-	if (!chip->bmaddr) {
-		dev_err(card->dev, "Controller space ioremap problem\n");
-		snd_intel8x0_free(chip);
-		return -EIO;
-	}
 	chip->bdbars_count = bdbars[device_type];
 
 	/* initialize offsets */
@@ -3066,10 +3027,10 @@ static int snd_intel8x0_create(struct snd_card *card,
 
 	/* allocate buffer descriptor lists */
 	/* the start of each lists must be aligned to 8 bytes */
-	if (snd_dma_alloc_pages(intel8x0_dma_type(chip), snd_dma_pci_data(pci),
-				chip->bdbars_count * sizeof(u32) * ICH_MAX_FRAGS * 2,
-				&chip->bdbars) < 0) {
-		snd_intel8x0_free(chip);
+	chip->bdbars = snd_devm_alloc_pages(&pci->dev, intel8x0_dma_type(chip),
+					    chip->bdbars_count * sizeof(u32) *
+					    ICH_MAX_FRAGS * 2);
+	if (IS_ERR(chip->bdbars)) {
 		dev_err(card->dev, "cannot allocate buffer descriptors\n");
 		return -ENOMEM;
 	}
@@ -3078,9 +3039,9 @@ static int snd_intel8x0_create(struct snd_card *card,
 	int_sta_masks = 0;
 	for (i = 0; i < chip->bdbars_count; i++) {
 		ichdev = &chip->ichd[i];
-		ichdev->bdbar = ((__le32 *)chip->bdbars.area) +
+		ichdev->bdbar = ((__le32 *)chip->bdbars->area) +
 			(i * ICH_MAX_FRAGS * 2);
-		ichdev->bdbar_addr = chip->bdbars.addr +
+		ichdev->bdbar_addr = chip->bdbars->addr +
 			(i * sizeof(u32) * ICH_MAX_FRAGS * 2);
 		int_sta_masks |= ichdev->int_sta_mask;
 	}
@@ -3113,26 +3074,23 @@ static int snd_intel8x0_create(struct snd_card *card,
 	for (i = 0; i < chip->max_codecs; i++)
 		chip->codec_isr_bits |= chip->codec_bit[i];
 
-	if ((err = snd_intel8x0_chip_init(chip, 1)) < 0) {
-		snd_intel8x0_free(chip);
+	err = snd_intel8x0_chip_init(chip, 1);
+	if (err < 0)
 		return err;
-	}
 
 	/* request irq after initializaing int_sta_mask, etc */
+	/* NOTE: we don't use devm version here since it's released /
+	 * re-acquired in PM callbacks.
+	 * It's released explicitly in snd_intel8x0_free(), too.
+	 */
 	if (request_irq(pci->irq, snd_intel8x0_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
+	card->private_free = snd_intel8x0_free;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_intel8x0_free(chip);
-		return err;
-	}
-
-	*r_intel8x0 = chip;
 	return 0;
 }
 
@@ -3198,9 +3156,11 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 	int err;
 	struct shortname_table *name;
 
-	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
+	err = snd_devm_card_new(&pci->dev, index, id, THIS_MODULE,
+				sizeof(*chip), &card);
 	if (err < 0)
 		return err;
+	chip = card->private_data;
 
 	if (spdif_aclink < 0)
 		spdif_aclink = check_default_spdif_aclink(pci);
@@ -3234,21 +3194,16 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 			buggy_irq = 0;
 	}
 
-	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data,
-				       &chip)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0_init(card, pci, pci_id->driver_data);
+	if (err < 0)
 		return err;
-	}
-	card->private_data = chip;
 
-	if ((err = snd_intel8x0_mixer(chip, ac97_clock, ac97_quirk)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0_mixer(chip, ac97_clock, ac97_quirk);
+	if (err < 0)
 		return err;
-	}
-	if ((err = snd_intel8x0_pcm(chip)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0_pcm(chip);
+	if (err < 0)
 		return err;
-	}
 	
 	snd_intel8x0_proc_init(chip);
 
@@ -3265,24 +3220,18 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 		}
 	}
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
+	err = snd_card_register(card);
+	if (err < 0)
 		return err;
-	}
+
 	pci_set_drvdata(pci, card);
 	return 0;
 }
 
-static void snd_intel8x0_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
-}
-
 static struct pci_driver intel8x0_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_intel8x0_ids,
 	.probe = snd_intel8x0_probe,
-	.remove = snd_intel8x0_remove,
 	.driver = {
 		.pm = INTEL8X0_PM_OPS,
 	},
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index c84629190cba..22fc834f48c0 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -212,7 +212,7 @@ struct intel8x0m {
 
 	spinlock_t reg_lock;
 	
-	struct snd_dma_buffer bdbars;
+	struct snd_dma_buffer *bdbars;
 	u32 bdbars_count;
 	u32 int_sta_reg;		/* interrupt status register */
 	u32 int_sta_mask;		/* interrupt status mask */
@@ -990,8 +990,9 @@ static int snd_intel8x0m_chip_init(struct intel8x0m *chip, int probing)
 	return 0;
 }
 
-static int snd_intel8x0m_free(struct intel8x0m *chip)
+static void snd_intel8x0m_free(struct snd_card *card)
 {
+	struct intel8x0m *chip = card->private_data;
 	unsigned int i;
 
 	if (chip->irq < 0)
@@ -1005,16 +1006,6 @@ static int snd_intel8x0m_free(struct intel8x0m *chip)
  __hw_end:
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	if (chip->bdbars.area)
-		snd_dma_free_pages(&chip->bdbars);
-	if (chip->addr)
-		pci_iounmap(chip->pci, chip->addr);
-	if (chip->bmaddr)
-		pci_iounmap(chip->pci, chip->bmaddr);
-	pci_release_regions(chip->pci);
-	pci_disable_device(chip->pci);
-	kfree(chip);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1093,84 +1084,54 @@ static void snd_intel8x0m_proc_init(struct intel8x0m *chip)
 		snd_info_set_text_ops(entry, chip, snd_intel8x0m_proc_read);
 }
 
-static int snd_intel8x0m_dev_free(struct snd_device *device)
-{
-	struct intel8x0m *chip = device->device_data;
-	return snd_intel8x0m_free(chip);
-}
-
 struct ich_reg_info {
 	unsigned int int_sta_mask;
 	unsigned int offset;
 };
 
-static int snd_intel8x0m_create(struct snd_card *card,
-				struct pci_dev *pci,
-				unsigned long device_type,
-				struct intel8x0m **r_intel8x0m)
+static int snd_intel8x0m_init(struct snd_card *card,
+			      struct pci_dev *pci,
+			      unsigned long device_type)
 {
-	struct intel8x0m *chip;
+	struct intel8x0m *chip = card->private_data;
 	int err;
 	unsigned int i;
 	unsigned int int_sta_masks;
 	struct ichdev *ichdev;
-	static struct snd_device_ops ops = {
-		.dev_free =	snd_intel8x0m_dev_free,
-	};
 	static struct ich_reg_info intel_regs[2] = {
 		{ ICH_MIINT, 0 },
 		{ ICH_MOINT, 0x10 },
 	};
 	struct ich_reg_info *tbl;
 
-	*r_intel8x0m = NULL;
-
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pcim_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
 	spin_lock_init(&chip->reg_lock);
 	chip->device_type = device_type;
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
 
-	if ((err = pci_request_regions(pci, card->shortname)) < 0) {
-		kfree(chip);
-		pci_disable_device(pci);
+	err = pcim_iomap_regions(pci, -1, card->shortname);
+	if (err < 0)
 		return err;
-	}
 
 	if (device_type == DEVICE_ALI) {
 		/* ALI5455 has no ac97 region */
-		chip->bmaddr = pci_iomap(pci, 0, 0);
-		goto port_inited;
-	}
-
-	if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) /* ICH4 and Nforce */
-		chip->addr = pci_iomap(pci, 2, 0);
-	else
-		chip->addr = pci_iomap(pci, 0, 0);
-	if (!chip->addr) {
-		dev_err(card->dev, "AC'97 space ioremap problem\n");
-		snd_intel8x0m_free(chip);
-		return -EIO;
-	}
-	if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
-		chip->bmaddr = pci_iomap(pci, 3, 0);
-	else
-		chip->bmaddr = pci_iomap(pci, 1, 0);
-	if (!chip->bmaddr) {
-		dev_err(card->dev, "Controller space ioremap problem\n");
-		snd_intel8x0m_free(chip);
-		return -EIO;
+		chip->bmaddr = pcim_iomap_table(pci)[0];
+	} else {
+		if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) /* ICH4 and Nforce */
+			chip->addr = pcim_iomap_table(pci)[2];
+		else
+			chip->addr = pcim_iomap_table(pci)[0];
+		if (pci_resource_flags(pci, 3) & IORESOURCE_MEM) /* ICH4 */
+			chip->bmaddr = pcim_iomap_table(pci)[3];
+		else
+			chip->bmaddr = pcim_iomap_table(pci)[1];
 	}
 
- port_inited:
 	/* initialize offsets */
 	chip->bdbars_count = 2;
 	tbl = intel_regs;
@@ -1196,19 +1157,19 @@ static int snd_intel8x0m_create(struct snd_card *card,
 
 	/* allocate buffer descriptor lists */
 	/* the start of each lists must be aligned to 8 bytes */
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				chip->bdbars_count * sizeof(u32) * ICH_MAX_FRAGS * 2,
-				&chip->bdbars) < 0) {
-		snd_intel8x0m_free(chip);
+	chip->bdbars = snd_devm_alloc_pages(&pci->dev, SNDRV_DMA_TYPE_DEV,
+					    chip->bdbars_count * sizeof(u32) *
+					    ICH_MAX_FRAGS * 2);
+	if (IS_ERR(chip->bdbars))
 		return -ENOMEM;
-	}
+
 	/* tables must be aligned to 8 bytes here, but the kernel pages
 	   are much bigger, so we don't care (on i386) */
 	int_sta_masks = 0;
 	for (i = 0; i < chip->bdbars_count; i++) {
 		ichdev = &chip->ichd[i];
-		ichdev->bdbar = ((__le32 *)chip->bdbars.area) + (i * ICH_MAX_FRAGS * 2);
-		ichdev->bdbar_addr = chip->bdbars.addr + (i * sizeof(u32) * ICH_MAX_FRAGS * 2);
+		ichdev->bdbar = ((__le32 *)chip->bdbars->area) + (i * ICH_MAX_FRAGS * 2);
+		ichdev->bdbar_addr = chip->bdbars->addr + (i * sizeof(u32) * ICH_MAX_FRAGS * 2);
 		int_sta_masks |= ichdev->int_sta_mask;
 	}
 	chip->int_sta_reg = ICH_REG_GLOB_STA;
@@ -1216,25 +1177,22 @@ static int snd_intel8x0m_create(struct snd_card *card,
 
 	pci_set_master(pci);
 
-	if ((err = snd_intel8x0m_chip_init(chip, 1)) < 0) {
-		snd_intel8x0m_free(chip);
+	err = snd_intel8x0m_chip_init(chip, 1);
+	if (err < 0)
 		return err;
-	}
 
+	/* NOTE: we don't use devm version here since it's released /
+	 * re-acquired in PM callbacks.
+	 * It's released explicitly in snd_intel8x0m_free(), too.
+	 */
 	if (request_irq(pci->irq, snd_intel8x0m_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_intel8x0m_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
+	card->private_free = snd_intel8x0m_free;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_intel8x0m_free(chip);
-		return err;
-	}
-
-	*r_intel8x0m = chip;
 	return 0;
 }
 
@@ -1272,9 +1230,11 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	int err;
 	struct shortname_table *name;
 
-	err = snd_card_new(&pci->dev, index, id, THIS_MODULE, 0, &card);
+	err = snd_devm_card_new(&pci->dev, index, id, THIS_MODULE,
+				sizeof(*chip), &card);
 	if (err < 0)
 		return err;
+	chip = card->private_data;
 
 	strcpy(card->driver, "ICH-MODEM");
 	strcpy(card->shortname, "Intel ICH");
@@ -1286,44 +1246,33 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	}
 	strcat(card->shortname," Modem");
 
-	if ((err = snd_intel8x0m_create(card, pci, pci_id->driver_data, &chip)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0m_init(card, pci, pci_id->driver_data);
+	if (err < 0)
 		return err;
-	}
-	card->private_data = chip;
 
-	if ((err = snd_intel8x0m_mixer(chip, ac97_clock)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0m_mixer(chip, ac97_clock);
+	if (err < 0)
 		return err;
-	}
-	if ((err = snd_intel8x0m_pcm(chip)) < 0) {
-		snd_card_free(card);
+	err = snd_intel8x0m_pcm(chip);
+	if (err < 0)
 		return err;
-	}
 	
 	snd_intel8x0m_proc_init(chip);
 
 	sprintf(card->longname, "%s at irq %i",
 		card->shortname, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
+	err = snd_card_register(card);
+	if (err < 0)
 		return err;
-	}
 	pci_set_drvdata(pci, card);
 	return 0;
 }
 
-static void snd_intel8x0m_remove(struct pci_dev *pci)
-{
-	snd_card_free(pci_get_drvdata(pci));
-}
-
 static struct pci_driver intel8x0m_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_intel8x0m_ids,
 	.probe = snd_intel8x0m_probe,
-	.remove = snd_intel8x0m_remove,
 	.driver = {
 		.pm = INTEL8X0M_PM_OPS,
 	},
-- 
2.18.0
