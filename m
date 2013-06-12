From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] ASoC: tegra: add tegra+RT5640 machine driver
Date: Wed, 12 Jun 2013 11:35:34 -0600
Message-ID: <1371058534-25158-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Initially, this binding and driver only describe/support playback to
headphones and speakers.

This driver will support Beaver and Dalmore.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/sound/nvidia,tegra-audio-rt5640.txt   |  71 ++++++
 sound/soc/tegra/Kconfig                            |  10 +
 sound/soc/tegra/Makefile                           |   2 +
 sound/soc/tegra/tegra_rt5640.c                     | 257 +++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
 create mode 100644 sound/soc/tegra/tegra_rt5640.c

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
new file mode 100644
index 0000000..d130818
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
@@ -0,0 +1,71 @@
+NVIDIA Tegra audio complex, with RT5640 CODEC
+
+Required properties:
+- compatible : "nvidia,tegra-audio-rt5640"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must include the following entries:
+  "pll_a" (The Tegra clock of that name),
+  "pll_a_out0" (The Tegra clock of that name),
+  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
+- nvidia,model : The user-visible name of this sound complex.
+- nvidia,audio-routing : A list of the connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source. Valid names for sources and
+  sinks are the RT5640's pins, and the jacks on the board:
+
+  RT5640 pins:
+
+  * DMIC1
+  * DMIC2
+  * MICBIAS1
+  * IN1P
+  * IN1R
+  * IN2P
+  * IN2R
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * MONOP
+  * MONON
+  * SPOLP
+  * SPOLN
+  * SPORP
+  * SPORN
+
+  Board connectors:
+
+  * Headphones
+  * Speakers
+
+- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
+  connected to the CODEC.
+- nvidia,audio-codec : The phandle of the RT5640 audio codec. This binding
+  assumes that AIF1 on the CODEC is connected to Tegra.
+
+Optional properties:
+- nvidia,hp-det-gpios : The GPIO that detects headphones are plugged in
+
+Example:
+
+sound {
+	compatible = "nvidia,tegra-audio-rt5640-dalmore",
+			"nvidia,tegra-audio-rt5640";
+	nvidia,model = "NVIDIA Tegra Dalmore";
+
+	nvidia,audio-routing =
+		"Headphones", "HPOR",
+		"Headphones", "HPOL",
+		"Speakers", "SPORP",
+		"Speakers", "SPORN",
+		"Speakers", "SPOLP",
+		"Speakers", "SPOLN";
+
+	nvidia,i2s-controller = <&tegra_i2s1>;
+	nvidia,audio-codec = <&rt5640>;
+
+	nvidia,hp-det-gpios = <&gpio 143 0>; /* GPIO PR7 */
+
+	clocks = <&tegra_car 216>, <&tegra_car 217>, <&tegra_car 120>;
+	clock-names = "pll_a", "pll_a_out0", "mclk";
+};
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index b1c9d57..995b120 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -59,6 +59,16 @@ config SND_SOC_TEGRA30_I2S
 	  Tegra30 I2S interface. You will also need to select the individual
 	  machine drivers to support below.
 
+config SND_SOC_TEGRA_RT5640
+	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
+	depends on SND_SOC_TEGRA && I2C
+	select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
+	select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
+	select SND_SOC_RT5640
+	help
+	  Say Y or M here if you want to add support for SoC audio on Tegra
+	  boards using the RT5640 codec, such as Dalmore.
+
 config SND_SOC_TEGRA_WM8753
 	tristate "SoC Audio support for Tegra boards using a WM8753 codec"
 	depends on SND_SOC_TEGRA && I2C
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index 416a14b..21d2550 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -18,12 +18,14 @@ obj-$(CONFIG_SND_SOC_TEGRA30_AHUB) += snd-soc-tegra30-ahub.o
 obj-$(CONFIG_SND_SOC_TEGRA30_I2S) += snd-soc-tegra30-i2s.o
 
 # Tegra machine Support
+snd-soc-tegra-rt5640-objs := tegra_rt5640.o
 snd-soc-tegra-wm8753-objs := tegra_wm8753.o
 snd-soc-tegra-wm8903-objs := tegra_wm8903.o
 snd-soc-tegra-wm9712-objs := tegra_wm9712.o
 snd-soc-tegra-trimslice-objs := trimslice.o
 snd-soc-tegra-alc5632-objs := tegra_alc5632.o
 
+obj-$(CONFIG_SND_SOC_TEGRA_RT5640) += snd-soc-tegra-rt5640.o
 obj-$(CONFIG_SND_SOC_TEGRA_WM8753) += snd-soc-tegra-wm8753.o
 obj-$(CONFIG_SND_SOC_TEGRA_WM8903) += snd-soc-tegra-wm8903.o
 obj-$(CONFIG_SND_SOC_TEGRA_WM9712) += snd-soc-tegra-wm9712.o
diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
new file mode 100644
index 0000000..08794f9
--- /dev/null
+++ b/sound/soc/tegra/tegra_rt5640.c
@@ -0,0 +1,257 @@
+/*
+* tegra_rt5640.c - Tegra machine ASoC driver for boards using WM8903 codec.
+ *
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Based on code copyright/by:
+ *
+ * Copyright (C) 2010-2012 - NVIDIA, Inc.
+ * Copyright (C) 2011 The AC100 Kernel Team <ac100-oU9gvf+ajcSyy5GWsZ7R2qxOck334EZe@public.gmane.org>
+ * (c) 2009, 2010 Nvidia Graphics Pvt. Ltd.
+ * Copyright 2007 Wolfson Microelectronics PLC.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "../codecs/rt5640.h"
+
+#include "tegra_asoc_utils.h"
+
+#define DRV_NAME "tegra-snd-rt5640"
+
+struct tegra_rt5640 {
+	struct tegra_asoc_utils_data util_data;
+	int gpio_hp_det;
+};
+
+static int tegra_rt5640_asoc_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_card *card = codec->card;
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(card);
+	int srate, mclk;
+	int err;
+
+	srate = params_rate(params);
+	mclk = 256 * srate;
+
+	err = tegra_asoc_utils_set_rate(&machine->util_data, srate, mclk);
+	if (err < 0) {
+		dev_err(card->dev, "Can't configure clocks\n");
+		return err;
+	}
+
+	err = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_MCLK, mclk,
+					SND_SOC_CLOCK_IN);
+	if (err < 0) {
+		dev_err(card->dev, "codec_dai clock not set\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops tegra_rt5640_ops = {
+	.hw_params = tegra_rt5640_asoc_hw_params,
+};
+
+static struct snd_soc_jack tegra_rt5640_hp_jack;
+
+static struct snd_soc_jack_pin tegra_rt5640_hp_jack_pins[] = {
+	{
+		.pin = "Headphones",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+static struct snd_soc_jack_gpio tegra_rt5640_hp_jack_gpio = {
+	.name = "Headphone detection",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 150,
+	.invert = 1,
+};
+
+static const struct snd_soc_dapm_widget tegra_rt5640_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+};
+
+static const struct snd_kcontrol_new tegra_rt5640_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+};
+
+static int tegra_rt5640_asoc_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(codec->card);
+
+	snd_soc_jack_new(codec, "Headphones", SND_JACK_HEADPHONE,
+			 &tegra_rt5640_hp_jack);
+	snd_soc_jack_add_pins(&tegra_rt5640_hp_jack,
+			ARRAY_SIZE(tegra_rt5640_hp_jack_pins),
+			tegra_rt5640_hp_jack_pins);
+
+	if (gpio_is_valid(machine->gpio_hp_det)) {
+		tegra_rt5640_hp_jack_gpio.gpio = machine->gpio_hp_det;
+		snd_soc_jack_add_gpios(&tegra_rt5640_hp_jack,
+						1,
+						&tegra_rt5640_hp_jack_gpio);
+	}
+
+	return 0;
+}
+
+static struct snd_soc_dai_link tegra_rt5640_dai = {
+	.name = "RT5640",
+	.stream_name = "RT5640 PCM",
+	.codec_dai_name = "rt5640-aif1",
+	.init = tegra_rt5640_asoc_init,
+	.ops = &tegra_rt5640_ops,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card snd_soc_tegra_rt5640 = {
+	.name = "tegra-rt5640",
+	.owner = THIS_MODULE,
+	.dai_link = &tegra_rt5640_dai,
+	.num_links = 1,
+	.controls = tegra_rt5640_controls,
+	.num_controls = ARRAY_SIZE(tegra_rt5640_controls),
+	.dapm_widgets = tegra_rt5640_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tegra_rt5640_dapm_widgets),
+	.fully_routed = true,
+};
+
+static int tegra_rt5640_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_soc_card *card = &snd_soc_tegra_rt5640;
+	struct tegra_rt5640 *machine;
+	int ret;
+
+	machine = devm_kzalloc(&pdev->dev,
+			sizeof(struct tegra_rt5640), GFP_KERNEL);
+	if (!machine) {
+		dev_err(&pdev->dev, "Can't allocate tegra_rt5640\n");
+		return -ENOMEM;
+	}
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
+
+	machine->gpio_hp_det = of_get_named_gpio(np, "nvidia,hp-det-gpios", 0);
+	if (machine->gpio_hp_det == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	ret = snd_soc_of_parse_card_name(card, "nvidia,model");
+	if (ret)
+		goto err;
+
+	ret = snd_soc_of_parse_audio_routing(card, "nvidia,audio-routing");
+	if (ret)
+		goto err;
+
+	tegra_rt5640_dai.codec_of_node = of_parse_phandle(np,
+			"nvidia,audio-codec", 0);
+	if (!tegra_rt5640_dai.codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'nvidia,audio-codec' missing or invalid\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	tegra_rt5640_dai.cpu_of_node = of_parse_phandle(np,
+			"nvidia,i2s-controller", 0);
+	if (!tegra_rt5640_dai.cpu_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'nvidia,i2s-controller' missing or invalid\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	tegra_rt5640_dai.platform_of_node = tegra_rt5640_dai.cpu_of_node;
+
+	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
+	if (ret)
+		goto err;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+			ret);
+		goto err_fini_utils;
+	}
+
+	return 0;
+
+err_fini_utils:
+	tegra_asoc_utils_fini(&machine->util_data);
+err:
+	return ret;
+}
+
+static int tegra_rt5640_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(card);
+
+	snd_soc_jack_free_gpios(&tegra_rt5640_hp_jack, 1,
+				&tegra_rt5640_hp_jack_gpio);
+
+	snd_soc_unregister_card(card);
+
+	tegra_asoc_utils_fini(&machine->util_data);
+
+	return 0;
+}
+
+static const struct of_device_id tegra_rt5640_of_match[] = {
+	{ .compatible = "nvidia,tegra-audio-rt5640", },
+	{},
+};
+
+static struct platform_driver tegra_rt5640_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = tegra_rt5640_of_match,
+	},
+	.probe = tegra_rt5640_probe,
+	.remove = tegra_rt5640_remove,
+};
+module_platform_driver(tegra_rt5640_driver);
+
+MODULE_AUTHOR("Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("Tegra+RT5640 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, tegra_rt5640_of_match);
-- 
1.8.1.5
