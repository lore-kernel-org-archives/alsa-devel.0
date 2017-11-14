From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: es1938: Use common error handling
 code in snd_es1938_create()
Date: Tue, 14 Nov 2017 21:38:28 +0100
Message-ID: <08c88cad-b4cf-948a-e990-390617503ffd@users.sourceforge.net>
References: <afd9d456-ae8e-b2f6-a682-a27c1fa4209b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FDE8267500
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 21:38:31 +0100 (CET)
In-Reply-To: <afd9d456-ae8e-b2f6-a682-a27c1fa4209b@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 21:25:55 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1938.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index b19e611345d1..2b4dd1297bbc 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1606,14 +1606,14 @@ static int snd_es1938_create(struct snd_card *card,
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(24)) < 0) {
 		dev_err(card->dev,
 			"architecture does not support 24bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-                return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
         }
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&chip->reg_lock);
 	spin_lock_init(&chip->mixer_lock);
@@ -1623,8 +1623,7 @@ static int snd_es1938_create(struct snd_card *card,
 	err = pci_request_regions(pci, "ESS Solo-1");
 	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->io_port = pci_resource_start(pci, 0);
 	chip->sb_port = pci_resource_start(pci, 1);
@@ -1634,8 +1633,8 @@ static int snd_es1938_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_es1938_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_es1938_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_sound_chip;
 	}
 	chip->irq = pci->irq;
 	dev_dbg(card->dev,
@@ -1647,13 +1646,19 @@ static int snd_es1938_create(struct snd_card *card,
 	snd_es1938_chip_init(chip);
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_es1938_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	*rchip = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+free_sound_chip:
+	snd_es1938_free(chip);
+	return err;
 }
 
 /* --------------------------------------------------------------------
-- 
2.15.0
