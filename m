From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 6/9] ASoC: arizona: Calculate OUTDIV first
Date: Fri,  7 Mar 2014 16:34:22 +0000
Message-ID: <1394210065-23941-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D37452659F3
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:53 +0100 (CET)
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

OUTDIV will remain unchanged whilst the rest of the FLL configuration is
calculated so do this first.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e9488cd..175e230 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1424,6 +1424,18 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 
 	arizona_fll_dbg(fll, "Fref=%u Fout=%u\n", Fref, fll->fout);
 
+	/* Fvco should be over the targt; don't check the upper bound */
+	div = ARIZONA_FLL_MIN_OUTDIV;
+	while (fll->fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
+		div++;
+		if (div > ARIZONA_FLL_MAX_OUTDIV)
+			return -EINVAL;
+	}
+	target = fll->fout * div / fll->vco_mult;
+	cfg->outdiv = div;
+
+	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
+
 	/* Fref must be <=13.5MHz */
 	div = 1;
 	cfg->refdiv = 0;
@@ -1438,18 +1450,6 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	/* Apply the division for our remaining calculations */
 	Fref /= div;
 
-	/* Fvco should be over the targt; don't check the upper bound */
-	div = ARIZONA_FLL_MIN_OUTDIV;
-	while (fll->fout * div < ARIZONA_FLL_MIN_FVCO * fll->vco_mult) {
-		div++;
-		if (div > ARIZONA_FLL_MAX_OUTDIV)
-			return -EINVAL;
-	}
-	target = fll->fout * div / fll->vco_mult;
-	cfg->outdiv = div;
-
-	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
-
 	/* Find an appropraite FLL_FRATIO and factor it out of the target */
 	for (i = 0; i < ARRAY_SIZE(fll_fratios); i++) {
 		if (fll_fratios[i].min <= Fref && Fref <= fll_fratios[i].max) {
-- 
1.7.2.5
