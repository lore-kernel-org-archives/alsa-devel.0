From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: add wm8524 codec driver" to the
	asoc tree
Date: Fri, 28 Jul 2017 13:37:58 +0100
Message-ID: <E1db4Wk-0004t4-SB@finisterre>
References: <1501167310-24905-1-git-send-email-mihai.serban@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8D42676CC
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 14:38:12 +0200 (CEST)
In-Reply-To: <1501167310-24905-1-git-send-email-mihai.serban@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mihai Serban <mihai.serban@nxp.com>
Cc: shengjiu.wang@nxp.com, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: add wm8524 codec driver

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

>From 007b6a54c305688d1db7255e5c724e3d76ba5aa4 Mon Sep 17 00:00:00 2001
From: Mihai Serban <mihai.serban@nxp.com>
Date: Thu, 27 Jul 2017 17:55:10 +0300
Subject: [PATCH] ASoC: codecs: add wm8524 codec driver

WM8524 is a 24-bit 192KHz stereo digital/analog converter (DAC) with
integral charge pump and a simple hardware control interface.
Product information can be found at:
https://www.cirrus.com/products/wm8524/

Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/wm8524.txt |  16 ++
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/wm8524.c                          | 265 +++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8524.txt
 create mode 100644 sound/soc/codecs/wm8524.c

diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
new file mode 100644
index 000000000000..20c62002cbcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8524.txt
@@ -0,0 +1,16 @@
+WM8524 audio CODEC
+
+This device does not use I2C or SPI but a simple Hardware Control Interface.
+
+Required properties:
+
+  - compatible : "wlf,wm8524"
+
+  - wlf,mute-gpios: a GPIO spec for the MUTE pin.
+
+Example:
+
+codec: wm8524@0 {
+	compatible = "wlf,wm8524";
+	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+};
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6c78b0b49b81..c3d8aef98608 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -173,6 +173,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8400 if MFD_WM8400
 	select SND_SOC_WM8510 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8523 if I2C
+	select SND_SOC_WM8524 if GPIOLIB
 	select SND_SOC_WM8580 if I2C
 	select SND_SOC_WM8711 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8727
@@ -967,6 +968,10 @@ config SND_SOC_WM8523
 	tristate "Wolfson Microelectronics WM8523 DAC"
 	depends on I2C
 
+config SND_SOC_WM8524
+	tristate "Wolfson Microelectronics WM8524 DAC"
+	depends on GPIOLIB
+
 config SND_SOC_WM8580
 	tristate "Wolfson Microelectronics WM8580 and WM8581 CODECs"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1755a54e3dc9..66a8567d76d1 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -182,6 +182,7 @@ snd-soc-wm8350-objs := wm8350.o
 snd-soc-wm8400-objs := wm8400.o
 snd-soc-wm8510-objs := wm8510.o
 snd-soc-wm8523-objs := wm8523.o
+snd-soc-wm8524-objs := wm8524.o
 snd-soc-wm8580-objs := wm8580.o
 snd-soc-wm8711-objs := wm8711.o
 snd-soc-wm8727-objs := wm8727.o
@@ -414,6 +415,7 @@ obj-$(CONFIG_SND_SOC_WM8350)	+= snd-soc-wm8350.o
 obj-$(CONFIG_SND_SOC_WM8400)	+= snd-soc-wm8400.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
 obj-$(CONFIG_SND_SOC_WM8523)	+= snd-soc-wm8523.o
+obj-$(CONFIG_SND_SOC_WM8524)	+= snd-soc-wm8524.o
 obj-$(CONFIG_SND_SOC_WM8580)	+= snd-soc-wm8580.o
 obj-$(CONFIG_SND_SOC_WM8711)	+= snd-soc-wm8711.o
 obj-$(CONFIG_SND_SOC_WM8727)	+= snd-soc-wm8727.o
diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
new file mode 100644
index 000000000000..f42ec664877c
--- /dev/null
+++ b/sound/soc/codecs/wm8524.c
@@ -0,0 +1,265 @@
+/*
+ * wm8524.c  --  WM8524 ALSA SoC Audio driver
+ *
+ * Copyright 2009 Wolfson Microelectronics plc
+ * Copyright 2017 NXP
+ *
+ * Based on WM8523 ALSA SoC Audio driver written by Mark Brown
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+#define WM8524_NUM_RATES 7
+
+/* codec private data */
+struct wm8524_priv {
+	struct gpio_desc *mute;
+	unsigned int sysclk;
+	unsigned int rate_constraint_list[WM8524_NUM_RATES];
+	struct snd_pcm_hw_constraint_list rate_constraint;
+};
+
+
+static const struct snd_soc_dapm_widget wm8524_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("LINEVOUTL"),
+SND_SOC_DAPM_OUTPUT("LINEVOUTR"),
+};
+
+static const struct snd_soc_dapm_route wm8524_dapm_routes[] = {
+	{ "LINEVOUTL", NULL, "DAC" },
+	{ "LINEVOUTR", NULL, "DAC" },
+};
+
+static const struct {
+	int value;
+	int ratio;
+} lrclk_ratios[WM8524_NUM_RATES] = {
+	{ 1, 128 },
+	{ 2, 192 },
+	{ 3, 256 },
+	{ 4, 384 },
+	{ 5, 512 },
+	{ 6, 768 },
+	{ 7, 1152 },
+};
+
+static int wm8524_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8524_priv *wm8524 = snd_soc_codec_get_drvdata(codec);
+
+	/* The set of sample rates that can be supported depends on the
+	 * MCLK supplied to the CODEC - enforce this.
+	 */
+	if (!wm8524->sysclk) {
+		dev_err(codec->dev,
+			"No MCLK configured, call set_sysclk() on init\n");
+		return -EINVAL;
+	}
+
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &wm8524->rate_constraint);
+
+	gpiod_set_value_cansleep(wm8524->mute, 1);
+
+	return 0;
+}
+
+static void wm8524_shutdown(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8524_priv *wm8524 = snd_soc_codec_get_drvdata(codec);
+
+	gpiod_set_value_cansleep(wm8524->mute, 0);
+}
+
+static int wm8524_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8524_priv *wm8524 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
+	int i, j = 0;
+
+	wm8524->sysclk = freq;
+
+	wm8524->rate_constraint.count = 0;
+	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
+		val = freq / lrclk_ratios[i].ratio;
+		/* Check that it's a standard rate since core can't
+		 * cope with others and having the odd rates confuses
+		 * constraint matching.
+		 */
+		switch (val) {
+		case 8000:
+		case 32000:
+		case 44100:
+		case 48000:
+		case 88200:
+		case 96000:
+		case 176400:
+		case 192000:
+			dev_err(codec->dev, "Supported sample rate: %dHz\n",
+				val);
+			wm8524->rate_constraint_list[j++] = val;
+			wm8524->rate_constraint.count++;
+			break;
+		default:
+			dev_dbg(codec->dev, "Skipping sample rate: %dHz\n",
+				val);
+		}
+	}
+
+	/* Need at least one supported rate... */
+	if (wm8524->rate_constraint.count == 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int wm8524_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
+{
+	fmt &= (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK |
+		SND_SOC_DAIFMT_MASTER_MASK);
+
+	if (fmt != (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		    SND_SOC_DAIFMT_CBS_CFS)) {
+		dev_err(codec_dai->dev, "Invalid DAI format\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wm8524_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct wm8524_priv *wm8524 = snd_soc_codec_get_drvdata(dai->codec);
+
+	if (wm8524->mute)
+		gpiod_set_value_cansleep(wm8524->mute, mute);
+
+	return 0;
+}
+
+#define WM8524_RATES SNDRV_PCM_RATE_8000_192000
+
+#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
+
+static const struct snd_soc_dai_ops wm8524_dai_ops = {
+	.startup	= wm8524_startup,
+	.shutdown	= wm8524_shutdown,
+	.set_sysclk	= wm8524_set_dai_sysclk,
+	.set_fmt	= wm8524_set_fmt,
+	.mute_stream	= wm8524_mute_stream,
+};
+
+static struct snd_soc_dai_driver wm8524_dai = {
+	.name = "wm8524-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = WM8524_RATES,
+		.formats = WM8524_FORMATS,
+	},
+	.ops = &wm8524_dai_ops,
+};
+
+static int wm8524_probe(struct snd_soc_codec *codec)
+{
+	struct wm8524_priv *wm8524 = snd_soc_codec_get_drvdata(codec);
+
+	wm8524->rate_constraint.list = &wm8524->rate_constraint_list[0];
+	wm8524->rate_constraint.count =
+		ARRAY_SIZE(wm8524->rate_constraint_list);
+
+	return 0;
+}
+
+static const struct snd_soc_codec_driver soc_codec_dev_wm8524 = {
+	.probe =	wm8524_probe,
+
+	.component_driver = {
+		.dapm_widgets		= wm8524_dapm_widgets,
+		.num_dapm_widgets	= ARRAY_SIZE(wm8524_dapm_widgets),
+		.dapm_routes		= wm8524_dapm_routes,
+		.num_dapm_routes	= ARRAY_SIZE(wm8524_dapm_routes),
+	},
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id wm8524_of_match[] = {
+	{ .compatible = "wlf,wm8524" },
+	{ /* sentinel*/ }
+};
+MODULE_DEVICE_TABLE(of, wm8524_of_match);
+#endif
+
+static int wm8524_codec_probe(struct platform_device *pdev)
+{
+	struct wm8524_priv *wm8524;
+	int ret;
+
+	wm8524 = devm_kzalloc(&pdev->dev, sizeof(struct wm8524_priv),
+						  GFP_KERNEL);
+	if (wm8524 == NULL)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wm8524);
+
+	wm8524->mute = devm_gpiod_get(&pdev->dev, "wlf,mute", GPIOD_OUT_LOW);
+	if (IS_ERR(wm8524->mute)) {
+		ret = PTR_ERR(wm8524->mute);
+		dev_err(&pdev->dev, "Failed to get mute line: %d\n", ret);
+		return ret;
+	}
+
+	ret =  snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_wm8524, &wm8524_dai, 1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		snd_soc_unregister_platform(&pdev->dev);
+	}
+
+	return ret;
+}
+
+static int wm8524_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver wm8524_codec_driver = {
+	.probe		= wm8524_codec_probe,
+	.remove		= wm8524_codec_remove,
+	.driver		= {
+		.name	= "wm8524-codec",
+		.of_match_table = wm8524_of_match,
+	},
+};
+module_platform_driver(wm8524_codec_driver);
+
+MODULE_DESCRIPTION("ASoC WM8524 driver");
+MODULE_AUTHOR("Mihai Serban <mihai.serban@nxp.com>");
+MODULE_ALIAS("platform:wm8524-codec");
+MODULE_LICENSE("GPL");
-- 
2.13.2
