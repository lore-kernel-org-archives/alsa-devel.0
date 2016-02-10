From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: fref must be limited in
	pseudo-fractional mode" to the asoc tree
Date: Wed, 10 Feb 2016 19:22:52 +0000
Message-ID: <E1aTaLk-0000dt-1L@debutante>
References: <1455105373-8606-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D1AC260605
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 20:23:02 +0100 (CET)
In-Reply-To: <1455105373-8606-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: fref must be limited in pseudo-fractional mode

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

>From 01582a841493f28caf1688b2af4dafbcbee8135e Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Wed, 10 Feb 2016 11:56:13 +0000
Subject: [PATCH] ASoC: arizona: fref must be limited in pseudo-fractional mode

When the FLL is in pseudo-fractional mode there is an additional
limit on fref based on the fratio, to prevent aliasing around the
Nyquist frequency. If fref exceeds this limit the refclk divider
must be increased and the calculation tried again until a suitable
combination of fref and fratio is found or we have to fall back to
integer mode.

This patch also adds some debug log prints around this code.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 33143fe1de0b..91785318b283 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1929,6 +1929,25 @@ static struct {
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
@@ -2042,16 +2061,32 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
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
@@ -2060,6 +2095,9 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 			if (target % (ratio * Fref)) {
 				cfg->refdiv = refdiv;
 				cfg->fratio = ratio - 1;
+				arizona_fll_dbg(fll,
+					"pseudo: found fref=%u refdiv=%d(%d) ratio=%d\n",
+					Fref, refdiv, div, ratio);
 				return ratio;
 			}
 		}
@@ -2068,6 +2106,9 @@ static int arizona_calc_fratio(struct arizona_fll *fll,
 		Fref /= 2;
 		refdiv++;
 		init_ratio = arizona_find_fratio(Fref, NULL);
+		arizona_fll_dbg(fll,
+				"pseudo: change fref=%u refdiv=%d(%d) ratio=%u\n",
+				Fref, refdiv, div, init_ratio);
 	}
 
 	arizona_fll_warn(fll, "Falling back to integer mode operation\n");
-- 
2.7.0
