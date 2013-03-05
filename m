From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: If we only have a clock to
	synchronise with make it REFCLK
Date: Tue,  5 Mar 2013 10:02:24 +0800
Message-ID: <1362448944-25952-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB88426518D
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 03:46:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If there is only one clock active the FLL should use REFCLK rather than
SYNCCLK as the clock to synchronise with since REFCLK is always required.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   76 ++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e456cb4..0599ff8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1132,14 +1132,30 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	struct arizona *arizona = fll->arizona;
 	int ret;
 
-	regmap_update_bits(arizona->regmap, fll->base + 5,
-			   ARIZONA_FLL1_OUTDIV_MASK,
-			   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
-
-	arizona_apply_fll(arizona, fll->base, ref, fll->ref_src);
-	if (fll->sync_src >= 0)
-		arizona_apply_fll(arizona, fll->base + 0x10, sync,
+	/*
+	 * If we have both REFCLK and SYNCCLK then enable both,
+	 * otherwise apply the SYNCCLK settings to REFCLK.
+	 */
+	if (fll->ref_src >= 0 && fll->ref_src != fll->sync_src) {
+		regmap_update_bits(arizona->regmap, fll->base + 5,
+				   ARIZONA_FLL1_OUTDIV_MASK,
+				   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+
+		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src);
+		if (fll->sync_src >= 0)
+			arizona_apply_fll(arizona, fll->base + 0x10, sync,
+					  fll->sync_src);
+	} else if (fll->sync_src >= 0) {
+		regmap_update_bits(arizona->regmap, fll->base + 5,
+				   ARIZONA_FLL1_OUTDIV_MASK,
+				   sync->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+
+		arizona_apply_fll(arizona, fll->base, sync,
 				  fll->sync_src);
+	} else {
+		arizona_fll_err(fll, "No clocks provided\n");
+		return;
+	}
 
 	if (!arizona_is_enabled_fll(fll))
 		pm_runtime_get(arizona->dev);
@@ -1149,7 +1165,8 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 
 	regmap_update_bits(arizona->regmap, fll->base + 1,
 			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-	if (fll->sync_src >= 0)
+	if (fll->ref_src >= 0 && fll->sync_src >= 0 &&
+	    fll->ref_src != fll->sync_src)
 		regmap_update_bits(arizona->regmap, fll->base + 0x11,
 				   ARIZONA_FLL1_SYNC_ENA,
 				   ARIZONA_FLL1_SYNC_ENA);
@@ -1180,9 +1197,6 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 	struct arizona_fll_cfg ref, sync;
 	int ret;
 
-	if (source < 0)
-		return -EINVAL;
-
 	if (fll->ref_src == source && fll->ref_freq == Fref)
 		return 0;
 
@@ -1216,39 +1230,25 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	struct arizona_fll_cfg ref, sync;
 	int ret;
 
-	if (fll->ref_src < 0 || fll->ref_src == source) {
-		if (fll->sync_src == ARIZONA_FLL_SRC_NONE &&
-		    fll->ref_src == source && fll->ref_freq == Fref &&
-		    fll->fout == Fout)
-			return 0;
-
-		if (Fout) {
-			ret = arizona_calc_fll(fll, &ref, Fref, Fout);
-			if (ret != 0)
-				return ret;
-		}
-
-		fll->sync_src = ARIZONA_FLL_SRC_NONE;
-		fll->ref_src = source;
-		fll->ref_freq = Fref;
-	} else {
-		if (fll->sync_src == source &&
-		    fll->sync_freq == Fref && fll->fout == Fout)
-			return 0;
-
-		if (Fout) {
-			ret = arizona_calc_fll(fll, &ref, fll->ref_freq, Fout);
-			if (ret != 0)
-				return ret;
+	if (fll->sync_src == source &&
+	    fll->sync_freq == Fref && fll->fout == Fout)
+		return 0;
 
-			ret = arizona_calc_fll(fll, &sync, Fref, Fout);
+	if (Fout) {
+		if (fll->ref_src >= 0) {
+			ret = arizona_calc_fll(fll, &ref, fll->ref_freq,
+					       Fout);
 			if (ret != 0)
 				return ret;
 		}
 
-		fll->sync_src = source;
-		fll->sync_freq = Fref;
+		ret = arizona_calc_fll(fll, &sync, Fref, Fout);
+		if (ret != 0)
+			return ret;
 	}
+
+	fll->sync_src = source;
+	fll->sync_freq = Fref;
 	fll->fout = Fout;
 
 	if (Fout) {
-- 
1.7.10.4
