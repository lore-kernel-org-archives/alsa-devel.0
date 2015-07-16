From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup SRC position on each code"
	to the asoc tree
Date: Thu, 16 Jul 2015 22:29:49 +0100
Message-ID: <E1ZFqiz-0004fz-OK@finisterre>
References: <878uahvqop.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 009182605D2
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:29:55 +0200 (CEST)
In-Reply-To: <878uahvqop.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: tidyup SRC position on each code

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

>From 78edead4494219640d9fdf37d76beae24f79de9e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:16:37 +0000
Subject: [PATCH] ASoC: rsnd: tidyup SRC position on each code

This is cleanup for CTU/MIX support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/Makefile |  2 +-
 sound/soc/sh/rcar/core.c   |  8 ++++----
 sound/soc/sh/rcar/rsnd.h   | 38 +++++++++++++++++++-------------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sh/rcar/Makefile b/sound/soc/sh/rcar/Makefile
index f1b4451..3a274fd 100644
--- a/sound/soc/sh/rcar/Makefile
+++ b/sound/soc/sh/rcar/Makefile
@@ -1,4 +1,4 @@
-snd-soc-rcar-objs	:= core.o gen.o dma.o src.o adg.o ssi.o dvc.o
+snd-soc-rcar-objs	:= core.o gen.o dma.o adg.o ssi.o src.o dvc.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
 
 snd-soc-rsrc-card-objs	:= rsrc-card.o
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8919afa..e20d8ea 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -641,13 +641,13 @@ static int rsnd_path_init(struct rsnd_priv *priv,
 	 * using fixed path.
 	 */
 
-	/* SRC */
-	ret = rsnd_path_add(priv, io, src);
+	/* SSI */
+	ret = rsnd_path_add(priv, io, ssi);
 	if (ret < 0)
 		return ret;
 
-	/* SSI */
-	ret = rsnd_path_add(priv, io, ssi);
+	/* SRC */
+	ret = rsnd_path_add(priv, io, src);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 5f5b8b1..7fee207 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -441,12 +441,6 @@ struct rsnd_priv {
 	void *gen;
 
 	/*
-	 * below value will be filled on rsnd_src_probe()
-	 */
-	void *src;
-	int src_nr;
-
-	/*
 	 * below value will be filled on rsnd_adg_probe()
 	 */
 	void *adg;
@@ -463,6 +457,12 @@ struct rsnd_priv {
 	int ssi_nr;
 
 	/*
+	 * below value will be filled on rsnd_src_probe()
+	 */
+	void *src;
+	int src_nr;
+
+	/*
 	 * below value will be filled on rsnd_dvc_probe()
 	 */
 	void *dvc;
@@ -535,6 +535,19 @@ int rsnd_kctrl_new_e(struct rsnd_mod *mod,
 		     u32 max);
 
 /*
+ *	R-Car SSI
+ */
+int rsnd_ssi_probe(struct platform_device *pdev,
+		   const struct rsnd_of_data *of_data,
+		   struct rsnd_priv *priv);
+void rsnd_ssi_remove(struct platform_device *pdev,
+		     struct rsnd_priv *priv);
+struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
+int rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
+int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
+int rsnd_ssi_use_busif(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
+
+/*
  *	R-Car SRC
  */
 int rsnd_src_probe(struct platform_device *pdev,
@@ -555,19 +568,6 @@ int rsnd_src_ssi_irq_enable(struct rsnd_mod *ssi_mod);
 int rsnd_src_ssi_irq_disable(struct rsnd_mod *ssi_mod);
 
 /*
- *	R-Car SSI
- */
-int rsnd_ssi_probe(struct platform_device *pdev,
-		   const struct rsnd_of_data *of_data,
-		   struct rsnd_priv *priv);
-void rsnd_ssi_remove(struct platform_device *pdev,
-		     struct rsnd_priv *priv);
-struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
-int rsnd_ssi_is_pin_sharing(struct rsnd_mod *mod);
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
-int rsnd_ssi_use_busif(struct rsnd_dai_stream *io, struct rsnd_mod *mod);
-
-/*
  *	R-Car DVC
  */
 int rsnd_dvc_probe(struct platform_device *pdev,
-- 
2.1.4
