From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: samsung: i2s: Add missing clk_disable_unprepare() on error in samsung_i2s_probe()
Date: Tue, 23 Aug 2016 15:16:42 +0000
Message-ID: <1471965402-6642-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the missing clk_disable_unprepare() before return
from samsung_i2s_probe() in the error handling case.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 sound/soc/samsung/i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fa3ff03..7e32cf4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1318,7 +1318,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai = i2s_alloc_dai(pdev, true);
 		if (!sec_dai) {
 			dev_err(&pdev->dev, "Unable to alloc I2S_sec\n");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto err_disable_clk;
 		}
 
 		sec_dai->lock = &pri_dai->spinlock;
@@ -1342,7 +1343,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_disable_clk;
 	}
 
 	ret = devm_snd_soc_register_component(&pri_dai->pdev->dev,
@@ -1366,6 +1368,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 err_free_dai:
 	if (sec_dai)
 		i2s_free_sec_dai(sec_dai);
+err_disable_clk:
+	clk_disable_unprepare(pri_dai->clk);
 	return ret;
 }
 
