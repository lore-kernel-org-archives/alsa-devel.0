From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use dma_sync_single_for_xxx() for
	IOMMU" to the asoc tree
Date: Tue, 22 Nov 2016 17:26:08 +0000
Message-ID: <E1c9Epc-0005hD-Gf@debutante>
References: <87wpgxb7bc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F27CC2665A6
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 18:26:18 +0100 (CET)
In-Reply-To: <87wpgxb7bc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: use dma_sync_single_for_xxx() for IOMMU

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4821d914fe747a91453021675a74069776f0b819 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 14 Nov 2016 04:20:56 +0000
Subject: [PATCH] ASoC: rsnd: use dma_sync_single_for_xxx() for IOMMU

IOMMU needs DMA mapping function to use it. One solution is that
we can use DMA mapped dev on snd_pcm_lib_preallocate_pages_for_all()
for SNDRV_DMA_TYPE_DEV. But pcm_new and dma map timing are mismatched.
Thus, this patch uses SNDRV_DMA_TYPE_CONTINUOUS for pcm_new,
and use dma_sync_single_for_xxx() for each transfer.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  4 +--
 sound/soc/sh/rcar/dma.c  | 84 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 9ffa29941ceb..912dc62ff9c7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1126,8 +1126,8 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 	return snd_pcm_lib_preallocate_pages_for_all(
 		rtd->pcm,
-		SNDRV_DMA_TYPE_DEV,
-		rtd->card->snd_card->dev,
+		SNDRV_DMA_TYPE_CONTINUOUS,
+		snd_dma_continuous_data(GFP_KERNEL),
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
 }
 
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 3c663a5cfe8b..1f405c833867 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -25,6 +25,10 @@
 
 struct rsnd_dmaen {
 	struct dma_chan		*chan;
+	dma_addr_t		dma_buf;
+	unsigned int		dma_len;
+	unsigned int		dma_period;
+	unsigned int		dma_cnt;
 };
 
 struct rsnd_dmapp {
@@ -58,10 +62,38 @@ struct rsnd_dma_ctrl {
 /*
  *		Audio DMAC
  */
+#define rsnd_dmaen_sync(dmaen, io, i)	__rsnd_dmaen_sync(dmaen, io, i, 1)
+#define rsnd_dmaen_unsync(dmaen, io, i)	__rsnd_dmaen_sync(dmaen, io, i, 0)
+static void __rsnd_dmaen_sync(struct rsnd_dmaen *dmaen, struct rsnd_dai_stream *io,
+			      int i, int sync)
+{
+	struct device *dev = dmaen->chan->device->dev;
+	enum dma_data_direction dir;
+	int is_play = rsnd_io_is_play(io);
+	dma_addr_t buf;
+	int len, max;
+	size_t period;
+
+	len	= dmaen->dma_len;
+	period	= dmaen->dma_period;
+	max	= len / period;
+	i	= i % max;
+	buf	= dmaen->dma_buf + (period * i);
+
+	dir = is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+	if (sync)
+		dma_sync_single_for_device(dev, buf, period, dir);
+	else
+		dma_sync_single_for_cpu(dev, buf, period, dir);
+}
+
 static void __rsnd_dmaen_complete(struct rsnd_mod *mod,
 				  struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	bool elapsed = false;
 	unsigned long flags;
 
@@ -78,9 +110,22 @@ static void __rsnd_dmaen_complete(struct rsnd_mod *mod,
 	 */
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (rsnd_io_is_working(io))
+	if (rsnd_io_is_working(io)) {
+		rsnd_dmaen_unsync(dmaen, io, dmaen->dma_cnt);
+
+		/*
+		 * Next period is already started.
+		 * Let's sync Next Next period
+		 * see
+		 *	rsnd_dmaen_start()
+		 */
+		rsnd_dmaen_sync(dmaen, io, dmaen->dma_cnt + 2);
+
 		elapsed = rsnd_dai_pointer_update(io, io->byte_per_period);
 
+		dmaen->dma_cnt++;
+	}
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	if (elapsed)
@@ -116,7 +161,12 @@ static int rsnd_dmaen_stop(struct rsnd_mod *mod,
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 
 	if (dmaen->chan) {
+		int is_play = rsnd_io_is_play(io);
+
 		dmaengine_terminate_all(dmaen->chan);
+		dma_unmap_single(dmaen->chan->device->dev,
+				 dmaen->dma_buf, dmaen->dma_len,
+				 is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	}
 
 	return 0;
@@ -184,7 +234,11 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
 	struct dma_slave_config cfg = {};
+	dma_addr_t buf;
+	size_t len;
+	size_t period;
 	int is_play = rsnd_io_is_play(io);
+	int i;
 	int ret;
 
 	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
@@ -201,10 +255,19 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	len	= snd_pcm_lib_buffer_bytes(substream);
+	period	= snd_pcm_lib_period_bytes(substream);
+	buf	= dma_map_single(dmaen->chan->device->dev,
+				 substream->runtime->dma_area,
+				 len,
+				 is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (dma_mapping_error(dmaen->chan->device->dev, buf)) {
+		dev_err(dev, "dma map failed\n");
+		return -EIO;
+	}
+
 	desc = dmaengine_prep_dma_cyclic(dmaen->chan,
-					 substream->runtime->dma_addr,
-					 snd_pcm_lib_buffer_bytes(substream),
-					 snd_pcm_lib_period_bytes(substream),
+					 buf, len, period,
 					 is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
 					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
@@ -216,6 +279,19 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	desc->callback		= rsnd_dmaen_complete;
 	desc->callback_param	= rsnd_mod_get(dma);
 
+	dmaen->dma_buf		= buf;
+	dmaen->dma_len		= len;
+	dmaen->dma_period	= period;
+	dmaen->dma_cnt		= 0;
+
+	/*
+	 * synchronize this and next period
+	 * see
+	 *	__rsnd_dmaen_complete()
+	 */
+	for (i = 0; i < 2; i++)
+		rsnd_dmaen_sync(dmaen, io, i);
+
 	if (dmaengine_submit(desc) < 0) {
 		dev_err(dev, "dmaengine_submit() fail\n");
 		return -EIO;
-- 
2.10.2
