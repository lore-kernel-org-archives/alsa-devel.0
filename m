From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: dma.c: spin lock is no longer
	needed in IRQ handler" to the asoc tree
Date: Wed, 29 Nov 2017 10:57:44 +0000
Message-ID: <E1eK03k-00063l-7X@debutante>
References: <87y3mprdre.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A976D267895
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 11:57:47 +0100 (CET)
In-Reply-To: <87y3mprdre.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: dma.c: spin lock is no longer needed in IRQ handler

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 65bedda1feec4f57e1322a200853cc29079b01c6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 29 Nov 2017 03:08:35 +0000
Subject: [PATCH] ASoC: rsnd: dma.c: spin lock is no longer needed in IRQ
 handler

DMA handler had needed to calculate pointer before, but it doesn't
need now. Thus, we can remove unnecessary spin lock from DMAC handler.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 4d750bdf8e24..41de23417c4a 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -71,25 +71,7 @@ static struct rsnd_mod mem = {
 static void __rsnd_dmaen_complete(struct rsnd_mod *mod,
 				  struct rsnd_dai_stream *io)
 {
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	bool elapsed = false;
-	unsigned long flags;
-
-	/*
-	 * Renesas sound Gen1 needs 1 DMAC,
-	 * Gen2 needs 2 DMAC.
-	 * In Gen2 case, it are Audio-DMAC, and Audio-DMAC-peri-peri.
-	 * But, Audio-DMAC-peri-peri doesn't have interrupt,
-	 * and this driver is assuming that here.
-	 */
-	spin_lock_irqsave(&priv->lock, flags);
-
 	if (rsnd_io_is_working(io))
-		elapsed = true;
-
-	spin_unlock_irqrestore(&priv->lock, flags);
-
-	if (elapsed)
 		rsnd_dai_period_elapsed(io);
 }
 
-- 
2.15.0
