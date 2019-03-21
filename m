From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: lochnagar: Add driver to support
	Lochnagar 2 sound card" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:35 +0000 (GMT)
Message-ID: <20190321150635.4A43411288EC@debutante.sirena.org.uk>
References: <20190320173732.8067-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD504F896B7
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:42 +0100 (CET)
In-Reply-To: <20190320173732.8067-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: lochnagar: Add driver to support Lochnagar 2 sound card

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 16123412a6283bcf956f1a377f2e799a79c2b439 Mon Sep 17 00:00:00 2001
From: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Date: Wed, 20 Mar 2019 17:37:32 +0000
Subject: [PATCH] ASoC: lochnagar: Add driver to support Lochnagar 2 sound card

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform.

Lochnagar 2 provides a set of line inputs/outputs, and a USB audio
device. This driver adds support for these analog line connections and
the Lochnagar side of the USB audio link.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                     |   2 +
 sound/soc/codecs/Kconfig        |   8 +
 sound/soc/codecs/Makefile       |   2 +
 sound/soc/codecs/lochnagar-sc.c | 266 ++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 sound/soc/codecs/lochnagar-sc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..1bc9f64ab0e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3799,6 +3799,7 @@ F:	drivers/clk/clk-lochnagar.c
 F:	drivers/mfd/lochnagar-i2c.c
 F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
 F:	drivers/regulator/lochnagar-regulator.c
+F:	sound/soc/codecs/lochnagar-sc.c
 F:	include/dt-bindings/clk/lochnagar.h
 F:	include/dt-bindings/pinctrl/lochnagar.h
 F:	include/linux/mfd/lochnagar*
@@ -3806,6 +3807,7 @@ F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
 F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
+F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
 
 CISCO FCOE HBA DRIVER
 M:	Satish Kharat <satishkh@cisco.com>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114edfd57..05f16632296b 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -94,6 +94,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_JZ4725B_CODEC
 	select SND_SOC_LM4857 if I2C
 	select SND_SOC_LM49453 if I2C
+	select SND_SOC_LOCHNAGAR_SC
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
@@ -688,6 +689,13 @@ config SND_SOC_ISABELLE
 config SND_SOC_LM49453
 	tristate
 
+config SND_SOC_LOCHNAGAR_SC
+	tristate "Lochnagar Sound Card"
+	depends on MFD_LOCHNAGAR
+	help
+	  This driver support the sound card functionality of the Cirrus
+	  Logic Lochnagar audio development board.
+
 config SND_SOC_MAX98088
 	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index aab2ad95a137..a597de946027 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -91,6 +91,7 @@ snd-soc-jz4725b-codec-objs := jz4725b.o
 snd-soc-l3-objs := l3.o
 snd-soc-lm4857-objs := lm4857.o
 snd-soc-lm49453-objs := lm49453.o
+snd-soc-lochnagar-sc-objs := lochnagar-sc.o
 snd-soc-max9759-objs := max9759.o
 snd-soc-max9768-objs := max9768.o
 snd-soc-max98088-objs := max98088.o
@@ -364,6 +365,7 @@ obj-$(CONFIG_SND_SOC_JZ4725B_CODEC)	+= snd-soc-jz4725b-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
 obj-$(CONFIG_SND_SOC_LM4857)	+= snd-soc-lm4857.o
 obj-$(CONFIG_SND_SOC_LM49453)   += snd-soc-lm49453.o
+obj-$(CONFIG_SND_SOC_LOCHNAGAR_SC)	+= snd-soc-lochnagar-sc.o
 obj-$(CONFIG_SND_SOC_MAX9759)	+= snd-soc-max9759.o
 obj-$(CONFIG_SND_SOC_MAX9768)	+= snd-soc-max9768.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
diff --git a/sound/soc/codecs/lochnagar-sc.c b/sound/soc/codecs/lochnagar-sc.c
new file mode 100644
index 000000000000..3209b39e46af
--- /dev/null
+++ b/sound/soc/codecs/lochnagar-sc.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Lochnagar sound card driver
+//
+// Copyright (c) 2017-2019 Cirrus Logic, Inc. and
+//                         Cirrus Logic International Semiconductor Ltd.
+//
+// Author: Charles Keepax <ckeepax@opensource.cirrus.com>
+//         Piotr Stankiewicz <piotrs@opensource.cirrus.com>
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#include <linux/mfd/lochnagar.h>
+#include <linux/mfd/lochnagar1_regs.h>
+#include <linux/mfd/lochnagar2_regs.h>
+
+struct lochnagar_sc_priv {
+	struct clk *mclk;
+};
+
+static const struct snd_soc_dapm_widget lochnagar_sc_widgets[] = {
+	SND_SOC_DAPM_LINE("Line Jack", NULL),
+	SND_SOC_DAPM_LINE("USB Audio", NULL),
+};
+
+static const struct snd_soc_dapm_route lochnagar_sc_routes[] = {
+	{ "Line Jack", NULL, "AIF1 Playback" },
+	{ "AIF1 Capture", NULL, "Line Jack" },
+
+	{ "USB Audio", NULL, "USB1 Playback" },
+	{ "USB Audio", NULL, "USB2 Playback" },
+	{ "USB1 Capture", NULL, "USB Audio" },
+	{ "USB2 Capture", NULL, "USB Audio" },
+};
+
+static const unsigned int lochnagar_sc_chan_vals[] = {
+	4, 8,
+};
+
+static const struct snd_pcm_hw_constraint_list lochnagar_sc_chan_constraint = {
+	.count = ARRAY_SIZE(lochnagar_sc_chan_vals),
+	.list = lochnagar_sc_chan_vals,
+};
+
+static const unsigned int lochnagar_sc_rate_vals[] = {
+	8000, 16000, 24000, 32000, 48000, 96000, 192000,
+	22050, 44100, 88200, 176400,
+};
+
+static const struct snd_pcm_hw_constraint_list lochnagar_sc_rate_constraint = {
+	.count = ARRAY_SIZE(lochnagar_sc_rate_vals),
+	.list = lochnagar_sc_rate_vals,
+};
+
+static int lochnagar_sc_hw_rule_rate(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval range = {
+		.min = 8000,
+		.max = 24576000 / hw_param_interval(params, rule->deps[0])->max,
+	};
+
+	return snd_interval_refine(hw_param_interval(params, rule->var),
+				   &range);
+}
+
+static int lochnagar_sc_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct lochnagar_sc_priv *priv = snd_soc_component_get_drvdata(comp);
+	int ret;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 &lochnagar_sc_rate_constraint);
+	if (ret)
+		return ret;
+
+	return snd_pcm_hw_rule_add(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   lochnagar_sc_hw_rule_rate, priv,
+				   SNDRV_PCM_HW_PARAM_FRAME_BITS, -1);
+}
+
+static int lochnagar_sc_line_startup(struct snd_pcm_substream *substream,
+				     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct lochnagar_sc_priv *priv = snd_soc_component_get_drvdata(comp);
+	int ret;
+
+	ret = clk_prepare_enable(priv->mclk);
+	if (ret < 0) {
+		dev_err(dai->dev, "Failed to enable MCLK: %d\n", ret);
+		return ret;
+	}
+
+	ret = lochnagar_sc_startup(substream, dai);
+	if (ret)
+		return ret;
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS,
+					  &lochnagar_sc_chan_constraint);
+}
+
+static void lochnagar_sc_line_shutdown(struct snd_pcm_substream *substream,
+				       struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *comp = dai->component;
+	struct lochnagar_sc_priv *priv = snd_soc_component_get_drvdata(comp);
+
+	clk_disable_unprepare(priv->mclk);
+}
+
+static int lochnagar_sc_check_fmt(struct snd_soc_dai *dai, unsigned int fmt,
+				  unsigned int tar)
+{
+	tar |= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF;
+
+	if ((fmt & ~SND_SOC_DAIFMT_CLOCK_MASK) != tar)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int lochnagar_sc_set_line_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	return lochnagar_sc_check_fmt(dai, fmt, SND_SOC_DAIFMT_CBS_CFS);
+}
+
+static int lochnagar_sc_set_usb_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	return lochnagar_sc_check_fmt(dai, fmt, SND_SOC_DAIFMT_CBM_CFM);
+}
+
+static const struct snd_soc_dai_ops lochnagar_sc_line_ops = {
+	.startup = lochnagar_sc_line_startup,
+	.shutdown = lochnagar_sc_line_shutdown,
+	.set_fmt = lochnagar_sc_set_line_fmt,
+};
+
+static const struct snd_soc_dai_ops lochnagar_sc_usb_ops = {
+	.startup = lochnagar_sc_startup,
+	.set_fmt = lochnagar_sc_set_usb_fmt,
+};
+
+static struct snd_soc_dai_driver lochnagar_sc_dai[] = {
+	{
+		.name = "lochnagar-line",
+		.playback = {
+			.stream_name = "AIF1 Playback",
+			.channels_min = 4,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.capture = {
+			.stream_name = "AIF1 Capture",
+			.channels_min = 4,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &lochnagar_sc_line_ops,
+		.symmetric_rates = true,
+		.symmetric_samplebits = true,
+	},
+	{
+		.name = "lochnagar-usb1",
+		.playback = {
+			.stream_name = "USB1 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.capture = {
+			.stream_name = "USB1 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &lochnagar_sc_usb_ops,
+		.symmetric_rates = true,
+		.symmetric_samplebits = true,
+	},
+	{
+		.name = "lochnagar-usb2",
+		.playback = {
+			.stream_name = "USB2 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.capture = {
+			.stream_name = "USB2 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_KNOT,
+			.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		},
+		.ops = &lochnagar_sc_usb_ops,
+		.symmetric_rates = true,
+		.symmetric_samplebits = true,
+	},
+};
+
+static const struct snd_soc_component_driver lochnagar_sc_driver = {
+	.non_legacy_dai_naming = 1,
+
+	.dapm_widgets = lochnagar_sc_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(lochnagar_sc_widgets),
+	.dapm_routes = lochnagar_sc_routes,
+	.num_dapm_routes = ARRAY_SIZE(lochnagar_sc_routes),
+};
+
+static int lochnagar_sc_probe(struct platform_device *pdev)
+{
+	struct lochnagar_sc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->mclk = devm_clk_get(&pdev->dev, "mclk");
+	if (IS_ERR(priv->mclk)) {
+		ret = PTR_ERR(priv->mclk);
+		dev_err(&pdev->dev, "Failed to get MCLK: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_snd_soc_register_component(&pdev->dev,
+					       &lochnagar_sc_driver,
+					       lochnagar_sc_dai,
+					       ARRAY_SIZE(lochnagar_sc_dai));
+}
+
+static const struct of_device_id lochnagar_of_match[] = {
+	{ .compatible = "cirrus,lochnagar2-soundcard" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lochnagar_of_match);
+
+static struct platform_driver lochnagar_sc_codec_driver = {
+	.driver = {
+		.name = "lochnagar-soundcard",
+		.of_match_table = of_match_ptr(lochnagar_of_match),
+	},
+
+	.probe = lochnagar_sc_probe,
+};
+module_platform_driver(lochnagar_sc_codec_driver);
+
+MODULE_DESCRIPTION("ASoC Lochnagar Sound Card Driver");
+MODULE_AUTHOR("Piotr Stankiewicz <piotrs@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:lochnagar-soundcard");
-- 
2.20.1
