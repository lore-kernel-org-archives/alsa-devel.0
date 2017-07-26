From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2 01/11] ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
Date: Wed, 26 Jul 2017 11:15:25 +0530
Message-ID: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
Chnage in v2 :
             Error handling for things done in s3c_i2sv2_probe().

 sound/soc/samsung/s3c2412-i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 0a47182..0b96927 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -65,13 +65,16 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
 	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
 		pr_err("failed to get i2sclk clock\n");
-		return PTR_ERR(s3c2412_i2s.iis_cclk);
+		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
+		goto err;
 	}
 
 	/* Set MPLL as the source for IIS CLK */
 
 	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
-	clk_prepare_enable(s3c2412_i2s.iis_cclk);
+	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
+	if (ret)
+		goto err;
 
 	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
 
@@ -80,6 +83,11 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 			      S3C_GPIO_PULL_NONE);
 
 	return 0;
+
+err:
+	clk_disable(s3c2412_i2s.iis_pclk);
+	clk_put(s3c2412_i2s.iis_pclk);
+	return ret;
 }
 
 static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
-- 
1.9.1
