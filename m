From: Mark Brown <broonie@linaro.org>
Subject: [PATCH 1/2] ASoC: samsung-ac97: Use devm_clk_get()
Date: Wed, 26 Jun 2013 10:37:42 +0100
Message-ID: <1372239463-14603-1-git-send-email-broonie@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/samsung/ac97.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index cb88ead..1c85999 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -440,7 +440,7 @@ static int s3c_ac97_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	s3c_ac97.ac97_clk = clk_get(&pdev->dev, "ac97");
+	s3c_ac97.ac97_clk = devm_clk_get(&pdev->dev, "ac97");
 	if (IS_ERR(s3c_ac97.ac97_clk)) {
 		dev_err(&pdev->dev, "ac97 failed to get ac97_clock\n");
 		ret = -ENODEV;
@@ -480,7 +480,6 @@ err5:
 err4:
 err3:
 	clk_disable_unprepare(s3c_ac97.ac97_clk);
-	clk_put(s3c_ac97.ac97_clk);
 err2:
 	iounmap(s3c_ac97.regs);
 err1:
@@ -501,7 +500,6 @@ static int s3c_ac97_remove(struct platform_device *pdev)
 		free_irq(irq_res->start, NULL);
 
 	clk_disable_unprepare(s3c_ac97.ac97_clk);
-	clk_put(s3c_ac97.ac97_clk);
 
 	iounmap(s3c_ac97.regs);
 
-- 
1.8.3.1
