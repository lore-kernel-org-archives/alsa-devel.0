From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 07/10] ASoC: blackfin: Switch
	bf5xx-ad193x from bf5xx-tdm to bf5xx-i2s
Date: Tue, 28 May 2013 19:22:15 +0200
Message-ID: <1369761738-29503-7-git-send-email-lars@metafoo.de>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1369761738-29503-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The bf5xx-i2s driver now has support for TDM mode and the bf5xx-tdm driver is
going to be removed soon, so switch the driver over to bf5xx-i2s.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 sound/soc/blackfin/Kconfig        | 18 +++++++++---------
 sound/soc/blackfin/bf5xx-ad193x.c | 39 ++++++++++-----------------------------
 2 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 16b88f5..906c349 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -56,6 +56,15 @@ config SND_SOC_BFIN_EVAL_ADAV80X
 	  Note: This driver assumes that the ADAV80X digital record and playback
 	  interfaces are connected to the first SPORT port on the BF5XX board.
 
+config SND_BF5XX_SOC_AD193X
+	tristate "SoC AD193X Audio support for Blackfin"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_AD193X
+	help
+	  Say Y if you want to add support for AD193X codec on Blackfin.
+	  This driver supports AD1936, AD1937, AD1938 and AD1939.
+
 config SND_BF5XX_SOC_AD73311
 	tristate "SoC AD73311 Audio support for Blackfin"
 	depends on SND_BF5XX_I2S
@@ -90,15 +99,6 @@ config SND_BF5XX_SOC_AD1836
 	help
 	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
 
-config SND_BF5XX_SOC_AD193X
-	tristate "SoC AD193X Audio support for Blackfin"
-	depends on SND_BF5XX_TDM
-	select SND_BF5XX_SOC_TDM
-	select SND_SOC_AD193X
-	help
-	  Say Y if you want to add support for AD193X codec on Blackfin.
-	  This driver supports AD1936, AD1937, AD1938 and AD1939.
-
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index ce773b3..603ad1f 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -39,29 +39,16 @@
 
 #include "../codecs/ad193x.h"
 
-#include "bf5xx-tdm.h"
-
 static struct snd_soc_card bf5xx_ad193x;
 
-static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
+static int bf5xx_ad193x_link_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int clk = 0;
-	unsigned int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7};
-	int ret = 0;
-
-	switch (params_rate(params)) {
-	case 48000:
-		clk = 24576000;
-		break;
-	}
+	int ret;
 
 	/* set the codec system clock for DAC and ADC */
-	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
-		SND_SOC_CLOCK_IN);
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 24576000, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
@@ -70,9 +57,7 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* set cpu DAI channel mapping */
-	ret = snd_soc_dai_set_channel_map(cpu_dai, ARRAY_SIZE(channel_map),
-		channel_map, ARRAY_SIZE(channel_map), channel_map);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0xFF, 0xFF, 8, 32);
 	if (ret < 0)
 		return ret;
 
@@ -82,30 +67,26 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 #define BF5XX_AD193X_DAIFMT (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_IB_IF | \
 				SND_SOC_DAIFMT_CBM_CFM)
 
-static struct snd_soc_ops bf5xx_ad193x_ops = {
-	.hw_params = bf5xx_ad193x_hw_params,
-};
-
 static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
 	{
 		.name = "ad193x",
 		.stream_name = "AD193X",
-		.cpu_dai_name = "bfin-tdm.0",
+		.cpu_dai_name = "bfin-i2s.0",
 		.codec_dai_name ="ad193x-hifi",
-		.platform_name = "bfin-tdm-pcm-audio",
+		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "spi0.5",
-		.ops = &bf5xx_ad193x_ops,
 		.dai_fmt = BF5XX_AD193X_DAIFMT,
+		.init = bf5xx_ad193x_link_init,
 	},
 	{
 		.name = "ad193x",
 		.stream_name = "AD193X",
-		.cpu_dai_name = "bfin-tdm.1",
+		.cpu_dai_name = "bfin-i2s.1",
 		.codec_dai_name ="ad193x-hifi",
-		.platform_name = "bfin-tdm-pcm-audio",
+		.platform_name = "bfin-i2s-pcm-audio",
 		.codec_name = "spi0.5",
-		.ops = &bf5xx_ad193x_ops,
 		.dai_fmt = BF5XX_AD193X_DAIFMT,
+		.init = bf5xx_ad193x_link_init,
 	},
 };
 
-- 
1.8.0
