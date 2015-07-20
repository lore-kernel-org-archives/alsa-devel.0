From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: Add machine driver for
	rt5645/rt5650 codec" to the asoc tree
Date: Mon, 20 Jul 2015 18:52:12 +0100
Message-ID: <E1ZHFEa-0002sr-A8@debutante>
References: <1437291962-16273-3-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 087A0261510
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:20 +0200 (CEST)
In-Reply-To: <1437291962-16273-3-git-send-email-zhengxing@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: zhengxing <zhengxing@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 86059653ea7ca7b30ed25d6bec5807ba59a4f2e6 Mon Sep 17 00:00:00 2001
From: zhengxing <zhengxing@rock-chips.com>
Date: Sun, 19 Jul 2015 19:33:49 +0800
Subject: [PATCH] ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

The driver is used for rockchip board using a rt5645/rt5650.

Reviewed-by: Dylan Reid <dgreid@chromium.org>
Signed-off-by: zhengxing <zhengxing@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rockchip-rt5645.txt  |  17 ++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_rt5645.c               | 225 +++++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

diff --git a/Documentation/devicetree/bindings/sound/rockchip-rt5645.txt b/Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
new file mode 100644
index 000000000000..411a62b3ff41
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
@@ -0,0 +1,17 @@
+ROCKCHIP with RT5645/RT5650 CODECS
+
+Required properties:
+- compatible: "rockchip,rockchip-audio-rt5645"
+- rockchip,model: The user-visible name of this sound complex
+- rockchip,i2s-controller: The phandle of the Rockchip I2S controller that's
+  connected to the CODEC
+- rockchip,audio-codec: The phandle of the RT5645/RT5650 audio codec
+
+Example:
+
+sound {
+	compatible = "rockchip,rockchip-audio-rt5645";
+	rockchip,model = "ROCKCHIP-I2S";
+	rockchip,i2s-controller = <&i2s>;
+	rockchip,audio-codec = <&rt5645>;
+};
diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
index d12356617fc7..58bae8e2cf5f 100644
--- a/sound/soc/rockchip/Kconfig
+++ b/sound/soc/rockchip/Kconfig
@@ -24,3 +24,12 @@ config SND_SOC_ROCKCHIP_MAX98090
 	help
 	  Say Y or M here if you want to add support for SoC audio on Rockchip
 	  boards using the MAX98090 codec, such as Veyron.
+
+config SND_SOC_ROCKCHIP_RT5645
+	tristate "ASoC support for Rockchip boards using a RT5645/RT5650 codec"
+	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
+	select SND_SOC_ROCKCHIP_I2S
+	select SND_SOC_RT5645
+	help
+	  Say Y or M here if you want to add support for SoC audio on Rockchip
+	  boards using the RT5645/RT5650 codec, such as Veyron.
diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index df3445b53806..1bc1dc3c729a 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -4,5 +4,7 @@ snd-soc-i2s-objs := rockchip_i2s.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
+snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
 
 obj-$(CONFIG_SND_SOC_ROCKCHIP_MAX98090) += snd-soc-rockchip-max98090.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_RT5645) += snd-soc-rockchip-rt5645.o
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
new file mode 100644
index 000000000000..3c6bb1ea06ec
--- /dev/null
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -0,0 +1,225 @@
+/*
+ * Rockchip machine ASoC driver for boards using a RT5645/RT5650 CODEC.
+ *
+ * Copyright (c) 2015, ROCKCHIP CORPORATION.  All rights reserved.
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
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "rockchip_i2s.h"
+
+#define DRV_NAME "rockchip-snd-rt5645"
+
+static struct snd_soc_jack headset_jack;
+
+/* Jack detect via rt5645 driver. */
+extern int rt5645_set_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
+	struct snd_soc_jack *btn_jack);
+
+static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route rk_audio_map[] = {
+	/* Input Lines */
+	{"DMIC L2", NULL, "Int Mic"},
+	{"DMIC R2", NULL, "Int Mic"},
+	{"RECMIXL", NULL, "Headset Mic"},
+	{"RECMIXR", NULL, "Headset Mic"},
+
+	/* Output Lines */
+	{"Headphones", NULL, "HPOR"},
+	{"Headphones", NULL, "HPOL"},
+	{"Speakers", NULL, "SPOL"},
+	{"Speakers", NULL, "SPOR"},
+};
+
+static const struct snd_kcontrol_new rk_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+};
+
+static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
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
+	case 48000:
+	case 96000:
+		mclk = 12288000;
+		break;
+	case 44100:
+		mclk = 11289600;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
+				     SND_SOC_CLOCK_OUT);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int rk_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	int ret;
+
+	/* Enable Headset and 4 Buttons Jack detection */
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &headset_jack, NULL, 0);
+	if (!ret) {
+		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
+		return ret;
+	}
+
+	return rt5645_set_jack_detect(runtime->codec,
+				     &headset_jack,
+				     &headset_jack,
+				     &headset_jack);
+}
+
+static struct snd_soc_ops rk_aif1_ops = {
+	.hw_params = rk_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link rk_dailink = {
+	.name = "rt5645",
+	.stream_name = "rt5645 PCM",
+	.codec_dai_name = "rt5645-aif1",
+	.init = rk_init,
+	.ops = &rk_aif1_ops,
+	/* set rt5645 as slave */
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		SND_SOC_DAIFMT_CBS_CFS,
+};
+
+static struct snd_soc_card snd_soc_card_rk = {
+	.name = "I2S-RT5650",
+	.dai_link = &rk_dailink,
+	.num_links = 1,
+	.dapm_widgets = rk_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rk_dapm_widgets),
+	.dapm_routes = rk_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(rk_audio_map),
+	.controls = rk_mc_controls,
+	.num_controls = ARRAY_SIZE(rk_mc_controls),
+};
+
+static int snd_rk_mc_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct snd_soc_card *card = &snd_soc_card_rk;
+	struct device_node *np = pdev->dev.of_node;
+
+	/* register the soc card */
+	card->dev = &pdev->dev;
+
+	rk_dailink.codec_of_node = of_parse_phandle(np,
+			"rockchip,audio-codec", 0);
+	if (!rk_dailink.codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rk_dailink.cpu_of_node = of_parse_phandle(np,
+			"rockchip,i2s-controller", 0);
+	if (!rk_dailink.cpu_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'rockchip,i2s-controller' missing or invalid\n");
+		return -EINVAL;
+	}
+
+	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
+
+	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Soc parse card name failed %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Soc register card failed %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct of_device_id rockchip_rt5645_of_match[] = {
+	{ .compatible = "rockchip,rockchip-audio-rt5645", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, rockchip_rt5645_of_match);
+
+static struct platform_driver snd_rk_mc_driver = {
+	.probe = snd_rk_mc_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = rockchip_rt5645_of_match,
+	},
+};
+
+module_platform_driver(snd_rk_mc_driver);
+
+MODULE_AUTHOR("Xing Zheng <zhengxing@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip rt5645 machine ASoC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.1.4
