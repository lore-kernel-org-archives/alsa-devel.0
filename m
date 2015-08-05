From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rl6231: Simplify DMIC divider
	calculation expression
Date: Wed,  5 Aug 2015 14:58:33 -0700
Message-ID: <1438811913-39249-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C0D26041D
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 23:58:49 +0200 (CEST)
Received: by pacrr5 with SMTP id rr5so10570250pac.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2015 14:58:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: oder_chiou@realtek.com, albertchen@realtek.com, broonie@kernel.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Existing implementation checks all divider values and tracks
'red' proximity value for the frequency.

But as divider array is monotonically increasing the first
divider that gives DMIC rate in 3MHz range is the best one
we should use. No need for 'red' zone tracking.

Additionally make sure that DMIC frequency is higher 1MHz.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/rl6231.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 57e51c1..aca479f 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -62,31 +62,31 @@ int rl6231_get_pre_div(struct regmap *map, unsigned int reg, int sft)
 EXPORT_SYMBOL_GPL(rl6231_get_pre_div);
 
 /**
- * rl6231_calc_dmic_clk - Calculate the parameter of dmic.
+ * rl6231_calc_dmic_clk - Calculate the frequency divider parameter of dmic.
  *
  * @rate: base clock rate.
  *
- * Choose dmic clock between 1MHz and 3MHz.
- * It is better for clock to approximate 3MHz.
+ * Choose divider parameter that gives the highest possible DMIC frequency in
+ * 1MHz - 3MHz range.
  */
 int rl6231_calc_dmic_clk(int rate)
 {
-	int div[] = {2, 3, 4, 6, 8, 12}, idx = -EINVAL;
-	int i, red, bound, temp;
+	int div[] = {2, 3, 4, 6, 8, 12};
+	int i;
+
+	if (rate < 1000000 * div[0]) {
+		pr_warn("Base clock rate %d is too low\n", rate);
+		return -EINVAL;
+	}
 
-	red = 3000000 * 12;
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
-		bound = div[i] * 3000000;
-		if (rate > bound)
-			continue;
-		temp = bound - rate;
-		if (temp < red) {
-			red = temp;
-			idx = i;
-		}
+		/* find divider that gives DMIC frequency below 3MHz */
+		if (3000000 * div[i] >= rate)
+			return i;
 	}
 
-	return idx;
+	pr_warn("Base clock rate %d is too high\n", rate);
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(rl6231_calc_dmic_clk);
 
-- 
2.5.0.rc2.392.g76e840b
