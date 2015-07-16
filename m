From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: dma: add DMA name on .ops" to the
	asoc tree
Date: Thu, 16 Jul 2015 22:29:51 +0100
Message-ID: <E1ZFqj1-0004gv-RC@finisterre>
References: <87bnfdvqpn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56BF82605EE
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:29:56 +0200 (CEST)
In-Reply-To: <87bnfdvqpn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: dma: add DMA name on .ops

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

>From ddea1b2e83c379840aa54fadc587e418cf986ccb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:16:03 +0000
Subject: [PATCH] ASoC: rsnd: dma: add DMA name on .ops

Current rsnd driver is using Audio DMAC (via DMAEngine) and
Audio DMAC peri peri (via original method), and usage of these DMAC
are different. Indicates its naming is useful for debugging.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 9431061..a175863 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -28,6 +28,7 @@ struct rsnd_dma_ctrl {
 };
 
 struct rsnd_dma_ops {
+	char *name;
 	void (*start)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
 	void (*stop)(struct rsnd_dai_stream *io, struct rsnd_dma *dma);
 	int (*init)(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id,
@@ -190,7 +191,8 @@ static int rsnd_dmaen_init(struct rsnd_dai_stream *io,
 	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	dev_dbg(dev, "dma : %pad -> %pad\n",
+	dev_dbg(dev, "%s %pad -> %pad\n",
+		dma->ops->name,
 		&cfg.src_addr, &cfg.dst_addr);
 
 	ret = dmaengine_slave_config(dmaen->chan, &cfg);
@@ -223,6 +225,7 @@ static void rsnd_dmaen_quit(struct rsnd_dai_stream *io, struct rsnd_dma *dma)
 }
 
 static struct rsnd_dma_ops rsnd_dmaen_ops = {
+	.name	= "audmac",
 	.start	= rsnd_dmaen_start,
 	.stop	= rsnd_dmaen_stop,
 	.init	= rsnd_dmaen_init,
@@ -368,6 +371,7 @@ static int rsnd_dmapp_init(struct rsnd_dai_stream *io,
 }
 
 static struct rsnd_dma_ops rsnd_dmapp_ops = {
+	.name	= "audmac-pp",
 	.start	= rsnd_dmapp_start,
 	.stop	= rsnd_dmapp_stop,
 	.init	= rsnd_dmapp_init,
@@ -580,6 +584,7 @@ int rsnd_dma_init(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id)
 	struct rsnd_mod *mod_to;
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_play = rsnd_io_is_play(io);
 
 	/*
@@ -606,6 +611,11 @@ int rsnd_dma_init(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id)
 	if (rsnd_is_gen1(priv))
 		dma->ops = &rsnd_dmaen_ops;
 
+	dev_dbg(dev, "%s %s[%d] -> %s[%d]\n",
+		dma->ops->name,
+		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
+		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+
 	return dma->ops->init(io, dma, id, mod_from, mod_to);
 }
 
-- 
2.1.4
