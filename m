From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 43/48] ALSA: rme9652: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:45 +0100
Message-ID: <1393430030-26704-44-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FE452657E5
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 03D0B7502A
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:54 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
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

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/rme9652.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index a62d6e13d8ce..1d9be90f7748 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -394,7 +394,9 @@ static snd_pcm_uframes_t rme9652_hw_pointer(struct snd_rme9652 *rme9652)
 	if (offset < period_size) {
 		if (offset > rme9652->max_jitter) {
 			if (frag)
-				printk(KERN_ERR "Unexpected hw_pointer position (bufid == 0): status: %x offset: %d\n", status, offset);
+				dev_err(rme9652->card->dev,
+					"Unexpected hw_pointer position (bufid == 0): status: %x offset: %d\n",
+					status, offset);
 		} else if (!frag)
 			return 0;
 		offset -= rme9652->max_jitter;
@@ -403,7 +405,9 @@ static snd_pcm_uframes_t rme9652_hw_pointer(struct snd_rme9652 *rme9652)
 	} else {
 		if (offset > period_size + rme9652->max_jitter) {
 			if (!frag)
-				printk(KERN_ERR "Unexpected hw_pointer position (bufid == 1): status: %x offset: %d\n", status, offset);
+				dev_err(rme9652->card->dev,
+					"Unexpected hw_pointer position (bufid == 1): status: %x offset: %d\n",
+					status, offset);
 		} else if (frag)
 			return period_size;
 		offset -= rme9652->max_jitter;
@@ -769,7 +773,8 @@ static inline int rme9652_spdif_sample_rate(struct snd_rme9652 *s)
 		break;
 
 	default:
-		snd_printk(KERN_ERR "%s: unknown S/PDIF input rate (bits = 0x%x)\n",
+		dev_err(s->card->dev,
+			"%s: unknown S/PDIF input rate (bits = 0x%x)\n",
 			   s->card_name, rate_bits);
 		return 0;
 		break;
@@ -1790,7 +1795,8 @@ static int snd_rme9652_initialize_memory(struct snd_rme9652 *rme9652)
 	    snd_hammerfall_get_buffer(rme9652->pci, &rme9652->playback_dma_buf, RME9652_DMA_AREA_BYTES) < 0) {
 		if (rme9652->capture_dma_buf.area)
 			snd_dma_free_pages(&rme9652->capture_dma_buf);
-		printk(KERN_ERR "%s: no buffers available\n", rme9652->card_name);
+		dev_err(rme9652->card->dev,
+			"%s: no buffers available\n", rme9652->card_name);
 		return -ENOMEM;
 	}
 
@@ -2468,13 +2474,14 @@ static int snd_rme9652_create(struct snd_card *card,
 	rme9652->port = pci_resource_start(pci, 0);
 	rme9652->iobase = ioremap_nocache(rme9652->port, RME9652_IO_EXTENT);
 	if (rme9652->iobase == NULL) {
-		snd_printk(KERN_ERR "unable to remap region 0x%lx-0x%lx\n", rme9652->port, rme9652->port + RME9652_IO_EXTENT - 1);
+		dev_err(card->dev, "unable to remap region 0x%lx-0x%lx\n",
+			rme9652->port, rme9652->port + RME9652_IO_EXTENT - 1);
 		return -EBUSY;
 	}
 	
 	if (request_irq(pci->irq, snd_rme9652_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, rme9652)) {
-		snd_printk(KERN_ERR "unable to request IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to request IRQ %d\n", pci->irq);
 		return -EBUSY;
 	}
 	rme9652->irq = pci->irq;
-- 
1.9.0
