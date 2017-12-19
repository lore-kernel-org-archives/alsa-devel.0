From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6231: get better PLL parameters" to
	the asoc tree
Date: Tue, 19 Dec 2017 10:58:51 +0000
Message-ID: <E1eRFbn-0000lL-F1@debutante>
References: <1511784194-10083-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E8799267681
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:58:57 +0100 (CET)
In-Reply-To: <1511784194-10083-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6231: get better PLL parameters

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2f8aab3d29fda158fa49ecae94b3b3a4b494909d Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 27 Nov 2017 20:03:14 +0800
Subject: [PATCH] ASoC: rl6231: get better PLL parameters

For those which can only get approximation PLL out cases, this patch
will use higher resolution to get a better PLL parameter.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6231.c | 95 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 974a9040651d..33690e98e297 100644
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
2.15.1
