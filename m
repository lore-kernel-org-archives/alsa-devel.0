From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove platform boot support from
	dvc.c" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:36 +0000
Message-ID: <E1Zz7Am-0000GB-Gu@debutante>
References: <87vb9ajvcf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C2DB265A36
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:41 +0100 (CET)
In-Reply-To: <87vb9ajvcf.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove platform boot support from dvc.c

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

>From 9eaa1a6f7e31ead7e2b8eb762455e77376bd87cc Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:12:50 +0000
Subject: [PATCH] ASoC: rsnd: remove platform boot support from dvc.c

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
This patch removes platform boot support from dvc.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 83 ++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 52 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index d2bd4804db0d..a550b75ff9ac 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -15,7 +15,6 @@
 #define DVC_NAME "dvc"
 
 struct rsnd_dvc {
-	struct rsnd_dvc_platform_info *info; /* rcar_snd.h */
 	struct rsnd_mod mod;
 	struct rsnd_kctrl_cfg_m volume;
 	struct rsnd_kctrl_cfg_m mute;
@@ -24,6 +23,7 @@ struct rsnd_dvc {
 	struct rsnd_kctrl_cfg_s rdown;	/* Ramp Rate Down */
 };
 
+#define rsnd_dvc_get(priv, id) ((struct rsnd_dvc *)(priv->dvc) + id)
 #define rsnd_dvc_nr(priv) ((priv)->dvc_nr)
 #define rsnd_dvc_of_node(priv) \
 	of_get_child_by_name(rsnd_priv_to_dev(priv)->of_node, "rcar_sound,dvc")
@@ -301,50 +301,15 @@ struct rsnd_mod *rsnd_dvc_mod_get(struct rsnd_priv *priv, int id)
 	if (WARN_ON(id < 0 || id >= rsnd_dvc_nr(priv)))
 		id = 0;
 
-	return rsnd_mod_get((struct rsnd_dvc *)(priv->dvc) + id);
-}
-
-static void rsnd_of_parse_dvc(struct platform_device *pdev,
-			      const struct rsnd_of_data *of_data,
-			      struct rsnd_priv *priv)
-{
-	struct device_node *node;
-	struct rsnd_dvc_platform_info *dvc_info;
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
-	struct device *dev = &pdev->dev;
-	int nr;
-
-	if (!of_data)
-		return;
-
-	node = rsnd_dvc_of_node(priv);
-	if (!node)
-		return;
-
-	nr = of_get_child_count(node);
-	if (!nr)
-		goto rsnd_of_parse_dvc_end;
-
-	dvc_info = devm_kzalloc(dev,
-				sizeof(struct rsnd_dvc_platform_info) * nr,
-				GFP_KERNEL);
-	if (!dvc_info) {
-		dev_err(dev, "dvc info allocation error\n");
-		goto rsnd_of_parse_dvc_end;
-	}
-
-	info->dvc_info		= dvc_info;
-	info->dvc_info_nr	= nr;
-
-rsnd_of_parse_dvc_end:
-	of_node_put(node);
+	return rsnd_mod_get(rsnd_dvc_get(priv, id));
 }
 
 int rsnd_dvc_probe(struct platform_device *pdev,
 		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
 {
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
+	struct device_node *node;
+	struct device_node *np;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_dvc *dvc;
 	struct clk *clk;
@@ -355,36 +320,50 @@ int rsnd_dvc_probe(struct platform_device *pdev,
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	rsnd_of_parse_dvc(pdev, of_data, priv);
+	node = rsnd_dvc_of_node(priv);
+	if (!node)
+		return 0; /* not used is not error */
 
-	nr = info->dvc_info_nr;
-	if (!nr)
-		return 0;
+	nr = of_get_child_count(node);
+	if (!nr) {
+		ret = -EINVAL;
+		goto rsnd_dvc_probe_done;
+	}
 
 	dvc	= devm_kzalloc(dev, sizeof(*dvc) * nr, GFP_KERNEL);
-	if (!dvc)
-		return -ENOMEM;
+	if (!dvc) {
+		ret = -ENOMEM;
+		goto rsnd_dvc_probe_done;
+	}
 
 	priv->dvc_nr	= nr;
 	priv->dvc	= dvc;
 
-	for_each_rsnd_dvc(dvc, priv, i) {
+	i = 0;
+	for_each_child_of_node(node, np) {
+		dvc = rsnd_dvc_get(priv, i);
+
 		snprintf(name, RSND_DVC_NAME_SIZE, "%s.%d",
 			 DVC_NAME, i);
 
 		clk = devm_clk_get(dev, name);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-
-		dvc->info = &info->dvc_info[i];
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto rsnd_dvc_probe_done;
+		}
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(dvc), &rsnd_dvc_ops,
 			      clk, RSND_MOD_DVC, i);
 		if (ret)
-			return ret;
+			goto rsnd_dvc_probe_done;
+
+		i++;
 	}
 
-	return 0;
+rsnd_dvc_probe_done:
+	of_node_put(node);
+
+	return ret;
 }
 
 void rsnd_dvc_remove(struct platform_device *pdev,
-- 
2.6.2
