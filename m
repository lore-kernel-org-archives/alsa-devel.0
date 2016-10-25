From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove non DT support for DMA" to
	the asoc tree
Date: Tue, 25 Oct 2016 20:24:00 +0100
Message-ID: <E1bz7KK-0004pw-AI@debutante>
References: <8760ohclz7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 660CD265B3E
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:24:07 +0200 (CEST)
In-Reply-To: <8760ohclz7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove non DT support for DMA

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

>From b99305d20122174c9fd0469bae036f0c401999b5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Oct 2016 00:36:13 +0000
Subject: [PATCH] ASoC: rsnd: remove non DT support for DMA

Current Renesas Sound driver is based on DeviceTree, and no one is
using this driver from non DT. Non-DT support is no longer needed.
Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 21 ++++++---------------
 sound/soc/sh/rcar/rsnd.h |  2 +-
 sound/soc/sh/rcar/src.c  |  2 +-
 sound/soc/sh/rcar/ssi.c  |  3 +--
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index b3bdd362a511..e0761cac0ab7 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -191,7 +191,7 @@ static int rsnd_dmaen_remove(struct rsnd_mod *mod,
 }
 
 static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
-			   struct rsnd_dma *dma, int id,
+			   struct rsnd_dma *dma,
 			   struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
 	struct rsnd_mod *mod = rsnd_mod_get(dma);
@@ -208,17 +208,8 @@ static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 		return -EIO;
 	}
 
-	if (dev->of_node) {
-		dmaen->chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
-	} else {
-		dma_cap_mask_t mask;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
+	dmaen->chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
 
-		dmaen->chan = dma_request_channel(mask, shdma_chan_filter,
-						  (void *)(uintptr_t)id);
-	}
 	if (IS_ERR_OR_NULL(dmaen->chan)) {
 		dmaen->chan = NULL;
 		dev_err(dev, "can't get dma channel\n");
@@ -394,7 +385,7 @@ static int rsnd_dmapp_start(struct rsnd_mod *mod,
 }
 
 static int rsnd_dmapp_attach(struct rsnd_dai_stream *io,
-			     struct rsnd_dma *dma, int id,
+			     struct rsnd_dma *dma,
 			     struct rsnd_mod *mod_from, struct rsnd_mod *mod_to)
 {
 	struct rsnd_dmapp *dmapp = rsnd_dma_to_dmapp(dma);
@@ -627,7 +618,7 @@ static void rsnd_dma_of_path(struct rsnd_mod *this,
 }
 
 int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
-		    struct rsnd_mod **dma_mod, int id)
+		    struct rsnd_mod **dma_mod)
 {
 	struct rsnd_mod *mod_from = NULL;
 	struct rsnd_mod *mod_to = NULL;
@@ -636,7 +627,7 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_mod_ops *ops;
 	enum rsnd_mod_type type;
-	int (*attach)(struct rsnd_dai_stream *io, struct rsnd_dma *dma, int id,
+	int (*attach)(struct rsnd_dai_stream *io, struct rsnd_dma *dma,
 		      struct rsnd_mod *mod_from, struct rsnd_mod *mod_to);
 	int is_play = rsnd_io_is_play(io);
 	int ret, dma_id;
@@ -695,7 +686,7 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 			rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
 			rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
 
-		ret = attach(io, dma, id, mod_from, mod_to);
+		ret = attach(io, dma, mod_from, mod_to);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index b3b4d89347be..2460d1fbf775 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -199,7 +199,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
  *	R-Car DMA
  */
 int rsnd_dma_attach(struct rsnd_dai_stream *io,
-		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod, int id);
+		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
 void rsnd_dma_detach(struct rsnd_mod *mod, struct rsnd_mod **dma_mod);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 969a5169de25..e13d6d439b32 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -475,7 +475,7 @@ static int rsnd_src_probe_(struct rsnd_mod *mod,
 			return ret;
 	}
 
-	ret = rsnd_dma_attach(io, mod, &src->dma, 0);
+	ret = rsnd_dma_attach(io, mod, &src->dma);
 
 	return ret;
 }
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 94a19f975fa2..59cd9824d8a4 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -669,7 +669,6 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 			      struct rsnd_priv *priv)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
-	int dma_id = 0; /* not needed */
 	int ret;
 
 	/*
@@ -684,7 +683,7 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 		return ret;
 
 	/* SSI probe might be called many times in MUX multi path */
-	ret = rsnd_dma_attach(io, mod, &ssi->dma, dma_id);
+	ret = rsnd_dma_attach(io, mod, &ssi->dma);
 
 	return ret;
 }
-- 
2.8.1
