From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/8] ASoC: Initial audio support for Speyside
	on Cragganmore 6410
Date: Tue, 12 Apr 2011 23:06:04 -0700
Message-ID: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F15BE103800
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is minimal code required to get audio out of the Speyside audio
subsystem on the Wolfson Cragganmore 6410 reference platform.  It sets
up the link between the CPU and AIF1 of the WM8915 on the system,
enabling audio playback via the headphone and speaker outputs of the
device (which require no further configuration except runtime).  It
allows verification of basic functionality of the system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig    |    6 ++
 sound/soc/samsung/Makefile   |    2 +
 sound/soc/samsung/speyside.c |  123 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/speyside.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index b8c7a2e..726af2e 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -170,3 +170,9 @@ config SND_SOC_SMDK_WM8580_PCM
 	select SND_SAMSUNG_PCM
 	help
 	  Say Y if you want to add support for SoC audio on the SMDK.
+
+config SND_SOC_SPEYSIDE
+	tristate "Audio support for Wolfson Speyside"
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	select SND_SAMSUNG_I2S
+	select SND_SOC_WM8915
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 6c598fc..683843a 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -35,6 +35,7 @@ snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
+snd-soc-speyside-objs := speyside.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -53,3 +54,4 @@ obj-$(CONFIG_SND_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
 obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
+obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
new file mode 100644
index 0000000..f6dcee7b
--- /dev/null
+++ b/sound/soc/samsung/speyside.c
@@ -0,0 +1,123 @@
+/*
+ * Speyside audio support
+ *
+ * Copyright 2011 Wolfson Microelectronics
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "../codecs/wm8915.h"
+
+static int speyside_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, WM8915_FLL_MCLK1,
+				  32768, 256 * 48000);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_FLL,
+				     256 * 48000, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops speyside_ops = {
+	.hw_params = speyside_hw_params,
+};
+
+static struct snd_soc_dai_link speyside_dai[] = {
+	{
+		.name = "CPU",
+		.stream_name = "CPU",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm8915-aif1",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8915.1-001a",
+		.ops = &speyside_ops,
+	},
+};
+
+static struct snd_soc_card speyside = {
+	.name = "Speyside",
+	.dai_link = speyside_dai,
+	.num_links = ARRAY_SIZE(speyside_dai),
+};
+
+static __devinit int speyside_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &speyside;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit speyside_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver speyside_driver = {
+	.driver = {
+		.name = "speyside",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = speyside_probe,
+	.remove = __devexit_p(speyside_remove),
+};
+
+static int __init speyside_audio_init(void)
+{
+	return platform_driver_register(&speyside_driver);
+}
+module_init(speyside_audio_init);
+
+static void __exit speyside_audio_exit(void)
+{
+	platform_driver_unregister(&speyside_driver);
+}
+module_exit(speyside_audio_exit);
+
+MODULE_DESCRIPTION("Speyside audio support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:speyside");
-- 
1.7.4.1
