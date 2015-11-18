From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove platform boot support from
	src.c" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:39 +0000
Message-ID: <E1Zz7Ap-0000Hm-8z@debutante>
References: <87ziymjve0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 121F5265AF8
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:44 +0100 (CET)
In-Reply-To: <87ziymjve0.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove platform boot support from src.c

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

>From adf6a6815952c6c6092ae15e27c1b782fd96c6a3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:11:55 +0000
Subject: [PATCH] ASoC: rsnd: remove platform boot support from src.c

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
This patch removes platform boot support from src.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/src.c | 158 +++++++++++++-----------------------------------
 1 file changed, 43 insertions(+), 115 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 230db9f81377..f965fea7aa50 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -20,17 +20,18 @@
 #define OUF_SRC(id)	((1 << (id + 16)) | (1 << id))
 
 struct rsnd_src {
-	struct rsnd_src_platform_info *info; /* rcar_snd.h */
 	struct rsnd_mod mod;
 	struct rsnd_mod *dma;
 	struct rsnd_kctrl_cfg_s sen;  /* sync convert enable */
 	struct rsnd_kctrl_cfg_s sync; /* sync convert */
 	u32 convert_rate; /* sampling rate convert */
 	int err;
+	int irq;
 };
 
 #define RSND_SRC_NAME_SIZE 16
 
+#define rsnd_src_get(priv, id) ((struct rsnd_src *)(priv->src) + id)
 #define rsnd_src_to_dma(src) ((src)->dma)
 #define rsnd_src_nr(priv) ((priv)->src_nr)
 #define rsnd_enable_sync_convert(src) ((src)->sen.val)
@@ -69,52 +70,6 @@ struct rsnd_src {
  *        |-----------------|
  */
 
-/*
- *	How to use SRC bypass mode for debugging
- *
- * SRC has bypass mode, and it is useful for debugging.
- * In Gen2 case,
- * SRCm_MODE controls whether SRC is used or not
- * SSI_MODE0 controls whether SSIU which receives SRC data
- * is used or not.
- * Both SRCm_MODE/SSI_MODE0 settings are needed if you use SRC,
- * but SRC bypass mode needs SSI_MODE0 only.
- *
- * This driver request
- * struct rsnd_src_platform_info {
- *	u32 convert_rate;
- *	int dma_id;
- * }
- *
- * rsnd_src_convert_rate() indicates
- * above convert_rate, and it controls
- * whether SRC is used or not.
- *
- * ex) doesn't use SRC
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], },
- * };
- *
- * ex) uses SRC
- * static struct rsnd_src_platform_info rsnd_src[] = {
- *	RSND_SCU(48000, 0),
- *	...
- * };
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], .src = &rsnd_src[0] },
- * };
- *
- * ex) uses SRC bypass mode
- * static struct rsnd_src_platform_info rsnd_src[] = {
- *	RSND_SCU(0, 0),
- *	...
- * };
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], .src = &rsnd_src[0] },
- * };
- *
- */
-
 static void rsnd_src_soft_reset(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, SRC_SWRSR, 0);
@@ -187,9 +142,6 @@ static int rsnd_src_hw_params(struct rsnd_mod *mod,
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 
-	/* default value (mainly for non-DT) */
-	src->convert_rate = src->info->convert_rate;
-
 	/*
 	 * SRC assumes that it is used under DPCM if user want to use
 	 * sampling rate convert. Then, SRC should be FE.
@@ -318,7 +270,7 @@ static void rsnd_src_irq_ctrol(struct rsnd_mod *mod, int enable)
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	u32 sys_int_val, int_val, sys_int_mask;
-	int irq = src->info->irq;
+	int irq = src->irq;
 	int id = rsnd_mod_id(mod);
 
 	sys_int_val =
@@ -517,7 +469,7 @@ static int rsnd_src_probe_(struct rsnd_mod *mod,
 {
 	struct rsnd_src *src = rsnd_mod_to_src(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	int irq = src->info->irq;
+	int irq = src->irq;
 	int ret;
 
 	if (irq > 0) {
@@ -534,7 +486,7 @@ static int rsnd_src_probe_(struct rsnd_mod *mod,
 			return ret;
 	}
 
-	src->dma = rsnd_dma_attach(io, mod, src->info->dma_id);
+	src->dma = rsnd_dma_attach(io, mod, 0);
 	if (IS_ERR(src->dma))
 		return PTR_ERR(src->dma);
 
@@ -598,58 +550,15 @@ struct rsnd_mod *rsnd_src_mod_get(struct rsnd_priv *priv, int id)
 	if (WARN_ON(id < 0 || id >= rsnd_src_nr(priv)))
 		id = 0;
 
-	return rsnd_mod_get((struct rsnd_src *)(priv->src) + id);
-}
-
-static void rsnd_of_parse_src(struct platform_device *pdev,
-			      const struct rsnd_of_data *of_data,
-			      struct rsnd_priv *priv)
-{
-	struct device_node *src_node;
-	struct device_node *np;
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
-	struct rsnd_src_platform_info *src_info;
-	struct device *dev = &pdev->dev;
-	int nr, i;
-
-	if (!of_data)
-		return;
-
-	src_node = rsnd_src_of_node(priv);
-	if (!src_node)
-		return;
-
-	nr = of_get_child_count(src_node);
-	if (!nr)
-		goto rsnd_of_parse_src_end;
-
-	src_info = devm_kzalloc(dev,
-				sizeof(struct rsnd_src_platform_info) * nr,
-				GFP_KERNEL);
-	if (!src_info) {
-		dev_err(dev, "src info allocation error\n");
-		goto rsnd_of_parse_src_end;
-	}
-
-	info->src_info		= src_info;
-	info->src_info_nr	= nr;
-
-	i = 0;
-	for_each_child_of_node(src_node, np) {
-		src_info[i].irq = irq_of_parse_and_map(np, 0);
-
-		i++;
-	}
-
-rsnd_of_parse_src_end:
-	of_node_put(src_node);
+	return rsnd_mod_get(rsnd_src_get(priv, id));
 }
 
 int rsnd_src_probe(struct platform_device *pdev,
 		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
+	struct device_node *node;
+	struct device_node *np;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_src *src;
 	struct clk *clk;
@@ -660,39 +569,58 @@ int rsnd_src_probe(struct platform_device *pdev,
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	rsnd_of_parse_src(pdev, of_data, priv);
+	node = rsnd_src_of_node(priv);
+	if (!node)
+		return 0; /* not used is not error */
 
-	/*
-	 * init SRC
-	 */
-	nr	= info->src_info_nr;
-	if (!nr)
-		return 0;
+	nr = of_get_child_count(node);
+	if (!nr) {
+		ret = -EINVAL;
+		goto rsnd_src_probe_done;
+	}
 
 	src	= devm_kzalloc(dev, sizeof(*src) * nr, GFP_KERNEL);
-	if (!src)
-		return -ENOMEM;
+	if (!src) {
+		ret = -ENOMEM;
+		goto rsnd_src_probe_done;
+	}
 
 	priv->src_nr	= nr;
 	priv->src	= src;
 
-	for_each_rsnd_src(src, priv, i) {
+	i = 0;
+	for_each_child_of_node(node, np) {
+		src = rsnd_src_get(priv, i);
+
 		snprintf(name, RSND_SRC_NAME_SIZE, "%s.%d",
 			 SRC_NAME, i);
 
-		clk = devm_clk_get(dev, name);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		src->irq = irq_of_parse_and_map(np, 0);
+		if (!src->irq) {
+			ret = -EINVAL;
+			goto rsnd_src_probe_done;
+		}
 
-		src->info = &info->src_info[i];
+		clk = devm_clk_get(dev, name);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto rsnd_src_probe_done;
+		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
 				    &rsnd_src_ops, clk, RSND_MOD_SRC, i);
 		if (ret)
-			return ret;
+			goto rsnd_src_probe_done;
+
+		i++;
 	}
 
-	return 0;
+	ret = 0;
+
+rsnd_src_probe_done:
+	of_node_put(node);
+
+	return ret;
 }
 
 void rsnd_src_remove(struct platform_device *pdev,
-- 
2.6.2
