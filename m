From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH RESEND 2/2] ASoC: arizona: Add gating for
	source clocks of the FLLs
Date: Fri, 21 Oct 2016 14:15:58 +0100
Message-ID: <1477055758-11490-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1477055758-11490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F092671FB
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 15:15:46 +0200 (CEST)
In-Reply-To: <1477055758-11490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

Whilst ultimately we would like to move all the clocking over to the
clock framework, as an intermediate step to get people going for now
enable the source clocks for FLLs as they are powered up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/codecs/arizona.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 10be50a..7f7d4b3 100644
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
2.1.4
