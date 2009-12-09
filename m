From: jassisinghbrar@gmail.com
Subject: [PATCH 5/7] ASoC: S3C64XX: Move gpio pin setup in
	platform init code
Date: Wed,  9 Dec 2009 13:29:44 +0900
Message-ID: <1260332984-11505-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id CA297243B4
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 05:36:10 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Like for other IPs, the configuration of MUX'ed GPIO to I2S mode
should be done in platform initialization code.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s.c |   40 +++++++++-----------------------------
 1 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 8ca3c1d..751a1b6 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -16,17 +16,13 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/clk.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
 
 #include <sound/soc.h>
 
 #include <plat/regs-s3c2412-iis.h>
-#include <plat/gpio-bank-d.h>
-#include <plat/gpio-bank-e.h>
-#include <plat/gpio-cfg.h>
+#include <plat/audio.h>
 
-#include <mach/map.h>
 #include <mach/dma.h>
 
 #include "s3c-dma.h"
@@ -106,30 +102,6 @@ struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai)
 }
 EXPORT_SYMBOL_GPL(s3c64xx_i2s_get_clock);
 
-static int s3c64xx_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
-{
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
-	return 0;
-}
-
-
 #define S3C64XX_I2S_RATES \
 	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
 	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
@@ -145,6 +117,7 @@ static struct snd_soc_dai_ops s3c64xx_i2s_dai_ops = {
 
 static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 {
+	struct s3c_audio_pdata *i2s_pdata;
 	struct s3c_i2sv2_info *i2s;
 	struct snd_soc_dai *dai;
 	struct resource *res;
@@ -169,7 +142,6 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	dai->capture.channels_max = 2;
 	dai->capture.rates = S3C64XX_I2S_RATES;
 	dai->capture.formats = S3C64XX_I2S_FMTS;
-	dai->probe = s3c64xx_i2s_probe;
 	dai->ops = &s3c64xx_i2s_dai_ops;
 
 	i2s->dma_capture = &s3c64xx_i2s_pcm_stereo_in[pdev->id];
@@ -202,6 +174,14 @@ static __devinit int s3c64xx_iis_dev_probe(struct platform_device *pdev)
 	i2s->dma_playback->client = &s3c64xx_dma_client_out;
 	i2s->dma_playback->dma_size = 4;
 
+	i2s_pdata = pdev->dev.platform_data;
+
+	/* Configure the I2S pins if MUX'ed */
+	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
+		dev_err(&pdev->dev, "Unable to configure gpio\n");
+		return -EINVAL;
+	}
+
 	i2s->iis_cclk = clk_get(&pdev->dev, "audio-bus");
 	if (IS_ERR(i2s->iis_cclk)) {
 		dev_err(&pdev->dev, "failed to get audio-bus\n");
-- 
1.6.2.5
