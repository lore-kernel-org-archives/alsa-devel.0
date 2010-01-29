From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: improve MCLKDIV calculation in wm8978,
 when OPCLK is not used
Date: Fri, 29 Jan 2010 14:51:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001291432030.4613@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0349B1038ED
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 14:51:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

In case, if OPCLK is not used, and PLL is used for driving the codec, the 
choice of PLL output frequency could result in a needlessly imprecise 
system clock frequency. Use an iterative process to select a precise 
configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 6d807b1..61b0925 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -58,6 +58,7 @@ struct wm8978_priv {
 	unsigned int f_mclk;
 	unsigned int f_256fs;
 	unsigned int f_opclk;
+	int mclk_idx;
 	enum wm8978_sysclk_src sysclk;
 	u16 reg_cache[WM8978_CACHEREGNUM];
 };
@@ -402,6 +403,35 @@ static void pll_factors(struct wm8978_pll_div *pll_div, unsigned int target,
 
 	pll_div->k = k;
 }
+
+/* MCLK dividers */
+static const int mclk_numerator[]	= {1, 3, 2, 3, 4, 6, 8, 12};
+static const int mclk_denominator[]	= {1, 2, 1, 1, 1, 1, 1, 1};
+
+/*
+ * find index >= idx, such that, for a given f_out,
+ * 3 * f_mclk / 4 <= f_PLLOUT < 13 * f_mclk / 4
+ * f_out can be f_256fs or f_opclk, currently only used for f_256fs. Can be
+ * generalised for f_opclk with suitable coefficient arrays, but currently
+ * the OPCLK divisor is calculated directly, not iteratively.
+ */
+static int wm8978_enum_mclk(unsigned int f_out, unsigned int f_mclk,
+			    unsigned int *f_pllout)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mclk_numerator); i++) {
+		unsigned int f_pllout_x4 = 4 * f_out * mclk_numerator[i] /
+			mclk_denominator[i];
+		if (3 * f_mclk <= f_pllout_x4 && f_pllout_x4 < 13 * f_mclk) {
+			*f_pllout = f_pllout_x4 / 4;
+			return i;
+		}
+	}
+
+	return -EINVAL;
+}
+
 /*
  * Calculate internal frequencies and dividers, according to Figure 40
  * "PLL and Clock Select Circuit" in WM8978 datasheet Rev. 2.6
@@ -412,12 +442,16 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 	struct wm8978_pll_div pll_div;
 	unsigned int f_opclk = wm8978->f_opclk, f_mclk = wm8978->f_mclk,
 		f_256fs = wm8978->f_256fs;
-	unsigned int f2, opclk_div;
+	unsigned int f2;
 
 	if (!f_mclk)
 		return -EINVAL;
 
 	if (f_opclk) {
+		unsigned int opclk_div;
+		/* Cannot set up MCLK divider now, do later */
+		wm8978->mclk_idx = -1;
+
 		/*
 		 * The user needs OPCLK. Choose OPCLKDIV to put
 		 * 6 <= R = f2 / f1 < 13, 1 <= OPCLKDIV <= 4.
@@ -444,7 +478,7 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 		wm8978->f_pllout = f_opclk * opclk_div;
 	} else if (f_256fs) {
 		/*
-		 * Not using OPCLK, choose R:
+		 * Not using OPCLK, but PLL is used for the codec, choose R:
 		 * 6 <= R = f2 / f1 < 13, to put 1 <= MCLKDIV <= 12.
 		 * f_256fs = f_mclk * prescale * R / 4 / MCLKDIV, where
 		 * prescale = 1, or prescale = 2. Prescale is calculated inside
@@ -453,18 +487,11 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 		 * f_mclk * 3 / 48 <= f_256fs < f_mclk * 13 / 4. This means MCLK
 		 * must be 3.781MHz <= f_MCLK <= 32.768MHz
 		 */
-		if (48 * f_256fs < 3 * f_mclk || 4 * f_256fs >= 13 * f_mclk)
-			return -EINVAL;
+		int idx = wm8978_enum_mclk(f_256fs, f_mclk, &wm8978->f_pllout);
+		if (idx < 0)
+			return idx;
 
-		/*
-		 * MCLKDIV will be selected in .hw_params(), just choose a
-		 * suitable f_PLLOUT
-		 */
-		if (4 * f_256fs < 3 * f_mclk)
-			/* Will have to use MCLKDIV */
-			wm8978->f_pllout = wm8978->f_mclk * 3 / 4;
-		else
-			wm8978->f_pllout = f_256fs;
+		wm8978->mclk_idx = idx;
 
 		/* GPIO1 into default mode as input - before configuring PLL */
 		snd_soc_update_bits(codec, WM8978_GPIO_CONTROL, 7, 0);
@@ -515,6 +542,20 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		wm8978->f_opclk = div;
 
 		if (wm8978->f_mclk)
+			/*
+			 * We know the MCLK frequency, the user has requested
+			 * OPCLK, configure the PLL based on that and start it
+			 * and OPCLK immediately. We will configure PLL to match
+			 * user-requested OPCLK frquency as good as possible.
+			 * In fact, it is likely, that matching the sampling
+			 * rate, when it becomes known, is more important, and
+			 * we will not be reconfiguring PLL then, because we
+			 * must not interrupt OPCLK. But it should be fine,
+			 * because typically the user will request OPCLK to run
+			 * at 256fs or 512fs, and for these cases we will also
+			 * find an exact MCLK divider configuration - it will
+			 * be equal to or double the OPCLK divisor.
+			 */
 			ret = wm8978_configure_pll(codec);
 		break;
 	case WM8978_BCLKDIV:
@@ -640,10 +681,6 @@ static int wm8978_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
-/* MCLK dividers */
-static const int mclk_numerator[]	= {1, 3, 2, 3, 4, 6, 8, 12};
-static const int mclk_denominator[]	= {1, 2, 1, 1, 1, 1, 1, 1};
-
 /*
  * Set PCM DAI bit size and sample rate.
  */
@@ -709,9 +746,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 	wm8978->f_256fs = params_rate(params) * 256;
 
 	if (wm8978->sysclk == WM8978_MCLK) {
+		wm8978->mclk_idx = -1;
 		f_sel = wm8978->f_mclk;
 	} else {
 		if (!wm8978->f_pllout) {
+			/* We only enter here, if OPCLK is not used */
 			int ret = wm8978_configure_pll(codec);
 			if (ret < 0)
 				return ret;
@@ -719,32 +758,34 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 		f_sel = wm8978->f_pllout;
 	}
 
-	/*
-	 * In some cases it is possible to reconfigure PLL to a higher frequency
-	 * by raising OPCLKDIV, but normally OPCLK is configured to 256 * fs or
-	 * 512 * fs, so, we should be fine.
-	 */
-	if (f_sel < wm8978->f_256fs || f_sel > 12 * wm8978->f_256fs)
-		return -EINVAL;
+	if (wm8978->mclk_idx < 0) {
+		/* Either MCLK is used directly, or OPCLK is used */
+		if (f_sel < wm8978->f_256fs || f_sel > 12 * wm8978->f_256fs)
+			return -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(mclk_numerator); i++) {
-		diff = abs(wm8978->f_256fs * 3 -
-			   f_sel * 3 * mclk_denominator[i] / mclk_numerator[i]);
+		for (i = 0; i < ARRAY_SIZE(mclk_numerator); i++) {
+			diff = abs(wm8978->f_256fs * 3 -
+				   f_sel * 3 * mclk_denominator[i] / mclk_numerator[i]);
 
-		if (diff < diff_best) {
-			diff_best = diff;
-			best = i;
-		}
+			if (diff < diff_best) {
+				diff_best = diff;
+				best = i;
+			}
 
-		if (!diff)
-			break;
+			if (!diff)
+				break;
+		}
+	} else {
+		/* OPCLK not used, codec driven by PLL */
+		best = wm8978->mclk_idx;
+		diff = 0;
 	}
 
 	if (diff)
-		dev_warn(codec->dev, "Imprecise clock: %u%s\n",
-			 f_sel * mclk_denominator[best] / mclk_numerator[best],
-			 wm8978->sysclk == WM8978_MCLK ?
-			 ", consider using PLL" : "");
+		dev_warn(codec->dev, "Imprecise sampling rate: %uHz%s\n",
+			f_sel * mclk_denominator[best] / mclk_numerator[best] / 256,
+			wm8978->sysclk == WM8978_MCLK ?
+			", consider using PLL" : "");
 
 	dev_dbg(codec->dev, "%s: fmt %d, rate %u, MCLK divisor #%d\n", __func__,
 		params_format(params), params_rate(params), best);
