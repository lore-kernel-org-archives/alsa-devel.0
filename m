From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 09/11] ASoC: atmel: ac97c: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:45:37 +0530
Message-ID: <1500977737-28056-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/atmel/ac97c.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 9d2c9d9..52b0522 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -783,7 +783,9 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "no peripheral clock\n");
 		return PTR_ERR(pclk);
 	}
-	clk_prepare_enable(pclk);
+	retval = clk_prepare_enable(pclk);
+	if (retval)
+		return retval;
 
 	retval = snd_card_new(&pdev->dev, SNDRV_DEFAULT_IDX1,
 			      SNDRV_DEFAULT_STR1, THIS_MODULE,
@@ -897,9 +899,9 @@ static int atmel_ac97c_resume(struct device *pdev)
 {
 	struct snd_card *card = dev_get_drvdata(pdev);
 	struct atmel_ac97c *chip = card->private_data;
+	int ret = clk_prepare_enable(chip->pclk);
 
-	clk_prepare_enable(chip->pclk);
-	return 0;
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(atmel_ac97c_pm, atmel_ac97c_suspend, atmel_ac97c_resume);
-- 
1.9.1
