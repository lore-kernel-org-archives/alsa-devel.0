From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove Gen1 support from SRC" to
	the asoc tree
Date: Wed, 18 Nov 2015 18:09:43 +0000
Message-ID: <E1Zz7At-0000Lv-NF@debutante>
References: <877flqla1r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA985265CA3
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:48 +0100 (CET)
In-Reply-To: <877flqla1r.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: remove Gen1 support from SRC

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

>From e8e7b7bdc65c19f8d84c25f7e0d21176d598c870 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:09:52 +0000
Subject: [PATCH] ASoC: rsnd: remove Gen1 support from SRC

This patch removes SRC Gen1 support which has no user on upstream.
Historically, SRC Gen1 was created as prepare for SRC Gen2 support.
It works well for Gen2 support, but Gen1 is not same as Gen2.
So now, Gen1 support is no longer needed. Thanks Gen1 and Bye-bye.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c  |  62 ---------------
 sound/soc/sh/rcar/gen.c  |  38 +--------
 sound/soc/sh/rcar/rsnd.h |  15 ----
 sound/soc/sh/rcar/src.c  | 199 ++---------------------------------------------
 4 files changed, 7 insertions(+), 307 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 1946ce8baf2e..1dffde3218be 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -242,68 +242,6 @@ int rsnd_adg_set_convert_timing_gen2(struct rsnd_mod *src_mod,
 	return rsnd_adg_set_src_timsel_gen2(src_mod, io, val);
 }
 
-int rsnd_adg_set_convert_clk_gen1(struct rsnd_priv *priv,
-				  struct rsnd_mod *mod,
-				  unsigned int src_rate,
-				  unsigned int dst_rate)
-{
-	struct rsnd_adg *adg = rsnd_priv_to_adg(priv);
-	struct rsnd_mod *adg_mod = rsnd_mod_get(adg);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	int idx, sel, div, shift;
-	u32 mask, val;
-	int id = rsnd_mod_id(mod);
-	unsigned int sel_rate [] = {
-		clk_get_rate(adg->clk[CLKA]),	/* 000: CLKA */
-		clk_get_rate(adg->clk[CLKB]),	/* 001: CLKB */
-		clk_get_rate(adg->clk[CLKC]),	/* 010: CLKC */
-		0,				/* 011: MLBCLK (not used) */
-		adg->rbga_rate_for_441khz,	/* 100: RBGA */
-		adg->rbgb_rate_for_48khz,	/* 101: RBGB */
-	};
-
-	/* find div (= 1/128, 1/256, 1/512, 1/1024, 1/2048 */
-	for (sel = 0; sel < ARRAY_SIZE(sel_rate); sel++) {
-		for (div  = 128,	idx = 0;
-		     div <= 2048;
-		     div *= 2,		idx++) {
-			if (src_rate == sel_rate[sel] / div) {
-				val = (idx << 4) | sel;
-				goto find_rate;
-			}
-		}
-	}
-	dev_err(dev, "can't find convert src clk\n");
-	return -EINVAL;
-
-find_rate:
-	shift	= (id % 4) * 8;
-	mask	= 0xFF << shift;
-	val	= val << shift;
-
-	dev_dbg(dev, "adg convert src clk = %02x\n", val);
-
-	switch (id / 4) {
-	case 0:
-		rsnd_mod_bset(adg_mod, AUDIO_CLK_SEL3, mask, val);
-		break;
-	case 1:
-		rsnd_mod_bset(adg_mod, AUDIO_CLK_SEL4, mask, val);
-		break;
-	case 2:
-		rsnd_mod_bset(adg_mod, AUDIO_CLK_SEL5, mask, val);
-		break;
-	}
-
-	/*
-	 * Gen1 doesn't need dst_rate settings,
-	 * since it uses SSI WS pin.
-	 * see also rsnd_src_set_route_if_gen1()
-	 */
-
-	return 0;
-}
-
 static void rsnd_adg_set_ssi_clk(struct rsnd_mod *ssi_mod, u32 val)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(ssi_mod);
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 76da7620904c..1808fc64646c 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -320,43 +320,12 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 static int rsnd_gen1_probe(struct platform_device *pdev,
 			   struct rsnd_priv *priv)
 {
-	struct rsnd_regmap_field_conf conf_sru[] = {
-		RSND_GEN_S_REG(SRC_ROUTE_SEL,	0x00),
-		RSND_GEN_S_REG(SRC_TMG_SEL0,	0x08),
-		RSND_GEN_S_REG(SRC_TMG_SEL1,	0x0c),
-		RSND_GEN_S_REG(SRC_TMG_SEL2,	0x10),
-		RSND_GEN_S_REG(SRC_ROUTE_CTRL,	0xc0),
-		RSND_GEN_S_REG(SSI_MODE0,	0xD0),
-		RSND_GEN_S_REG(SSI_MODE1,	0xD4),
-		RSND_GEN_M_REG(SRC_BUSIF_MODE,	0x20,	0x4),
-		RSND_GEN_M_REG(SRC_ROUTE_MODE0,	0x50,	0x8),
-		RSND_GEN_M_REG(SRC_SWRSR,	0x200,	0x40),
-		RSND_GEN_M_REG(SRC_SRCIR,	0x204,	0x40),
-		RSND_GEN_M_REG(SRC_ADINR,	0x214,	0x40),
-		RSND_GEN_M_REG(SRC_IFSCR,	0x21c,	0x40),
-		RSND_GEN_M_REG(SRC_IFSVR,	0x220,	0x40),
-		RSND_GEN_M_REG(SRC_SRCCR,	0x224,	0x40),
-		RSND_GEN_M_REG(SRC_MNFSR,	0x228,	0x40),
-		/*
-		 * ADD US
-		 *
-		 * SRC_STATUS
-		 * SRC_INT_EN
-		 * SCU_SYS_STATUS0
-		 * SCU_SYS_STATUS1
-		 * SCU_SYS_INT_EN0
-		 * SCU_SYS_INT_EN1
-		 */
-	};
 	struct rsnd_regmap_field_conf conf_adg[] = {
 		RSND_GEN_S_REG(BRRA,		0x00),
 		RSND_GEN_S_REG(BRRB,		0x04),
 		RSND_GEN_S_REG(SSICKR,		0x08),
 		RSND_GEN_S_REG(AUDIO_CLK_SEL0,	0x0c),
 		RSND_GEN_S_REG(AUDIO_CLK_SEL1,	0x10),
-		RSND_GEN_S_REG(AUDIO_CLK_SEL3,	0x18),
-		RSND_GEN_S_REG(AUDIO_CLK_SEL4,	0x1c),
-		RSND_GEN_S_REG(AUDIO_CLK_SEL5,	0x20),
 	};
 	struct rsnd_regmap_field_conf conf_ssi[] = {
 		RSND_GEN_M_REG(SSICR,		0x00,	0x40),
@@ -365,17 +334,14 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
 		RSND_GEN_M_REG(SSIRDR,		0x0c,	0x40),
 		RSND_GEN_M_REG(SSIWSR,		0x20,	0x40),
 	};
-	int ret_sru;
 	int ret_adg;
 	int ret_ssi;
 
-	ret_sru  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SRU, "sru", conf_sru);
 	ret_adg  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_ADG, "adg", conf_adg);
 	ret_ssi  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SSI, "ssi", conf_ssi);
-	if (ret_sru  < 0 ||
-	    ret_adg  < 0 ||
+	if (ret_adg  < 0 ||
 	    ret_ssi  < 0)
-		return ret_sru | ret_adg | ret_ssi;
+		return ret_adg | ret_ssi;
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 8efa19fa2b6e..da671869f12a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -117,17 +117,6 @@ enum rsnd_reg {
 	RSND_REG_MAX,
 };
 
-/* Gen1 only */
-#define RSND_REG_SRC_ROUTE_SEL		RSND_REG_SHARE01
-#define RSND_REG_SRC_TMG_SEL0		RSND_REG_SHARE02
-#define RSND_REG_SRC_TMG_SEL1		RSND_REG_SHARE03
-#define RSND_REG_SRC_TMG_SEL2		RSND_REG_SHARE04
-#define RSND_REG_SRC_ROUTE_CTRL		RSND_REG_SHARE05
-#define RSND_REG_SRC_MNFSR		RSND_REG_SHARE06
-#define RSND_REG_AUDIO_CLK_SEL3		RSND_REG_SHARE07
-#define RSND_REG_AUDIO_CLK_SEL4		RSND_REG_SHARE08
-#define RSND_REG_AUDIO_CLK_SEL5		RSND_REG_SHARE09
-
 /* Gen2 only */
 #define RSND_REG_SRC_CTRL		RSND_REG_SHARE01
 #define RSND_REG_SSI_CTRL		RSND_REG_SHARE02
@@ -407,10 +396,6 @@ int rsnd_adg_probe(struct platform_device *pdev,
 		   struct rsnd_priv *priv);
 void rsnd_adg_remove(struct platform_device *pdev,
 		     struct rsnd_priv *priv);
-int rsnd_adg_set_convert_clk_gen1(struct rsnd_priv *priv,
-				  struct rsnd_mod *mod,
-				  unsigned int src_rate,
-				  unsigned int dst_rate);
 int rsnd_adg_set_convert_clk_gen2(struct rsnd_mod *mod,
 				  struct rsnd_dai_stream *io,
 				  unsigned int src_rate,
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 776b0efec4d6..0978221b2fe1 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -310,187 +310,6 @@ static int rsnd_src_stop(struct rsnd_mod *mod)
 }
 
 /*
- *		Gen1 functions
- */
-static int rsnd_src_set_route_gen1(struct rsnd_dai_stream *io,
-				   struct rsnd_mod *mod)
-{
-	struct src_route_config {
-		u32 mask;
-		int shift;
-	} routes[] = {
-		{ 0xF,  0, }, /* 0 */
-		{ 0xF,  4, }, /* 1 */
-		{ 0xF,  8, }, /* 2 */
-		{ 0x7, 12, }, /* 3 */
-		{ 0x7, 16, }, /* 4 */
-		{ 0x7, 20, }, /* 5 */
-		{ 0x7, 24, }, /* 6 */
-		{ 0x3, 28, }, /* 7 */
-		{ 0x3, 30, }, /* 8 */
-	};
-	u32 mask;
-	u32 val;
-	int id;
-
-	id = rsnd_mod_id(mod);
-	if (id < 0 || id >= ARRAY_SIZE(routes))
-		return -EIO;
-
-	/*
-	 * SRC_ROUTE_SELECT
-	 */
-	val = rsnd_io_is_play(io) ? 0x1 : 0x2;
-	val = val		<< routes[id].shift;
-	mask = routes[id].mask	<< routes[id].shift;
-
-	rsnd_mod_bset(mod, SRC_ROUTE_SEL, mask, val);
-
-	return 0;
-}
-
-static int rsnd_src_set_convert_timing_gen1(struct rsnd_dai_stream *io,
-					    struct rsnd_mod *mod)
-{
-	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
-	struct rsnd_src *src = rsnd_mod_to_src(mod);
-	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	u32 convert_rate = rsnd_src_convert_rate(io, src);
-	u32 mask;
-	u32 val;
-	int shift;
-	int id = rsnd_mod_id(mod);
-	int ret;
-
-	/*
-	 * SRC_TIMING_SELECT
-	 */
-	shift	= (id % 4) * 8;
-	mask	= 0x1F << shift;
-
-	/*
-	 * ADG is used as source clock if SRC was used,
-	 * then, SSI WS is used as destination clock.
-	 * SSI WS is used as source clock if SRC is not used
-	 * (when playback, source/destination become reverse when capture)
-	 */
-	ret = 0;
-	if (convert_rate) {
-		/* use ADG */
-		val = 0;
-		ret = rsnd_adg_set_convert_clk_gen1(priv, mod,
-						    runtime->rate,
-						    convert_rate);
-	} else if (8 == id) {
-		/* use SSI WS, but SRU8 is special */
-		val = id << shift;
-	} else {
-		/* use SSI WS */
-		val = (id + 1) << shift;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	switch (id / 4) {
-	case 0:
-		rsnd_mod_bset(mod, SRC_TMG_SEL0, mask, val);
-		break;
-	case 1:
-		rsnd_mod_bset(mod, SRC_TMG_SEL1, mask, val);
-		break;
-	case 2:
-		rsnd_mod_bset(mod, SRC_TMG_SEL2, mask, val);
-		break;
-	}
-
-	return 0;
-}
-
-static int rsnd_src_set_convert_rate_gen1(struct rsnd_mod *mod,
-					  struct rsnd_dai_stream *io)
-{
-	struct rsnd_src *src = rsnd_mod_to_src(mod);
-	int ret;
-
-	ret = rsnd_src_set_convert_rate(mod, io);
-	if (ret < 0)
-		return ret;
-
-	/* Select SRC mode (fixed value) */
-	rsnd_mod_write(mod, SRC_SRCCR, 0x00010110);
-
-	/* Set the restriction value of the FS ratio (98%) */
-	rsnd_mod_write(mod, SRC_MNFSR,
-		       rsnd_mod_read(mod, SRC_IFSVR) / 100 * 98);
-
-	/* Gen1/Gen2 are not compatible */
-	if (rsnd_src_convert_rate(io, src))
-		rsnd_mod_write(mod, SRC_ROUTE_MODE0, 1);
-
-	/* no SRC_BFSSR settings, since SRC_SRCCR::BUFMD is 0 */
-
-	return 0;
-}
-
-static int rsnd_src_init_gen1(struct rsnd_mod *mod,
-			      struct rsnd_dai_stream *io,
-			      struct rsnd_priv *priv)
-{
-	int ret;
-
-	ret = rsnd_src_init(mod, priv);
-	if (ret < 0)
-		return ret;
-
-	ret = rsnd_src_set_route_gen1(io, mod);
-	if (ret < 0)
-		return ret;
-
-	ret = rsnd_src_set_convert_rate_gen1(mod, io);
-	if (ret < 0)
-		return ret;
-
-	ret = rsnd_src_set_convert_timing_gen1(io, mod);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int rsnd_src_start_gen1(struct rsnd_mod *mod,
-			       struct rsnd_dai_stream *io,
-			       struct rsnd_priv *priv)
-{
-	int id = rsnd_mod_id(mod);
-
-	rsnd_mod_bset(mod, SRC_ROUTE_CTRL, (1 << id), (1 << id));
-
-	return rsnd_src_start(mod);
-}
-
-static int rsnd_src_stop_gen1(struct rsnd_mod *mod,
-			      struct rsnd_dai_stream *io,
-			      struct rsnd_priv *priv)
-{
-	int id = rsnd_mod_id(mod);
-
-	rsnd_mod_bset(mod, SRC_ROUTE_CTRL, (1 << id), 0);
-
-	return rsnd_src_stop(mod);
-}
-
-static struct rsnd_mod_ops rsnd_src_gen1_ops = {
-	.name	= SRC_NAME,
-	.dma_req = rsnd_src_dma_req,
-	.init	= rsnd_src_init_gen1,
-	.quit	= rsnd_src_quit,
-	.start	= rsnd_src_start_gen1,
-	.stop	= rsnd_src_stop_gen1,
-	.hw_params = rsnd_src_hw_params,
-};
-
-/*
  *		Gen2 functions
  */
 #define rsnd_src_irq_enable_gen2(mod)  rsnd_src_irq_ctrol_gen2(mod, 1)
@@ -927,22 +746,13 @@ int rsnd_src_probe(struct platform_device *pdev,
 	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_src *src;
-	struct rsnd_mod_ops *ops;
 	struct clk *clk;
 	char name[RSND_SRC_NAME_SIZE];
 	int i, nr, ret;
 
-	ops = NULL;
-	if (rsnd_is_gen1(priv)) {
-		ops = &rsnd_src_gen1_ops;
-		dev_warn(dev, "Gen1 support will be removed soon\n");
-	}
-	if (rsnd_is_gen2(priv))
-		ops = &rsnd_src_gen2_ops;
-	if (!ops) {
-		dev_err(dev, "unknown Generation\n");
-		return -EIO;
-	}
+	/* This driver doesn't support Gen1 at this point */
+	if (rsnd_is_gen1(priv))
+		return 0;
 
 	rsnd_of_parse_src(pdev, of_data, priv);
 
@@ -970,7 +780,8 @@ int rsnd_src_probe(struct platform_device *pdev,
 
 		src->info = &info->src_info[i];
 
-		ret = rsnd_mod_init(priv, rsnd_mod_get(src), ops, clk, RSND_MOD_SRC, i);
+		ret = rsnd_mod_init(priv, rsnd_mod_get(src),
+				    &rsnd_src_gen2_ops, clk, RSND_MOD_SRC, i);
 		if (ret)
 			return ret;
 	}
-- 
2.6.2
