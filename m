From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: imx-wm8962: Remove machine driver
Date: Mon, 26 Feb 2018 16:15:35 -0300
Message-ID: <1519672535-26589-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f66.google.com (mail-vk0-f66.google.com
 [209.85.213.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F2DA267AA5
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 20:15:28 +0100 (CET)
Received: by mail-vk0-f66.google.com with SMTP id y127so10585190vky.9
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 11:15:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, leonard.crestez@nxp.com, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

fsl-asoc-card machine driver also handles wm8962, so there is
really no need for keeping the dedicated imx-wm8962 driver anymore.

Remove the imx-wm8962 machine driver.

Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Instead of fixing the imx-wm8962 driver private strcuc, 
better remove it as wm8962 can be handled by fsl-asoc-card. (Nicolin)

 sound/soc/fsl/Kconfig      |  11 --
 sound/soc/fsl/Makefile     |   2 -
 sound/soc/fsl/imx-wm8962.c | 312 ---------------------------------------------
 3 files changed, 325 deletions(-)
 delete mode 100644 sound/soc/fsl/imx-wm8962.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 37f9b62..6ec19fb 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -231,17 +231,6 @@ config SND_SOC_EUKREA_TLV320
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
 
-config SND_SOC_IMX_WM8962
-	tristate "SoC Audio support for i.MX boards with wm8962"
-	depends on OF && I2C && INPUT
-	select SND_SOC_WM8962
-	select SND_SOC_IMX_PCM_DMA
-	select SND_SOC_IMX_AUDMUX
-	select SND_SOC_FSL_SSI
-	help
-	  Say Y if you want to add support for SoC audio on an i.MX board with
-	  a wm8962 codec.
-
 config SND_SOC_IMX_ES8328
 	tristate "SoC Audio support for i.MX boards with the ES8328 codec"
 	depends on OF && (I2C || SPI)
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index c67bf11..de94fa0 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -55,7 +55,6 @@ snd-soc-mx27vis-aic32x4-objs := mx27vis-aic32x4.o
 snd-soc-wm1133-ev1-objs := wm1133-ev1.o
 snd-soc-imx-es8328-objs := imx-es8328.o
 snd-soc-imx-sgtl5000-objs := imx-sgtl5000.o
-snd-soc-imx-wm8962-objs := imx-wm8962.o
 snd-soc-imx-spdif-objs := imx-spdif.o
 snd-soc-imx-mc13783-objs := imx-mc13783.o
 
@@ -65,6 +64,5 @@ obj-$(CONFIG_SND_SOC_MX27VIS_AIC32X4) += snd-soc-mx27vis-aic32x4.o
 obj-$(CONFIG_SND_MXC_SOC_WM1133_EV1) += snd-soc-wm1133-ev1.o
 obj-$(CONFIG_SND_SOC_IMX_ES8328) += snd-soc-imx-es8328.o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) += snd-soc-imx-sgtl5000.o
-obj-$(CONFIG_SND_SOC_IMX_WM8962) += snd-soc-imx-wm8962.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) += snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) += snd-soc-imx-mc13783.o
diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
deleted file mode 100644
index 206b898..0000000
--- a/sound/soc/fsl/imx-wm8962.c
+++ /dev/null
@@ -1,312 +0,0 @@
-/*
- * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * Based on imx-sgtl5000.c
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
-
-#include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/i2c.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <sound/soc.h>
-#include <sound/pcm_params.h>
-#include <sound/soc-dapm.h>
-#include <linux/pinctrl/consumer.h>
-
-#include "../codecs/wm8962.h"
-#include "imx-audmux.h"
-
-#define DAI_NAME_SIZE	32
-
-struct imx_wm8962_data {
-	struct snd_soc_dai_link dai;
-	struct snd_soc_card card;
-	char codec_dai_name[DAI_NAME_SIZE];
-	char platform_name[DAI_NAME_SIZE];
-	unsigned int clk_frequency;
-};
-
-struct imx_priv {
-	struct platform_device *pdev;
-	int sample_rate;
-	snd_pcm_format_t sample_format;
-};
-
-static const struct snd_soc_dapm_widget imx_wm8962_dapm_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
-	SND_SOC_DAPM_SPK("Ext Spk", NULL),
-	SND_SOC_DAPM_MIC("AMIC", NULL),
-	SND_SOC_DAPM_MIC("DMIC", NULL),
-};
-
-static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
-		struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_priv *priv = snd_soc_card_get_drvdata(rtd->card);
-
-	priv->sample_rate = params_rate(params);
-	priv->sample_format = params_format(params);
-
-	return 0;
-}
-
-static const struct snd_soc_ops imx_hifi_ops = {
-	.hw_params = imx_hifi_hw_params,
-};
-
-static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
-					struct snd_soc_dapm_context *dapm,
-					enum snd_soc_bias_level level)
-{
-	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai *codec_dai;
-	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
-	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
-	struct device *dev = &priv->pdev->dev;
-	unsigned int pll_out;
-	int ret;
-
-	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
-	codec_dai = rtd->codec_dai;
-	if (dapm->dev != codec_dai->dev)
-		return 0;
-
-	switch (level) {
-	case SND_SOC_BIAS_PREPARE:
-		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-			if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
-				pll_out = priv->sample_rate * 384;
-			else
-				pll_out = priv->sample_rate * 256;
-
-			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					WM8962_FLL_MCLK, data->clk_frequency,
-					pll_out);
-			if (ret < 0) {
-				dev_err(dev, "failed to start FLL: %d\n", ret);
-				return ret;
-			}
-
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-					WM8962_SYSCLK_FLL, pll_out,
-					SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(dev, "failed to set SYSCLK: %d\n", ret);
-				return ret;
-			}
-		}
-		break;
-
-	case SND_SOC_BIAS_STANDBY:
-		if (dapm->bias_level == SND_SOC_BIAS_PREPARE) {
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-					WM8962_SYSCLK_MCLK, data->clk_frequency,
-					SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				dev_err(dev,
-					"failed to switch away from FLL: %d\n",
-					ret);
-				return ret;
-			}
-
-			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					0, 0, 0);
-			if (ret < 0) {
-				dev_err(dev, "failed to stop FLL: %d\n", ret);
-				return ret;
-			}
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int imx_wm8962_late_probe(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai *codec_dai;
-	struct imx_priv *priv = snd_soc_card_get_drvdata(card);
-	struct imx_wm8962_data *data = snd_soc_card_get_drvdata(card);
-	struct device *dev = &priv->pdev->dev;
-	int ret;
-
-	rtd = snd_soc_get_pcm_runtime(card, card->dai_link[0].name);
-	codec_dai = rtd->codec_dai;
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
-			data->clk_frequency, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		dev_err(dev, "failed to set sysclk in %s\n", __func__);
-
-	return ret;
-}
-
-static int imx_wm8962_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device_node *ssi_np, *codec_np;
-	struct platform_device *ssi_pdev;
-	struct i2c_client *codec_dev;
-	struct imx_wm8962_data *data;
-	struct imx_priv *priv;
-	struct clk *codec_clk;
-	int int_port, ext_port;
-	int ret;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->pdev = pdev;
-	priv->sample_rate = 44100;
-	priv->sample_format = SNDRV_PCM_FORMAT_S16_LE;
-
-	ret = of_property_read_u32(np, "mux-int-port", &int_port);
-	if (ret) {
-		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
-		return ret;
-	}
-	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
-	if (ret) {
-		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
-		return ret;
-	}
-
-	/*
-	 * The port numbering in the hardware manual starts at 1, while
-	 * the audmux API expects it starts at 0.
-	 */
-	int_port--;
-	ext_port--;
-	ret = imx_audmux_v2_configure_port(int_port,
-			IMX_AUDMUX_V2_PTCR_SYN |
-			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
-			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
-			IMX_AUDMUX_V2_PTCR_TFSDIR |
-			IMX_AUDMUX_V2_PTCR_TCLKDIR,
-			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
-	if (ret) {
-		dev_err(&pdev->dev, "audmux internal port setup failed\n");
-		return ret;
-	}
-	ret = imx_audmux_v2_configure_port(ext_port,
-			IMX_AUDMUX_V2_PTCR_SYN,
-			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
-	if (ret) {
-		dev_err(&pdev->dev, "audmux external port setup failed\n");
-		return ret;
-	}
-
-	ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
-	codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
-	if (!ssi_np || !codec_np) {
-		dev_err(&pdev->dev, "phandle missing or invalid\n");
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	ssi_pdev = of_find_device_by_node(ssi_np);
-	if (!ssi_pdev) {
-		dev_err(&pdev->dev, "failed to find SSI platform device\n");
-		ret = -EINVAL;
-		goto fail;
-	}
-	codec_dev = of_find_i2c_device_by_node(codec_np);
-	if (!codec_dev || !codec_dev->dev.driver) {
-		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		ret = -EINVAL;
-		goto fail;
-	}
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto fail;
-	}
-
-	codec_clk = clk_get(&codec_dev->dev, NULL);
-	if (IS_ERR(codec_clk)) {
-		ret = PTR_ERR(codec_clk);
-		dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
-		goto fail;
-	}
-
-	data->clk_frequency = clk_get_rate(codec_clk);
-	clk_put(codec_clk);
-
-	data->dai.name = "HiFi";
-	data->dai.stream_name = "HiFi";
-	data->dai.codec_dai_name = "wm8962";
-	data->dai.codec_of_node = codec_np;
-	data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
-	data->dai.platform_of_node = ssi_np;
-	data->dai.ops = &imx_hifi_ops;
-	data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			    SND_SOC_DAIFMT_CBM_CFM;
-
-	data->card.dev = &pdev->dev;
-	ret = snd_soc_of_parse_card_name(&data->card, "model");
-	if (ret)
-		goto fail;
-	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
-	if (ret)
-		goto fail;
-	data->card.num_links = 1;
-	data->card.owner = THIS_MODULE;
-	data->card.dai_link = &data->dai;
-	data->card.dapm_widgets = imx_wm8962_dapm_widgets;
-	data->card.num_dapm_widgets = ARRAY_SIZE(imx_wm8962_dapm_widgets);
-
-	data->card.late_probe = imx_wm8962_late_probe;
-	data->card.set_bias_level = imx_wm8962_set_bias_level;
-
-	platform_set_drvdata(pdev, &data->card);
-	snd_soc_card_set_drvdata(&data->card, data);
-
-	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
-		goto fail;
-	}
-
-fail:
-	of_node_put(ssi_np);
-	of_node_put(codec_np);
-
-	return ret;
-}
-
-static const struct of_device_id imx_wm8962_dt_ids[] = {
-	{ .compatible = "fsl,imx-audio-wm8962", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, imx_wm8962_dt_ids);
-
-static struct platform_driver imx_wm8962_driver = {
-	.driver = {
-		.name = "imx-wm8962",
-		.pm = &snd_soc_pm_ops,
-		.of_match_table = imx_wm8962_dt_ids,
-	},
-	.probe = imx_wm8962_probe,
-};
-module_platform_driver(imx_wm8962_driver);
-
-MODULE_AUTHOR("Freescale Semiconductor, Inc.");
-MODULE_DESCRIPTION("Freescale i.MX WM8962 ASoC machine driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:imx-wm8962");
-- 
2.7.4
