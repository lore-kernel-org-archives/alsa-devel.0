From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2 2/4] change bf5xx-ad1938 machine driver to
	bf5xx-ad193x machine driver
Date: Fri, 19 Mar 2010 11:18:40 +0800
Message-ID: <1268968720-25540-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id D482C103879
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 04:19:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/blackfin/Kconfig                         |    9 ++-
 sound/soc/blackfin/Makefile                        |    4 +-
 .../blackfin/{bf5xx-ad1938.c => bf5xx-ad193x.c}    |   66 ++++++++++----------
 3 files changed, 40 insertions(+), 39 deletions(-)
 rename sound/soc/blackfin/{bf5xx-ad1938.c => bf5xx-ad193x.c} (65%)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 97f1a25..8ef2502 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -49,13 +49,14 @@ config SND_BF5XX_SOC_AD1836
 	help
 	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
 
-config SND_BF5XX_SOC_AD1938
-	tristate "SoC AD1938 Audio support for Blackfin"
+config SND_BF5XX_SOC_AD193X
+	tristate "SoC AD193X Audio support for Blackfin"
 	depends on SND_BF5XX_TDM
 	select SND_BF5XX_SOC_TDM
-	select SND_SOC_AD1938
+	select SND_SOC_AD193X
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
diff --git a/sound/soc/blackfin/bf5xx-ad1938.c b/sound/soc/blackfin/bf5xx-ad193x.c
similarity index 65%
rename from sound/soc/blackfin/bf5xx-ad1938.c
rename to sound/soc/blackfin/bf5xx-ad193x.c
index 2ef1e50..b8c9060 100644
--- a/sound/soc/blackfin/bf5xx-ad1938.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -1,9 +1,9 @@
 /*
- * File:         sound/soc/blackfin/bf5xx-ad1938.c
+ * File:         sound/soc/blackfin/bf5xx-ad193x.c
  * Author:       Barry Song <Barry.Song@analog.com>
  *
  * Created:      Thur June 4 2009
- * Description:  Board driver for ad1938 sound chip
+ * Description:  Board driver for ad193x sound chip
  *
  * Bugs:         Enter bugs at http://blackfin.uclinux.org/
  *
@@ -38,15 +38,15 @@
 #include <asm/dma.h>
 #include <asm/portmux.h>
 
-#include "../codecs/ad1938.h"
+#include "../codecs/ad193x.h"
 #include "bf5xx-sport.h"
 
 #include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 
-static struct snd_soc_card bf5xx_ad1938;
+static struct snd_soc_card bf5xx_ad193x;
 
-static int bf5xx_ad1938_startup(struct snd_pcm_substream *substream)
+static int bf5xx_ad193x_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
@@ -55,7 +55,7 @@ static int bf5xx_ad1938_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
+static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -89,61 +89,61 @@ static int bf5xx_ad1938_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops bf5xx_ad1938_ops = {
-	.startup = bf5xx_ad1938_startup,
-	.hw_params = bf5xx_ad1938_hw_params,
+static struct snd_soc_ops bf5xx_ad193x_ops = {
+	.startup = bf5xx_ad193x_startup,
+	.hw_params = bf5xx_ad193x_hw_params,
 };
 
-static struct snd_soc_dai_link bf5xx_ad1938_dai = {
-	.name = "ad1938",
-	.stream_name = "AD1938",
+static struct snd_soc_dai_link bf5xx_ad193x_dai = {
+	.name = "ad193x",
+	.stream_name = "AD193X",
 	.cpu_dai = &bf5xx_tdm_dai,
-	.codec_dai = &ad1938_dai,
-	.ops = &bf5xx_ad1938_ops,
+	.codec_dai = &ad193x_dai,
+	.ops = &bf5xx_ad193x_ops,
 };
 
-static struct snd_soc_card bf5xx_ad1938 = {
-	.name = "bf5xx_ad1938",
+static struct snd_soc_card bf5xx_ad193x = {
+	.name = "bf5xx_ad193x",
 	.platform = &bf5xx_tdm_soc_platform,
-	.dai_link = &bf5xx_ad1938_dai,
+	.dai_link = &bf5xx_ad193x_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device bf5xx_ad1938_snd_devdata = {
-	.card = &bf5xx_ad1938,
-	.codec_dev = &soc_codec_dev_ad1938,
+static struct snd_soc_device bf5xx_ad193x_snd_devdata = {
+	.card = &bf5xx_ad193x,
+	.codec_dev = &soc_codec_dev_ad193x,
 };
 
-static struct platform_device *bfxx_ad1938_snd_device;
+static struct platform_device *bfxx_ad193x_snd_device;
 
-static int __init bf5xx_ad1938_init(void)
+static int __init bf5xx_ad193x_init(void)
 {
 	int ret;
 
-	bfxx_ad1938_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!bfxx_ad1938_snd_device)
+	bfxx_ad193x_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bfxx_ad193x_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bfxx_ad1938_snd_device, &bf5xx_ad1938_snd_devdata);
-	bf5xx_ad1938_snd_devdata.dev = &bfxx_ad1938_snd_device->dev;
-	ret = platform_device_add(bfxx_ad1938_snd_device);
+	platform_set_drvdata(bfxx_ad193x_snd_device, &bf5xx_ad193x_snd_devdata);
+	bf5xx_ad193x_snd_devdata.dev = &bfxx_ad193x_snd_device->dev;
+	ret = platform_device_add(bfxx_ad193x_snd_device);
 
 	if (ret)
-		platform_device_put(bfxx_ad1938_snd_device);
+		platform_device_put(bfxx_ad193x_snd_device);
 
 	return ret;
 }
 
-static void __exit bf5xx_ad1938_exit(void)
+static void __exit bf5xx_ad193x_exit(void)
 {
-	platform_device_unregister(bfxx_ad1938_snd_device);
+	platform_device_unregister(bfxx_ad193x_snd_device);
 }
 
-module_init(bf5xx_ad1938_init);
-module_exit(bf5xx_ad1938_exit);
+module_init(bf5xx_ad193x_init);
+module_exit(bf5xx_ad193x_exit);
 
 /* Module information */
 MODULE_AUTHOR("Barry Song");
-MODULE_DESCRIPTION("ALSA SoC AD1938 board driver");
+MODULE_DESCRIPTION("ALSA SoC AD193X board driver");
 MODULE_LICENSE("GPL");
 
-- 
1.5.6.3
