From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: echoaudio: use after free on error
Date: Wed, 5 Mar 2014 14:07:15 +0300
Message-ID: <20140305110715.GB16926@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There are some places where we dereference "chip" in the error message
but we've already freed it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 166ec0c120d4..9f10c9e0df5e 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1990,8 +1990,8 @@ static int snd_echo_create(struct snd_card *card,
 
 	if ((chip->iores = request_mem_region(chip->dsp_registers_phys, sz,
 					      ECHOCARD_NAME)) == NULL) {
-		snd_echo_free(chip);
 		dev_err(chip->card->dev, "cannot get memory region\n");
+		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)
@@ -1999,8 +1999,8 @@ static int snd_echo_create(struct snd_card *card,
 
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_echo_free(chip);
 		dev_err(chip->card->dev, "cannot grab irq\n");
+		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
@@ -2012,8 +2012,8 @@ static int snd_echo_create(struct snd_card *card,
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
 				sizeof(struct comm_page),
 				&chip->commpage_dma_buf) < 0) {
-		snd_echo_free(chip);
 		dev_err(chip->card->dev, "cannot allocate the comm page\n");
+		snd_echo_free(chip);
 		return -ENOMEM;
 	}
 	chip->comm_page_phys = chip->commpage_dma_buf.addr;
@@ -2291,8 +2291,8 @@ static int snd_echo_resume(struct device *dev)
 
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_echo_free(chip);
 		dev_err(chip->card->dev, "cannot grab irq\n");
+		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
