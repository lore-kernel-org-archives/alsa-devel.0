From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Prefer lower FRATIO in
	pseudo-fractional mode
Date: Thu, 21 Apr 2016 14:04:14 +0100
Message-ID: <1461243854-31765-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 319BB2666BD
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 15:04:20 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When setting up an FLL in pseudo-fractional mode it is preferred
to use a lower FRATIO if possible to give a higher reference clock
frequency. This patch swaps the two loops in arizona_calc_fratio()
so that lower FRATIOs are tried first. The decrementing loop is also
changed to start from init_ratio because the original settings might
already give a fractional value for N.K

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0cd27e0..d1e1127 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2039,7 +2039,21 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 			init_ratio, Fref, refdiv);
 
 	while (div <= ARIZONA_FLL_MAX_REFDIV) {
-		for (ratio = init_ratio; ratio <= ARIZONA_FLL_MAX_FRATIO;
+		/* start from init_ratio because this may already give a
+		 * fractional N.K
+		 */
+		for (ratio = init_ratio; ratio > 0; ratio--) {
+			if (target % (ratio * Fref)) {
+				cfg->refdiv = refdiv;
+				cfg->fratio = ratio - 1;
+				arizona_fll_dbg(fll,
+					"pseudo: found fref=%u refdiv=%d(%d) ratio=%d\n",
+					Fref, refdiv, div, ratio);
+				return ratio;
+			}
+		}
+
+		for (ratio = init_ratio + 1; ratio <= ARIZONA_FLL_MAX_FRATIO;
 		     ratio++) {
 			if ((ARIZONA_FLL_VCO_CORNER / 2) /
 			    (fll->vco_mult * ratio) < Fref) {
@@ -2065,17 +2079,6 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 			}
 		}
 
-		for (ratio = init_ratio - 1; ratio > 0; ratio--) {
-			if (target % (ratio * Fref)) {
-				cfg->refdiv = refdiv;
-				cfg->fratio = ratio - 1;
-				arizona_fll_dbg(fll,
-					"pseudo: found fref=%u refdiv=%d(%d) ratio=%d\n",
-					Fref, refdiv, div, ratio);
-				return ratio;
-			}
-		}
-
 		div *= 2;
 		Fref /= 2;
 		refdiv++;
-- 
1.9.1
