From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove struct rsnd_of_data" to
	the asoc tree
Date: Wed, 18 Nov 2015 18:09:34 +0000
Message-ID: <E1Zz7Ak-0000F1-MM@debutante>
References: <87si4ejvb8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6422C2659C7
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:40 +0100 (CET)
In-Reply-To: <87si4ejvb8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove struct rsnd_of_data

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

>From e797f58ead6069478e535ae62b180da87b28a84f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:13:33 +0000
Subject: [PATCH] ASoC: rsnd: remove struct rsnd_of_data

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
Now, platform boot style was removed from driver.
This is cleanup patch, and remove pointless struct rsnd_of_data

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  |  1 -
 sound/soc/sh/rcar/cmd.c  |  1 -
 sound/soc/sh/rcar/core.c | 25 +++++--------------------
 sound/soc/sh/rcar/ctu.c  |  1 -
 sound/soc/sh/rcar/dma.c  |  1 -
 sound/soc/sh/rcar/dvc.c  |  1 -
 sound/soc/sh/rcar/gen.c  |  1 -
 sound/soc/sh/rcar/mix.c  |  1 -
 sound/soc/sh/rcar/rsnd.h | 15 ---------------
 sound/soc/sh/rcar/src.c  |  1 -
 sound/soc/sh/rcar/ssi.c  |  1 -
 sound/soc/sh/rcar/ssiu.c |  1 -
 12 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 1dffde3218be..ba80961a8fa8 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -516,7 +516,6 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 }
 
 int rsnd_adg_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct rsnd_adg *adg;
diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 47ef47c22217..2294c5c7a25a 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -128,7 +128,6 @@ struct rsnd_mod *rsnd_cmd_mod_get(struct rsnd_priv *priv, int id)
 }
 
 int rsnd_cmd_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6043c71d10c9..8b9d721acb41 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -99,18 +99,10 @@
 #define RSND_RATES SNDRV_PCM_RATE_8000_96000
 #define RSND_FMTS (SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE)
 
-static const struct rsnd_of_data rsnd_of_data_gen1 = {
-	.flags = RSND_GEN1,
-};
-
-static const struct rsnd_of_data rsnd_of_data_gen2 = {
-	.flags = RSND_GEN2,
-};
-
 static const struct of_device_id rsnd_of_match[] = {
-	{ .compatible = "renesas,rcar_sound-gen1", .data = &rsnd_of_data_gen1 },
-	{ .compatible = "renesas,rcar_sound-gen2", .data = &rsnd_of_data_gen2 },
-	{ .compatible = "renesas,rcar_sound-gen3", .data = &rsnd_of_data_gen2 }, /* gen2 compatible */
+	{ .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
+	{ .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
+	{ .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN2 }, /* gen2 compatible */
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
@@ -569,7 +561,6 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 };
 
 static int rsnd_dai_probe(struct platform_device *pdev,
-			  const struct rsnd_of_data *of_data,
 			  struct rsnd_priv *priv)
 {
 	struct device_node *dai_node;
@@ -583,9 +574,6 @@ static int rsnd_dai_probe(struct platform_device *pdev,
 	int nr, dai_i, io_i, np_i;
 	int ret;
 
-	if (!of_data)
-		return 0;
-
 	dai_node = rsnd_dai_of_node(priv);
 	nr = of_get_child_count(dai_node);
 	if (!nr) {
@@ -1002,9 +990,7 @@ static int rsnd_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rsnd_dai *rdai;
 	const struct of_device_id *of_id = of_match_device(rsnd_of_match, dev);
-	const struct rsnd_of_data *of_data;
 	int (*probe_func[])(struct platform_device *pdev,
-			    const struct rsnd_of_data *of_data,
 			    struct rsnd_priv *priv) = {
 		rsnd_gen_probe,
 		rsnd_dma_probe,
@@ -1024,7 +1010,6 @@ static int rsnd_probe(struct platform_device *pdev)
 			    GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	of_data = of_id->data;
 
 	/*
 	 *	init priv data
@@ -1037,14 +1022,14 @@ static int rsnd_probe(struct platform_device *pdev)
 
 	priv->pdev	= pdev;
 	priv->info	= info;
-	priv->flags	= of_data->flags;
+	priv->flags	= (u32)of_id->data;
 	spin_lock_init(&priv->lock);
 
 	/*
 	 *	init each module
 	 */
 	for (i = 0; i < ARRAY_SIZE(probe_func); i++) {
-		ret = probe_func[i](pdev, of_data, priv);
+		ret = probe_func[i](pdev, priv);
 		if (ret)
 			return ret;
 	}
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 9506db4958bc..3e36a5325ce4 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -78,7 +78,6 @@ struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
 }
 
 int rsnd_ctu_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device_node *node;
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 9917b985c403..e5f435361d96 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -702,7 +702,6 @@ struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 }
 
 int rsnd_dma_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index a550b75ff9ac..d2c03bd94fcb 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -305,7 +305,6 @@ struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id)
 }
 
 int rsnd_dvc_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device_node *node;
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 099a1cd2d245..ced8acb7a7ec 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -350,7 +350,6 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
  *		Gen
  */
 int rsnd_gen_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 8b615c7aecb4..897e4f3d4c24 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -117,7 +117,6 @@ struct rsnd_mod *rsnd_mix_mod_get(struct rsnd_priv *priv, int id)
 }
 
 int rsnd_mix_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device_node *node;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index c1cf16db6405..0ad3d0d20a81 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -115,7 +115,6 @@ enum rsnd_reg {
 	RSND_REG_MAX,
 };
 
-struct rsnd_of_data;
 struct rsnd_priv;
 struct rsnd_mod;
 struct rsnd_dai;
@@ -150,7 +149,6 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 struct rsnd_mod *rsnd_dma_attach(struct rsnd_dai_stream *io,
 			       struct rsnd_mod *mod, int id);
 int rsnd_dma_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 struct dma_chan *rsnd_dma_request_channel(struct device_node *of_node,
 					  struct rsnd_mod *mod, char *name);
@@ -345,7 +343,6 @@ int rsnd_dai_connect(struct rsnd_mod *mod,
  *	R-Car Gen1/Gen2
  */
 int rsnd_gen_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void __iomem *rsnd_gen_reg_get(struct rsnd_priv *priv,
 			       struct rsnd_mod *mod,
@@ -358,7 +355,6 @@ phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id);
 int rsnd_adg_ssi_clk_stop(struct rsnd_mod *mod);
 int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *mod, unsigned int rate);
 int rsnd_adg_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void rsnd_adg_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
@@ -374,10 +370,6 @@ int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *mod,
 /*
  *	R-Car sound priv
  */
-struct rsnd_of_data {
-	u32 flags;
-};
-
 struct rsnd_priv {
 
 	struct platform_device *pdev;
@@ -515,7 +507,6 @@ int rsnd_kctrl_new_e(struct rsnd_mod *mod,
  *	R-Car SSI
  */
 int rsnd_ssi_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void rsnd_ssi_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
@@ -536,7 +527,6 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
 int rsnd_ssiu_attach(struct rsnd_dai_stream *io,
 		     struct rsnd_mod *mod);
 int rsnd_ssiu_probe(struct platform_device *pdev,
-		    const struct rsnd_of_data *of_data,
 		    struct rsnd_priv *priv);
 void rsnd_ssiu_remove(struct platform_device *pdev,
 		      struct rsnd_priv *priv);
@@ -545,7 +535,6 @@ void rsnd_ssiu_remove(struct platform_device *pdev,
  *	R-Car SRC
  */
 int rsnd_src_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void rsnd_src_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
@@ -560,7 +549,6 @@ unsigned int rsnd_src_get_ssi_rate(struct rsnd_priv *priv,
  *	R-Car CTU
  */
 int rsnd_ctu_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 
 void rsnd_ctu_remove(struct platform_device *pdev,
@@ -573,7 +561,6 @@ struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id);
  *	R-Car MIX
  */
 int rsnd_mix_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 
 void rsnd_mix_remove(struct platform_device *pdev,
@@ -586,7 +573,6 @@ struct rsnd_mod *rsnd_mix_mod_get(struct rsnd_priv *priv, int id);
  *	R-Car DVC
  */
 int rsnd_dvc_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void rsnd_dvc_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
@@ -598,7 +584,6 @@ struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id);
  *	R-Car CMD
  */
 int rsnd_cmd_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv);
 void rsnd_cmd_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index f965fea7aa50..c0f7e2a4b688 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -554,7 +554,6 @@ struct rsnd_mod *rsnd_src_mod_get(struct rsnd_priv *priv, int id)
 }
 
 int rsnd_src_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device_node *node;
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 1f1ecedabb5d..848c06436226 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -724,7 +724,6 @@ int __rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod)
 }
 
 int rsnd_ssi_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
 	struct device_node *node;
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index fc5ec17fe37e..89b1bc77cb8a 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -137,7 +137,6 @@ int rsnd_ssiu_attach(struct rsnd_dai_stream *io,
 }
 
 int rsnd_ssiu_probe(struct platform_device *pdev,
-		    const struct rsnd_of_data *of_data,
 		    struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-- 
2.6.2
