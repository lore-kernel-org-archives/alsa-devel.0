From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCHv2 1/4] ASoC: S3C64XX: Move GPIO settings to
	platform
Date: Fri, 16 Jul 2010 15:20:27 +0900
Message-ID: <1279261227-18393-1-git-send-email-sw.youn@samsung.com>
References: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id EACC610394D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 08:29:57 +0200 (CEST)
In-Reply-To: <1279260977-18342-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Now that we have platform data provide callbacks for gpio config,
remove the explicit settings from CPU driver and just call the
cfg_gpio callback.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Reviewed-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c |   21 ++++++++----------
 sound/soc/s3c24xx/s3c64xx-i2s.c    |   40 +++++++++++++++--------------------
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 72708af..93ae973 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -16,9 +16,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
-#include <mach/gpio-bank-c.h>
-#include <mach/gpio-bank-h.h>
-#include <plat/gpio-cfg.h>
+#include <plat/audio.h>
 
 #include <mach/map.h>
 #include <mach/dma.h>
@@ -41,15 +39,7 @@ static struct s3c_i2sv2_info s3c64xx_i2sv4;
 
 static int s3c64xx_i2sv4_probe(struct snd_soc_dai *dai)
 {
-	/* configure GPIO for i2s port */
-	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
-	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
-	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
-
+	/* do nothing */
 	return 0;
 }
 
@@ -117,6 +107,7 @@ EXPORT_SYMBOL_GPL(s3c64xx_i2s_v4_dai);
 
 static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 {
+	struct s3c_audio_pdata *i2s_pdata;
 	struct s3c_i2sv2_info *i2s;
 	int ret;
 
@@ -137,6 +128,12 @@ static __devinit int s3c64xx_i2sv4_dev_probe(struct platform_device *pdev)
 	i2s->dma_playback->client = &s3c64xx_dma_client_out;
 	i2s->dma_playback->dma_size = 4;
 
+	i2s_pdata = pdev->dev.platform_data;
+	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		return -EINVAL;
+	}
+
 	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
 		dev_err(&pdev->dev, "failed to get audio-bus\n");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 5017e31..ab2ae47 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -20,9 +20,6 @@
 
 #include <sound/soc.h>
 
-#include <mach/gpio-bank-d.h>
-#include <mach/gpio-bank-e.h>
-#include <plat/gpio-cfg.h>
 #include <plat/audio.h>
 
 #include <mach/map.h>
@@ -47,6 +44,7 @@ static struct s3c2410_dma_client s3c64xx_dma_client_in = {
 
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_out[MAX_I2SV3];
 static struct s3c_dma_params s3c64xx_i2s_pcm_stereo_in[MAX_I2SV3];
+static struct s3c_i2sv2_info s3c64xx_i2s[MAX_I2SV3];
 
 static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 				  int clk_id, unsigned int freq, int dir)
@@ -102,9 +100,12 @@ static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 	struct s3c_i2sv2_info *i2s;
 	int ret;
 
-	i2s = kzalloc(sizeof(struct s3c_i2sv2_info), GFP_KERNEL);
-	if (i2s == NULL)
-		return -ENOMEM;
+	if (dai->id >= MAX_I2SV3) {
+		dev_err(dai->dev, "id %d out of range\n", dai->id);
+		return -EINVAL;
+	}
+
+	i2s = &s3c64xx_i2s[dai->id];
 	snd_soc_dai_set_drvdata(dai, i2s);
 
 	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[dai->id];
@@ -139,23 +140,6 @@ static int s3c64xx_i2s_probe(struct snd_soc_dai *dai)
 
 	clk_enable(i2s->iis_cclk);
 
-	/* configure GPIO for i2s port */
-	switch (dai->id) {
-	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_I2S0_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_I2S0_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_I2S0_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_I2S0_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_I2S0_D0);
-		break;
-	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_I2S1_CLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_I2S1_CDCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_I2S1_LRCLK);
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
-	}
-
 	return 0;
 
 err:
@@ -213,12 +197,22 @@ EXPORT_SYMBOL_GPL(s3c64xx_i2s_dai);
 
 static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
+	struct s3c_audio_pdata *i2s_pdata;
+	struct s3c_i2sv2_info *i2s;
 
 	if (pdev->id >= MAX_I2SV3) {
 		dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
 		return -EINVAL;
 	}
 
+	i2s = &s3c64xx_i2s[pdev->id];
+
+	i2s_pdata = pdev->dev.platform_data;
+	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		return -EINVAL;
+	}
+
 	return snd_soc_register_dais(&pdev->dev, s3c64xx_i2s_dai,
 			ARRAY_SIZE(s3c64xx_i2s_dai));
 }
-- 
1.6.2.5
