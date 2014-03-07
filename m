From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 9/9] ASoC: arizona: Support new fratio encoding
	on the wm5110 rev D
Date: Fri,  7 Mar 2014 16:34:25 +0000
Message-ID: <1394210065-23941-10-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71355265A31
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:58 +0100 (CET)
In-Reply-To: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The reference clock path on newer IP FLLs requires a different
configuration, and should avoid integer mode operation. This patch adds
support for both the new encoding and updates the calculation.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |  130 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 101 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 24ea6ed..29e198f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -53,8 +53,10 @@
 #define ARIZONA_AIF_RX_ENABLES                  0x1A
 #define ARIZONA_AIF_FORCE_WRITE                 0x1B
 
+#define ARIZONA_FLL_VCO_CORNER 141900000
 #define ARIZONA_FLL_MAX_FREF   13500000
 #define ARIZONA_FLL_MIN_FVCO   90000000
+#define ARIZONA_FLL_MAX_FRATIO 16
 #define ARIZONA_FLL_MAX_REFDIV 8
 #define ARIZONA_FLL_MIN_OUTDIV 2
 #define ARIZONA_FLL_MAX_OUTDIV 7
@@ -1415,9 +1417,99 @@ static int arizona_validate_fll(struct arizona_fll *fll,
 	return 0;
 }
 
+static int arizona_find_fratio(unsigned int Fref, int *fratio)
+{
+	int i;
+
+	/* Find an appropriate FLL_FRATIO */
+	for (i = 0; i < ARRAY_SIZE(fll_fratios); i++) {
+		if (fll_fratios[i].min <= Fref && Fref <= fll_fratios[i].max) {
+			if (fratio)
+				*fratio = fll_fratios[i].fratio;
+			return fll_fratios[i].ratio;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int arizona_calc_fratio(struct arizona_fll *fll,
+			       struct arizona_fll_cfg *cfg,
+			       unsigned int target,
+			       unsigned int Fref, bool sync)
+{
+	int init_ratio, ratio;
+	int refdiv, div;
+
+	/* Fref must be <=13.5MHz, find initial refdiv */
+	div = 1;
+	cfg->refdiv = 0;
+	while (Fref > ARIZONA_FLL_MAX_FREF) {
+		div *= 2;
+		Fref /= 2;
+		cfg->refdiv++;
+
+		if (div > ARIZONA_FLL_MAX_REFDIV)
+			return -EINVAL;
+	}
+
+	/* Find an appropriate FLL_FRATIO */
+	init_ratio = arizona_find_fratio(Fref, &cfg->fratio);
+	if (init_ratio < 0) {
+		arizona_fll_err(fll, "Unable to find FRATIO for Fref=%uHz\n",
+				Fref);
+		return init_ratio;
+	}
+
+	switch (fll->arizona->type) {
+	case WM5110:
+		if (fll->arizona->rev < 3 || sync)
+			return init_ratio;
+		break;
+	default:
+		return init_ratio;
+	}
+
+	cfg->fratio = init_ratio - 1;
+
+	/* Adjust FRATIO/refdiv to avoid integer mode if possible */
+	refdiv = cfg->refdiv;
+
+	while (div <= ARIZONA_FLL_MAX_REFDIV) {
+		for (ratio = init_ratio; ratio <= ARIZONA_FLL_MAX_FRATIO;
+		     ratio++) {
+			if (target % (ratio * Fref)) {
+				cfg->refdiv = refdiv;
+				cfg->fratio = ratio - 1;
+				return ratio;
+			}
+		}
+
+		for (ratio = init_ratio - 1; ratio >= 0; ratio--) {
+			if (ARIZONA_FLL_VCO_CORNER / (fll->vco_mult * ratio) <
+			    Fref)
+				break;
+
+			if (target % (ratio * Fref)) {
+				cfg->refdiv = refdiv;
+				cfg->fratio = ratio - 1;
+				return ratio;
+			}
+		}
+
+		div *= 2;
+		Fref /= 2;
+		refdiv++;
+		init_ratio = arizona_find_fratio(Fref, NULL);
+	}
+
+	arizona_fll_warn(fll, "Falling back to integer mode operation\n");
+	return cfg->fratio + 1;
+}
+
 static int arizona_calc_fll(struct arizona_fll *fll,
 			    struct arizona_fll_cfg *cfg,
-			    unsigned int Fref)
+			    unsigned int Fref, bool sync)
 {
 	unsigned int target, div, gcd_fll;
 	int i, ratio;
@@ -1436,33 +1528,13 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 
 	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
 
-	/* Fref must be <=13.5MHz */
-	div = 1;
-	cfg->refdiv = 0;
-	while ((Fref / div) > ARIZONA_FLL_MAX_FREF) {
-		div *= 2;
-		cfg->refdiv++;
-
-		if (div > ARIZONA_FLL_MAX_REFDIV)
-			return -EINVAL;
-	}
+	/* Find an appropriate FLL_FRATIO and refdiv */
+	ratio = arizona_calc_fratio(fll, cfg, target, Fref, sync);
+	if (ratio < 0)
+		return ratio;
 
 	/* Apply the division for our remaining calculations */
-	Fref /= div;
-
-	/* Find an appropraite FLL_FRATIO and factor it out of the target */
-	for (i = 0; i < ARRAY_SIZE(fll_fratios); i++) {
-		if (fll_fratios[i].min <= Fref && Fref <= fll_fratios[i].max) {
-			cfg->fratio = fll_fratios[i].fratio;
-			ratio = fll_fratios[i].ratio;
-			break;
-		}
-	}
-	if (i == ARRAY_SIZE(fll_fratios)) {
-		arizona_fll_err(fll, "Unable to find FRATIO for Fref=%uHz\n",
-				Fref);
-		return -EINVAL;
-	}
+	Fref = Fref / (1 << cfg->refdiv);
 
 	cfg->n = target / (ratio * Fref);
 
@@ -1573,19 +1645,19 @@ static void arizona_enable_fll(struct arizona_fll *fll)
 	 */
 	if (fll->ref_src >= 0 && fll->ref_freq &&
 	    fll->ref_src != fll->sync_src) {
-		arizona_calc_fll(fll, &cfg, fll->ref_freq);
+		arizona_calc_fll(fll, &cfg, fll->ref_freq, false);
 
 		arizona_apply_fll(arizona, fll->base, &cfg, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
-			arizona_calc_fll(fll, &cfg, fll->sync_freq);
+			arizona_calc_fll(fll, &cfg, fll->sync_freq, true);
 
 			arizona_apply_fll(arizona, fll->base + 0x10, &cfg,
 					  fll->sync_src, true);
 			use_sync = true;
 		}
 	} else if (fll->sync_src >= 0) {
-		arizona_calc_fll(fll, &cfg, fll->sync_freq);
+		arizona_calc_fll(fll, &cfg, fll->sync_freq, false);
 
 		arizona_apply_fll(arizona, fll->base, &cfg,
 				  fll->sync_src, false);
-- 
1.7.2.5
