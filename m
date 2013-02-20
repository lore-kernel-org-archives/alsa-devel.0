From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/8] ASoC: arizona: Tidy up SYNCCLK
	selection and cache values
Date: Wed, 20 Feb 2013 17:28:35 +0000
Message-ID: <1361381321-437-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98FEF26172B
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 18:31:02 +0100 (CET)
In-Reply-To: <1361381321-437-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch caches the current SYNCCLK settings in the arizona_fll struct
and uses these to simplify the code which determines which source should
be used for the REFCLK and SYNCCLK inputs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |  101 ++++++++++++++++++++++----------------------
 sound/soc/codecs/arizona.h |    2 +
 2 files changed, 52 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index c14e755..03076ef 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1078,15 +1078,39 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
 	struct arizona *arizona = fll->arizona;
-	struct arizona_fll_cfg cfg, sync;
+	struct arizona_fll_cfg ref, sync;
 	unsigned int reg;
-	int syncsrc;
 	bool ena;
 	int ret;
 
 	if (fll->fref == Fref && fll->fout == Fout)
 		return 0;
 
+	if (fll->ref_src < 0 || fll->ref_src == source) {
+		if (Fout) {
+			ret = arizona_calc_fll(fll, &ref, Fref, Fout);
+			if (ret != 0)
+				return ret;
+		}
+
+		fll->sync_src = -1;
+		fll->ref_src = source;
+		fll->ref_freq = Fref;
+	} else {
+		if (Fout) {
+			ret = arizona_calc_fll(fll, &ref, fll->ref_freq, Fout);
+			if (ret != 0)
+				return ret;
+
+			ret = arizona_calc_fll(fll, &sync, Fref, Fout);
+			if (ret != 0)
+				return ret;
+		}
+
+		fll->sync_src = source;
+		fll->sync_freq = Fref;
+	}
+
 	ret = regmap_read(arizona->regmap, fll->base + 1, &reg);
 	if (ret != 0) {
 		arizona_fll_err(fll, "Failed to read current state: %d\n",
@@ -1096,24 +1120,32 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	ena = reg & ARIZONA_FLL1_ENA;
 
 	if (Fout) {
-		syncsrc = fll->ref_src;
+		regmap_update_bits(arizona->regmap, fll->base + 5,
+				   ARIZONA_FLL1_OUTDIV_MASK,
+				   ref.outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
 
-		if (source == syncsrc)
-			syncsrc = -1;
+		arizona_apply_fll(arizona, fll->base, &ref, fll->ref_src);
+		if (fll->sync_src >= 0)
+			arizona_apply_fll(arizona, fll->base + 0x10, &sync,
+					  fll->sync_src);
 
-		if (syncsrc >= 0) {
-			ret = arizona_calc_fll(fll, &sync, Fref, Fout);
-			if (ret != 0)
-				return ret;
+		if (!ena)
+			pm_runtime_get(arizona->dev);
 
-			ret = arizona_calc_fll(fll, &cfg, fll->ref_freq, Fout);
-			if (ret != 0)
-				return ret;
-		} else {
-			ret = arizona_calc_fll(fll, &cfg, Fref, Fout);
-			if (ret != 0)
-				return ret;
-		}
+		/* Clear any pending completions */
+		try_wait_for_completion(&fll->ok);
+
+		regmap_update_bits(arizona->regmap, fll->base + 1,
+				   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
+		if (fll->sync_src >= 0)
+			regmap_update_bits(arizona->regmap, fll->base + 0x11,
+					   ARIZONA_FLL1_SYNC_ENA,
+					   ARIZONA_FLL1_SYNC_ENA);
+
+		ret = wait_for_completion_timeout(&fll->ok,
+						  msecs_to_jiffies(250));
+		if (ret == 0)
+			arizona_fll_warn(fll, "Timed out waiting for lock\n");
 	} else {
 		regmap_update_bits(arizona->regmap, fll->base + 1,
 				   ARIZONA_FLL1_ENA, 0);
@@ -1122,42 +1154,8 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 
 		if (ena)
 			pm_runtime_put_autosuspend(arizona->dev);
-
-		fll->fref = Fref;
-		fll->fout = Fout;
-
-		return 0;
 	}
 
-	regmap_update_bits(arizona->regmap, fll->base + 5,
-			   ARIZONA_FLL1_OUTDIV_MASK,
-			   cfg.outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
-
-	if (syncsrc >= 0) {
-		arizona_apply_fll(arizona, fll->base, &cfg, syncsrc);
-		arizona_apply_fll(arizona, fll->base + 0x10, &sync, source);
-	} else {
-		arizona_apply_fll(arizona, fll->base, &cfg, source);
-	}
-
-	if (!ena)
-		pm_runtime_get(arizona->dev);
-
-	/* Clear any pending completions */
-	try_wait_for_completion(&fll->ok);
-
-	regmap_update_bits(arizona->regmap, fll->base + 1,
-			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-	if (syncsrc >= 0)
-		regmap_update_bits(arizona->regmap, fll->base + 0x11,
-				   ARIZONA_FLL1_SYNC_ENA,
-				   ARIZONA_FLL1_SYNC_ENA);
-
-	ret = wait_for_completion_timeout(&fll->ok,
-					  msecs_to_jiffies(250));
-	if (ret == 0)
-		arizona_fll_warn(fll, "Timed out waiting for lock\n");
-
 	fll->fref = Fref;
 	fll->fout = Fout;
 
@@ -1176,6 +1174,7 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 	fll->id = id;
 	fll->base = base;
 	fll->arizona = arizona;
+	fll->sync_src = -1;
 
 	/* Configure default refclk to 32kHz if we have one */
 	regmap_read(arizona->regmap, ARIZONA_CLOCK_32K_1, &val);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 124f9f0..37766b5 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -201,6 +201,8 @@ struct arizona_fll {
 	unsigned int fref;
 	unsigned int fout;
 
+	int sync_src;
+	unsigned int sync_freq;
 	int ref_src;
 	unsigned int ref_freq;
 
-- 
1.7.2.5
