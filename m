From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/9] ASoC: arizona: Don't pass Fout into
	arizona_calc_fll
Date: Fri,  7 Mar 2014 16:34:21 +0000
Message-ID: <1394210065-23941-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EF08265A1C
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:52 +0100 (CET)
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

As we now calculate the FLL configuration at a later stage in the
process the fout member of the FLL structure will contain the desired
Fout frequency so no need to pass this in seperately.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index c9cae8e..e9488cd 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1417,13 +1417,12 @@ static int arizona_validate_fll(struct arizona_fll *fll,
 
 static int arizona_calc_fll(struct arizona_fll *fll,
 			    struct arizona_fll_cfg *cfg,
-			    unsigned int Fref,
-			    unsigned int Fout)
+			    unsigned int Fref)
 {
 	unsigned int target, div, gcd_fll;
 	int i, ratio;
 
-	arizona_fll_dbg(fll, "Fref=%u Fout=%u\n", Fref, Fout);
+	arizona_fll_dbg(fll, "Fref=%u Fout=%u\n", Fref, fll->fout);
 
 	/* Fref must be <=13.5MHz */
 	div = 1;
@@ -1441,12 +1440,12 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 
 	/* Fvco should be over the targt; don't check the upper bound */
 	div = ARIZONA_FLL_MIN_OUTDIV;
-	while (Fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
+	while (fll->fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
 		div++;
 		if (div > ARIZONA_FLL_MAX_OUTDIV)
 			return -EINVAL;
 	}
-	target = Fout * div / fll->vco_mult;
+	target = fll->fout * div / fll->vco_mult;
 	cfg->outdiv = div;
 
 	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
@@ -1574,19 +1573,19 @@ static void arizona_enable_fll(struct arizona_fll *fll)
 	 */
 	if (fll->ref_src >= 0 && fll->ref_freq &&
 	    fll->ref_src != fll->sync_src) {
-		arizona_calc_fll(fll, &cfg, fll->ref_freq, fll->fout);
+		arizona_calc_fll(fll, &cfg, fll->ref_freq);
 
 		arizona_apply_fll(arizona, fll->base, &cfg, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
-			arizona_calc_fll(fll, &cfg, fll->sync_freq, fll->fout);
+			arizona_calc_fll(fll, &cfg, fll->sync_freq);
 
 			arizona_apply_fll(arizona, fll->base + 0x10, &cfg,
 					  fll->sync_src, true);
 			use_sync = true;
 		}
 	} else if (fll->sync_src >= 0) {
-		arizona_calc_fll(fll, &cfg, fll->sync_freq, fll->fout);
+		arizona_calc_fll(fll, &cfg, fll->sync_freq);
 
 		arizona_apply_fll(arizona, fll->base, &cfg,
 				  fll->sync_src, false);
-- 
1.7.2.5
