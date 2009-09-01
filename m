From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] new board driver to connect bfin-5xx with
	ad1836 codec
Date: Tue, 1 Sep 2009 12:45:14 +0800
Message-ID: <1251780314-18707-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E47624803
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 06:43:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
As discussed, the patch uses the original TDM order without rewriting.
For the match between TDM slot number and audio channel number, a new
API need be added.
Thanks
Barry

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/blackfin/Kconfig        |    8 ++
 sound/soc/blackfin/Makefile       |    2 +
 sound/soc/blackfin/bf5xx-ad1836.c |  128 +++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad1836.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 8a4de4d..ac927ff 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -88,6 +88,14 @@ config SND_BF5XX_SOC_AC97
 	select SND_SOC_AC97_BUS
 	select SND_BF5XX_SOC_SPORT
 
+config SND_BF5XX_SOC_AD1836
+	tristate "SoC AD1836 Audio support for BF5xx"
+	depends on SND_BF5XX_TDM
+	select SND_BF5XX_SOC_TDM
+	select SND_SOC_AD1836
+	help
+	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
+
 config SND_BF5XX_SOC_AD1980
 	tristate "SoC AD1980/1 Audio support for BF5xx"
 	depends on SND_BF5XX_AC97
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index f4d7607..87e3042 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -16,11 +16,13 @@ obj-$(CONFIG_SND_BF5XX_SOC_I2S) += snd-soc-bf5xx-i2s.o
 obj-$(CONFIG_SND_BF5XX_SOC_TDM) += snd-soc-bf5xx-tdm.o
 
 # Blackfin Machine Support
+snd-ad1836-objs := bf5xx-ad1836.o
 snd-ad1980-objs := bf5xx-ad1980.o
 snd-ssm2602-objs := bf5xx-ssm2602.o
 snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad1938-objs := bf5xx-ad1938.o
 
+obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD1980) += snd-ad1980.o
 obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
new file mode 100644
index 0000000..cd361e3
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -0,0 +1,128 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-ad1836.c
+ * Author:       Barry Song <Barry.Song@analog.com>
+ *
+ * Created:      Aug 4 2009
+ * Description:  Board driver for ad1836 sound chip
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm_params.h>
+
+#include <asm/blackfin.h>
+#include <asm/cacheflush.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+#include <asm/portmux.h>
+
+#include "../codecs/ad1836.h"
+#include "bf5xx-sport.h"
+
+#include "bf5xx-tdm-pcm.h"
+#include "bf5xx-tdm.h"
+
+static struct snd_soc_card bf5xx_ad1836;
+
+static int bf5xx_ad1836_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	cpu_dai->private_data = sport_handle;
+	return 0;
+}
+
+static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	int ret = 0;
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
+		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_A |
+		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops bf5xx_ad1836_ops = {
+	.startup = bf5xx_ad1836_startup,
+	.hw_params = bf5xx_ad1836_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_ad1836_dai = {
+	.name = "ad1836",
+	.stream_name = "AD1836",
+	.cpu_dai = &bf5xx_tdm_dai,
+	.codec_dai = &ad1836_dai,
+	.ops = &bf5xx_ad1836_ops,
+};
+
+static struct snd_soc_card bf5xx_ad1836 = {
+	.name = "bf5xx_ad1836",
+	.platform = &bf5xx_tdm_soc_platform,
+	.dai_link = &bf5xx_ad1836_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_ad1836_snd_devdata = {
+	.card = &bf5xx_ad1836,
+	.codec_dev = &soc_codec_dev_ad1836,
+};
+
+static struct platform_device *bfxx_ad1836_snd_device;
+
+static int __init bf5xx_ad1836_init(void)
+{
+	int ret;
+
+	bfxx_ad1836_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bfxx_ad1836_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bfxx_ad1836_snd_device, &bf5xx_ad1836_snd_devdata);
+	bf5xx_ad1836_snd_devdata.dev = &bfxx_ad1836_snd_device->dev;
+	ret = platform_device_add(bfxx_ad1836_snd_device);
+
+	if (ret)
+		platform_device_put(bfxx_ad1836_snd_device);
+
+	return ret;
+}
+
+static void __exit bf5xx_ad1836_exit(void)
+{
+	platform_device_unregister(bfxx_ad1836_snd_device);
+}
+
+module_init(bf5xx_ad1836_init);
+module_exit(bf5xx_ad1836_exit);
+
+/* Module information */
+MODULE_AUTHOR("Barry Song");
+MODULE_DESCRIPTION("ALSA SoC AD1836 board driver");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.3
