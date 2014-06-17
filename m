From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFC/RFT] ASoC: rt5677: Convert to use
	rl6231_pll_calc
Date: Tue, 17 Jun 2014 12:41:31 +0800
Message-ID: <1402980091.13607.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC4826550E
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 06:41:37 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id w10so2533519pde.31
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 21:41:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The implementation of rt5677_pll_calc() has the same logic of rl6231_pll_calc().
The only difference is the lower boundary checking for freq_in.

This patch calls rl6231_pll_calc() instead of open-coded.
The k_bp of struct rt5677_pll_code is always false, thus also remove the
code to check pll_code.k_bp.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Oder,
This patch removes the usage of k_bp from struct rt5677_pll_code because it is
always false. I think if k_bp is necessay in the further development, maybe
it's better to add it to rl6231_pll_code. How do you think?

Regards,
Axel

 sound/soc/codecs/rt5677.c | 69 ++++++-----------------------------------------
 sound/soc/codecs/rt5677.h |  8 ------
 2 files changed, 8 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 45f99a8..e7c401f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -2988,62 +2988,12 @@ static int rt5677_set_dai_sysclk(struct snd_soc_dai *dai,
  * Returns 0 for success or negative error code.
  */
 static int rt5677_pll_calc(const unsigned int freq_in,
-	const unsigned int freq_out, struct rt5677_pll_code *pll_code)
+	const unsigned int freq_out, struct rl6231_pll_code *pll_code)
 {
-	int max_n = RT5677_PLL_N_MAX, max_m = RT5677_PLL_M_MAX;
-	int k, red, n_t, pll_out, in_t;
-	int n = 0, m = 0, m_t = 0;
-	int out_t, red_t = abs(freq_out - freq_in);
-	bool m_bp = false, k_bp = false;
-
-	if (RT5677_PLL_INP_MAX < freq_in || RT5677_PLL_INP_MIN > freq_in)
+	if (RT5677_PLL_INP_MIN > freq_in)
 		return -EINVAL;
 
-	k = 100000000 / freq_out - 2;
-	if (k > RT5677_PLL_K_MAX)
-		k = RT5677_PLL_K_MAX;
-	for (n_t = 0; n_t <= max_n; n_t++) {
-		in_t = freq_in / (k + 2);
-		pll_out = freq_out / (n_t + 2);
-		if (in_t < 0)
-			continue;
-		if (in_t == pll_out) {
-			m_bp = true;
-			n = n_t;
-			goto code_find;
-		}
-		red = abs(in_t - pll_out);
-		if (red < red_t) {
-			m_bp = true;
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
-				m_bp = false;
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
-	pll_code->m_bp = m_bp;
-	pll_code->k_bp = k_bp;
-	pll_code->m_code = m;
-	pll_code->n_code = n;
-	pll_code->k_code = k;
-	return 0;
+	return rl6231_pll_calc(freq_in, freq_out, pll_code);
 }
 
 static int rt5677_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
@@ -3051,7 +3001,7 @@ static int rt5677_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
-	struct rt5677_pll_code pll_code;
+	struct rl6231_pll_code pll_code;
 	int ret;
 
 	if (source == rt5677->pll_src && freq_in == rt5677->pll_in &&
@@ -3109,15 +3059,12 @@ static int rt5677_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		return ret;
 	}
 
-	dev_dbg(codec->dev, "m_bypass=%d k_bypass=%d m=%d n=%d k=%d\n",
-		pll_code.m_bp, pll_code.k_bp,
-		(pll_code.m_bp ? 0 : pll_code.m_code), pll_code.n_code,
-		(pll_code.k_bp ? 0 : pll_code.k_code));
+	dev_dbg(codec->dev, "m_bypass=%d m=%d n=%d k=%d\n",
+		pll_code.m_bp, (pll_code.m_bp ? 0 : pll_code.m_code),
+		pll_code.n_code, pll_code.k_code);
 
 	regmap_write(rt5677->regmap, RT5677_PLL1_CTRL1,
-		pll_code.n_code << RT5677_PLL_N_SFT |
-		pll_code.k_bp << RT5677_PLL_K_BP_SFT |
-		(pll_code.k_bp ? 0 : pll_code.k_code));
+		pll_code.n_code << RT5677_PLL_N_SFT | pll_code.k_code);
 	regmap_write(rt5677->regmap, RT5677_PLL1_CTRL2,
 		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5677_PLL_M_SFT |
 		pll_code.m_bp << RT5677_PLL_M_BP_SFT);
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index af4e9c7..08252e7 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1425,14 +1425,6 @@ enum {
 	RT5677_AIFS,
 };
 
-struct rt5677_pll_code {
-	bool m_bp; /* Indicates bypass m code or not. */
-	bool k_bp; /* Indicates bypass k code or not. */
-	int m_code;
-	int n_code;
-	int k_code;
-};
-
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
-- 
1.8.3.2
