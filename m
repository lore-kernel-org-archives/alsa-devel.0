From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/9] ASoC: arizona: Move set of OUTDIV in to
	arizona_apply_fll
Date: Fri,  7 Mar 2014 16:34:19 +0000
Message-ID: <1394210065-23941-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA687265A1A
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:50 +0100 (CET)
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

Since we know in arizona_apply_fll if we are setting the sync or ref
path there is no need to set the outdiv seperately anymore. This patch
moves this from arizona_enable_fll to arizona_apply_fll.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e6f8290..6b53c3c 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1511,14 +1511,18 @@ static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
 				 cfg->refdiv << ARIZONA_FLL1_CLK_REF_DIV_SHIFT |
 				 source << ARIZONA_FLL1_CLK_REF_SRC_SHIFT);
 
-	if (sync)
-		regmap_update_bits_async(arizona->regmap, base + 0x7,
-					 ARIZONA_FLL1_GAIN_MASK,
-					 cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
-	else
-		regmap_update_bits_async(arizona->regmap, base + 0x9,
-					 ARIZONA_FLL1_GAIN_MASK,
-					 cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+	if (sync) {
+		regmap_update_bits(arizona->regmap, base + 0x7,
+				   ARIZONA_FLL1_GAIN_MASK,
+				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+	} else {
+		regmap_update_bits(arizona->regmap, base + 0x5,
+				   ARIZONA_FLL1_OUTDIV_MASK,
+				   cfg->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
+		regmap_update_bits(arizona->regmap, base + 0x9,
+				   ARIZONA_FLL1_GAIN_MASK,
+				   cfg->gain << ARIZONA_FLL1_GAIN_SHIFT);
+	}
 
 	regmap_update_bits_async(arizona->regmap, base + 2,
 				 ARIZONA_FLL1_CTRL_UPD | ARIZONA_FLL1_N_MASK,
@@ -1555,10 +1559,6 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	 */
 	if (fll->ref_src >= 0 && fll->ref_freq &&
 	    fll->ref_src != fll->sync_src) {
-		regmap_update_bits_async(arizona->regmap, fll->base + 5,
-					 ARIZONA_FLL1_OUTDIV_MASK,
-					 ref->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
-
 		arizona_apply_fll(arizona, fll->base, ref, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
@@ -1567,10 +1567,6 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 			use_sync = true;
 		}
 	} else if (fll->sync_src >= 0) {
-		regmap_update_bits_async(arizona->regmap, fll->base + 5,
-					 ARIZONA_FLL1_OUTDIV_MASK,
-					 sync->outdiv << ARIZONA_FLL1_OUTDIV_SHIFT);
-
 		arizona_apply_fll(arizona, fll->base, sync,
 				  fll->sync_src, false);
 
-- 
1.7.2.5
