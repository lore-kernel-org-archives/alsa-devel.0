From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: Blackfin: Add bf5xx-adau1701 machine
	driver
Date: Fri, 10 Jun 2011 19:18:50 +0200
Message-ID: <1307726331-28618-2-git-send-email-lars@metafoo.de>
References: <1307726331-28618-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-056.synserver.de (smtp-out-056.synserver.de
	[212.40.185.56]) by alsa0.perex.cz (Postfix) with SMTP id 581B3103C49
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 19:19:55 +0200 (CEST)
In-Reply-To: <1307726331-28618-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Add a machine driver to support the ADAU1701 SigmaDSP processors on
Analog Devices BF5XX evaluation boards.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig          |   10 +++
 sound/soc/blackfin/Makefile         |    2 +
 sound/soc/blackfin/bf5xx-adau1701.c |  118 +++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-adau1701.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index ae40359..0777210 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -17,6 +17,16 @@ config SND_BF5XX_SOC_SSM2602
 	help
 	  Say Y if you want to add support for SoC audio on BF527-EZKIT.
 
+config SND_BF5XX_SOC_ADAU1701
+	tristate "SoC ADAU1701 Audio support for BF5xx eval boards"
+	depends on SND_BF5XX_I2S
+	select SND_BF5XX_SOC_I2S
+	select SND_SOC_ADAU1701
+	select I2C
+	help
+	  Say Y if you want to add support for the ADAU1701 SigmaDSP processor on
+	  Analog Devices BF5xx evaluation boards.
+
 config SND_BF5XX_SOC_AD73311
 	tristate "SoC AD73311 Audio support for Blackfin"
 	depends on SND_BF5XX_I2S
diff --git a/sound/soc/blackfin/Makefile b/sound/soc/blackfin/Makefile
index 49af3f3..1d75173 100644
--- a/sound/soc/blackfin/Makefile
+++ b/sound/soc/blackfin/Makefile
@@ -21,9 +21,11 @@ snd-ad1980-objs := bf5xx-ad1980.o
 snd-ssm2602-objs := bf5xx-ssm2602.o
 snd-ad73311-objs := bf5xx-ad73311.o
 snd-ad193x-objs := bf5xx-ad193x.o
+snd-adau1701-objs := bf5xx-adau1701.o
 
 obj-$(CONFIG_SND_BF5XX_SOC_AD1836) += snd-ad1836.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD1980) += snd-ad1980.o
 obj-$(CONFIG_SND_BF5XX_SOC_SSM2602) += snd-ssm2602.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD73311) += snd-ad73311.o
 obj-$(CONFIG_SND_BF5XX_SOC_AD193X) += snd-ad193x.o
+obj-$(CONFIG_SND_BF5XX_SOC_ADAU1701) += snd-adau1701.o
diff --git a/sound/soc/blackfin/bf5xx-adau1701.c b/sound/soc/blackfin/bf5xx-adau1701.c
new file mode 100644
index 0000000..dcdd6cd
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-adau1701.c
@@ -0,0 +1,118 @@
+/*
+ * Machine driver for ADAU1701 SigmaDSP processor on Analog Devices BF5XX
+ * evaluation boards.
+ *
+ * Copyright 2011 Analog Devices Inc.
+ * Author: Lars-Peter Clausen <lars@metafoo.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "../codecs/adau1701.h"
+
+static int bf5xx_adau1701_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, ADAU1701_CLK_SRC_OSC, 12288000,
+			SND_SOC_CLOCK_IN);
+
+	return ret;
+}
+
+static struct snd_soc_ops bf5xx_adau1701_ops = {
+	.hw_params = bf5xx_adau1701_hw_params,
+};
+
+static struct snd_soc_dai_link bf5xx_adau1701_dai[] = {
+	{
+		.name = "adau1701",
+		.stream_name = "adau1701",
+		.cpu_dai_name = "bfin-i2s.0",
+		.codec_dai_name = "adau1701",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "adau1701.0-0034",
+		.ops = &bf5xx_adau1701_ops,
+	},
+	{
+		.name = "adau1701",
+		.stream_name = "adau1701",
+		.cpu_dai_name = "bfin-i2s.1",
+		.codec_dai_name = "adau1701",
+		.platform_name = "bfin-i2s-pcm-audio",
+		.codec_name = "adau1701.0-0034",
+		.ops = &bf5xx_adau1701_ops,
+	},
+};
+
+static struct snd_soc_card bf5xx_adau1701 = {
+	.name = "bfin-adau1701",
+	.dai_link = &bf5xx_adau1701_dai[CONFIG_SND_BF5XX_SPORT_NUM],
+	.num_links = 1,
+};
+
+static int bf5xx_adau1701_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &bf5xx_adau1701;
+
+	card->dev = &pdev->dev;
+
+	return snd_soc_register_card(&bf5xx_adau1701);
+}
+
+static int __devexit bf5xx_adau1701_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver bf5xx_adau1701_driver = {
+	.driver = {
+		.name = "bf5xx-adau1701",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = bf5xx_adau1701_probe,
+	.remove = __devexit_p(bf5xx_adau1701_remove),
+};
+
+static int __init bf5xx_adau1701_init(void)
+{
+	return platform_driver_register(&bf5xx_adau1701_driver);
+}
+module_init(bf5xx_adau1701_init);
+
+static void __exit bf5xx_adau1701_exit(void)
+{
+	platform_driver_unregister(&bf5xx_adau1701_driver);
+}
+module_exit(bf5xx_adau1701_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("ALSA SoC BF5XX ADAU1701 driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bfin-adau1701");
-- 
1.7.2.5
