From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: arizona: Optimise FLL loop gains
Date: Wed,  6 Mar 2013 14:28:16 +0800
Message-ID: <1362551296-14920-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90DB226535C
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 07:29:38 +0100 (CET)
In-Reply-To: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For optimal performance the FLL loop gain should be adjusted depending on
the frequency of the input clock for the loop.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 41c116f..29dd641 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1175,6 +1175,16 @@ static struct {
 	{ 1000000, 13500000, 0,  1 },
 };
 
+static struct {
+	unsigned int min;
+	unsigned int max;
+	u16 gain;
+} fll_gains[] = {
+	{       0,   256000, 0 },
+	{  256000,  1000000, 2 },
+	{ 1000000, 13500000, 4 },
+};
+
 struct arizona_fll_cfg {
 	int n;
 	int theta;
@@ -1182,6 +1192,7 @@ struct arizona_fll_cfg {
 	int refdiv;
 	int outdiv;
 	int fratio;
+	int gain;
 };
 
 static int arizona_calc_fll(struct arizona_fll *fll,
@@ -1241,6 +1252,18 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		return -EINVAL;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(fll_gains); i++) {
+		if (fll_gains[i].min <= Fref && Fref <= fll_gains[i].max) {
+			cfg->gain = fll_gains[i].gain;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(fll_gains)) {
+		arizona_fll_err(fll, "Unable to find gain for Fref=%uHz\n",
+				Fref);
+		return -EINVAL;
+	}
+
 	cfg->n = target / (ratio * Fref);
 
 	if (target % (ratio * Fref)) {
@@ -1268,13 +1291,15 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 			cfg->n, cfg->theta, cfg->lambda);
 	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
 			cfg->fratio, cfg->fratio, cfg->outdiv, cfg->refdiv);
+	arizona_fll_dbg(fll, "GAIN=%d\n", cfg->gain);
 
 	return 0;
 
 }
 
 static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
-			      struct arizona_fll_cfg *cfg, int source)
+			      struct arizona_fll_cfg *cfg, int source,
+			      bool sync)
 {
 	regmap_update_bits(arizona->regmap, base + 3,
 			   ARIZONA_FLL1_THETA_MASK, cfg->theta);
@@ -1289,6 +1314,15 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 			   cfg->refdiv << ARIZONA_FLL1_CLK_REF_DIV_SHIFT |
 			   source << ARIZONA_FLL1_CLK_REF_SRC_SHIFT);
 
+	if (sync)
+		regmap_update_bits(arizona->regmap, base + 0x7,
+				   ARIZONA_FLL1_GAIN_MASK,
+				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+	else
+		regmap_update_bits(arizona->regmap, base + 0x9,
+				   ARIZONA_FLL1_GAIN_MASK,
+				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+
 	regmap_update_bits(arizona->regmap, base + 2,
 			   ARIZONA_FLL1_CTRL_UPD | ARIZONA_FLL1_N_MASK,
 			   ARIZONA_FLL1_CTRL_UPD | cfg->n);
@@ -1326,17 +1360,18 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 				   ARIZONA_FLL1_OUTDIV_MASK,
 				   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
-		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src);
+		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src,
+				  false);
 		if (fll->sync_src >= 0)
 			arizona_apply_fll(arizona, fll->base + 0x10, sync,
-					  fll->sync_src);
+					  fll->sync_src, true);
 	} else if (fll->sync_src >= 0) {
 		regmap_update_bits(arizona->regmap, fll->base + 5,
 				   ARIZONA_FLL1_OUTDIV_MASK,
 				   sync->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
 		arizona_apply_fll(arizona, fll->base, sync,
-				  fll->sync_src);
+				  fll->sync_src, false);
 	} else {
 		arizona_fll_err(fll, "No clocks provided\n");
 		return;
-- 
1.7.10.4
