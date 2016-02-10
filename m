From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: fref must be limited in pseudo-fractional mode
Date: Wed, 10 Feb 2016 11:56:13 +0000
Message-ID: <1455105373-8606-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When the FLL is in pseudo-fractional mode there is an additional
limit on fref based on the fratio, to prevent aliasing around the
Nyquist frequency. If fref exceeds this limit the refclk divider
must be increased and the calculation tried again until a suitable
combination of fref and fratio is found or we have to fall back to
integer mode.

This patch also adds some debug log prints around this code.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a32cfb8..913cfa8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1899,6 +1899,25 @@ static struct {
 	{ 1000000, 13500000, 0,  1 },
 };
 
+static const unsigned int pseudo_fref_max[ARIZONA_FLL_MAX_FRATIO] = {
+	13500000,
+	 6144000,
+	 6144000,
+	 3072000,
+	 3072000,
+	 2822400,
+	 2822400,
+	 1536000,
+	 1536000,
+	 1536000,
+	 1536000,
+	 1536000,
+	 1536000,
+	 1536000,
+	 1536000,
+	  768000,
+};
+
 static struct {
 	unsigned int min;
 	unsigned int max;
@@ -2012,16 +2031,32 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 	/* Adjust FRATIO/refdiv to avoid integer mode if possible */
 	refdiv = cfg->refdiv;
 
+	arizona_fll_dbg(fll, "pseudo: initial ratio=%u fref=%u refdiv=%u\n",
+			init_ratio, Fref, refdiv);
+
 	while (div <= ARIZONA_FLL_MAX_REFDIV) {
 		for (ratio = init_ratio; ratio <= ARIZONA_FLL_MAX_FRATIO;
 		     ratio++) {
 			if ((ARIZONA_FLL_VCO_CORNER / 2) /
-			    (fll->vco_mult * ratio) < Fref)
+			    (fll->vco_mult * ratio) < Fref) {
+				arizona_fll_dbg(fll, "pseudo: hit VCO corner\n");
 				break;
+			}
+
+			if (Fref > pseudo_fref_max[ratio - 1]) {
+				arizona_fll_dbg(fll,
+					"pseudo: exceeded max fref(%u) for ratio=%u\n",
+					pseudo_fref_max[ratio - 1],
+					ratio);
+				break;
+			}
 
 			if (target % (ratio * Fref)) {
 				cfg->refdiv = refdiv;
 				cfg->fratio = ratio - 1;
+				arizona_fll_dbg(fll,
+					"pseudo: found fref=%u refdiv=%d(%d) ratio=%d\n",
+					Fref, refdiv, div, ratio);
 				return ratio;
 			}
 		}
@@ -2030,6 +2065,9 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 			if (target % (ratio * Fref)) {
 				cfg->refdiv = refdiv;
 				cfg->fratio = ratio - 1;
+				arizona_fll_dbg(fll,
+					"pseudo: found fref=%u refdiv=%d(%d) ratio=%d\n",
+					Fref, refdiv, div, ratio);
 				return ratio;
 			}
 		}
@@ -2038,6 +2076,9 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 		Fref /= 2;
 		refdiv++;
 		init_ratio = arizona_find_fratio(Fref, NULL);
+		arizona_fll_dbg(fll,
+				"pseudo: change fref=%u refdiv=%d(%d) ratio=%u\n",
+				Fref, refdiv, div, init_ratio);
 	}
 
 	arizona_fll_warn(fll, "Falling back to integer mode operation\n");
-- 
1.9.1
