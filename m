From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: arizona: Factor out FLL enable
Date: Wed, 20 Feb 2013 16:09:36 +0000
Message-ID: <1361376579-29051-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 878442616DD
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:12:18 +0100 (CET)
In-Reply-To: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

In preparation for additional features on the FLL this patch factors out
the code for enabling an FLL into a seperate function.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   66 ++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 72f2f65..7ad850c 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1090,6 +1090,41 @@ static bool arizona_is_enabled_fll(struct arizona_fll *fll)
 	return reg & ARIZONA_FLL1_ENA;
 }
 
+static void arizona_enable_fll(struct arizona_fll *fll,
+			      struct arizona_fll_cfg *ref,
+			      struct arizona_fll_cfg *sync)
+{
+	struct arizona *arizona = fll->arizona;
+	int ret;
+
+	regmap_update_bits(arizona->regmap, fll->base + 5,
+			   ARIZONA_FLL1_OUTDIV_MASK,
+			   ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+
+	arizona_apply_fll(arizona, fll->base, ref, fll->ref_src);
+	if (fll->sync_src >= 0)
+		arizona_apply_fll(arizona, fll->base + 0x10, sync,
+				  fll->sync_src);
+
+	if (!arizona_is_enabled_fll(fll))
+		pm_runtime_get(arizona->dev);
+
+	/* Clear any pending completions */
+	try_wait_for_completion(&fll->ok);
+
+	regmap_update_bits(arizona->regmap, fll->base + 1,
+			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
+	if (fll->sync_src >= 0)
+		regmap_update_bits(arizona->regmap, fll->base + 0x11,
+				   ARIZONA_FLL1_SYNC_ENA,
+				   ARIZONA_FLL1_SYNC_ENA);
+
+	ret = wait_for_completion_timeout(&fll->ok,
+					  msecs_to_jiffies(250));
+	if (ret == 0)
+		arizona_fll_warn(fll, "Timed out waiting for lock\n");
+}
+
 static void arizona_disable_fll(struct arizona_fll *fll)
 {
 	struct arizona *arizona = fll->arizona;
@@ -1107,9 +1142,7 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 int arizona_set_fll(struct arizona_fll *fll, int source,
 		    unsigned int Fref, unsigned int Fout)
 {
-	struct arizona *arizona = fll->arizona;
 	struct arizona_fll_cfg ref, sync;
-	bool ena;
 	int ret;
 
 	if (fll->fref == Fref && fll->fout == Fout)
@@ -1140,35 +1173,8 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 		fll->sync_freq = Fref;
 	}
 
-	ena = arizona_is_enabled_fll(fll);
-
 	if (Fout) {
-		regmap_update_bits(arizona->regmap, fll->base + 5,
-				   ARIZONA_FLL1_OUTDIV_MASK,
-				   ref.outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
-
-		arizona_apply_fll(arizona, fll->base, &ref, fll->ref_src);
-		if (fll->sync_src >= 0)
-			arizona_apply_fll(arizona, fll->base + 0x10, &sync,
-					  fll->sync_src);
-
-		if (!ena)
-			pm_runtime_get(arizona->dev);
-
-		/* Clear any pending completions */
-		try_wait_for_completion(&fll->ok);
-
-		regmap_update_bits(arizona->regmap, fll->base + 1,
-				   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
-		if (fll->sync_src >= 0)
-			regmap_update_bits(arizona->regmap, fll->base + 0x11,
-					   ARIZONA_FLL1_SYNC_ENA,
-					   ARIZONA_FLL1_SYNC_ENA);
-
-		ret = wait_for_completion_timeout(&fll->ok,
-						  msecs_to_jiffies(250));
-		if (ret == 0)
-			arizona_fll_warn(fll, "Timed out waiting for lock\n");
+		arizona_enable_fll(fll, &ref, &sync);
 	} else {
 		arizona_disable_fll(fll);
 	}
-- 
1.7.2.5
