From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: s3c24xx_uda134x DAI accessor
	functions and static cleanup
Date: Wed, 19 Nov 2008 13:36:32 +0000
Message-ID: <1227101793-3768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081119133427.GA3687@rakim.wolfsonmicro.main>
	<1227101793-3768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227101793-3768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 265F310380C
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:36:35 +0100 (CET)
In-Reply-To: <1227101793-3768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Missed these during review.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c24xx_uda134x.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 487b010..92d90f2 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -63,7 +63,7 @@ static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 
 static struct platform_device *s3c24xx_uda134x_snd_device;
 
-int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
+static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 #ifdef ENFORCE_RATES
@@ -115,7 +115,7 @@ int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
+static void s3c24xx_uda134x_shutdown(struct snd_pcm_substream *substream)
 {
 	mutex_lock(&clk_lock);
 	pr_debug("%s %d\n", __func__, clk_users);
@@ -180,39 +180,38 @@ static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	ret = codec_dai->dai_ops.set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
-	ret = cpu_dai->dai_ops.set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
 			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
 	if (ret < 0)
 		return ret;
 
-	ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, clk_source , clk,
-						SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(cpu_dai, clk_source , clk,
+			SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
-						fs_mode);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK, fs_mode);
 	if (ret < 0)
 		return ret;
 
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
-						S3C2410_IISMOD_32FS);
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_BCLK,
+			S3C2410_IISMOD_32FS);
 	if (ret < 0)
 		return ret;
 
-	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-					  S3C24XX_PRESCALE(div, div));
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
+			S3C24XX_PRESCALE(div, div));
 	if (ret < 0)
 		return ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0, clk,
-						SND_SOC_CLOCK_OUT);
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
+			SND_SOC_CLOCK_OUT);
 	if (ret < 0)
 		return ret;
 
-- 
1.5.6.5
