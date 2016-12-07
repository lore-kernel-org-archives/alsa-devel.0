From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: enable/disable ADG when
	suspend/resume timing" to the asoc tree
Date: Wed, 07 Dec 2016 15:50:18 +0000
Message-ID: <E1cEeU6-0000mt-KI@finisterre>
References: <87r35k37np.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACFFC267211
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 16:50:30 +0100 (CET)
In-Reply-To: <87r35k37np.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Gaku Inami <gaku.inami.xw@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: enable/disable ADG when suspend/resume timing

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

>From c2d3171847611e8a33d3e10a9942f6c065d05c1f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 7 Dec 2016 00:29:02 +0000
Subject: [PATCH] ASoC: rsnd: enable/disable ADG when suspend/resume timing

Current rsnd driver enables ADG clock when .probe timing,
but it breaks sound after Suspend/Resume. These should be setups
every suspend/resume timing too.
This patch is tested on R-Car Gen3 Salvator-X board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  | 38 ++++++++++++++++++++++++--------------
 sound/soc/sh/rcar/core.c | 24 ++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h |  3 +++
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 545377dc15ed..54b28fd502ef 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -376,6 +376,25 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 	return 0;
 }
 
+void rsnd_adg_clk_control(struct rsnd_priv *priv, int enable)
+{
+	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct clk *clk;
+	int i, ret;
+
+	for_each_rsnd_clk(clk, adg, i) {
+		ret = 0;
+		if (enable)
+			ret = clk_prepare_enable(clk);
+		else
+			clk_disable_unprepare(clk);
+
+		if (ret < 0)
+			dev_warn(dev, "can't use clk %d\n", i);
+	}
+}
+
 static void rsnd_adg_get_clkin(struct rsnd_priv *priv,
 			       struct rsnd_adg *adg)
 {
@@ -387,20 +406,15 @@ static void rsnd_adg_get_clkin(struct rsnd_priv *priv,
 		[CLKC]	= "clk_c",
 		[CLKI]	= "clk_i",
 	};
-	int i, ret;
+	int i;
 
 	for (i = 0; i < CLKMAX; i++) {
 		clk = devm_clk_get(dev, clk_name[i]);
 		adg->clk[i] = IS_ERR(clk) ? NULL : clk;
 	}
 
-	for_each_rsnd_clk(clk, adg, i) {
-		ret = clk_prepare_enable(clk);
-		if (ret < 0)
-			dev_warn(dev, "can't use clk %d\n", i);
-
+	for_each_rsnd_clk(clk, adg, i)
 		dev_dbg(dev, "clk %d : %p : %ld\n", i, clk, clk_get_rate(clk));
-	}
 }
 
 static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
@@ -565,16 +579,12 @@ int rsnd_adg_probe(struct rsnd_priv *priv)
 
 	priv->adg = adg;
 
+	rsnd_adg_clk_enable(priv);
+
 	return 0;
 }
 
 void rsnd_adg_remove(struct rsnd_priv *priv)
 {
-	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
-	struct clk *clk;
-	int i;
-
-	for_each_rsnd_clk(clk, adg, i) {
-		clk_disable_unprepare(clk);
-	}
+	rsnd_adg_clk_disable(priv);
 }
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 825635aaf30e..4bd68de76130 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1308,9 +1308,33 @@ static int rsnd_remove(struct platform_device *pdev)
 	return ret;
 }
 
+static int rsnd_suspend(struct device *dev)
+{
+	struct rsnd_priv *priv = dev_get_drvdata(dev);
+
+	rsnd_adg_clk_disable(priv);
+
+	return 0;
+}
+
+static int rsnd_resume(struct device *dev)
+{
+	struct rsnd_priv *priv = dev_get_drvdata(dev);
+
+	rsnd_adg_clk_enable(priv);
+
+	return 0;
+}
+
+static struct dev_pm_ops rsnd_pm_ops = {
+	.suspend		= rsnd_suspend,
+	.resume			= rsnd_resume,
+};
+
 static struct platform_driver rsnd_driver = {
 	.driver	= {
 		.name	= "rcar_sound",
+		.pm	= &rsnd_pm_ops,
 		.of_match_table = rsnd_of_match,
 	},
 	.probe		= rsnd_probe,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 71158c8bc254..b90df77662df 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -499,6 +499,9 @@ int rsnd_adg_set_src_timesel_gen2(struct rsnd_mod *src_mod,
 				  unsigned int out_rate);
 int rsnd_adg_set_cmd_timsel_gen2(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io);
+#define rsnd_adg_clk_enable(priv)	rsnd_adg_clk_control(priv, 1)
+#define rsnd_adg_clk_disable(priv)	rsnd_adg_clk_control(priv, 0)
+void rsnd_adg_clk_control(struct rsnd_priv *priv, int enable);
 
 /*
  *	R-Car sound priv
-- 
2.10.2
