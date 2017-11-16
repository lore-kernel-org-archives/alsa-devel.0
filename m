From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: pcxhr: Use common error handling
 code in pcxhr_probe()
Date: Thu, 16 Nov 2017 22:28:11 +0100
Message-ID: <5860adfd-3357-68ba-5508-96fde59faf5f@users.sourceforge.net>
References: <c110ba76-d99d-9f80-d927-14d437115004@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BCA126779C
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 22:28:26 +0100 (CET)
In-Reply-To: <c110ba76-d99d-9f80-d927-14d437115004@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 22:11:52 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/pcxhr/pcxhr.c | 62 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index c490d7e57ff7..f05c6a042890 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1541,21 +1541,21 @@ static int pcxhr_probe(struct pci_dev *pci,
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) {
 		dev_err(&pci->dev,
 			"architecture does not support 32bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-		return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
 	}
 
 	/* alloc card manager */
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-	if (! mgr) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+	if (!mgr) {
+		err = -ENOMEM;
+		goto disable_device;
 	}
 
 	if (snd_BUG_ON(pci_id->driver_data >= PCI_ID_LAST)) {
 		kfree(mgr);
-		pci_disable_device(pci);
-		return -ENODEV;
+		err = -ENODEV;
+		goto disable_device;
 	}
 	card_name =
 		pcxhr_board_params[pci_id->driver_data].board_name;
@@ -1581,8 +1581,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 	err = pci_request_regions(pci, card_name);
 	if (err < 0) {
 		kfree(mgr);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	for (i = 0; i < 3; i++)
 		mgr->port[i] = pci_resource_start(pci, i);
@@ -1594,8 +1593,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 				 pcxhr_threaded_irq, IRQF_SHARED,
 				 KBUILD_MODNAME, mgr)) {
 		dev_err(&pci->dev, "unable to grab IRQ %d\n", pci->irq);
-		pcxhr_free(mgr);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_manager;
 	}
 	mgr->irq = pci->irq;
 
@@ -1614,10 +1613,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS -
 					   PCXHR_SIZE_MAX_STATUS),
 			    GFP_KERNEL);
-	if (! mgr->prmh) {
-		pcxhr_free(mgr);
-		return -ENOMEM;
-	}
+	if (!mgr->prmh)
+		goto e_nomem;
 
 	for (i=0; i < PCXHR_MAX_CARDS; i++) {
 		struct snd_card *card;
@@ -1640,8 +1637,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 
 		if (err < 0) {
 			dev_err(&pci->dev, "cannot allocate the card %d\n", i);
-			pcxhr_free(mgr);
-			return err;
+			goto free_manager;
 		}
 
 		strcpy(card->driver, DRIVER_NAME);
@@ -1653,8 +1649,7 @@ static int pcxhr_probe(struct pci_dev *pci,
 		err = pcxhr_create(mgr, card, i);
 		if (err < 0) {
 			snd_card_free(card);
-			pcxhr_free(mgr);
-			return err;
+			goto free_manager;
 		}
 
 		if (i == 0)
@@ -1662,32 +1657,37 @@ static int pcxhr_probe(struct pci_dev *pci,
 			pcxhr_proc_init(mgr->chip[i]);
 
 		err = snd_card_register(card);
-		if (err < 0) {
-			pcxhr_free(mgr);
-			return err;
-		}
+		if (err < 0)
+			goto free_manager;
 	}
 
 	/* create hostport purgebuffer */
 	size = PAGE_ALIGN(sizeof(struct pcxhr_hostport));
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				size, &mgr->hostport) < 0) {
-		pcxhr_free(mgr);
-		return -ENOMEM;
-	}
+				size, &mgr->hostport) < 0)
+		goto e_nomem;
+
 	/* init purgebuffer */
 	memset(mgr->hostport.area, 0, size);
 
 	/* create a DSP loader */
 	err = pcxhr_setup_firmware(mgr);
-	if (err < 0) {
-		pcxhr_free(mgr);
-		return err;
-	}
+	if (err < 0)
+		goto free_manager;
 
 	pci_set_drvdata(pci, mgr);
 	dev++;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_nomem:
+	err = -ENOMEM;
+free_manager:
+	pcxhr_free(mgr);
+	return err;
 }
 
 static void pcxhr_remove(struct pci_dev *pci)
-- 
2.15.0
