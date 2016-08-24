From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Add missing clk_disable_unprepare() on error in samsung_i2s_probe()" to the asoc tree
Date: Wed, 24 Aug 2016 12:38:29 +0100
Message-ID: <E1bcWVp-0000yB-5k@debutante>
References: <1471965402-6642-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471965402-6642-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Add missing clk_disable_unprepare() on error in samsung_i2s_probe()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fd61576fdda88c9677f9ea62e6f32997ce39daea Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Tue, 23 Aug 2016 15:16:42 +0000
Subject: [PATCH] ASoC: samsung: i2s: Add missing clk_disable_unprepare() on
 error in samsung_i2s_probe()

Add the missing clk_disable_unprepare() before return
from samsung_i2s_probe() in the error handling case.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fa3ff03d97d5..7e32cf4581f8 100644
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
 
-- 
2.8.1
