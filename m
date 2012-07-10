From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Support variable FLL VCO
	multipliers
Date: Tue, 10 Jul 2012 17:21:28 +0100
Message-ID: <1341937288-32640-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC12424373
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2012 18:21:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some Arizona chips have a higher frequency for the FLL VCO, support this
in the common code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    6 +++---
 sound/soc/codecs/arizona.h |    1 +
 sound/soc/codecs/wm5102.c  |    3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index f3680c3..5c9caca 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -734,9 +734,9 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	/* Apply the division for our remaining calculations */
 	Fref /= div;
 
-	/* Fvco should be 90-100MHz; don't check the upper bound */
+	/* Fvco should be over the targt; don't check the upper bound */
 	div = 1;
-	while (Fout * div < 90000000) {
+	while (Fout * div < 90000000 * fll->vco_mult) {
 		div++;
 		if (div > 7) {
 			arizona_fll_err(fll, "No FLL_OUTDIV for Fout=%uHz\n",
@@ -744,7 +744,7 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 			return -EINVAL;
 		}
 	}
-	target = Fout * div;
+	target = Fout * div / fll->vco_mult;
 	cfg->outdiv = div;
 
 	arizona_fll_dbg(fll, "Fvco=%dHz\n", target);
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index b894b64..59caca8 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -141,6 +141,7 @@ struct arizona_fll {
 	struct arizona *arizona;
 	int id;
 	unsigned int base;
+	unsigned int vco_mult;
 	struct completion lock;
 	struct completion ok;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 7a6a11a..6537f16 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -853,6 +853,9 @@ static int __devinit wm5102_probe(struct platform_device *pdev)
 
 	wm5102->core.arizona = arizona;
 
+	for (i = 0; i < ARRAY_SIZE(wm5102->fll); i++)
+		wm5102->fll[i].vco_mult = 1;
+
 	arizona_init_fll(arizona, 1, ARIZONA_FLL1_CONTROL_1 - 1,
 			 ARIZONA_IRQ_FLL1_LOCK, ARIZONA_IRQ_FLL1_CLOCK_OK,
 			 &wm5102->fll[0]);
-- 
1.7.10
