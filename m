From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Prefer lower FRATIO in pseudo-fractional mode" to the asoc tree
Date: Thu, 21 Apr 2016 17:11:31 +0100
Message-ID: <E1atHCV-0002yI-MD@debutante>
References: <1461243854-31765-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461243854-31765-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Prefer lower FRATIO in pseudo-fractional mode

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8e42db1eaab6c2558dbc2e6c1428730df0a295f4 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Thu, 21 Apr 2016 14:04:14 +0100
Subject: [PATCH] ASoC: arizona: Prefer lower FRATIO in pseudo-fractional mode

When setting up an FLL in pseudo-fractional mode it is preferred
to use a lower FRATIO if possible to give a higher reference clock
frequency. This patch swaps the two loops in arizona_calc_fratio()
so that lower FRATIOs are tried first. The decrementing loop is also
changed to start from init_ratio because the original settings might
already give a fractional value for N.K

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d8a682302580..0caecc6f78df 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2037,7 +2037,21 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
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
@@ -2063,17 +2077,6 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
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
2.8.0.rc3
