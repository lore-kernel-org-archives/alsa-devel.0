From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda: Allocate resources with
	device-managed APIs
Date: Thu, 20 Sep 2018 17:55:00 +0200
Message-ID: <20180920155502.7534-6-tiwai@suse.de>
References: <20180920155502.7534-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C089267891
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 17:55:07 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 642A3B003
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 15:55:05 +0000 (UTC)
In-Reply-To: <20180920155502.7534-1-tiwai@suse.de>
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

This patch is an attempt to slightly simplify the resource management
in HD-audio code, by using some device-managed APIs.  A few resources
like PCI enablement, PCI resources and the card object are managed via
devres now.  But most of codes dealing with HD-audio core stuff
couldn't be changed so much, hence the changes in this patch are
pretty small in the end.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_controller.h |  1 -
 sound/pci/hda/hda_intel.c      | 43 ++++++++--------------------------
 2 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c95097bb5a0c..16f2285847b3 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -156,7 +156,6 @@ struct azx {
 	unsigned int snoop:1;
 	unsigned int uc_buffer:1; /* non-cached pages for stream buffers */
 	unsigned int align_buffer_size:1;
-	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
 
 	/* GTS present */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4e64595b381b..7a697db7a6a0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1318,18 +1318,11 @@ static int azx_free(struct azx *chip)
 
 	if (bus->irq >= 0)
 		free_irq(bus->irq, (void*)chip);
-	if (chip->msi)
-		pci_disable_msi(chip->pci);
-	iounmap(bus->remap_addr);
 
 	azx_free_stream_pages(chip);
 	azx_free_streams(chip);
 	snd_hdac_bus_exit(bus);
 
-	if (chip->region_requested)
-		pci_release_regions(chip->pci);
-
-	pci_disable_device(chip->pci);
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
 	release_firmware(chip->fw);
 #endif
@@ -1657,15 +1650,13 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 
 	*rchip = NULL;
 
-	err = pci_enable_device(pci);
+	err = pcim_enable_device(pci);
 	if (err < 0)
 		return err;
 
 	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
-	if (!hda) {
-		pci_disable_device(pci);
+	if (!hda)
 		return -ENOMEM;
-	}
 
 	chip = &hda->chip;
 	mutex_init(&chip->open_mutex);
@@ -1707,7 +1698,6 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	err = azx_bus_init(chip, model[dev], &pci_hda_io_ops);
 	if (err < 0) {
 		kfree(hda);
-		pci_disable_device(pci);
 		return err;
 	}
 
@@ -1751,17 +1741,12 @@ static int azx_first_init(struct azx *chip)
 	}
 #endif
 
-	err = pci_request_regions(pci, "ICH HD audio");
+	err = pcim_iomap_regions(pci, 1 << 0, "ICH HD audio");
 	if (err < 0)
 		return err;
-	chip->region_requested = 1;
 
 	bus->addr = pci_resource_start(pci, 0);
-	bus->remap_addr = pci_ioremap_bar(pci, 0);
-	if (bus->remap_addr == NULL) {
-		dev_err(card->dev, "ioremap error\n");
-		return -ENXIO;
-	}
+	bus->remap_addr = pcim_iomap_table(pci)[0];
 
 	if (chip->driver_type == AZX_DRIVER_SKL)
 		snd_hdac_bus_parse_capabilities(bus);
@@ -2057,16 +2042,14 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENOENT;
 	}
 
-	err = snd_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE,
-			   0, &card);
-	if (err < 0) {
-		dev_err(&pci->dev, "Error creating card!\n");
+	err = snd_devm_card_new(&pci->dev, index[dev], id[dev], THIS_MODULE, 0,
+				&card);
+	if (err < 0)
 		return err;
-	}
 
 	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
 	if (err < 0)
-		goto out_free;
+		return err;
 	card->private_data = chip;
 	hda = container_of(chip, struct hda_intel, chip);
 
@@ -2075,7 +2058,7 @@ static int azx_probe(struct pci_dev *pci,
 	err = register_vga_switcheroo(chip);
 	if (err < 0) {
 		dev_err(card->dev, "Error registering vga_switcheroo client\n");
-		goto out_free;
+		return err;
 	}
 
 	if (check_hdmi_disabled(pci)) {
@@ -2094,7 +2077,7 @@ static int azx_probe(struct pci_dev *pci,
 					      &pci->dev, GFP_KERNEL, card,
 					      azx_firmware_cb);
 		if (err < 0)
-			goto out_free;
+			return err;
 		schedule_probe = false; /* continued in azx_firmware_cb() */
 	}
 #endif /* CONFIG_SND_HDA_PATCH_LOADER */
@@ -2111,10 +2094,6 @@ static int azx_probe(struct pci_dev *pci,
 	if (chip->disabled)
 		complete_all(&hda->probe_wait);
 	return 0;
-
-out_free:
-	snd_card_free(card);
-	return err;
 }
 
 #ifdef CONFIG_PM
@@ -2304,8 +2283,6 @@ static void azx_remove(struct pci_dev *pci)
 		device_unlock(&pci->dev);
 		cancel_work_sync(&hda->probe_work);
 		device_lock(&pci->dev);
-
-		snd_card_free(card);
 	}
 }
 
-- 
2.18.0
