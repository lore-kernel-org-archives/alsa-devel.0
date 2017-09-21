From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add rsnd_dma_alloc()" to the asoc
	tree
Date: Thu, 21 Sep 2017 18:34:55 +0100
Message-ID: <E1dv5NH-0001QI-Rr@debutante>
References: <877exjniwl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3D2A2675F7
 for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2017 19:35:02 +0200 (CEST)
In-Reply-To: <877exjniwl.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add rsnd_dma_alloc()

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

>From 81cb71240e202a8086bda0755d9d78bd3decd0aa Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Sep 2017 06:28:44 +0000
Subject: [PATCH] ASoC: rsnd: add rsnd_dma_alloc()

R-Car sound DMA will be used from SSI/SRC.
dma.c doesn't alloc DMA handler in .probe timing, because we don't
know what kind of DMA transfer will be used then.
Thus, SSI/SRC have *rsnd_mod for DMA. rsnd_dma_attach() will allocate
it and attach it to system.
It will be PIO mode if it can't alloc DMA handler.

In case of MIX is used, rsnd_dma_attach() will be called twice from SSI.
To avoid duplicate allocation, current rsnd_dma_attach() is checking
allocated DMA handler. This DMA related operation is a little bit
difficult to understand.
This patch adds new rsnd_dma_alloc() and separates allocation and attach
for readable code.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c | 60 +++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 041ec1080d52..17220c946ff0 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -753,14 +753,15 @@ static void rsnd_dma_of_path(struct rsnd_mod *this,
 	}
 }
 
-int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
-		    struct rsnd_mod **dma_mod)
+static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
+			  struct rsnd_mod **dma_mod)
 {
 	struct rsnd_mod *mod_from = NULL;
 	struct rsnd_mod *mod_to = NULL;
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
+	struct rsnd_dma *dma;
 	struct rsnd_mod_ops *ops;
 	enum rsnd_mod_type type;
 	int (*attach)(struct rsnd_dai_stream *io, struct rsnd_dma *dma,
@@ -800,40 +801,45 @@ int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 		type	= RSND_MOD_AUDMA;
 	}
 
-	if (!(*dma_mod)) {
-		struct rsnd_dma *dma;
+	dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
 
-		dma = devm_kzalloc(dev, sizeof(*dma), GFP_KERNEL);
-		if (!dma)
-			return -ENOMEM;
+	*dma_mod = rsnd_mod_get(dma);
 
-		*dma_mod = rsnd_mod_get(dma);
+	ret = rsnd_mod_init(priv, *dma_mod, ops, NULL,
+			    rsnd_mod_get_status, type, dma_id);
+	if (ret < 0)
+		return ret;
 
-		ret = rsnd_mod_init(priv, *dma_mod, ops, NULL,
-				    rsnd_mod_get_status, type, dma_id);
-		if (ret < 0)
-			return ret;
+	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
+		rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
+		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
+		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+
+	ret = attach(io, dma, mod_from, mod_to);
+	if (ret < 0)
+		return ret;
 
-		dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
-			rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
-			rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
-			rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+	dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
+	dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
+	dma->mod_from = mod_from;
+	dma->mod_to   = mod_to;
+
+	return 0;
+}
+
+int rsnd_dma_attach(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
+		    struct rsnd_mod **dma_mod)
+{
+	if (!(*dma_mod)) {
+		int ret = rsnd_dma_alloc(io, mod, dma_mod);
 
-		ret = attach(io, dma, mod_from, mod_to);
 		if (ret < 0)
 			return ret;
-
-		dma->src_addr = rsnd_dma_addr(io, mod_from, is_play, 1);
-		dma->dst_addr = rsnd_dma_addr(io, mod_to,   is_play, 0);
-		dma->mod_from = mod_from;
-		dma->mod_to   = mod_to;
 	}
 
-	ret = rsnd_dai_connect(*dma_mod, io, type);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return rsnd_dai_connect(*dma_mod, io, (*dma_mod)->type);
 }
 
 int rsnd_dma_probe(struct rsnd_priv *priv)
-- 
2.14.1
