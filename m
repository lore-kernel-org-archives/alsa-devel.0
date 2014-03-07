From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/9] ASoC: arizona: Move calculation of FLL
	configuration
Date: Fri,  7 Mar 2014 16:34:20 +0000
Message-ID: <1394210065-23941-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92CDD265A1B
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:51 +0100 (CET)
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

Currently the FLL configuration is calculated before it is known which
FLL path the configuration will be applied to. Newer versions of the IP
have differences in the configuration required for each FLL path, which
makes it complicated to calculate the FLL configuration in advance.

This patch simply checks the validity of a requested input and output
frequency before we know which FLL path they will be applied to and
saves the actual calculation of the configuration until we know where
the settings will be applied.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   79 ++++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 6b53c3c..c9cae8e 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1392,6 +1392,29 @@ struct arizona_fll_cfg {
 	int gain;
 };
 
+static int arizona_validate_fll(struct arizona_fll *fll,
+				unsigned int Fref,
+				unsigned int Fout)
+{
+	unsigned int Fvco_min;
+
+	if (Fref / ARIZONA_FLL_MAX_REFDIV > ARIZONA_FLL_MAX_FREF) {
+		arizona_fll_err(fll,
+				"Can't scale %dMHz in to <=13.5MHz\n",
+				Fref);
+		return -EINVAL;
+	}
+
+	Fvco_min = ARIZONA_FLL_MIN_FVCO * fll->vco_mult;
+	if (Fout * ARIZONA_FLL_MAX_OUTDIV < Fvco_min) {
+		arizona_fll_err(fll, "No FLL_OUTDIV for Fout=%uHz\n",
+				Fout);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int arizona_calc_fll(struct arizona_fll *fll,
 			    struct arizona_fll_cfg *cfg,
 			    unsigned int Fref,
@@ -1409,12 +1432,8 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		div *= 2;
 		cfg->refdiv++;
 
-		if (div > ARIZONA_FLL_MAX_REFDIV) {
-			arizona_fll_err(fll,
-					"Can't scale %dMHz in to <=13.5MHz\n",
-					Fref);
+		if (div > ARIZONA_FLL_MAX_REFDIV)
 			return -EINVAL;
-		}
 	}
 
 	/* Apply the division for our remaining calculations */
@@ -1424,11 +1443,8 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	div = ARIZONA_FLL_MIN_OUTDIV;
 	while (Fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
 		div++;
-		if (div > ARIZONA_FLL_MAX_OUTDIV) {
-			arizona_fll_err(fll, "No FLL_OUTDIV for Fout=%uHz\n",
-					Fout);
+		if (div > ARIZONA_FLL_MAX_OUTDIV)
 			return -EINVAL;
-		}
 	}
 	target = Fout * div / fll->vco_mult;
 	cfg->outdiv = div;
@@ -1545,13 +1561,12 @@ static bool arizona_is_enabled_fll(struct arizona_fll *fll)
 	return reg & ARIZONA_FLL1_ENA;
 }
 
-static void arizona_enable_fll(struct arizona_fll *fll,
-			      struct arizona_fll_cfg *ref,
-			      struct arizona_fll_cfg *sync)
+static void arizona_enable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
 	int ret;
 	bool use_sync = false;
+	struct arizona_fll_cfg cfg;
 
 	/*
 	 * If we have both REFCLK and SYNCCLK then enable both,
@@ -1559,15 +1574,21 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	 */
 	if (fll->ref_src >= 0 && fll->ref_freq &&
 	    fll->ref_src != fll->sync_src) {
-		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src,
+		arizona_calc_fll(fll, &cfg, fll->ref_freq, fll->fout);
+
+		arizona_apply_fll(arizona, fll->base, &cfg, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
-			arizona_apply_fll(arizona, fll->base + 0x10, sync,
+			arizona_calc_fll(fll, &cfg, fll->sync_freq, fll->fout);
+
+			arizona_apply_fll(arizona, fll->base + 0x10, &cfg,
 					  fll->sync_src, true);
 			use_sync = true;
 		}
 	} else if (fll->sync_src >= 0) {
-		arizona_apply_fll(arizona, fll->base, sync,
+		arizona_calc_fll(fll, &cfg, fll->sync_freq, fll->fout);
+
+		arizona_apply_fll(arizona, fll->base, &cfg,
 				  fll->sync_src, false);
 
 		regmap_update_bits_async(arizona->regmap, fll->base + 0x11,
@@ -1629,32 +1650,22 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 			   unsigned int Fref, unsigned int Fout)
 {
-	struct arizona_fll_cfg ref, sync;
 	int ret;
 
 	if (fll->ref_src == source && fll->ref_freq == Fref)
 		return 0;
 
-	if (fll->fout) {
-		if (Fref > 0) {
-			ret = arizona_calc_fll(fll, &ref, Fref, fll->fout);
-			if (ret != 0)
-				return ret;
-		}
-
-		if (fll->sync_src >= 0) {
-			ret = arizona_calc_fll(fll, &sync, fll->sync_freq,
-					       fll->fout);
-			if (ret != 0)
-				return ret;
-		}
+	if (fll->fout && Fref > 0) {
+		ret = arizona_validate_fll(fll, Fref, fll->fout);
+		if (ret != 0)
+			return ret;
 	}
 
 	fll->ref_src = source;
 	fll->ref_freq = Fref;
 
 	if (fll->fout && Fref > 0) {
-		arizona_enable_fll(fll, &ref, &sync);
+		arizona_enable_fll(fll);
 	}
 
 	return 0;
@@ -1664,7 +1675,6 @@ EXPORT_SYMBOL_GPL(arizona_set_fll_refclk);
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
-	struct arizona_fll_cfg ref, sync;
 	int ret;
 
 	if (fll->sync_src == source &&
@@ -1673,13 +1683,12 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 
 	if (Fout) {
 		if (fll->ref_src >= 0) {
-			ret = arizona_calc_fll(fll, &ref, fll->ref_freq,
-					       Fout);
+			ret = arizona_validate_fll(fll, fll->ref_freq, Fout);
 			if (ret != 0)
 				return ret;
 		}
 
-		ret = arizona_calc_fll(fll, &sync, Fref, Fout);
+		ret = arizona_validate_fll(fll, Fref, Fout);
 		if (ret != 0)
 			return ret;
 	}
@@ -1689,7 +1698,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	fll->fout = Fout;
 
 	if (Fout) {
-		arizona_enable_fll(fll, &ref, &sync);
+		arizona_enable_fll(fll);
 	} else {
 		arizona_disable_fll(fll);
 	}
-- 
1.7.2.5
