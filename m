From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v3] ASoC: Tegra machine ASoC driver for boards
	using ALC5332 codec
Date: Mon, 19 Dec 2011 21:51:52 +0200
Message-ID: <1324324312-11478-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C5CD2491F
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 21:00:28 +0100 (CET)
Received: by eekb57 with SMTP id b57so5436750eek.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 12:00:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, swarren@nvidia.com, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

At this stage only Toshiba AC100/Dynabook supported.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
Signed-off-by: Andrey Danin <danindrey@mail.ru>

--
Changes since v2:
* Remove unsupported frequencies (more then 48Khz) - Suggested by Stephen Warren
* Remove GPIO related code, it will be added later by platform_data patchset.
Changes since v1:
* Use module_platform_driver.
* Move controls, dapm_widgets and dapm_routes to snd_soc_card structure.
* Set dai_fmt in snd_soc_dai_link structure instead probe function.
* Remove check board in probe function
* Fix warning about unused codec_dai.
* Use devm_kzalloc to manage memory allocation.
---
 sound/soc/tegra/Kconfig         |    9 ++
 sound/soc/tegra/Makefile        |    2 +
 sound/soc/tegra/tegra_alc5632.c |  233 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/tegra/tegra_alc5632.c

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index c6af1fd..ce1b773 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -47,3 +47,12 @@ config SND_SOC_TEGRA_TRIMSLICE
 	help
 	  Say Y or M here if you want to add support for SoC audio on the
 	  TrimSlice platform.
+
+config SND_SOC_TEGRA_ALC5632
+       tristate "SoC Audio support for Tegra boards using an ALC5632 codec"
+       depends on SND_SOC_TEGRA && I2C
+       select SND_SOC_TEGRA_I2S
+       select SND_SOC_ALC5632
+       help
+         Say Y or M here if you want to add support for SoC audio on the
+         Toshiba AC100 netbook.
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 4d943b3..8e584b8 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_SND_SOC_TEGRA_SPDIF) += snd-soc-tegra-spdif.o
 # Tegra machine Support
 snd-soc-tegra-wm8903-objs := tegra_wm8903.o
 snd-soc-tegra-trimslice-objs := trimslice.o
+snd-soc-tegra-alc5632-objs := tegra_alc5632.o
 
 obj-$(CONFIG_SND_SOC_TEGRA_WM8903) += snd-soc-tegra-wm8903.o
 obj-$(CONFIG_SND_SOC_TEGRA_TRIMSLICE) += snd-soc-tegra-trimslice.o
+obj-$(CONFIG_SND_SOC_TEGRA_ALC5632) += snd-soc-tegra-alc5632.o
diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
new file mode 100644
index 0000000..89697c6
--- /dev/null
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -0,0 +1,213 @@
+/*
+* tegra_alc5632.c  --  Toshiba AC100(PAZ00) machine ASoC driver
+*
+* Copyright (C) 2011 The AC100 Kernel Team <ac100@lists.lauchpad.net>
+*
+* Authors:  Leon Romanovsky <leon@leon.nu>
+*           Andrey Danin <danindrey@mail.ru>
+*           Marc Dietrich <marvin24@gmx.de>
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 as
+* published by the Free Software Foundation.
+*/
+
+#include <asm/mach-types.h>
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "../codecs/alc5632.h"
+
+#include "tegra_das.h"
+#include "tegra_i2s.h"
+#include "tegra_pcm.h"
+#include "tegra_asoc_utils.h"
+
+#define DRV_NAME "tegra-alc5632"
+
+struct tegra_alc5632 {
+	struct tegra_asoc_utils_data util_data;
+};
+
+static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	struct tegra_alc5632 *alc5632 = snd_soc_card_get_drvdata(card);
+	int srate, mclk;
+	int err;
+
+	srate = params_rate(params);
+	mclk = 512 * srate;
+
+	err = tegra_asoc_utils_set_rate(&alc5632->util_data, srate, mclk);
+	if (err < 0) {
+		dev_err(card->dev, "Can't configure clocks\n");
+		return err;
+	}
+
+	err = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+					SND_SOC_CLOCK_IN);
+	if (err < 0) {
+		dev_err(card->dev, "codec_dai clock not set\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops tegra_alc5632_asoc_ops = {
+	.hw_params = tegra_alc5632_asoc_hw_params,
+};
+
+static struct snd_soc_jack tegra_alc5632_hs_jack;
+
+static struct snd_soc_jack_pin tegra_alc5632_hs_jack_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headset Stereophone",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+static const struct snd_soc_dapm_widget tegra_alc5632_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Int Spk", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route tegra_alc5632_audio_map[] = {
+	/* Internal Speaker */
+	{"Int Spk", NULL, "SPKOUT"},
+	{"Int Spk", NULL, "SPKOUTN"},
+
+	/* Headset Mic */
+	{"MIC1", NULL, "MICBIAS1"},
+	{"MICBIAS1", NULL, "Headset Mic"},
+
+	/* Headset Stereophone */
+	{"Headset Stereophone", NULL, "HPR"},
+	{"Headset Stereophone", NULL, "HPL"},
+};
+
+static const struct snd_kcontrol_new tegra_alc5632_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Int Spk"),
+};
+
+static int tegra_alc5632_asoc_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_jack_new(codec, "Headset Jack", SND_JACK_HEADSET,
+			 &tegra_alc5632_hs_jack);
+	snd_soc_jack_add_pins(&tegra_alc5632_hs_jack,
+			ARRAY_SIZE(tegra_alc5632_hs_jack_pins),
+			tegra_alc5632_hs_jack_pins);
+
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
+
+	return 0;
+}
+
+static struct snd_soc_dai_link tegra_alc5632_dai = {
+	.name = "ALC5632",
+	.stream_name = "ALC5632 PCM",
+	.codec_name = "alc5632.0-001e",
+	.platform_name = "tegra-pcm-audio",
+	.cpu_dai_name = "tegra-i2s.0",
+	.codec_dai_name = "alc5632-hifi",
+	.init = tegra_alc5632_asoc_init,
+	.ops = &tegra_alc5632_asoc_ops,
+	.dai_fmt = SND_SOC_DAIFMT_I2S
+			   | SND_SOC_DAIFMT_NB_NF
+			   | SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card snd_soc_tegra_alc5632 = {
+	.name = "tegra-alc5632",
+	.dai_link = &tegra_alc5632_dai,
+	.num_links = 1,
+	.controls = tegra_alc5632_controls,
+	.num_controls = ARRAY_SIZE(tegra_alc5632_controls),
+	.dapm_widgets = tegra_alc5632_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tegra_alc5632_dapm_widgets),
+	.dapm_routes = tegra_alc5632_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(tegra_alc5632_audio_map),
+	.fully_routed = true,
+};
+
+static __devinit int tegra_alc5632_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_tegra_alc5632;
+	struct tegra_alc5632 *alc5632;
+	int ret;
+
+	alc5632 = devm_kzalloc(&pdev->dev,
+			sizeof(struct tegra_alc5632), GFP_KERNEL);
+	if (!alc5632) {
+		dev_err(&pdev->dev, "Can't allocate tegra_alc5632\n");
+		return -ENOMEM;
+	}
+
+	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
+	if (ret)
+		return ret;
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, alc5632);
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+			ret);
+		tegra_asoc_utils_fini(&alc5632->util_data);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit tegra_alc5632_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct tegra_alc5632 *alc5632 = snd_soc_card_get_drvdata(card);
+
+	snd_soc_unregister_card(card);
+
+	tegra_asoc_utils_fini(&alc5632->util_data);
+
+	return 0;
+}
+
+static struct platform_driver tegra_alc5632_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = tegra_alc5632_probe,
+	.remove = __devexit_p(tegra_alc5632_remove),
+};
+module_platform_driver(tegra_alc5632_driver);
+
+MODULE_AUTHOR("Leon Romanovsky <leon@leon.nu>");
+MODULE_DESCRIPTION("Tegra+ALC5632 machine ASoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.3.4
