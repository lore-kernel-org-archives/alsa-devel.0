From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/6] ASoC: Blackfin: new machine driver for
	ADAU1381 codecs
Date: Sat,  7 Aug 2010 16:28:23 -0400
Message-ID: <1281212905-12957-4-git-send-email-vapier@gentoo.org>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A83D9103806
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 22:28:23 +0200 (CEST)
In-Reply-To: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig          |    9 ++
 sound/soc/blackfin/Makefile         |    2 +
 sound/soc/blackfin/bf5xx-adau1381.c |  144 +++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-adau1381.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 56eb6c6..5df4e4b 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -41,6 +41,15 @@ config SND_BF5XX_SOC_ADAU1361
 	help
 	  Say Y if you want to add support for ADAU1361 SoC audio.
 
+config SND_BF5XX_SOC_ADAU1381
+	tristate "SoC ADAU1381 Audio support"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_ADAU1381
+	select I2C
+	help
+	  Say Y if you want to add support for ADAU1381 SoC audio.
+
 config SND_BF5XX_SOC_ADAV80X
 	tristate "SoC ADAV801/3 Audio support"
 	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 9de1fc9..02bb207 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -22,6 +22,7 @@ snd-ssm2602-objs := bf5xx-ssm2602.o
 snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad193x-objs := bf5xx-ad193x.o
 snd-adau1361-objs := bf5xx-adau1361.o
+snd-adau1381-objs := bf5xx-adau1381.o
 snd-adav80x-objs := bf5xx-adav80x.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
@@ -30,4 +31,5 @@ obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
 obj-$(CONFIG_SND_BF5XX_SOC_ADAU1361) += snd-adau1361.o
+obj-$(CONFIG_SND_BF5XX_SOC_ADAU1381) += snd-adau1381.o
 obj-$(CONFIG_SND_BF5XX_SOC_ADAV80X) += snd-adav80x.o
diff --git a/sound/soc/blackfin/bf5xx-adau1381.c b/sound/soc/blackfin/bf5xx-adau1381.c
new file mode 100644
index 0000000..ca2a9e4
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-adau1381.c
@@ -0,0 +1,144 @@
+/*
+ * board driver for adau1381 sound chip
+ *
+ * Copyright 2010 Analog Devices Inc.
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
+#include "../codecs/adau1381.h"
+#include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
+#include "bf5xx-i2s.h"
+
+static int bf5xx_adau1381_hw_params(struct snd_pcm_substream *substream,
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
+		pll_out = ADAU1381_PLL_FREQ_441;
+		break;
+	case 8000:
+	case 12000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		pll_out = ADAU1381_PLL_FREQ_48;
+		break;
+	default:
+		pll_out = ADAU1381_PLL_FREQ_441;
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
+	pll_in = ADAU1381_MCLK_RATE; /* fixed rate MCLK */
+	ret = codec_dai->ops->set_sysclk(codec_dai, ADAU1381_MCLK_ID, pll_in,
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
+static struct snd_soc_ops bf5xx_adau1381_ops = {
+	.hw_params = bf5xx_adau1381_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_adau1381_dai = {
+	.name = "adau1381",
+	.stream_name = "adau1381",
+	.cpu_dai = &bf5xx_i2s_dai,
+	.codec_dai = &adau1381_dai,
+	.ops = &bf5xx_adau1381_ops,
+};
+
+static struct snd_soc_card bf5xx_adau1381 = {
+	.name = "bf5xx_adau1381",
+	.platform = &bf5xx_i2s_soc_platform,
+	.dai_link = &bf5xx_adau1381_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_adau1381_snd_devdata = {
+	.card = &bf5xx_adau1381,
+	.codec_dev = &soc_codec_dev_adau1381,
+};
+
+static struct platform_device *bf5xx_adau1381_snd_device;
+
+static int __init bf5xx_adau1381_init(void)
+{
+	int ret;
+
+	pr_debug("%s enter\n", __func__);
+	bf5xx_adau1381_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_adau1381_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bf5xx_adau1381_snd_device,
+				&bf5xx_adau1381_snd_devdata);
+	bf5xx_adau1381_snd_devdata.dev = &bf5xx_adau1381_snd_device->dev;
+	ret = platform_device_add(bf5xx_adau1381_snd_device);
+
+	if (ret)
+		platform_device_put(bf5xx_adau1381_snd_device);
+
+	return ret;
+}
+module_init(bf5xx_adau1381_init);
+
+static void __exit bf5xx_adau1381_exit(void)
+{
+	pr_debug("%s enter\n", __func__);
+	platform_device_unregister(bf5xx_adau1381_snd_device);
+}
+module_exit(bf5xx_adau1381_exit);
+
+/* Module information */
+MODULE_AUTHOR("Cliff Cai");
+MODULE_DESCRIPTION("ALSA SoC adau1381");
+MODULE_LICENSE("GPL");
-- 
1.7.2
