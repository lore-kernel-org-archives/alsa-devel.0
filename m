From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove platform boot support from
	gen.c" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:35 +0000
Message-ID: <E1Zz7Al-0000Fc-Jq@debutante>
References: <87twoujvbw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DD22265A2E
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:40 +0100 (CET)
In-Reply-To: <87twoujvbw.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove platform boot support from gen.c

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

>From 348d592c719da61a7dab289c7ce36e73c7caf063 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:13:12 +0000
Subject: [PATCH] ASoC: rsnd: remove platform boot support from gen.c

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
This patch removes platform boot support from gen.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  1 +
 sound/soc/sh/rcar/gen.c  | 14 --------------
 sound/soc/sh/rcar/rsnd.h |  7 ++++---
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 039d6cba8414..6043c71d10c9 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1037,6 +1037,7 @@ static int rsnd_probe(struct platform_device *pdev)
 
 	priv->pdev	= pdev;
 	priv->info	= info;
+	priv->flags	= of_data->flags;
 	spin_lock_init(&priv->lock);
 
 	/*
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 1808fc64646c..099a1cd2d245 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -349,18 +349,6 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
 /*
  *		Gen
  */
-static void rsnd_of_parse_gen(struct platform_device *pdev,
-			      const struct rsnd_of_data *of_data,
-			      struct rsnd_priv *priv)
-{
-	struct rcar_snd_info *info = priv->info;
-
-	if (!of_data)
-		return;
-
-	info->flags = of_data->flags;
-}
-
 int rsnd_gen_probe(struct platform_device *pdev,
 		   const struct rsnd_of_data *of_data,
 		   struct rsnd_priv *priv)
@@ -369,8 +357,6 @@ int rsnd_gen_probe(struct platform_device *pdev,
 	struct rsnd_gen *gen;
 	int ret;
 
-	rsnd_of_parse_gen(pdev, of_data, priv);
-
 	gen = devm_kzalloc(dev, sizeof(*gen), GFP_KERNEL);
 	if (!gen) {
 		dev_err(dev, "GEN allocate failed\n");
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 23507c8d79c2..c1cf16db6405 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -352,9 +352,6 @@ void __iomem *rsnd_gen_reg_get(struct rsnd_priv *priv,
 			       enum rsnd_reg reg);
 phys_addr_t rsnd_gen_get_phy_addr(struct rsnd_priv *priv, int reg_id);
 
-#define rsnd_is_gen1(s)		(((s)->info->flags & RSND_GEN_MASK) == RSND_GEN1)
-#define rsnd_is_gen2(s)		(((s)->info->flags & RSND_GEN_MASK) == RSND_GEN2)
-
 /*
  *	R-Car ADG
  */
@@ -386,6 +383,7 @@ struct rsnd_priv {
 	struct platform_device *pdev;
 	struct rcar_snd_info *info;
 	spinlock_t lock;
+	u32 flags;
 
 	/*
 	 * below value will be filled on rsnd_gen_probe()
@@ -456,6 +454,9 @@ struct rsnd_priv {
 #define rsnd_priv_to_dev(priv)	(&(rsnd_priv_to_pdev(priv)->dev))
 #define rsnd_priv_to_info(priv)	((priv)->info)
 
+#define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
+#define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
+
 /*
  *	rsnd_kctrl
  */
-- 
2.6.2
