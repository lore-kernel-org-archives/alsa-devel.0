From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't use devm_request_irq() for
	SSI" to the asoc tree
Date: Tue, 25 Oct 2016 20:23:57 +0100
Message-ID: <E1bz7KH-0004p9-2M@debutante>
References: <874m41clyo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF922606F8
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:24:03 +0200 (CEST)
In-Reply-To: <874m41clyo.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't use devm_request_irq() for SSI

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

>From 701172dca15ba9860ba73d3e18082fbd2a78f2c9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Oct 2016 00:36:34 +0000
Subject: [PATCH] ASoC: rsnd: don't use devm_request_irq() for SSI

SSI will use DMA mode, and migh be fallback to PIO mode.
Using devm_request_irq() makes its operation more complex when
it fallbacks to PIO mode.
Let's use manual request_irq()/free_irq()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 59cd9824d8a4..b0338d0a4cde 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -644,10 +644,14 @@ static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
-	ret = devm_request_irq(dev, ssi->irq,
-			       rsnd_ssi_interrupt,
-			       IRQF_SHARED,
-			       dev_name(dev), mod);
+	/*
+	 * SSI might be called again as PIO fallback
+	 * It is easy to manual handling for IRQ request/free
+	 */
+	ret = request_irq(ssi->irq,
+			  rsnd_ssi_interrupt,
+			  IRQF_SHARED,
+			  dev_name(dev), mod);
 
 	return ret;
 }
@@ -693,12 +697,9 @@ static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
 			       struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	int irq = ssi->irq;
 
 	/* PIO will request IRQ again */
-	if (ssi->dma)
-		devm_free_irq(dev, irq, mod);
+	free_irq(ssi->irq, mod);
 
 	rsnd_dma_detach(mod, &ssi->dma);
 
-- 
2.8.1
