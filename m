From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/6] ASoC: Blackfin: new machine driver
	for ADAU1761 codecs
Date: Sat,  7 Aug 2010 16:28:25 -0400
Message-ID: <1281212905-12957-6-git-send-email-vapier@gentoo.org>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1281212905-12957-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 sound/soc/blackfin/Kconfig          |    9 ++
 sound/soc/blackfin/Makefile         |    2 +
 sound/soc/blackfin/bf5xx-adau1761.c |  144 +++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-adau1761.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 5df4e4b..64b90c1 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -50,6 +50,15 @@ config SND_BF5XX_SOC_ADAU1381
 	help
 	  Say Y if you want to add support for ADAU1381 SoC audio.
 
+config SND_BF5XX_SOC_ADAU1761
+	tristate "SoC ADAU1761 Audio support"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_ADAU1761
+	select I2C
+	help
+	  Say Y if you want to add support for ADAU1761 SoC audio.
+
 config SND_BF5XX_SOC_ADAV80X
 	tristate "SoC ADAV801/3 Audio support"
 	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 02bb207..33449b9 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -23,6 +23,7 @@ snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad193x-objs := bf5xx-ad193x.o
 snd-adau1361-objs := bf5xx-adau1361.o
 snd-adau1381-objs := bf5xx-adau1381.o
+snd-adau1761-objs := bf5xx-adau1761.o
 snd-adav80x-objs := bf5xx-adav80x.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
@@ -32,4 +33,5 @@ obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
 obj-$(CONFIG_SND_BF5XX_SOC_ADAU1361) += snd-adau1361.o
 obj-$(CONFIG_SND_BF5XX_SOC_ADAU1381) += snd-adau1381.o
+obj-$(CONFIG_SND_BF5XX_SOC_ADAU1761) += snd-adau1761.o
 obj-$(CONFIG_SND_BF5XX_SOC_ADAV80X) += snd-adav80x.o
diff --git a/sound/soc/blackfin/bf5xx-adau1761.c b/sound/soc/blackfin/bf5xx-adau1761.c
new file mode 100644
index 0000000..641c705
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-adau1761.c
@@ -0,0 +1,144 @@
+/*
+ * board driver for adau1761 sound chip
+ *
+ * Copyright 2009 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm_params.h>
+
+#include <asm/dma.h>
+#include <asm/portmux.h>
+#include <linux/gpio.h>
+#include "../codecs/adau1761.h"
+#include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
+#include "bf5xx-i2s.h"
+
+static int bf5xx_adau1761_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_in = 0, pll_out = 0;
+	int ret = 0;
+
+	switch (params_rate(params)) {
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		pll_out = ADAU1761_PLL_FREQ_441;
+		break;
+	case 8000:
+	case 12000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		pll_out = ADAU1761_PLL_FREQ_48;
+		break;
+	default:
+		pll_out = ADAU1761_PLL_FREQ_441;
+		break;
+	}
+
+	/* set codec DAI configuration */
+	ret = codec_dai->ops->set_fmt(codec_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = cpu_dai->ops->set_fmt(cpu_dai,
+		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock for DAC and ADC */
+	pll_in = ADAU1761_MCLK_RATE; /* fixed rate MCLK */
+	ret = codec_dai->ops->set_sysclk(codec_dai, ADAU1761_MCLK_ID, pll_in,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	/* codec PLL input is PCLK/4 */
+	ret = codec_dai->ops->set_pll(codec_dai, 0, 0, pll_in, pll_out);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops bf5xx_adau1761_ops = {
+	.hw_params = bf5xx_adau1761_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_adau1761_dai = {
+	.name = "adau1761",
+	.stream_name = "adau1761",
+	.cpu_dai = &bf5xx_i2s_dai,
+	.codec_dai = &adau1761_dai,
+	.ops = &bf5xx_adau1761_ops,
+};
+
+static struct snd_soc_card bf5xx_adau1761 = {
+	.name = "bf5xx_adau1761",
+	.platform = &bf5xx_i2s_soc_platform,
+	.dai_link = &bf5xx_adau1761_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_adau1761_snd_devdata = {
+	.card = &bf5xx_adau1761,
+	.codec_dev = &soc_codec_dev_adau1761,
+};
+
+static struct platform_device *bf5xx_adau1761_snd_device;
+
+static int __init bf5xx_adau1761_init(void)
+{
+	int ret;
+
+	pr_debug("%s enter\n", __func__);
+	bf5xx_adau1761_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_adau1761_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bf5xx_adau1761_snd_device,
+				&bf5xx_adau1761_snd_devdata);
+	bf5xx_adau1761_snd_devdata.dev = &bf5xx_adau1761_snd_device->dev;
+	ret = platform_device_add(bf5xx_adau1761_snd_device);
+
+	if (ret)
+		platform_device_put(bf5xx_adau1761_snd_device);
+
+	return ret;
+}
+module_init(bf5xx_adau1761_init);
+
+static void __exit bf5xx_adau1761_exit(void)
+{
+	pr_debug("%s enter\n", __func__);
+	platform_device_unregister(bf5xx_adau1761_snd_device);
+}
+module_exit(bf5xx_adau1761_exit);
+
+/* Module information */
+MODULE_AUTHOR("Cliff Cai");
+MODULE_DESCRIPTION("ALSA SoC adau1761");
+MODULE_LICENSE("GPL");
-- 
1.7.2
