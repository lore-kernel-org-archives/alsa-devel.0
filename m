From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rl6231: get better PLL parameters
Date: Mon, 27 Nov 2017 20:03:14 +0800
Message-ID: <1511784194-10083-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E825266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 13:03:25 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

For those which can only get approximation PLL out cases, this patch
will use higher resolution to get a better PLL parameter.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rl6231.c | 95 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 974a904..33690e9 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/gcd.h>
 #include "rl6231.h"
 
 /**
@@ -106,6 +107,25 @@ static const struct pll_calc_map pll_preset_table[] = {
 	{19200000,  24576000,  3, 30, 3, false},
 };
 
+static unsigned int find_best_div(unsigned int in,
+	unsigned int max, unsigned int div)
+{
+	unsigned int d;
+
+	if (in <= max)
+		return 1;
+
+	d = in / max;
+	if (in % max)
+		d++;
+
+	while (div % d != 0)
+		d++;
+
+
+	return d;
+}
+
 /**
  * rl6231_pll_calc - Calcualte PLL M/N/K code.
  * @freq_in: external clock provided to codec.
@@ -120,9 +140,11 @@ int rl6231_pll_calc(const unsigned int freq_in,
 	const unsigned int freq_out, struct rl6231_pll_code *pll_code)
 {
 	int max_n = RL6231_PLL_N_MAX, max_m = RL6231_PLL_M_MAX;
-	int i, k, red, n_t, pll_out, in_t, out_t;
-	int n = 0, m = 0, m_t = 0;
-	int red_t = abs(freq_out - freq_in);
+	int i, k, n_t;
+	int k_t, min_k, max_k, n = 0, m = 0, m_t = 0;
+	unsigned int red, pll_out, in_t, out_t, div, div_t;
+	unsigned int red_t = abs(freq_out - freq_in);
+	unsigned int f_in, f_out, f_max;
 	bool bypass = false;
 
 	if (RL6231_PLL_INP_MAX < freq_in || RL6231_PLL_INP_MIN > freq_in)
@@ -140,39 +162,54 @@ int rl6231_pll_calc(const unsigned int freq_in,
 		}
 	}
 
-	k = 100000000 / freq_out - 2;
-	if (k > RL6231_PLL_K_MAX)
-		k = RL6231_PLL_K_MAX;
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
+	min_k = 80000000 / freq_out - 2;
+	max_k = 150000000 / freq_out - 2;
+	if (max_k > RL6231_PLL_K_MAX)
+		max_k = RL6231_PLL_K_MAX;
+	if (min_k > RL6231_PLL_K_MAX)
+		min_k = max_k = RL6231_PLL_K_MAX;
+	div_t = gcd(freq_in, freq_out);
+	f_max = 0xffffffff / RL6231_PLL_N_MAX;
+	div = find_best_div(freq_in, f_max, div_t);
+	f_in = freq_in / div;
+	f_out = freq_out / div;
+	k = min_k;
+	for (k_t = min_k; k_t <= max_k; k_t++) {
+		for (n_t = 0; n_t <= max_n; n_t++) {
+			in_t = f_in * (n_t + 2);
+			pll_out = f_out * (k_t + 2);
+			if (in_t < 0)
+				continue;
+			if (in_t == pll_out) {
+				bypass = true;
+				n = n_t;
+				k = k_t;
 				goto code_find;
-			red_t = red;
-		}
-		for (m_t = 0; m_t <= max_m; m_t++) {
-			out_t = in_t / (m_t + 2);
-			red = abs(out_t - pll_out);
+			}
+			out_t = in_t / (k_t + 2);
+			red = abs(f_out - out_t);
 			if (red < red_t) {
-				bypass = false;
+				bypass = true;
 				n = n_t;
-				m = m_t;
+				m = 0;
+				k = k_t;
 				if (red == 0)
 					goto code_find;
 				red_t = red;
 			}
+			for (m_t = 0; m_t <= max_m; m_t++) {
+				out_t = in_t / ((m_t + 2) * (k_t + 2));
+				red = abs(f_out - out_t);
+				if (red < red_t) {
+					bypass = false;
+					n = n_t;
+					m = m_t;
+					k = k_t;
+					if (red == 0)
+						goto code_find;
+					red_t = red;
+				}
+			}
 		}
 	}
 	pr_debug("Only get approximation about PLL\n");
-- 
2.7.4
