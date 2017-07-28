From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Add proper error paths to s3c24xx I2S driver" to the asoc tree
Date: Fri, 28 Jul 2017 11:17:55 +0100
Message-ID: <E1db2LD-0003mG-H5@debutante>
References: <20170727171338.13300-4-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727171338.13300-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgArvind Yadav <arvind.yadav.cs@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: Add proper error paths to s3c24xx I2S driver

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

>From 6f187f7ef1c15dca9f720b18a7e928718fd1a8b3 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 27 Jul 2017 19:13:38 +0200
Subject: [PATCH] ASoC: samsung: Add proper error paths to s3c24xx I2S driver

s3c2412_i2s_probe() might fail so driver has to revert work done by
s3c_i2sv2_probe() (clock enabling).  Missing doing this would lead to
clock enable in-balance.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c  |  9 +++++++++
 sound/soc/samsung/s3c-i2s-v2.h  |  7 +++++++
 sound/soc/samsung/s3c2412-i2s.c | 13 +++++++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 3894bda06ebb..58c3e9bfc6b7 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -651,6 +651,15 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
 
+void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
+		      struct s3c_i2sv2_info *i2s)
+{
+	clk_disable_unprepare(i2s->iis_pclk);
+	clk_put(i2s->iis_pclk);
+	i2s->iis_pclk = NULL;
+}
+EXPORT_SYMBOL_GPL(s3c_i2sv2_cleanup);
+
 #ifdef CONFIG_PM
 static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
 {
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
index 182d80564e37..3fca20f7a853 100644
--- a/sound/soc/samsung/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -92,6 +92,13 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
 			   unsigned long base);
 
 /**
+ * s3c_i2sv2_cleanup - cleanup resources allocated in s3c_i2sv2_probe
+ * @dai: The ASoC DAI structure supplied to the original probe.
+ * @i2s: Our local i2s structure to fill in.
+ */
+extern void s3c_i2sv2_cleanup(struct snd_soc_dai *dai,
+			      struct s3c_i2sv2_info *i2s);
+/**
  * s3c_i2sv2_register_component - register component and dai with soc core
  * @dev: DAI device
  * @id: DAI ID
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index bcd1cbdeac93..cc0840fff5aa 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -65,7 +65,8 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
 	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
 		pr_err("failed to get i2sclk clock\n");
-		return PTR_ERR(s3c2412_i2s.iis_cclk);
+		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
+		goto err;
 	}
 
 	/* Set MPLL as the source for IIS CLK */
@@ -73,20 +74,24 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
 	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
 	if (ret)
-		return ret;
-
-	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
+		goto err;
 
 	/* Configure the I2S pins (GPE0...GPE4) in correct mode */
 	s3c_gpio_cfgall_range(S3C2410_GPE(0), 5, S3C_GPIO_SFN(2),
 			      S3C_GPIO_PULL_NONE);
 
 	return 0;
+
+err:
+	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
+
+	return ret;
 }
 
 static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
 {
 	clk_disable_unprepare(s3c2412_i2s.iis_cclk);
+	s3c_i2sv2_cleanup(dai, &s3c2412_i2s);
 
 	return 0;
 }
-- 
2.13.2
