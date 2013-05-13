From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Support EFS mode for FLL
Date: Mon, 13 May 2013 09:38:47 +0400
Message-ID: <1368423527-12354-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CE201261622
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 07:38:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Later WM8994 devices support an enhanced accuracy FLL divisor mode called
EFS which allows more precise selection of fractional source to output
ratios. Support this on relevant devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   49 +++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1eb152c..9f32dd8 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
+#include <linux/gcd.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -2005,15 +2006,16 @@ struct fll_div {
 	u16 outdiv;
 	u16 n;
 	u16 k;
+	u16 lambda;
 	u16 clk_ref_div;
 	u16 fll_fratio;
 };
 
-static int wm8994_get_fll_config(struct fll_div *fll,
+static int wm8994_get_fll_config(struct wm8994 *control, struct fll_div *fll,
 				 int freq_in, int freq_out)
 {
 	u64 Kpart;
-	unsigned int K, Ndiv, Nmod;
+	unsigned int K, Ndiv, Nmod, gcd_fll;
 
 	pr_debug("FLL input=%dHz, output=%dHz\n", freq_in, freq_out);
 
@@ -2062,20 +2064,30 @@ static int wm8994_get_fll_config(struct fll_div *fll,
 	Nmod = freq_out % freq_in;
 	pr_debug("Nmod=%d\n", Nmod);
 
-	/* Calculate fractional part - scale up so we can round. */
-	Kpart = FIXED_FLL_SIZE * (long long)Nmod;
+	switch (control->type) {
+	case WM8994:
+		/* Calculate fractional part - scale up so we can round. */
+		Kpart = FIXED_FLL_SIZE * (long long)Nmod;
 
-	do_div(Kpart, freq_in);
+		do_div(Kpart, freq_in);
 
-	K = Kpart & 0xFFFFFFFF;
+		K = Kpart & 0xFFFFFFFF;
 
-	if ((K % 10) >= 5)
-		K += 5;
+		if ((K % 10) >= 5)
+			K += 5;
 
-	/* Move down to proper range now rounding is done */
-	fll->k = K / 10;
+		/* Move down to proper range now rounding is done */
+		fll->k = K / 10;
 
-	pr_debug("N=%x K=%x\n", fll->n, fll->k);
+		pr_debug("N=%x K=%x\n", fll->n, fll->k);
+
+	default:
+		gcd_fll = gcd(freq_out, freq_in);
+
+		fll->k = (freq_out - (freq_in * fll->n)) / gcd_fll;
+		fll->lambda = freq_in / gcd_fll;
+		
+	}
 
 	return 0;
 }
@@ -2139,9 +2151,9 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 	 * analysis bugs spewing warnings.
 	 */
 	if (freq_out)
-		ret = wm8994_get_fll_config(&fll, freq_in, freq_out);
+		ret = wm8994_get_fll_config(control, &fll, freq_in, freq_out);
 	else
-		ret = wm8994_get_fll_config(&fll, wm8994->fll[id].in,
+		ret = wm8994_get_fll_config(control, &fll, wm8994->fll[id].in,
 					    wm8994->fll[id].out);
 	if (ret < 0)
 		return ret;
@@ -2186,6 +2198,17 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			    WM8994_FLL1_N_MASK,
 			    fll.n << WM8994_FLL1_N_SHIFT);
 
+	if (fll.lambda) {
+		snd_soc_update_bits(codec, WM8958_FLL1_EFS_1 + reg_offset,
+				    WM8958_FLL1_LAMBDA_MASK,
+				    fll.lambda);
+		snd_soc_update_bits(codec, WM8958_FLL1_EFS_2 + reg_offset,
+				    WM8958_FLL1_EFS_ENA, WM8958_FLL1_EFS_ENA);
+	} else {
+		snd_soc_update_bits(codec, WM8958_FLL1_EFS_2 + reg_offset,
+				    WM8958_FLL1_EFS_ENA, 0);
+	}
+
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
 			    WM8994_FLL1_FRC_NCO | WM8958_FLL1_BYP |
 			    WM8994_FLL1_REFCLK_DIV_MASK |
-- 
1.7.10.4
