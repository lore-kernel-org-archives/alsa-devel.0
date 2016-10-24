From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add gating for source clocks of the FLLs" to the asoc tree
Date: Mon, 24 Oct 2016 19:04:38 +0100
Message-ID: <E1byjby-0001VQ-5e@debutante>
References: <1472831568-466-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472831568-466-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>, lee.jones@linaro.orgbroonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.coms.nawrocki@samsung.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add gating for source clocks of the FLLs

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

>From ae1ea48c5c5998c5730cebaa2374ab02ad4d7d4f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 21 Oct 2016 14:15:58 +0100
Subject: [PATCH] ASoC: arizona: Add gating for source clocks of the FLLs

Whilst ultimately we would like to move all the clocking over to the
clock framework, as an intermediate step to get people going for now
enable the source clocks for FLLs as they are powered up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 10be50ae2f76..7f7d4b31a7fd 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2282,6 +2282,42 @@ static int arizona_is_enabled_fll(struct arizona_fll *fll, int base)
 	return reg & ARIZONA_FLL1_ENA;
 }
 
+static int arizona_set_fll_clks(struct arizona_fll *fll, int base, bool ena)
+{
+	struct arizona *arizona = fll->arizona;
+	unsigned int val;
+	struct clk *clk;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, base + 6, &val);
+	if (ret != 0) {
+		arizona_fll_err(fll, "Failed to read current source: %d\n",
+				ret);
+		return ret;
+	}
+
+	val &= ARIZONA_FLL1_CLK_REF_SRC_MASK;
+	val >>= ARIZONA_FLL1_CLK_REF_SRC_SHIFT;
+
+	switch (val) {
+	case ARIZONA_FLL_SRC_MCLK1:
+		clk = arizona->mclk[ARIZONA_MCLK1];
+		break;
+	case ARIZONA_FLL_SRC_MCLK2:
+		clk = arizona->mclk[ARIZONA_MCLK2];
+		break;
+	default:
+		return 0;
+	}
+
+	if (ena) {
+		return clk_prepare_enable(clk);
+	} else {
+		clk_disable_unprepare(clk);
+		return 0;
+	}
+}
+
 static int arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
@@ -2304,6 +2340,10 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 		udelay(32);
 		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
 					 ARIZONA_FLL1_GAIN_MASK, 0);
+
+		if (arizona_is_enabled_fll(fll, fll->base + 0x10) > 0)
+			arizona_set_fll_clks(fll, fll->base + 0x10, false);
+		arizona_set_fll_clks(fll, fll->base, false);
 	}
 
 	/*
@@ -2358,10 +2398,13 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	if (!already_enabled)
 		pm_runtime_get_sync(arizona->dev);
 
-	if (use_sync)
+	if (use_sync) {
+		arizona_set_fll_clks(fll, fll->base + 0x10, true);
 		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
 					 ARIZONA_FLL1_SYNC_ENA,
 					 ARIZONA_FLL1_SYNC_ENA);
+	}
+	arizona_set_fll_clks(fll, fll->base, true);
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 
@@ -2394,19 +2437,24 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 static void arizona_disable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
-	bool change;
+	bool ref_change, sync_change;
 
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
 	regmap_update_bits_check(arizona->regmap, fll->base + 1,
-				 ARIZONA_FLL1_ENA, 0, &change);
-	regmap_update_bits(arizona->regmap, fll->base + 0x11,
-			   ARIZONA_FLL1_SYNC_ENA, 0);
+				 ARIZONA_FLL1_ENA, 0, &ref_change);
+	regmap_update_bits_check(arizona->regmap, fll->base + 0x11,
+				 ARIZONA_FLL1_SYNC_ENA, 0, &sync_change);
 	regmap_update_bits_async(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_FREERUN, 0);
 
-	if (change)
+	if (sync_change)
+		arizona_set_fll_clks(fll, fll->base + 0x10, false);
+
+	if (ref_change) {
+		arizona_set_fll_clks(fll, fll->base, false);
 		pm_runtime_put_autosuspend(arizona->dev);
+	}
 }
 
 int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
-- 
2.8.1
