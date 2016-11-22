From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Request/Release DMA channel each
	time" to the asoc tree
Date: Tue, 22 Nov 2016 17:26:11 +0000
Message-ID: <E1c9Epf-0005i1-IL@debutante>
References: <87mvh2k80u.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F922665B0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 18:26:18 +0100 (CET)
In-Reply-To: <87mvh2k80u.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Request/Release DMA channel each time

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

>From edce5c496c6af3e5ca6e1bb18f7cf4f6ef6226fa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 14 Nov 2016 04:20:40 +0000
Subject: [PATCH] ASoC: rsnd: Request/Release DMA channel each time

Current Renesas Sound driver requests DMA channel when .probe timing,
and release it when .remove timing. And use DMA on .start/.stop
But, Audio DMAC power ON was handled when request timing (= .probe),
and power OFF was when release timing (= .remove).
This means Audio DMAC power is always ON during driver was enabled.
The best choice to solve this issue is that DMAEngine side handle
this. But current DMAEngine API design can't solve atmic/non-atmic
context issue for power ON/OFF. So next better choice is sound
driver request/release DMA channel each time. This patch do it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 184 ++++++++++++++++++++++++++++--------------------
 1 file changed, 107 insertions(+), 77 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 2f0327714625..3c663a5cfe8b 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -34,6 +34,8 @@ struct rsnd_dmapp {
 
 struct rsnd_dma {
 	struct rsnd_mod		mod;
+	struct rsnd_mod		*mod_from;
+	struct rsnd_mod		*mod_to;
 	dma_addr_t		src_addr;
 	dma_addr_t		dst_addr;
 	union {
@@ -92,6 +94,20 @@ static void rsnd_dmaen_complete(void *data)
 	rsnd_mod_interrupt(mod, __rsnd_dmaen_complete);
 }
 
+static struct dma_chan *rsnd_dmaen_request_channel(struct rsnd_dai_stream *io,
+						   struct rsnd_mod *mod_from,
+						   struct rsnd_mod *mod_to)
+{
+	if ((!mod_from && !mod_to) ||
+	    (mod_from && mod_to))
+		return NULL;
+
+	if (mod_from)
+		return rsnd_mod_dma_req(io, mod_from);
+	else
+		return rsnd_mod_dma_req(io, mod_to);
+}
+
 static int rsnd_dmaen_stop(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -99,7 +115,61 @@ static int rsnd_dmaen_stop(struct rsnd_mod *mod,
 	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 
-	dmaengine_terminate_all(dmaen->chan);
+	if (dmaen->chan) {
+		dmaengine_terminate_all(dmaen->chan);
+	}
+
+	return 0;
+}
+
+static int rsnd_dmaen_nolock_stop(struct rsnd_mod *mod,
+				   struct rsnd_dai_stream *io,
+				   struct rsnd_priv *priv)
+{
+	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
+
+	/*
+	 * DMAEngine release uses mutex lock.
+	 * Thus, it shouldn't be called under spinlock.
+	 * Let's call it under nolock_start
+	 */
+	if (dmaen->chan)
+		dma_release_channel(dmaen->chan);
+
+	dmaen->chan = NULL;
+
+	return 0;
+}
+
+static int rsnd_dmaen_nolock_start(struct rsnd_mod *mod,
+			    struct rsnd_dai_stream *io,
+			    struct rsnd_priv *priv)
+{
+	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
+	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
+	struct device *dev = rsnd_priv_to_dev(priv);
+
+	if (dmaen->chan) {
+		dev_err(dev, "it already has dma channel\n");
+		return -EIO;
+	}
+
+	/*
+	 * DMAEngine request uses mutex lock.
+	 * Thus, it shouldn't be called under spinlock.
+	 * Let's call it under nolock_start
+	 */
+	dmaen->chan = rsnd_dmaen_request_channel(io,
+						 dma->mod_from,
+						 dma->mod_to);
+	if (IS_ERR_OR_NULL(dmaen->chan)) {
+		int ret = PTR_ERR(dmaen->chan);
+
+		dmaen->chan = NULL;
+		dev_err(dev, "can't get dma channel\n");
+		return ret;
+	}
 
 	return 0;
 }
@@ -113,7 +183,23 @@ static int rsnd_dmaen_start(struct rsnd_mod *mod,
 	struct snd_pcm_substream *substream = io->substream;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config cfg = {};
 	int is_play = rsnd_io_is_play(io);
+	int ret;
+
+	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	cfg.src_addr	= dma->src_addr;
+	cfg.dst_addr	= dma->dst_addr;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+
+	dev_dbg(dev, "%s[%d] %pad -> %pad\n",
+		rsnd_mod_name(mod), rsnd_mod_id(mod),
+		&cfg.src_addr, &cfg.dst_addr);
+
+	ret = dmaengine_slave_config(dmaen->chan, &cfg);
+	if (ret < 0)
+		return ret;
 
 	desc = dmaengine_prep_dma_cyclic(dmaen->chan,
 					 substream->runtime->dma_addr,
@@ -159,97 +245,39 @@ struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 	return chan;
 }
 
-static struct dma_chan *rsnd_dmaen_request_channel(struct rsnd_dai_stream *io,
-						   struct rsnd_mod *mod_from,
-						   struct rsnd_mod *mod_to)
-{
-	if ((!mod_from && !mod_to) ||
-	    (mod_from && mod_to))
-		return NULL;
-
-	if (mod_from)
-		return rsnd_mod_dma_req(io, mod_from);
-	else
-		return rsnd_mod_dma_req(io, mod_to);
-}
-
-static int rsnd_dmaen_remove(struct rsnd_mod *mod,
-			      struct rsnd_dai_stream *io,
-			      struct rsnd_priv *priv)
-{
-	struct rsnd_dma *dma = rsnd_mod_to_dma(mod);
-	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
-
-	if (dmaen->chan)
-		dma_release_channel(dmaen->chan);
-
-	dmaen->chan = NULL;
-
-	return 0;
-}
-
 static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 			   struct rsnd_dma *dma,
 			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
-	struct rsnd_mod *mod = rsnd_mod_get(dma);
-	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct dma_slave_config cfg = {};
-	int is_play = rsnd_io_is_play(io);
-	int ret;
-
-	if (dmaen->chan) {
-		dev_err(dev, "it already has dma channel\n");
-		return -EIO;
-	}
-
-	dmaen->chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
-
-	if (IS_ERR_OR_NULL(dmaen->chan)) {
-		dmaen->chan = NULL;
-		dev_err(dev, "can't get dma channel\n");
-		goto rsnd_dma_channel_err;
+	struct dma_chan *chan;
+
+	/* try to get DMAEngine channel */
+	chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
+	if (IS_ERR_OR_NULL(chan)) {
+		/*
+		 * DMA failed. try to PIO mode
+		 * see
+		 *	rsnd_ssi_fallback()
+		 *	rsnd_rdai_continuance_probe()
+		 */
+		return -EAGAIN;
 	}
 
-	cfg.direction	= is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.src_addr	= dma->src_addr;
-	cfg.dst_addr	= dma->dst_addr;
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-
-	dev_dbg(dev, "%s[%d] %pad -> %pad\n",
-		rsnd_mod_name(mod), rsnd_mod_id(mod),
-		&cfg.src_addr, &cfg.dst_addr);
-
-	ret = dmaengine_slave_config(dmaen->chan, &cfg);
-	if (ret < 0)
-		goto rsnd_dma_attach_err;
+	dma_release_channel(chan);
 
 	dmac->dmaen_num++;
 
 	return 0;
-
-rsnd_dma_attach_err:
-	rsnd_dmaen_remove(mod, io, priv);
-rsnd_dma_channel_err:
-
-	/*
-	 * DMA failed. try to PIO mode
-	 * see
-	 *	rsnd_ssi_fallback()
-	 *	rsnd_rdai_continuance_probe()
-	 */
-	return -EAGAIN;
 }
 
 static struct rsnd_mod_ops rsnd_dmaen_ops = {
 	.name	= "audmac",
+	.nolock_start = rsnd_dmaen_nolock_start,
+	.nolock_stop  = rsnd_dmaen_nolock_stop,
 	.start	= rsnd_dmaen_start,
 	.stop	= rsnd_dmaen_stop,
-	.remove	= rsnd_dmaen_remove,
 };
 
 /*
@@ -671,9 +699,6 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 
 		*dma_mod = rsnd_mod_get(dma);
 
-		dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
-		dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
-
 		ret = rsnd_mod_init(priv, *dma_mod, ops, NULL,
 				    rsnd_mod_get_status, type, dma_id);
 		if (ret < 0)
@@ -687,6 +712,11 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 		ret = attach(io, dma, mod_from, mod_to);
 		if (ret < 0)
 			return ret;
+
+		dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
+		dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
+		dma->mod_from = mod_from;
+		dma->mod_to   = mod_to;
 	}
 
 	ret = rsnd_dai_connect(*dma_mod, io, type);
-- 
2.10.2
