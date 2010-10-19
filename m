From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 18/25] ASoC: SMARTQ: Move to use new I2S driver
Date: Tue, 19 Oct 2010 16:07:59 +0900
Message-ID: <1287472079-30982-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 47CDD103933
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:17:48 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Modify the smartq_wm8987.c to use new i2s controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig         |    2 +-
 sound/soc/s3c24xx/smartq_wm8987.c |   25 +++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 20fe288..e7fad53 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -144,7 +144,7 @@ config SND_SOC_SMDK_WM9713
 config SND_S3C64XX_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
 	depends on SND_S3C24XX_SOC && MACH_SMARTQ
-	select SND_S3C64XX_SOC_I2S
+	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
 
 config SND_SOC_GONI_AQUILA_WM8994
diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
index 1d55312..5fcc420 100644
--- a/sound/soc/s3c24xx/smartq_wm8987.c
+++ b/sound/soc/s3c24xx/smartq_wm8987.c
@@ -25,7 +25,7 @@
 #include <asm/mach-types.h>
 
 #include "dma.h"
-#include "s3c64xx-i2s.h"
+#include "i2s.h"
 
 #include "../codecs/wm8750.h"
 
@@ -41,13 +41,9 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct s3c_i2sv2_rate_calc div;
 	unsigned int clk = 0;
 	int ret;
 
-	s3c_i2sv2_iis_calc_rate(&div, NULL, params_rate(params),
-				s3c_i2sv2_get_clock(cpu_dai));
-
 	switch (params_rate(params)) {
 	case 8000:
 	case 16000:
@@ -78,20 +74,21 @@ static int smartq_hifi_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
-				     SND_SOC_CLOCK_IN);
+	/* Use PCLK for I2S signal generation */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_RCLKSRC_0,
+					0, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
-	/* set MCLK division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, div.fs_div);
+	/* Gate the RCLK output on PAD */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
+					0, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
-	/* set prescaler division for sample rate */
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_PRESCALER,
-				     div.clk_div - 1);
+	/* set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
+				     SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
@@ -211,7 +208,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 	{
 		.name		= "wm8987",
 		.stream_name	= "SmartQ Hi-Fi",
-		.cpu_dai_name	= "s3c64xx-i2s.0",
+		.cpu_dai_name	= "samsung-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
 		.platform_name	= "samsung-audio",
 		.codec_name	= "wm8750-codec.0-0x1a",
-- 
1.6.2.5
