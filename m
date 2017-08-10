From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: call free_irq() both DMA/PIO mode" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:27 +0100
Message-ID: <E1dfpbP-0001lX-RR@finisterre>
References: <8760dwz3z9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8760dwz3z9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: call free_irq() both DMA/PIO mode

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

>From 213691c7e873206742b39751895d15b41a02b3d1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Aug 2017 00:07:00 +0000
Subject: [PATCH] ASoC: rsnd: call free_irq() both DMA/PIO mode

commit 701172dca15b ("ASoC: rsnd: don't use devm_request_irq() for SSI")
exchanged devm_request_irq() to request_irq() for SSI, because SSI will
fallback into PIO mode if DMA doesn't work.
But, because of it, PIO mode needed to call free_irq() when removing,
not only DMA mode.
This patch call free_irq() both PIO/DMA. Otherwise, rsnd IRQ handler
will be increased if user tried many unbind/bind.

Fixes: 701172dca15b ("ASoC: rsnd: don't use devm_request_irq() for SSI")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0309de58bf18..281ed0da6ba1 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -792,6 +792,23 @@ static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
 	return ret;
 }
 
+static int rsnd_ssi_common_remove(struct rsnd_mod *mod,
+				  struct rsnd_dai_stream *io,
+				  struct rsnd_priv *priv)
+{
+	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	struct rsnd_mod *pure_ssi_mod = rsnd_io_to_mod_ssi(io);
+
+	/* Do nothing if non SSI (= SSI parent, multi SSI) mod */
+	if (pure_ssi_mod != mod)
+		return 0;
+
+	/* PIO will request IRQ again */
+	free_irq(ssi->irq, mod);
+
+	return 0;
+}
+
 static int rsnd_ssi_pointer(struct rsnd_mod *mod,
 			    struct rsnd_dai_stream *io,
 			    snd_pcm_uframes_t *pointer)
@@ -807,6 +824,7 @@ static int rsnd_ssi_pointer(struct rsnd_mod *mod,
 static struct rsnd_mod_ops rsnd_ssi_pio_ops = {
 	.name	= SSI_NAME,
 	.probe	= rsnd_ssi_common_probe,
+	.remove	= rsnd_ssi_common_remove,
 	.init	= rsnd_ssi_init,
 	.quit	= rsnd_ssi_quit,
 	.start	= rsnd_ssi_start,
@@ -841,23 +859,6 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 	return ret;
 }
 
-static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
-			       struct rsnd_dai_stream *io,
-			       struct rsnd_priv *priv)
-{
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	struct rsnd_mod *pure_ssi_mod = rsnd_io_to_mod_ssi(io);
-
-	/* Do nothing if non SSI (= SSI parent, multi SSI) mod */
-	if (pure_ssi_mod != mod)
-		return 0;
-
-	/* PIO will request IRQ again */
-	free_irq(ssi->irq, mod);
-
-	return 0;
-}
-
 static int rsnd_ssi_fallback(struct rsnd_mod *mod,
 			     struct rsnd_dai_stream *io,
 			     struct rsnd_priv *priv)
@@ -899,7 +900,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.name	= SSI_NAME,
 	.dma_req = rsnd_ssi_dma_req,
 	.probe	= rsnd_ssi_dma_probe,
-	.remove	= rsnd_ssi_dma_remove,
+	.remove	= rsnd_ssi_common_remove,
 	.init	= rsnd_ssi_init,
 	.quit	= rsnd_ssi_quit,
 	.start	= rsnd_ssi_start,
-- 
2.13.2
