From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: attach Audio-DMAC-periperi
	correctly" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:43 +0000
Message-ID: <E1aMgPz-00047C-3F@debutante>
References: <87d1sv4rym.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9ECD260504
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <87d1sv4rym.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: attach Audio-DMAC-periperi correctly

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

>From 355cb84fbe1f098f80c17dad9027ad2c6aec3fa0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:58:33 +0000
Subject: [PATCH] ASoC: rsnd: attach Audio-DMAC-periperi correctly

SSI/SRC will try to attach DMAC as Audio-DMAC or Audio-DMAC-periperi.
It is fixed IP, but will be attached to each streams as different module
in case of MUX (= multi sound path will be merged).
This patch solves this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  | 56 +++++++++++++++++++++++++-----------------------
 sound/soc/sh/rcar/rsnd.h |  4 ++--
 sound/soc/sh/rcar/src.c  |  4 +---
 sound/soc/sh/rcar/ssi.c  |  5 ++---
 4 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index d1cb3c177572..7658e8fd7bdc 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -622,15 +622,13 @@ static void rsnd_dma_of_path(struct rsnd_mod *this,
 	}
 }
 
-struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
-				 struct rsnd_mod *mod, int id)
+int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
+		    struct rsnd_mod **dma_mod, int id)
 {
-	struct rsnd_mod *dma_mod;
 	struct rsnd_mod *mod_from = NULL;
 	struct rsnd_mod *mod_to = NULL;
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
-	struct rsnd_dma *dma;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_mod_ops *ops;
 	enum rsnd_mod_type type;
@@ -646,17 +644,10 @@ struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 	 *	rsnd_rdai_continuance_probe()
 	 */
 	if (!dmac)
-		return ERR_PTR(-EAGAIN);
-
-	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
-	if (!dma)
-		return ERR_PTR(-ENOMEM);
+		return -EAGAIN;
 
 	rsnd_dma_of_path(mod, io, is_play, &mod_from, &mod_to);
 
-	dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
-	dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
-
 	/* for Gen2 */
 	if (mod_from && mod_to) {
 		ops	= &rsnd_dmapp_ops;
@@ -678,27 +669,38 @@ struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 		type	= RSND_MOD_AUDMA;
 	}
 
-	dma_mod = rsnd_mod_get(dma);
+	if (!(*dma_mod)) {
+		struct rsnd_dma *dma;
 
-	ret = rsnd_mod_init(priv, dma_mod,
-			    ops, NULL, rsnd_mod_get_status, type, dma_id);
-	if (ret < 0)
-		return ERR_PTR(ret);
+		dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+		if (!dma)
+			return -ENOMEM;
 
-	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
-		rsnd_mod_name(dma_mod), rsnd_mod_id(dma_mod),
-		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
-		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+		*dma_mod = rsnd_mod_get(dma);
 
-	ret = attach(io, dma, id, mod_from, mod_to);
-	if (ret < 0)
-		return ERR_PTR(ret);
+		dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
+		dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
+
+		ret = rsnd_mod_init(priv, *dma_mod, ops, NULL,
+				    rsnd_mod_get_status, type, dma_id);
+		if (ret < 0)
+			return ret;
 
-	ret = rsnd_dai_connect(dma_mod, io, type);
+		dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
+			rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
+			rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
+			rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+
+		ret = attach(io, dma, id, mod_from, mod_to);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = rsnd_dai_connect(*dma_mod, io, type);
 	if (ret < 0)
-		return ERR_PTR(ret);
+		return ret;
 
-	return rsnd_mod_get(dma);
+	return 0;
 }
 
 int rsnd_dma_probe(struct rsnd_priv *priv)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 28602607cf5e..90c732e265a2 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -166,8 +166,8 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 /*
  *	R-Car DMA
  */
-struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
-			       struct rsnd_mod *mod, int id);
+int rsnd_dma_attach(struct rsnd_dai_stream *io,
+		    struct rsnd_mod *mod, struct rsnd_mod **dma_mod, int id);
 int rsnd_dma_probe(struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name);
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 516b0c05451c..8dc9b483b5fa 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -495,9 +495,7 @@ static int rsnd_src_probe_(struct rsnd_mod *mod,
 			return ret;
 	}
 
-	src->dma = rsnd_dma_attach(io, mod, 0);
-	if (IS_ERR(src->dma))
-		return PTR_ERR(src->dma);
+	ret = rsnd_dma_attach(io, mod, &src->dma, 0);
 
 	return ret;
 }
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index e68f3a1c9cb4..90674137aa90 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -704,9 +704,8 @@ static int rsnd_ssi_dma_probe(struct rsnd_mod *mod,
 	if (ret)
 		return ret;
 
-	ssi->dma = rsnd_dma_attach(io, mod, dma_id);
-	if (IS_ERR(ssi->dma))
-		return PTR_ERR(ssi->dma);
+	/* SSI probe might be called many times in MUX multi path */
+	ret = rsnd_dma_attach(io, mod, &ssi->dma, dma_id);
 
 	return ret;
 }
-- 
2.7.0.rc3
