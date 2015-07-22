From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rl6231: add pll preset table
Date: Wed, 22 Jul 2015 13:09:15 +0800
Message-ID: <1437541755-20717-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B99026065E
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 07:09:29 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Currently, rl6231_pll_calc provide a working PLL parameters for
given freq_in and freq_out. However, in some cases it is not the
perfect parameter. For example if freq_in = 19200000 and freq_out
 = 24576000, the calculated parameter will gengrate 24.5647 MHz
which is not exactly the same as what we need. But the PLL can
output 24.576 MHz as exactly what we expect if we set the best
PLL parameter.
To improve it, we put the best match parameters in a preset table.
We can search the preset table first, if there is no preset parameter
for the given freq_in and freq_out, we can still calculate a working
PLL parameter.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rl6231.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 56650d6..96f3e90 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -43,6 +43,19 @@ int rl6231_calc_dmic_clk(int rate)
 }
 EXPORT_SYMBOL_GPL(rl6231_calc_dmic_clk);
 
+struct pll_calc_map {
+	unsigned int pll_in;
+	unsigned int pll_out;
+	int k;
+	int n;
+	int m;
+	bool m_bp;
+};
+
+static const struct pll_calc_map pll_preset_table[] = {
+	{19200000,  24576000,  3, 30, 3, false},
+};
+
 /**
  * rl6231_pll_calc - Calcualte PLL M/N/K code.
  * @freq_in: external clock provided to codec.
@@ -57,7 +70,7 @@ int rl6231_pll_calc(const unsigned int freq_in,
 	const unsigned int freq_out, struct rl6231_pll_code *pll_code)
 {
 	int max_n = RL6231_PLL_N_MAX, max_m = RL6231_PLL_M_MAX;
-	int k, red, n_t, pll_out, in_t, out_t;
+	int i, k, red, n_t, pll_out, in_t, out_t;
 	int n = 0, m = 0, m_t = 0;
 	int red_t = abs(freq_out - freq_in);
 	bool bypass = false;
@@ -65,6 +78,18 @@ int rl6231_pll_calc(const unsigned int freq_in,
 	if (RL6231_PLL_INP_MAX < freq_in || RL6231_PLL_INP_MIN > freq_in)
 		return -EINVAL;
 
+	for (i = 0; i < ARRAY_SIZE(pll_preset_table); i++) {
+		if (freq_in == pll_preset_table[i].pll_in &&
+			freq_out == pll_preset_table[i].pll_out) {
+			k = pll_preset_table[i].k;
+			m = pll_preset_table[i].m;
+			n = pll_preset_table[i].n;
+			bypass = pll_preset_table[i].m_bp;
+			pr_debug("Use preset PLL parameter table\n");
+			goto code_find;
+		}
+	}
+
 	k = 100000000 / freq_out - 2;
 	if (k > RL6231_PLL_K_MAX)
 		k = RL6231_PLL_K_MAX;
-- 
1.8.1.1.439.g50a6b54
