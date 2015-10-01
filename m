From: =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Subject: aic31xx_set_bias_level not called
Date: Thu, 1 Oct 2015 11:35:11 +0200
Message-ID: <CAO8h3eGbOWK6wohqQcmNqw2UiCjDX6ESCZ8_wi5N+0w1cd6+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FC1260686
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 11:35:12 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so19565418wic.0
 for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2015 02:35:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I currently try to port an existing alsa driver to a new hardware. The only
difference between these to board is the used codec. Where the original board
(iMX6SX SDB from Freescale) uses a wm8962 our custom board uses a tlv320aic3110.
So I took the file sound\soc\fsl\imx-wm8962.c and changed it according to the
new codec. From what I understand the main things where just renaming. I then
setup my device tree according to the new environment and the kernel seemed to
setup stuff correctly. But when I try to play some sound using speaker-test I
see some errors and don't hear anything. Tracking stuff down using dev_dbg
outputs I see that aic31xx_set_bias_level is never called with a value > 1 which
causes that the clocks of the codec are never enabled. Maybe someone can give me
some hints on what can be wrong.

Here are some things which might be useful:

~ # dmesg | grep -i -A 2 ALSA
[    5.058905] ALSA device list:
[    5.061885]   #0: tlv320aic31xx-audio

~ # dmesg | grep tlv
[    1.598495] tlv320aic31xx-codec 2-0018: ## aic31xx_i2c_probe:
tlv320aic3110 codec_type = 1
[    1.613239] tlv320aic31xx-codec 2-0018: ## aic31xx_codec_probe
[    1.621895] tlv320aic31xx-codec 2-0018: ## aic31xx_set_dai_fmt: fmt = 0x1001
[    1.630390] imx-tlv320aic31xx sound: tlv320aic31xx-hifi <->
202c000.ssi mapping ok
[    1.638145] tlv320aic31xx-codec 2-0018: ## aic31xx_set_dai_sysclk:
clk_id = 0, freq = 24000000, dir = 0
[    1.663566] tlv320aic31xx-codec 2-0018: ## aic31xx_set_bias_level: 0 -> 1
[    5.061885]   #0: tlv320aic31xx-audio
[   36.860404] tlv320aic31xx-codec 2-0018: ## aic31xx_hw_params: width
16 rate 48000
[   36.886777] tlv320aic31xx-codec 2-0018: pll 8.1920/2 dosr 128 n 8 m
2 aosr 128 n 8 m 2 bclk_n 16

# aplay -L
null
    Discard all samples (playback) or generate zero samples (capture)
default:CARD=tlv320aic31xxau
    tlv320aic31xx-audio,
    Default Audio Device
sysdefault:CARD=tlv320aic31xxau
    tlv320aic31xx-audio,
    Default Audio Device

# speaker-test -Ddefault

speaker-test 1.0.29

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 128 to 32768
Period size range from 64 to 16384
Using max buffer size 32768
Periods = 4
was set period_size = 8192
was set buffer_size = 32768
 0 - Front Left
Write error: -5,Input/output error
xrun_recovery failed: -5,Input/output error
Transfer failed: Input/output error

# uname -a
Linux imx6sx-g343-devel 4.1.4-dirty #49 Thu Oct 1 10:39:44 CEST 2015
armv7l GNU/Linux


/*
 * Copyright 2013 Freescale Semiconductor, Inc.
 *
 * Based on imx-wm8962.c
 * Copyright 2012 Freescale Semiconductor, Inc.
 * Copyright 2012 Linaro Ltd.
 *
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */

#define DEBUG

#include <linux/module.h>
#include <linux/of_platform.h>
#include <linux/i2c.h>
#include <linux/slab.h>
#include <linux/clk.h>
#include <sound/soc.h>
#include <sound/pcm_params.h>
#include <sound/soc-dapm.h>
#include <linux/pinctrl/consumer.h>

#include "../codecs/tlv320aic31xx.h"
#include "imx-audmux.h"

#define DAI_NAME_SIZE 32

struct imx_tlv320aic31xx_data {
struct snd_soc_dai_link dai;
struct snd_soc_card card;
char codec_dai_name[DAI_NAME_SIZE];
char platform_name[DAI_NAME_SIZE];
struct clk *codec_clk;
unsigned int clk_frequency;
};

struct imx_priv {
struct platform_device *pdev;
};
static struct imx_priv card_priv;

static const struct snd_soc_dapm_widget imx_tlv320aic31xx_dapm_widgets[] = {
SND_SOC_DAPM_HP("Headphone Jack", NULL),
SND_SOC_DAPM_SPK("Ext Spk", NULL),
SND_SOC_DAPM_MIC("AMIC", NULL),
SND_SOC_DAPM_MIC("DMIC", NULL),
};

static int sample_rate = 44100;
static snd_pcm_format_t sample_format = SNDRV_PCM_FORMAT_S16_LE;

static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
struct snd_pcm_hw_params *params)
{
sample_rate = params_rate(params);
sample_format = params_format(params);

return 0;
}

static struct snd_soc_ops imx_hifi_ops = {
.hw_params = imx_hifi_hw_params,
};

static int imx_tlv320aic31xx_late_probe(struct snd_soc_card *card)
{
struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
struct imx_priv *priv = &card_priv;
struct imx_tlv320aic31xx_data *data = snd_soc_card_get_drvdata(card);
struct device *dev = &priv->pdev->dev;
int ret = 0;
ret = snd_soc_dai_set_sysclk(codec_dai, 0,
data->clk_frequency, SND_SOC_CLOCK_IN);
if (ret < 0)
dev_err(dev, "failed to set sysclk in %s\n", __func__);

return ret;
}

static int imx_tlv320aic31xx_probe(struct platform_device *pdev)
{
struct device_node *np = pdev->dev.of_node;
struct device_node *ssi_np, *codec_np;
struct platform_device *ssi_pdev;
struct imx_priv *priv = &card_priv;
struct i2c_client *codec_dev;
struct imx_tlv320aic31xx_data *data;
int int_port, ext_port;
int ret;

priv->pdev = pdev;

ret = of_property_read_u32(np, "mux-int-port", &int_port);
if (ret) {
dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
return ret;
}
ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
if (ret) {
dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
return ret;
}

/*
* The port numbering in the hardware manual starts at 1, while
* the audmux API expects it starts at 0.
*/
int_port--;
ext_port--;
ret = imx_audmux_v2_configure_port(int_port,
IMX_AUDMUX_V2_PTCR_SYN |
IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
IMX_AUDMUX_V2_PTCR_TFSDIR |
IMX_AUDMUX_V2_PTCR_TCLKDIR,
IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
if (ret) {
dev_err(&pdev->dev, "audmux internal port setup failed\n");
return ret;
}
ret = imx_audmux_v2_configure_port(ext_port,
IMX_AUDMUX_V2_PTCR_SYN,
IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
if (ret) {
dev_err(&pdev->dev, "audmux external port setup failed\n");
return ret;
}

ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
if (!ssi_np || !codec_np) {
dev_err(&pdev->dev, "phandle missing or invalid\n");
ret = -EINVAL;
goto fail;
}

ssi_pdev = of_find_device_by_node(ssi_np);
if (!ssi_pdev) {
dev_err(&pdev->dev, "failed to find SSI platform device\n");
ret = -EINVAL;
goto fail;
}
codec_dev = of_find_i2c_device_by_node(codec_np);
if (!codec_dev || !codec_dev->dev.driver) {
dev_err(&pdev->dev, "failed to find codec platform device\n");
ret = -EINVAL;
goto fail;
}

data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
if (!data) {
ret = -ENOMEM;
goto fail;
}

data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
if (IS_ERR(data->codec_clk)) {
ret = PTR_ERR(data->codec_clk);
dev_err(&codec_dev->dev, "failed to get codec clk: %d\n", ret);
goto fail;
}

data->clk_frequency = clk_get_rate(data->codec_clk);
ret = clk_prepare_enable(data->codec_clk);
if (ret) {
dev_err(&codec_dev->dev, "failed to enable codec clk: %d\n", ret);
goto fail;
}

data->dai.name = "HiFi";
data->dai.stream_name = "HiFi";
data->dai.codec_dai_name = "tlv320aic31xx-hifi";
data->dai.codec_of_node = codec_np;
data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
data->dai.platform_of_node = ssi_np;
data->dai.ops = &imx_hifi_ops;
data->dai.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
   SND_SOC_DAIFMT_CBM_CFM;

data->card.dev = &pdev->dev;
ret = snd_soc_of_parse_card_name(&data->card, "model");
if (ret)
goto clk_fail;
ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
if (ret)
goto clk_fail;
data->card.num_links = 1;
data->card.owner = THIS_MODULE;
data->card.dai_link = &data->dai;
data->card.dapm_widgets = imx_tlv320aic31xx_dapm_widgets;
data->card.num_dapm_widgets = ARRAY_SIZE(imx_tlv320aic31xx_dapm_widgets);

data->card.late_probe = imx_tlv320aic31xx_late_probe;

platform_set_drvdata(pdev, &data->card);
snd_soc_card_set_drvdata(&data->card, data);

ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
if (ret) {
dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
goto clk_fail;
}

of_node_put(ssi_np);
of_node_put(codec_np);

return 0;

clk_fail:
clk_disable_unprepare(data->codec_clk);
fail:
of_node_put(ssi_np);
of_node_put(codec_np);

return ret;
}

static int imx_tlv320aic31xx_remove(struct platform_device *pdev)
{
struct snd_soc_card *card = platform_get_drvdata(pdev);
struct imx_tlv320aic31xx_data *data = snd_soc_card_get_drvdata(card);

if (!IS_ERR(data->codec_clk))
clk_disable_unprepare(data->codec_clk);

return 0;
}

static const struct of_device_id imx_tlv320aic31xx_dt_ids[] = {
{ .compatible = "fsl,imx-audio-tlv320aic31xx", },
{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, imx_tlv320aic31xx_dt_ids);

static struct platform_driver imx_tlv320aic31xx_driver = {
.driver = {
.name = "imx-tlv320aic31xx",
.pm = &snd_soc_pm_ops,
.of_match_table = imx_tlv320aic31xx_dt_ids,
},
.probe = imx_tlv320aic31xx_probe,
.remove = imx_tlv320aic31xx_remove,
};
module_platform_driver(imx_tlv320aic31xx_driver);

MODULE_AUTHOR("Freescale Semiconductor, Inc.");
MODULE_DESCRIPTION("Freescale i.MX tlv320aic31xx ASoC machine driver");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:imx-tlv320aic31xx");
