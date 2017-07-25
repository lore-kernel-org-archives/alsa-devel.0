From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/11] ASoC: samsung: i2s: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:31 +0530
Message-ID: <1500977674-27960-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/i2s.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index af3ba4d..b554497 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -550,7 +550,9 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 				goto err;
 			}
 
-			clk_prepare_enable(i2s->op_clk);
+			ret = clk_prepare_enable(i2s->op_clk);
+			if (ret)
+				goto err;
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
 			/* Over-ride the other's */
@@ -1132,10 +1134,19 @@ static int i2s_runtime_suspend(struct device *dev)
 static int i2s_runtime_resume(struct device *dev)
 {
 	struct i2s_dai *i2s = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(i2s->clk);
-	if (i2s->op_clk)
-		clk_prepare_enable(i2s->op_clk);
+	ret = clk_prepare_enable(i2s->clk);
+	if (ret)
+		return ret;
+
+	if (i2s->op_clk) {
+		ret = clk_prepare_enable(i2s->op_clk);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk);
+			return ret;
+		}
+	}
 
 	writel(i2s->suspend_i2scon, i2s->addr + I2SCON);
 	writel(i2s->suspend_i2smod, i2s->addr + I2SMOD);
-- 
1.9.1
