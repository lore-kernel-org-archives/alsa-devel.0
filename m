From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5640: Add the function of the PLL
	clock calculation to RL6231 shared support
Date: Tue, 20 May 2014 15:01:54 +0800
Message-ID: <1400569315-12221-2-git-send-email-oder_chiou@realtek.com>
References: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D44D2261A50
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 09:02:25 +0200 (CEST)
In-Reply-To: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the function of the PLL clock calculation to RL6231 shared
support.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rl6231.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rl6231.h | 15 ++++++++++
 sound/soc/codecs/rt5640.c | 68 ++++++--------------------------------------
 sound/soc/codecs/rt5640.h |  8 ------
 sound/soc/codecs/rt5645.c | 72 ++---------------------------------------------
 sound/soc/codecs/rt5645.h |  7 -----
 sound/soc/codecs/rt5651.c | 68 ++++++--------------------------------------
 sound/soc/codecs/rt5651.h |  1 -
 8 files changed, 102 insertions(+), 206 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 13ac551..289024b 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -62,6 +62,75 @@ int rl6231_calc_dmic_clk(int rate)
 }
 EXPORT_SYMBOL_GPL(rl6231_calc_dmic_clk);
 
+/**
+ * rl6231_pll_calc - Calcualte PLL M/N/K code.
+ * @freq_in: external clock provided to codec.
+ * @freq_out: target clock which codec works on.
+ * @pll_code: Pointer to structure with M, N, K and bypass flag.
+ *
+ * Calcualte M/N/K code to configure PLL for codec.
+ *
+ * Returns 0 for success or negative error code.
+ */
+int rl6231_pll_calc(const unsigned int freq_in,
+	const unsigned int freq_out, struct rl6231_pll_code *pll_code)
+{
+	int max_n = RL6231_PLL_N_MAX, max_m = RL6231_PLL_M_MAX;
+	int k, red, n_t, pll_out, in_t, out_t;
+	int n = 0, m = 0, m_t = 0;
+	int red_t = abs(freq_out - freq_in);
+	bool bypass = false;
+
+	if (RL6231_PLL_INP_MAX < freq_in || RL6231_PLL_INP_MIN > freq_in)
+		return -EINVAL;
+
+	k = 100000000 / freq_out - 2;
+	if (k > RL6231_PLL_K_MAX)
+		k = RL6231_PLL_K_MAX;
+	for (n_t = 0; n_t <= max_n; n_t++) {
+		in_t = freq_in / (k + 2);
+		pll_out = freq_out / (n_t + 2);
+		if (in_t < 0)
+			continue;
+		if (in_t == pll_out) {
+			bypass = true;
+			n = n_t;
+			goto code_find;
+		}
+		red = abs(in_t - pll_out);
+		if (red < red_t) {
+			bypass = true;
+			n = n_t;
+			m = m_t;
+			if (red == 0)
+				goto code_find;
+			red_t = red;
+		}
+		for (m_t = 0; m_t <= max_m; m_t++) {
+			out_t = in_t / (m_t + 2);
+			red = abs(out_t - pll_out);
+			if (red < red_t) {
+				bypass = false;
+				n = n_t;
+				m = m_t;
+				if (red == 0)
+					goto code_find;
+				red_t = red;
+			}
+		}
+	}
+	pr_debug("Only get approximation about PLL\n");
+
+code_find:
+
+	pll_code->m_bp = bypass;
+	pll_code->m_code = m;
+	pll_code->n_code = n;
+	pll_code->k_code = k;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rl6231_pll_calc);
+
 MODULE_DESCRIPTION("RL6231 class device shared support");
 MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rl6231.h b/sound/soc/codecs/rl6231.h
index 00032db..efdfc86 100644
--- a/sound/soc/codecs/rl6231.h
+++ b/sound/soc/codecs/rl6231.h
@@ -13,6 +13,21 @@
 #ifndef __RL6231_H__
 #define __RL6231_H__
 
+#define RL6231_PLL_INP_MAX	40000000
+#define RL6231_PLL_INP_MIN	256000
+#define RL6231_PLL_N_MAX	0x1ff
+#define RL6231_PLL_K_MAX	0x1f
+#define RL6231_PLL_M_MAX	0xf
+
+struct rl6231_pll_code {
+	bool m_bp; /* Indicates bypass m code or not. */
+	int m_code;
+	int n_code;
+	int k_code;
+};
+
 int rl6231_calc_dmic_clk(int rate);
+int rl6231_pll_calc(const unsigned int freq_in,
+	const unsigned int freq_out, struct rl6231_pll_code *pll_code);
 
 #endif /* __RL6231_H__ */
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0cefc16..bdc1a94 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1807,65 +1807,12 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-/**
- * rt5640_pll_calc - Calculate PLL M/N/K code.
- * @freq_in: external clock provided to codec.
- * @freq_out: target clock which codec works on.
- * @pll_code: Pointer to structure with M, N, K and bypass flag.
- *
- * Calculate M/N/K code to configure PLL for codec. And K is assigned to 2
- * which make calculation more efficiently.
- *
- * Returns 0 for success or negative error code.
- */
-static int rt5640_pll_calc(const unsigned int freq_in,
-	const unsigned int freq_out, struct rt5640_pll_code *pll_code)
-{
-	int max_n = RT5640_PLL_N_MAX, max_m = RT5640_PLL_M_MAX;
-	int n = 0, m = 0, red, n_t, m_t, in_t, out_t;
-	int red_t = abs(freq_out - freq_in);
-	bool bypass = false;
-
-	if (RT5640_PLL_INP_MAX < freq_in || RT5640_PLL_INP_MIN > freq_in)
-		return -EINVAL;
-
-	for (n_t = 0; n_t <= max_n; n_t++) {
-		in_t = (freq_in >> 1) + (freq_in >> 2) * n_t;
-		if (in_t < 0)
-			continue;
-		if (in_t == freq_out) {
-			bypass = true;
-			n = n_t;
-			goto code_find;
-		}
-		for (m_t = 0; m_t <= max_m; m_t++) {
-			out_t = in_t / (m_t + 2);
-			red = abs(out_t - freq_out);
-			if (red < red_t) {
-				n = n_t;
-				m = m_t;
-				if (red == 0)
-					goto code_find;
-				red_t = red;
-			}
-		}
-	}
-	pr_debug("Only get approximation about PLL\n");
-
-code_find:
-	pll_code->m_bp = bypass;
-	pll_code->m_code = m;
-	pll_code->n_code = n;
-	pll_code->k_code = 2;
-	return 0;
-}
-
 static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-	struct rt5640_pll_code *pll_code = &rt5640->pll_code;
+	struct rl6231_pll_code pll_code;
 	int ret, dai_sel;
 
 	if (source == rt5640->pll_src && freq_in == rt5640->pll_in &&
@@ -1909,20 +1856,21 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		return -EINVAL;
 	}
 
-	ret = rt5640_pll_calc(freq_in, freq_out, pll_code);
+	ret = rl6231_pll_calc(freq_in, freq_out, &pll_code);
 	if (ret < 0) {
 		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
 		return ret;
 	}
 
-	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=2\n", pll_code->m_bp,
-		(pll_code->m_bp ? 0 : pll_code->m_code), pll_code->n_code);
+	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=%d\n",
+		pll_code.m_bp, (pll_code.m_bp ? 0 : pll_code.m_code),
+		pll_code.n_code, pll_code.k_code);
 
 	snd_soc_write(codec, RT5640_PLL_CTRL1,
-		pll_code->n_code << RT5640_PLL_N_SFT | pll_code->k_code);
+		pll_code.n_code << RT5640_PLL_N_SFT | pll_code.k_code);
 	snd_soc_write(codec, RT5640_PLL_CTRL2,
-		(pll_code->m_bp ? 0 : pll_code->m_code) << RT5640_PLL_M_SFT |
-		pll_code->m_bp << RT5640_PLL_M_BP_SFT);
+		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5640_PLL_M_SFT |
+		pll_code.m_bp << RT5640_PLL_M_BP_SFT);
 
 	rt5640->pll_in = freq_in;
 	rt5640->pll_out = freq_out;
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 895ca14..58ebe96 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2079,13 +2079,6 @@ enum {
 	RT5640_DMIC2,
 };
 
-struct rt5640_pll_code {
-	bool m_bp; /* Indicates bypass m code or not. */
-	int m_code;
-	int n_code;
-	int k_code;
-};
-
 struct rt5640_priv {
 	struct snd_soc_codec *codec;
 	struct rt5640_platform_data pdata;
@@ -2097,7 +2090,6 @@ struct rt5640_priv {
 	int bclk[RT5640_AIFS];
 	int master[RT5640_AIFS];
 
-	struct rt5640_pll_code pll_code;
 	int pll_src;
 	int pll_in;
 	int pll_out;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index caa5519..ee6db7c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1964,80 +1964,12 @@ static int rt5645_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-/**
- * rt5645_pll_calc - Calcualte PLL M/N/K code.
- * @freq_in: external clock provided to codec.
- * @freq_out: target clock which codec works on.
- * @pll_code: Pointer to structure with M, N, K and bypass flag.
- *
- * Calcualte M/N/K code to configure PLL for codec. And K is assigned to 2
- * which make calculation more efficiently.
- *
- * Returns 0 for success or negative error code.
- */
-static int rt5645_pll_calc(const unsigned int freq_in,
-	const unsigned int freq_out, struct rt5645_pll_code *pll_code)
-{
-	int max_n = RT5645_PLL_N_MAX, max_m = RT5645_PLL_M_MAX;
-	int k, n = 0, m = 0, red, n_t, m_t, pll_out, in_t, out_t;
-	int red_t = abs(freq_out - freq_in);
-	bool bypass = false;
-
-	if (RT5645_PLL_INP_MAX < freq_in || RT5645_PLL_INP_MIN > freq_in)
-		return -EINVAL;
-
-	k = 100000000 / freq_out - 2;
-	if (k > RT5645_PLL_K_MAX)
-		k = RT5645_PLL_K_MAX;
-	for (n_t = 0; n_t <= max_n; n_t++) {
-		in_t = freq_in / (k + 2);
-		pll_out = freq_out / (n_t + 2);
-		if (in_t < 0)
-			continue;
-		if (in_t == pll_out) {
-			bypass = true;
-			n = n_t;
-			goto code_find;
-		}
-		red = abs(in_t - pll_out);
-		if (red < red_t) {
-			bypass = true;
-			n = n_t;
-			m = m_t;
-			if (red == 0)
-				goto code_find;
-			red_t = red;
-		}
-		for (m_t = 0; m_t <= max_m; m_t++) {
-			out_t = in_t / (m_t + 2);
-			red = abs(out_t - pll_out);
-			if (red < red_t) {
-				bypass = false;
-				n = n_t;
-				m = m_t;
-				if (red == 0)
-					goto code_find;
-				red_t = red;
-			}
-		}
-	}
-	pr_debug("Only get approximation about PLL\n");
-
-code_find:
-
-	pll_code->m_bp = bypass;
-	pll_code->m_code = m;
-	pll_code->n_code = n;
-	pll_code->k_code = k;
-	return 0;
-}
-
 static int rt5645_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	struct rt5645_pll_code pll_code;
+	struct rl6231_pll_code pll_code;
 	int ret;
 
 	if (source == rt5645->pll_src && freq_in == rt5645->pll_in &&
@@ -2080,7 +2012,7 @@ static int rt5645_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		return -EINVAL;
 	}
 
-	ret = rt5645_pll_calc(freq_in, freq_out, &pll_code);
+	ret = rl6231_pll_calc(freq_in, freq_out, &pll_code);
 	if (ret < 0) {
 		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
 		return ret;
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 345aa3f..355b7e9 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2162,13 +2162,6 @@ enum {
 	RT5645_DMIC_DATA_GPIO11,
 };
 
-struct rt5645_pll_code {
-	bool m_bp; /* Indicates bypass m code or not. */
-	int m_code;
-	int n_code;
-	int k_code;
-};
-
 struct rt5645_priv {
 	struct snd_soc_codec *codec;
 	struct rt5645_platform_data pdata;
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7a7bec6..a627a1f 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1516,65 +1516,12 @@ static int rt5651_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-/**
- * rt5651_pll_calc - Calcualte PLL M/N/K code.
- * @freq_in: external clock provided to codec.
- * @freq_out: target clock which codec works on.
- * @pll_code: Pointer to structure with M, N, K and bypass flag.
- *
- * Calcualte M/N/K code to configure PLL for codec. And K is assigned to 2
- * which make calculation more efficiently.
- *
- * Returns 0 for success or negative error code.
- */
-static int rt5651_pll_calc(const unsigned int freq_in,
-	const unsigned int freq_out, struct rt5651_pll_code *pll_code)
-{
-	int max_n = RT5651_PLL_N_MAX, max_m = RT5651_PLL_M_MAX;
-	int n = 0, m = 0, red, n_t, m_t, in_t, out_t;
-	int red_t = abs(freq_out - freq_in);
-	bool bypass = false;
-
-	if (RT5651_PLL_INP_MAX < freq_in || RT5651_PLL_INP_MIN > freq_in)
-		return -EINVAL;
-
-	for (n_t = 0; n_t <= max_n; n_t++) {
-		in_t = (freq_in >> 1) + (freq_in >> 2) * n_t;
-		if (in_t < 0)
-			continue;
-		if (in_t == freq_out) {
-			bypass = true;
-			n = n_t;
-			goto code_find;
-		}
-		for (m_t = 0; m_t <= max_m; m_t++) {
-			out_t = in_t / (m_t + 2);
-			red = abs(out_t - freq_out);
-			if (red < red_t) {
-				n = n_t;
-				m = m_t;
-				if (red == 0)
-					goto code_find;
-				red_t = red;
-			}
-		}
-	}
-	pr_debug("Only get approximation about PLL\n");
-
-code_find:
-	pll_code->m_bp = bypass;
-	pll_code->m_code = m;
-	pll_code->n_code = n;
-	pll_code->k_code = 2;
-	return 0;
-}
-
 static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
-	struct rt5651_pll_code *pll_code = &rt5651->pll_code;
+	struct rl6231_pll_code pll_code;
 	int ret;
 
 	if (source == rt5651->pll_src && freq_in == rt5651->pll_in &&
@@ -1609,20 +1556,21 @@ static int rt5651_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		return -EINVAL;
 	}
 
-	ret = rt5651_pll_calc(freq_in, freq_out, pll_code);
+	ret = rl6231_pll_calc(freq_in, freq_out, &pll_code);
 	if (ret < 0) {
 		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
 		return ret;
 	}
 
-	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=2\n", pll_code->m_bp,
-		(pll_code->m_bp ? 0 : pll_code->m_code), pll_code->n_code);
+	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=%d\n",
+		pll_code.m_bp, (pll_code.m_bp ? 0 : pll_code.m_code),
+		pll_code.n_code, pll_code.k_code);
 
 	snd_soc_write(codec, RT5651_PLL_CTRL1,
-		pll_code->n_code << RT5651_PLL_N_SFT | pll_code->k_code);
+		pll_code.n_code << RT5651_PLL_N_SFT | pll_code.k_code);
 	snd_soc_write(codec, RT5651_PLL_CTRL2,
-		(pll_code->m_bp ? 0 : pll_code->m_code) << RT5651_PLL_M_SFT |
-		pll_code->m_bp << RT5651_PLL_M_BP_SFT);
+		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5651_PLL_M_SFT |
+		pll_code.m_bp << RT5651_PLL_M_BP_SFT);
 
 	rt5651->pll_in = freq_in;
 	rt5651->pll_out = freq_out;
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index a28bd0c..1bd33cf 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2069,7 +2069,6 @@ struct rt5651_priv {
 	int bclk[RT5651_AIFS];
 	int master[RT5651_AIFS];
 
-	struct rt5651_pll_code pll_code;
 	int pll_src;
 	int pll_in;
 	int pll_out;
-- 
1.8.1.1.439.g50a6b54
