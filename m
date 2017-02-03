From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v8 3/4] ASoC: rockchip: Add machine driver for
	RK3288 boards that use analog/HDMI
Date: Fri,  3 Feb 2017 15:37:59 +0100
Message-ID: <20170203143800.23859-4-romain.perier@collabora.com>
References: <20170203143800.23859-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A0DF266B17
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 15:38:12 +0100 (CET)
In-Reply-To: <20170203143800.23859-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

The driver is used for Rockchip rk3288-based boards using a configurable
analog output (can be an headphone) and the built-in HDMI audio output
that is part of the RK3288 SoCs and use the Alsa HDMI codec driver. For
some rk3288-based boards the analog output and the hdmi audio are plugged
on the same i2s line, so we have to do the same in the driver by using a
DAI link CPU to multicodecs. This configuration can be found for example
on the Radxa Rock2 or the Firefly-RK3288.

This commit is based on the initial work that was done by Sjoerd Simons
<sjoerd.simons@collabora.com> with some improvements.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v8: None
Changes in v7:
- No longer select SND_SOC_ES8328_I2C from kconfig (as this driver
  is dynamic and genric for analog outputs)
Changes in v6:
- Fixed bad error handling for gpios in the probe function
- Replaced 'codec clock' by 'cpu clock' for set_sysclk for cpu_dai
Changes in v5:
- Fixed error handling for gpios in the probe function
Changes in v4:
- Added support for multi codecs in the asoc machine driver, so the driver
  matches the hw architecture (analog and hdmi audio are connected on
  the same i2s line)
- Renamed the driver to rk3288-hdmi-analog.c
- Changed some variables names due to this renaming
- Changed the documentation
- Added built-in support for hdmi audio in this driver
- Added support for the property 'rockchip,routing'

Changes in v3:
- Cosmetic changes
- Added missing email to MODULE_AUTHOR
Changes in v2:
- Fixed wrong dependencies for SND_SOC_ROCKCHIP_ES8388, SND_SOC_ROCKCHIP_I2S
  was selected with unmet direct dependencies

 .../bindings/sound/rockchip,rk3288-hdmi-analog.txt |  36 +++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rk3288_hdmi_analog.c            | 299 +++++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
 create mode 100644 sound/soc/rockchip/rk3288_hdmi_analog.c

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
new file mode 100644
index 0000000..2539e1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3288-hdmi-analog.txt
@@ -0,0 +1,36 @@
+ROCKCHIP RK3288 with HDMI and analog audio
+
+Required properties:
+- compatible: "rockchip,rk3288-hdmi-analog"
+- rockchip,model: The user-visible name of this sound complex
+- rockchip,i2s-controller: The phandle of the Rockchip I2S controller that's
+  connected to the CODEC
+- rockchip,audio-codec: The phandle of the analog audio codec.
+- rockchip,routing: A list of the connections between audio components.
+		    Each entry is a pair of strings, the first being the
+		    connection's sink, the second being the connection's
+		    source. For this driver the first string should always be
+		    "Analog".
+
+Optionnal properties:
+- rockchip,hp-en-gpios = The phandle of the GPIO that power up/down the
+  headphone (when the analog output is an headphone).
+- rockchip,hp-det-gpios = The phandle of the GPIO that detects the headphone
+  (when the analog output is an headphone).
+- pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
+
+Example:
+
+sound {
+	compatible = "rockchip,rockchip-audio-es8388";
+	rockchip,model = "Analog audio output";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,audio-codec = <&es8388>;
+	rockchip,routing = "Analog", "LOUT2",
+			   "Analog", "ROUT2";
+	rockchip,hp-en-gpios = <&gpio8 0 GPIO_ACTIVE_HIGH>;
+	rockchip,hp-det-gpios = <&gpio7 7 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&headphone>;
+};
+
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index c783f9a..e3ca1e9 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -42,6 +42,15 @@ config SND_SOC_ROCKCHIP_RT5645
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the RT5645/RT5650 codec, such as Veyron.
 
+config SND_SOC_RK3288_HDMI_ANALOG
+	tristate "ASoC support multiple codecs for Rockchip RK3288 boards"
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_HDMI_CODEC
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  RK3288 boards using an analog output and the built-in HDMI audio.
+
 config SND_SOC_RK3399_GRU_SOUND
 	tristate "ASoC support multiple codecs for Rockchip RK3399 GRU boards"
 	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB && CLKDEV_LOOKUP && SPI
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 84e5c7c..991f91b 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -7,8 +7,10 @@ obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
+snd-soc-rk3288-hdmi-analog-objs := rk3288_hdmi_analog.o
 snd-soc-rk3399-gru-sound-objs := rk3399_gru_sound.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
+obj-$(CONFIG_SND_SOC_RK3288_HDMI_ANALOG) += snd-soc-rk3288-hdmi-analog.o
 obj-$(CONFIG_SND_SOC_RK3399_GRU_SOUND) += snd-soc-rk3399-gru-sound.o
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
new file mode 100644
index 0000000..b60abf3
--- /dev/null
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -0,0 +1,299 @@
+/*
+ * Rockchip machine ASoC driver for RK3288 boards that have an HDMI and analog
+ * audio output
+ *
+ * Copyright (c) 2016, Collabora Ltd.
+ *
+ * Authors: Sjoerd Simons <sjoerd.simons@collabora.com>,
+ *	    Romain Perier <romain.perier@collabora.com>
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
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "rockchip_i2s.h"
+
+#define DRV_NAME "rk3288-snd-hdmi-analog"
+
+struct rk_drvdata {
+	int gpio_hp_en;
+	int gpio_hp_det;
+};
+
+static int rk_hp_power(struct snd_soc_dapm_widget *w,
+		       struct snd_kcontrol *k, int event)
+{
+	struct rk_drvdata *machine = snd_soc_card_get_drvdata(w->dapm->card);
+
+	if (!gpio_is_valid(machine->gpio_hp_en))
+		return 0;
+
+	gpio_set_value_cansleep(machine->gpio_hp_en,
+				SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
+static struct snd_soc_jack headphone_jack;
+static struct snd_soc_jack_pin headphone_jack_pins[] = {
+	{
+		.pin = "Analog",
+		.mask = SND_JACK_HEADPHONE
+	},
+};
+
+static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Analog", rk_hp_power),
+	SND_SOC_DAPM_LINE("HDMI", NULL),
+};
+
+static const struct snd_kcontrol_new rk_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Analog"),
+	SOC_DAPM_PIN_SWITCH("HDMI"),
+};
+
+static int rk_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	int ret = 0;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int mclk;
+
+	switch (params_rate(params)) {
+	case 8000:
+	case 16000:
+	case 24000:
+	case 32000:
+	case 48000:
+	case 64000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 11025:
+	case 22050:
+	case 44100:
+	case 88200:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(codec_dai->dev, "Can't set cpu clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret && ret != -ENOTSUPP) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_jack_gpio rk_hp_jack_gpio = {
+	.name = "Headphone detection",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 150
+};
+
+static int rk_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct rk_drvdata *machine = snd_soc_card_get_drvdata(runtime->card);
+
+	/* Enable Headset Jack detection */
+	if (gpio_is_valid(machine->gpio_hp_det)) {
+		snd_soc_card_jack_new(runtime->card, "Headphone Jack",
+				      SND_JACK_HEADPHONE, &headphone_jack,
+				      headphone_jack_pins,
+				      ARRAY_SIZE(headphone_jack_pins));
+		rk_hp_jack_gpio.gpio = machine->gpio_hp_det;
+		snd_soc_jack_add_gpios(&headphone_jack, 1, &rk_hp_jack_gpio);
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops rk_ops = {
+	.hw_params = rk_hw_params,
+};
+
+static struct snd_soc_dai_link_component rk_codecs[] = {
+	{ },
+	{
+		.name = "hdmi-audio-codec.2.auto",
+		.dai_name = "hdmi-hifi.0",
+	},
+};
+
+static struct snd_soc_dai_link rk_dailink = {
+	.name = "Codecs",
+	.stream_name = "Audio",
+	.init = rk_init,
+	.ops = &rk_ops,
+	.codecs = rk_codecs,
+	.num_codecs = ARRAY_SIZE(rk_codecs),
+	/* Set codecs as slave */
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card snd_soc_card_rk = {
+	.name = "ROCKCHIP-I2S",
+	.dai_link = &rk_dailink,
+	.num_links = 1,
+	.num_aux_devs = 0,
+	.dapm_widgets = rk_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
+	.controls = rk_mc_controls,
+	.num_controls = ARRAY_SIZE(rk_mc_controls),
+};
+
+static int snd_rk_mc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct snd_soc_card *card = &snd_soc_card_rk;
+	struct device_node *np = pdev->dev.of_node;
+	struct rk_drvdata *machine;
+	struct of_phandle_args args;
+
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct rk_drvdata),
+			       GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
+
+	card->dev = &pdev->dev;
+
+	machine->gpio_hp_det = of_get_named_gpio(np,
+		"rockchip,hp-det-gpios", 0);
+	if (!gpio_is_valid(machine->gpio_hp_det) && machine->gpio_hp_det != -ENODEV)
+		return machine->gpio_hp_det;
+
+	machine->gpio_hp_en = of_get_named_gpio(np,
+		"rockchip,hp-en-gpios", 0);
+	if (!gpio_is_valid(machine->gpio_hp_en) && machine->gpio_hp_en != -ENODEV)
+		return machine->gpio_hp_en;
+
+	if (gpio_is_valid(machine->gpio_hp_en)) {
+		ret = devm_gpio_request_one(&pdev->dev, machine->gpio_hp_en,
+					    GPIOF_OUT_INIT_LOW, "hp_en");
+		if (ret) {
+			dev_err(card->dev, "cannot get hp_en gpio\n");
+			return ret;
+		}
+	}
+
+	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
+	if (ret) {
+		dev_err(card->dev, "SoC parse card name failed %d\n", ret);
+		return ret;
+	}
+
+	rk_dailink.codecs[0].of_node = of_parse_phandle(np,
+							"rockchip,audio-codec",
+							0);
+	if (!rk_dailink.codecs[0].of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+	ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
+					       0, 0, &args);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Unable to parse property 'rockchip,audio-codec'\n");
+		return ret;
+	}
+
+	ret = snd_soc_get_dai_name(&args, &rk_dailink.codecs[0].dai_name);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to get codec_dai_name\n");
+		return ret;
+	}
+
+	rk_dailink.cpu_of_node = of_parse_phandle(np, "rockchip,i2s-controller",
+						  0);
+	if (!rk_dailink.cpu_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,i2s-controller' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
+
+	ret = snd_soc_of_parse_audio_routing(card, "rockchip,routing");
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Unable to parse 'rockchip,routing' property\n");
+		return ret;
+	}
+
+	snd_soc_card_set_drvdata(card, machine);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Soc register card failed %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, card);
+
+	return ret;
+}
+
+static const struct of_device_id rockchip_sound_of_match[] = {
+	{ .compatible = "rockchip,rk3288-hdmi-analog", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, rockchip_sound_of_match);
+
+static struct platform_driver rockchip_sound_driver = {
+	.probe = snd_rk_mc_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = rockchip_sound_of_match,
+	},
+};
+
+module_platform_driver(rockchip_sound_driver);
+
+MODULE_AUTHOR("Sjoerd Simons <sjoerd.simons@collabora.com>");
+MODULE_DESCRIPTION("Rockchip RK3288 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.9.3
