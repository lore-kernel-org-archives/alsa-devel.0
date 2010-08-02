From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] asoc/multi-component: fsl: add support for
	36-bit physical addresses
Date: Mon, 2 Aug 2010 12:44:36 -0500
Message-ID: <1280771076-8630-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
	[65.55.88.11]) by alsa0.perex.cz (Postfix) with ESMTP id A9299103825
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 19:44:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Update the DMA driver used by the Freescale MPC8610 HPCD audio driver to
support 36-bit physical addresses, for both DMA buffers and the SSI registers.

The DMA driver calls snd_dma_alloc_pages() to allocate the DMA buffers for
playback and capture.  This function is just a front-end for
dma_alloc_coherent().  Currently, dma_alloc_coherent() only allocates buffers
in low memory (it ignores GFP_HIGHMEM), so we never actually get a DMA buffer
with a real 36-bit physical address.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Liam, this patch should *not* be squashed into the rest of the changes for
multi-component.

 sound/soc/fsl/fsl_dma.c |   77 +++++++++++++++++++++++++++++++----------------
 1 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index d09e194..4450f9d 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -175,13 +175,23 @@ static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
 	struct fsl_dma_link_descriptor *link =
 		&dma_private->link[dma_private->current_link];
 
-	/* Update our link descriptors to point to the next period */
-	if (dma_private->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		link->source_addr =
-			cpu_to_be32(dma_private->dma_buf_next);
-	else
-		link->dest_addr =
-			cpu_to_be32(dma_private->dma_buf_next);
+	/* Update our link descriptors to point to the next period. On a 36-bit
+	 * system, we also need to update the ESAD bits.  We also set (keep) the
+	 * snoop bits.  See the comments in fsl_dma_hw_params() about snooping.
+	 */
+	if (dma_private->substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		link->source_addr = cpu_to_be32(dma_private->dma_buf_next);
+#ifdef CONFIG_PHYS_64BIT
+		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
+			upper_32_bits(dma_private->dma_buf_next));
+#endif
+	} else {
+		link->dest_addr = cpu_to_be32(dma_private->dma_buf_next);
+#ifdef CONFIG_PHYS_64BIT
+		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
+			upper_32_bits(dma_private->dma_buf_next));
+#endif
+	}
 
 	/* Update our variables for next time */
 	dma_private->dma_buf_next += dma_private->period_size;
@@ -273,11 +283,19 @@ static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
  * This function is called when the codec driver calls snd_soc_new_pcms(),
  * once for each .dai_link in the machine driver's snd_soc_card
  * structure.
+ *
+ * snd_dma_alloc_pages() is just a front-end to dma_alloc_coherent(), which
+ * (currently) always allocates the DMA buffer in lowmem, even if GFP_HIGHMEM
+ * is specified. Therefore, any DMA buffers we allocate will always be in low
+ * memory, but we support for 36-bit physical addresses anyway.
+ *
+ * Regardless of where the memory is actually allocated, since the device can
+ * technically DMA to any 36-bit address, we do need to set the DMA mask to 36.
  */
 static int fsl_dma_new(struct snd_card *card, struct snd_soc_dai *dai,
 	struct snd_pcm *pcm)
 {
-	static u64 fsl_dma_dmamask = DMA_BIT_MASK(32);
+	static u64 fsl_dma_dmamask = DMA_BIT_MASK(36);
 	int ret;
 
 	if (!card->dev->dma_mask)
@@ -609,12 +627,7 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 
 		link->count = cpu_to_be32(period_size);
 
-		/* Even though the DMA controller supports 36-bit addressing,
-		 * for simplicity we allow only 32-bit addresses for the audio
-		 * buffer itself.  This was enforced in fsl_dma_new() with the
-		 * DMA mask.
-		 *
-		 * The snoop bit tells the DMA controller whether it should tell
+		/* The snoop bit tells the DMA controller whether it should tell
 		 * the ECM to snoop during a read or write to an address. For
 		 * audio, we use DMA to transfer data between memory and an I/O
 		 * device (the SSI's STX0 or SRX0 register). Snooping is only
@@ -629,20 +642,24 @@ static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
 		 * flush out the data for the previous period.  So if you
 		 * increased period_bytes_min to a large enough size, you might
 		 * get more performance by not snooping, and you'll still be
-		 * okay.
+		 * okay.  You'll need to update fsl_dma_update_pointers() also.
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			link->source_addr = cpu_to_be32(temp_addr);
-			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
+				upper_32_bits(temp_addr));
 
 			link->dest_addr = cpu_to_be32(ssi_sxx_phys);
-			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP);
+			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP |
+				upper_32_bits(ssi_sxx_phys));
 		} else {
 			link->source_addr = cpu_to_be32(ssi_sxx_phys);
-			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP);
+			link->source_attr = cpu_to_be32(CCSR_DMA_ATR_NOSNOOP |
+				upper_32_bits(ssi_sxx_phys));
 
 			link->dest_addr = cpu_to_be32(temp_addr);
-			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+			link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP |
+				upper_32_bits(temp_addr));
 		}
 
 		temp_addr += period_size;
@@ -673,10 +690,23 @@ static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
 	dma_addr_t position;
 	snd_pcm_uframes_t frames;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	/* Obtain the current DMA pointer, but don't read the ESAD bits if we
+	 * only have 32-bit DMA addresses.  This function is typically called
+	 * in interrupt context, so we need to optimize it.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		position = in_be32(&dma_channel->sar);
-	else
+#ifdef CONFIG_PHYS_64BIT
+		position |= (u64)(in_be32(&dma_channel->satr) &
+				  CCSR_DMA_ATR_ESAD_MASK) << 32;
+#endif
+	} else {
 		position = in_be32(&dma_channel->dar);
+#ifdef CONFIG_PHYS_64BIT
+		position |= (u64)(in_be32(&dma_channel->datr) &
+				  CCSR_DMA_ATR_ESAD_MASK) << 32;
+#endif
+	}
 
 	/*
 	 * When capture is started, the SSI immediately starts to fill its FIFO.
@@ -936,11 +966,6 @@ static void __exit fsl_soc_dma_exit(void)
 	of_unregister_platform_driver(&fsl_soc_dma_driver);
 }
 
-/* We want the DMA driver to be initialized before the SSI driver, so that
- * when the SSI driver calls fsl_soc_dma_dai_from_node(), the DMA driver
- * will already have been probed.  The easiest way to do that is to make the
- * __init function called via arch_initcall().
- */
 module_init(fsl_soc_dma_init);
 module_exit(fsl_soc_dma_exit);
 
-- 
1.7.0.1
