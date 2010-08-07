From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] ASoC: Blackfin: new machine driver for
	ADAV801/ADAV803 codecs
Date: Sat,  7 Aug 2010 11:27:44 -0400
Message-ID: <1281194864-23311-2-git-send-email-vapier@gentoo.org>
References: <1281194864-23311-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 192AD1037FE
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 17:27:43 +0200 (CEST)
In-Reply-To: <1281194864-23311-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Yi Li <yi.li@analog.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Yi Li <yi.li@analog.com>

Signed-off-by: Yi Li <yi.li@analog.com>
Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig         |    8 ++
 sound/soc/blackfin/Makefile        |    2 +
 sound/soc/blackfin/bf5xx-adav80x.c |  154 ++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-adav80x.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 8ef2502..75bbc90 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -32,6 +32,14 @@ config SND_BFIN_AD73311_SE
 	  Enter the GPIO used to control AD73311's SE pin. Acceptable
 	  values are 0 to 7
 
+config SND_BF5XX_SOC_ADAV80X
+	tristate "SoC ADAV801/3 Audio support"
+	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_ADAV80X
+	help
+	  Say Y if you want to add support for ADAV80X SoC audio.
+
 config SND_BF5XX_TDM
 	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
 	depends on (BLACKFIN && SND_SOC)
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 49af3f3..872dac8 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -21,9 +21,11 @@ snd-ad1980-objs := bf5xx-ad1980.o
 snd-ssm2602-objs := bf5xx-ssm2602.o
 snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad193x-objs := bf5xx-ad193x.o
+snd-adav80x-objs := bf5xx-adav80x.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD1980) += snd-ad1980.o
 obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
+obj-$(CONFIG_SND_BF5XX_SOC_ADAV80X) += snd-adav80x.o
diff --git a/sound/soc/blackfin/bf5xx-adav80x.c b/sound/soc/blackfin/bf5xx-adav80x.c
new file mode 100644
index 0000000..720a885
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-adav80x.c
@@ -0,0 +1,154 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-adav80x.c
+ * Author:       Yi Li <yi.li@analog.com>
+ *
+ * Created:      Tue June 06 2010
+ * Description:  board driver for ADAV80X sound chip
+ *
+ * Modified:
+ *               Copyright 2010 Analog Devices Inc.
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
+#include "../codecs/adav80x.h"
+#include "bf5xx-sport.h"
+#include "bf5xx-i2s-pcm.h"
+#include "bf5xx-i2s.h"
+
+static struct snd_soc_card bf5xx_adav80x;
+
+static int bf5xx_adav80x_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int clk = 0;
+	int ret = 0;
+
+	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
+		params_format(params));
+
+	switch (params_rate(params)) {
+	case 32000:
+	case 44100:
+	case 48000:
+	case 96000:
+		clk = params_rate(params);
+		break;
+	}
+
+	/*
+	 * CODEC is master for BCLK and LRC in this configuration.
+	 */
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* For the ADAV80X evaluation board, use the on board crystal
+	   as XIN, and use XIN as source for PLL1 */
+	ret = snd_soc_dai_set_pll(codec_dai, ADAV80X_CLK_PLL1,
+			ADAV80X_CLK_XIN, 27000000, clk);
+
+	/* If you want to use XIN as clock source */
+	/* ret = snd_soc_dai_set_pll(codec_dai, 0, ADAV80X_CLK_XIN,
+		27000000, 0); */
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static struct snd_soc_ops bf5xx_adav80x_ops = {
+	.hw_params = bf5xx_adav80x_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_adav80x_dai = {
+	.name = "adav80x",
+	.stream_name = "ADAV80X",
+	.cpu_dai = &bf5xx_i2s_dai,
+	.codec_dai = &adav80x_dai,
+	.ops = &bf5xx_adav80x_ops,
+};
+
+static struct snd_soc_card bf5xx_adav80x = {
+	.name = "bf5xx_adav80x",
+	.platform = &bf5xx_i2s_soc_platform,
+	.dai_link = &bf5xx_adav80x_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_adav80x_snd_devdata = {
+	.card = &bf5xx_adav80x,
+	.codec_dev = &soc_codec_dev_adav80x,
+};
+
+static struct platform_device *bf5xx_adav80x_snd_device;
+
+static int __init bf5xx_adav80x_init(void)
+{
+	int ret;
+
+	bf5xx_adav80x_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_adav80x_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bf5xx_adav80x_snd_device,
+				&bf5xx_adav80x_snd_devdata);
+	bf5xx_adav80x_snd_devdata.dev = &bf5xx_adav80x_snd_device->dev;
+	ret = platform_device_add(bf5xx_adav80x_snd_device);
+
+	if (ret)
+		platform_device_put(bf5xx_adav80x_snd_device);
+
+	return ret;
+}
+
+static void __exit bf5xx_adav80x_exit(void)
+{
+	platform_device_unregister(bf5xx_adav80x_snd_device);
+}
+
+module_init(bf5xx_adav80x_init);
+module_exit(bf5xx_adav80x_exit);
+
+/* Module information */
+MODULE_AUTHOR("Yi Li");
+MODULE_DESCRIPTION("ALSA SoC ADAV80X Blackfin Board");
+MODULE_LICENSE("GPL");
-- 
1.7.2
