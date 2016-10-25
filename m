From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove rsnd_dma_detach()" to the
	asoc tree
Date: Tue, 25 Oct 2016 20:23:46 +0100
Message-ID: <E1bz7K6-0004oK-Ka@debutante>
References: <8737jlcly4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68881265B3E
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:23:53 +0200 (CEST)
In-Reply-To: <8737jlcly4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove rsnd_dma_detach()

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

>From dae4b83295ae50a86b5e3c60e7b6e2c597a1b69d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Oct 2016 00:36:56 +0000
Subject: [PATCH] ASoC: rsnd: remove rsnd_dma_detach()

DMA mod is now connected to stream via rsnd_dai_connect().
This means DMA mod can use .remove for its clearance.
rsnd_dma_detach() is no longer needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 11 -----------
 sound/soc/sh/rcar/rsnd.h |  1 -
 sound/soc/sh/rcar/ssi.c  |  2 --
 3 files changed, 14 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index e0761cac0ab7..c85a55111392 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -698,17 +698,6 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 	return 0;
 }
 
-void rsnd_dma_detach(struct rsnd_mod *mod, struct rsnd_mod **dma_mod)
-{
-	if (*dma_mod) {
-		struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-		struct device *dev = rsnd_priv_to_dev(priv);
-
-		devm_kfree(dev, *dma_mod);
-		*dma_mod = NULL;
-	}
-}
-
 int rsnd_dma_probe(struct rsnd_priv *priv)
 {
 	struct platform_device *pdev = rsnd_priv_to_pdev(priv);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 2460d1fbf775..c1cee1ab3e62 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -200,7 +200,6 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
  */
 int rsnd_dma_attach(struct rsnd_dai_stream *io,
 		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
-void rsnd_dma_detach(struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name);
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index b0338d0a4cde..e23e07b54d8c 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -701,8 +701,6 @@ static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
 	/* PIO will request IRQ again */
 	free_irq(ssi->irq, mod);
 
-	rsnd_dma_detach(mod, &ssi->dma);
-
 	return 0;
 }
 
-- 
2.8.1
