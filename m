From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: Blackfin: ADAU1X81 eval board support
Date: Wed, 28 Aug 2013 17:20:13 +0200
Message-ID: <1377703214-23234-5-git-send-email-lars@metafoo.de>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-189.synserver.de (smtp-out-189.synserver.de
 [212.40.185.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CE2F265476
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 17:18:49 +0200 (CEST)
In-Reply-To: <1377703214-23234-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds a ASoC machine driver to support the EVAL-ADAU1X81 board
connected to a Analog Devices BF5XX evaluation board.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/Kconfig              |  13 +++
 sound/soc/blackfin/Makefile             |   2 +
 sound/soc/blackfin/bfin-eval-adau1x81.c | 139 ++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 sound/soc/blackfin/bfin-eval-adau1x81.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 30e3fb9..87c3980 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -56,6 +56,19 @@ config SND_SOC_BFIN_EVAL_ADAU1X61
 	  Note: This driver assumes that the ADAU1X61 is connected to the
 	  first SPORT port on the BF5XX board.
 
+config SND_SOC_BFIN_EVAL_ADAU1X81
+	tristate "Support for the EVAL-ADAU1X81 boards on Blackfin eval boards"
+	depends on SND_BF5XX_I2S && I2C
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_ADAU1781
+	help
+	  Say Y if you want to add support for the Analog Devices EVAL-ADAU1X81
+	  board connected to one of the Blackfin evaluation boards like the
+	  BF5XX-STAMP or BF5XX-EZKIT.
+
+	  Note: This driver assumes that the ADAU1X81 is connected to the
+	  first SPORT port on the BF5XX board.
+
 config SND_SOC_BFIN_EVAL_ADAV80X
 	tristate "Support for the EVAL-ADAV80X boards on Blackfin eval boards"
 	depends on SND_BF5XX_I2S && (SPI_MASTER || I2C)
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 91eb0e7..f21e948 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -23,6 +23,7 @@ snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad193x-objs := bf5xx-ad193x.o
 snd-soc-bfin-eval-adau1373-objs := bfin-eval-adau1373.o
 snd-soc-bfin-eval-adau1x61-objs := bfin-eval-adau1x61.o
+snd-soc-bfin-eval-adau1x81-objs := bfin-eval-adau1x81.o
 snd-soc-bfin-eval-adau1701-objs := bfin-eval-adau1701.o
 snd-soc-bfin-eval-adav80x-objs := bfin-eval-adav80x.o
 
@@ -33,5 +34,6 @@ obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
 obj-$(CONFIG_SND_SOC_BFIN_EVAL_ADAU1373) += snd-soc-bfin-eval-adau1373.o
 obj-$(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X61) += snd-soc-bfin-eval-adau1x61.o
+obj-$(CONFIG_SND_SOC_BFIN_EVAL_ADAU1X81) += snd-soc-bfin-eval-adau1x81.o
 obj-$(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701) += snd-soc-bfin-eval-adau1701.o
 obj-$(CONFIG_SND_SOC_BFIN_EVAL_ADAV80X) += snd-soc-bfin-eval-adav80x.o
diff --git a/sound/soc/blackfin/bfin-eval-adau1x81.c b/sound/soc/blackfin/bfin-eval-adau1x81.c
new file mode 100644
index 0000000..74e3459
--- /dev/null
+++ b/sound/soc/blackfin/bfin-eval-adau1x81.c
@@ -0,0 +1,139 @@
+/*
+ * Machine driver for EVAL-ADAU1x81 on Analog Devices bfin
+ * evaluation boards.
+ *
+ * Copyright 2011-2013 Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "../codecs/adau17x1.h"
+
+static const struct snd_soc_dapm_widget bfin_eval_adau1x81_dapm_widgets[] = {
+	SND_SOC_DAPM_LINE("Stereo In", NULL),
+	SND_SOC_DAPM_LINE("Beep", NULL),
+
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+};
+
+static const struct snd_soc_dapm_route bfin_eval_adau1x81_dapm_routes[] = {
+	{ "BEEP", NULL, "Beep" },
+	{ "LMIC", NULL, "Stereo In" },
+	{ "LMIC", NULL, "Stereo In" },
+
+	{ "Headphone", NULL, "AOUTL" },
+	{ "Headphone", NULL, "AOUTR" },
+	{ "Speaker", NULL, "SP" },
+};
+
+static int bfin_eval_adau1x81_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int pll_rate;
+	int ret;
+
+	switch (params_rate(params)) {
+	case 48000:
+	case 8000:
+	case 12000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 96000:
+		pll_rate = 48000 * 1024;
+		break;
+	case 44100:
+	case 7350:
+	case 11025:
+	case 14700:
+	case 22050:
+	case 29400:
+	case 88200:
+		pll_rate = 44100 * 1024;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, ADAU17X1_PLL,
+			ADAU17X1_PLL_SRC_MCLK, 12288000, pll_rate);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, ADAU17X1_CLK_SRC_PLL, pll_rate,
+			SND_SOC_CLOCK_IN);
+
+	return ret;
+}
+
+static const struct snd_soc_ops bfin_eval_adau1x81_ops = {
+	.hw_params = bfin_eval_adau1x81_hw_params,
+};
+
+static struct snd_soc_dai_link bfin_eval_adau1x81_dai = {
+	.name			= "adau1x81",
+	.stream_name		= "adau1x81",
+	.cpu_dai_name		= "bfin-i2s.0",
+	.codec_dai_name		= "adau-hifi",
+	.platform_name		= "bfin-i2s-pcm-audio",
+	.codec_name		= "adau1781.0-0038",
+	.ops			= &bfin_eval_adau1x81_ops,
+	.dai_fmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+					SND_SOC_DAIFMT_CBM_CFM,
+};
+
+static struct snd_soc_card bfin_eval_adau1x81 = {
+	.name			= "bfin-eval-adau1x81",
+	.driver_name		= "eval-adau1x81",
+	.dai_link		= &bfin_eval_adau1x81_dai,
+	.num_links		= 1,
+
+	.dapm_widgets		= bfin_eval_adau1x81_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(bfin_eval_adau1x81_dapm_widgets),
+	.dapm_routes		= bfin_eval_adau1x81_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(bfin_eval_adau1x81_dapm_routes),
+};
+
+static int bfin_eval_adau1x81_probe(struct platform_device *pdev)
+{
+	bfin_eval_adau1x81.dev = &pdev->dev;
+
+	return snd_soc_register_card(&bfin_eval_adau1x81);
+}
+
+static int bfin_eval_adau1x81_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver bfin_eval_adau1x81_driver = {
+	.driver = {
+		.name = "bfin-eval-adau1x81",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = bfin_eval_adau1x81_probe,
+	.remove = bfin_eval_adau1x81_remove,
+};
+module_platform_driver(bfin_eval_adau1x81_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("ALSA SoC bfin adau1x81 driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bfin-eval-adau1x81");
-- 
1.8.0
