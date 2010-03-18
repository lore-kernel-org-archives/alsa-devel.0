From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] change bf5xx-ad1938 machine driver
	to bf5xx-ad193x machine driver
Date: Thu, 18 Mar 2010 16:16:59 +0800
Message-ID: <1268900221-6833-3-git-send-email-21cnbao@gmail.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1268900221-6833-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 sound/soc/blackfin/Kconfig        |   13 ++-
 sound/soc/blackfin/Makefile       |    4 +-
 sound/soc/blackfin/bf5xx-ad1938.c |  149 -------------------------------------
 sound/soc/blackfin/bf5xx-ad193x.c |  149 +++++++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 156 deletions(-)
 delete mode 100644 sound/soc/blackfin/bf5xx-ad1938.c
 create mode 100644 sound/soc/blackfin/bf5xx-ad193x.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 97f1a25..f04c2de 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -49,13 +49,16 @@ config SND_BF5XX_SOC_AD1836
 	help
 	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
 
-config SND_BF5XX_SOC_AD1938
-	tristate "SoC AD1938 Audio support for Blackfin"
-	depends on SND_BF5XX_TDM
+config SND_BF5XX_SOC_AD193X
+	tristate "SoC AD193X Audio support for Blackfin"
+	depends on SND_BF5XX_TDM && (SPI_MASTER || I2C)
 	select SND_BF5XX_SOC_TDM
-	select SND_SOC_AD1938
+	select SND_SOC_AD193X
+	select SND_SOC_AD193X_SPI if SPI_MASTER
+	select SND_SOC_AD193X_I2C if I2C
 	help
-	  Say Y if you want to add support for AD1938 codec on Blackfin.
+	  Say Y if you want to add support for AD193X codec on Blackfin.
+	  This driver supports AD1936, AD1937, AD1938 and AD1939.
 
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 87e3042..49af3f3 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -20,10 +20,10 @@ snd-ad1836-objs := bf5xx-ad1836.o
 snd-ad1980-objs := bf5xx-ad1980.o
 snd-ssm2602-objs := bf5xx-ssm2602.o
 snd-ad73311-objs := bf5xx-ad73311.o
-snd-ad1938-objs := bf5xx-ad1938.o
+snd-ad193x-objs := bf5xx-ad193x.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD1980) += snd-ad1980.o
 obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
-obj-$(CONFIG_SND_BF5XX_SOC_AD1938) += snd-ad1938.o
+obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
diff --git a/sound/soc/blackfin/bf5xx-ad1938.c b/sound/soc/blackfin/bf5xx-ad1938.c
deleted file mode 100644
index 2ef1e50..0000000
--- a/sound/soc/blackfin/bf5xx-ad1938.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- * File:         sound/soc/blackfin/bf5xx-ad1938.c
- * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
- *
- * Created:      Thur June 4 2009
- * Description:  Board driver for ad1938 sound chip
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/pcm_params.h>
-
-#include <asm/blackfin.h>
-#include <asm/cacheflush.h>
-#include <asm/irq.h>
-#include <asm/dma.h>
-#include <asm/portmux.h>
-
-#include "../codecs/ad1938.h"
-#include "bf5xx-sport.h"
-
-#include "bf5xx-tdm-pcm.h"
-#include "bf5xx-tdm.h"
-
-static struct snd_soc_card bf5xx_ad1938;
-
-static int bf5xx_ad1938_startup(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-
-	cpu_dai->private_data = sport_handle;
-	return 0;
-}
-
-static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	unsigned int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7};
-	int ret = 0;
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_DSP_A |
-		SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	/* set codec DAI slots, 8 channels, all channels are enabled */
-	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI channel mapping */
-	ret = snd_soc_dai_set_channel_map(cpu_dai, ARRAY_SIZE(channel_map),
-		channel_map, ARRAY_SIZE(channel_map), channel_map);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static struct snd_soc_ops bf5xx_ad1938_ops = {
-	.startup = bf5xx_ad1938_startup,
-	.hw_params = bf5xx_ad1938_hw_params,
-};
-
-static struct snd_soc_dai_link bf5xx_ad1938_dai = {
-	.name = "ad1938",
-	.stream_name = "AD1938",
-	.cpu_dai = &bf5xx_tdm_dai,
-	.codec_dai = &ad1938_dai,
-	.ops = &bf5xx_ad1938_ops,
-};
-
-static struct snd_soc_card bf5xx_ad1938 = {
-	.name = "bf5xx_ad1938",
-	.platform = &bf5xx_tdm_soc_platform,
-	.dai_link = &bf5xx_ad1938_dai,
-	.num_links = 1,
-};
-
-static struct snd_soc_device bf5xx_ad1938_snd_devdata = {
-	.card = &bf5xx_ad1938,
-	.codec_dev = &soc_codec_dev_ad1938,
-};
-
-static struct platform_device *bfxx_ad1938_snd_device;
-
-static int __init bf5xx_ad1938_init(void)
-{
-	int ret;
-
-	bfxx_ad1938_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!bfxx_ad1938_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(bfxx_ad1938_snd_device, &bf5xx_ad1938_snd_devdata);
-	bf5xx_ad1938_snd_devdata.dev = &bfxx_ad1938_snd_device->dev;
-	ret = platform_device_add(bfxx_ad1938_snd_device);
-
-	if (ret)
-		platform_device_put(bfxx_ad1938_snd_device);
-
-	return ret;
-}
-
-static void __exit bf5xx_ad1938_exit(void)
-{
-	platform_device_unregister(bfxx_ad1938_snd_device);
-}
-
-module_init(bf5xx_ad1938_init);
-module_exit(bf5xx_ad1938_exit);
-
-/* Module information */
-MODULE_AUTHOR("Barry Song");
-MODULE_DESCRIPTION("ALSA SoC AD1938 board driver");
-MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
new file mode 100644
index 0000000..b8c9060
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -0,0 +1,149 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-ad193x.c
+ * Author:       Barry Song <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
+ *
+ * Created:      Thur June 4 2009
+ * Description:  Board driver for ad193x sound chip
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
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
+#include "../codecs/ad193x.h"
+#include "bf5xx-sport.h"
+
+#include "bf5xx-tdm-pcm.h"
+#include "bf5xx-tdm.h"
+
+static struct snd_soc_card bf5xx_ad193x;
+
+static int bf5xx_ad193x_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	cpu_dai->private_data = sport_handle;
+	return 0;
+}
+
+static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7};
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
+	/* set codec DAI slots, 8 channels, all channels are enabled */
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xFF, 0xFF, 8, 32);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI channel mapping */
+	ret = snd_soc_dai_set_channel_map(cpu_dai, ARRAY_SIZE(channel_map),
+		channel_map, ARRAY_SIZE(channel_map), channel_map);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops bf5xx_ad193x_ops = {
+	.startup = bf5xx_ad193x_startup,
+	.hw_params = bf5xx_ad193x_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_ad193x_dai = {
+	.name = "ad193x",
+	.stream_name = "AD193X",
+	.cpu_dai = &bf5xx_tdm_dai,
+	.codec_dai = &ad193x_dai,
+	.ops = &bf5xx_ad193x_ops,
+};
+
+static struct snd_soc_card bf5xx_ad193x = {
+	.name = "bf5xx_ad193x",
+	.platform = &bf5xx_tdm_soc_platform,
+	.dai_link = &bf5xx_ad193x_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_ad193x_snd_devdata = {
+	.card = &bf5xx_ad193x,
+	.codec_dev = &soc_codec_dev_ad193x,
+};
+
+static struct platform_device *bfxx_ad193x_snd_device;
+
+static int __init bf5xx_ad193x_init(void)
+{
+	int ret;
+
+	bfxx_ad193x_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bfxx_ad193x_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bfxx_ad193x_snd_device, &bf5xx_ad193x_snd_devdata);
+	bf5xx_ad193x_snd_devdata.dev = &bfxx_ad193x_snd_device->dev;
+	ret = platform_device_add(bfxx_ad193x_snd_device);
+
+	if (ret)
+		platform_device_put(bfxx_ad193x_snd_device);
+
+	return ret;
+}
+
+static void __exit bf5xx_ad193x_exit(void)
+{
+	platform_device_unregister(bfxx_ad193x_snd_device);
+}
+
+module_init(bf5xx_ad193x_init);
+module_exit(bf5xx_ad193x_exit);
+
+/* Module information */
+MODULE_AUTHOR("Barry Song");
+MODULE_DESCRIPTION("ALSA SoC AD193X board driver");
+MODULE_LICENSE("GPL");
+
-- 
1.5.6.3
