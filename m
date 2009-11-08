From: Marin Mitov <mitov@issp.bas.bg>
Subject: [PATCH]Use DMA_BIT_MASK(32) instead of deprecated DMA_32BIT_MASK
Date: Sun, 8 Nov 2009 18:03:07 +0200
Message-ID: <200911081803.07386.mitov@issp.bas.bg>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754313AbZKHQEm@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Gloeckner <dg@emlix.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Use DMA_BIT_MASK(32) instead of deprecated DMA_32BIT_MASK

Signed-off-by: Marin Mitov <mitov@issp.bas.bg>

=========================================================
--- sound/soc/s6000/s6000-pcm.c.orig	2009-11-08 17:49:09.000000000 +0200
+++ sound/soc/s6000/s6000-pcm.c	2009-11-08 17:50:56.000000000 +0200
@@ -423,7 +423,7 @@
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
-static u64 s6000_pcm_dmamask = DMA_32BIT_MASK;
+static u64 s6000_pcm_dmamask = DMA_BIT_MASK(32);
 
 static int s6000_pcm_new(struct snd_card *card,
 			 struct snd_soc_dai *dai, struct snd_pcm *pcm)
@@ -435,7 +435,7 @@
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &s6000_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-		card->dev->coherent_dma_mask = DMA_32BIT_MASK;
+		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
 	if (params->dma_in) {
 		s6dmac_disable_chan(DMA_MASK_DMAC(params->dma_in),
