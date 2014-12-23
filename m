From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Tue, 23 Dec 2014 11:36:36 -0800
Message-ID: <CAOMFOmX-xRQNuyp=fLdbxbmE2gTVwqwzQ_d05hfaTg1Ptrn+HA@mail.gmail.com>
References: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f178.google.com (mail-lb0-f178.google.com
 [209.85.217.178])
 by alsa0.perex.cz (Postfix) with ESMTP id AD32A265499
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 20:36:36 +0100 (CET)
Received: by mail-lb0-f178.google.com with SMTP id f15so6502238lbj.37
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 11:36:36 -0800 (PST)
In-Reply-To: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Stephen Warren <swarren@nvidia.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Bard Liao <bardliao@realtek.com>, Laurent Dahan <ldahan@nvidia.com>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark

After thinking for a while we've decided to drop the speaker codec and
go with PDM speakers, thus we do not need speaker-codec property
anymore.

On Tue, Dec 23, 2014 at 11:29 AM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> The driver supports NVIDIA Tegra Ryu board
>
> Sponsored: Google ChromeOS
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> ---
>  .../bindings/sound/nvidia,tegra-audio-rt5677.txt   |  67 ++++
>  sound/soc/tegra/Kconfig                            |  10 +
>  sound/soc/tegra/Makefile                           |   2 +
>  sound/soc/tegra/tegra_rt5677.c                     | 351 +++++++++++++++++++++
>  4 files changed, 430 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
>  create mode 100644 sound/soc/tegra/tegra_rt5677.c
>
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
> new file mode 100644
> index 0000000..a4589cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
> @@ -0,0 +1,67 @@
> +NVIDIA Tegra audio complex, with RT5677 CODEC
> +
> +Required properties:
> +- compatible : "nvidia,tegra-audio-rt5677"
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names : Must include the following entries:
> +  - pll_a
> +  - pll_a_out0
> +  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
> +- nvidia,model : The user-visible name of this sound complex.
> +- nvidia,audio-routing : A list of the connections between audio components.
> +  Each entry is a pair of strings, the first being the connection's sink,
> +  the second being the connection's source. Valid names for sources and
> +  sinks are the RT5677's pins (as documented in its binding), and the jacks
> +  on the board:
> +
> +  * Headphone
> +  * Speaker
> +  * Headset Mic
> +  * Internal Mic 1
> +  * Internal Mic 2
> +
> +- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
> +  connected to the CODEC.
> +- nvidia,audio-codec : The phandle of the RT5677 audio codec. This binding
> +  assumes that AIF1 on the CODEC is connected to Tegra.
> +
> +Optional properties:
> +- nvidia,hp-det-gpios : The GPIO that detects headphones are plugged in
> +- nvidia,hp-en-gpios : The GPIO that enables headphone amplifier
> +- nvidia,mic-present-gpios: The GPIO that mic jack is plugged in
> +- nvidia,dmic-clk-en-gpios : The GPIO that gates DMIC clock signal
> +
> +Example:
> +
> +sound {
> +       compatible = "nvidia,tegra-audio-rt5677-ryu",
> +               "nvidia,tegra-audio-rt5677";
> +       nvidia,model = "NVIDIA Tegra Ryu";
> +
> +       nvidia,audio-routing =
> +               "Headphone", "LOUT2",
> +               "Headphone", "LOUT1",
> +               "Headset Mic", "MICBIAS1",
> +               "IN1P", "Headset Mic",
> +               "IN1N", "Headset Mic",
> +               "DMIC L1", "Internal Mic 1",
> +               "DMIC R1", "Internal Mic 1",
> +               "DMIC L2", "Internal Mic 2",
> +               "DMIC R2", "Internal Mic 2",
> +               "Speaker", "PDM1L",
> +               "Speaker", "PDM1R";
> +
> +       nvidia,i2s-controller = <&tegra_i2s1>;
> +       nvidia,audio-codec = <&rt5677>;
> +
> +       nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
> +       nvidia,mic-present-gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
> +       nvidia,hp-en-gpios = <&rt5677 1 GPIO_ACTIVE_HIGH>;
> +       nvidia,dmic-clk-en-gpios = <&rt5677 2 GPIO_ACTIVE_HIGH>;
> +
> +       clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
> +                <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
> +                <&tegra_car TEGRA124_CLK_EXTERN1>;
> +       clock-names = "pll_a", "pll_a_out0", "mclk";
> +};
> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> index 31198cf7..a6768f8 100644
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
> @@ -128,3 +128,13 @@ config SND_SOC_TEGRA_MAX98090
>         help
>           Say Y or M here if you want to add support for SoC audio on Tegra
>           boards using the MAX98090 codec, such as Venice2.
> +
> +config SND_SOC_TEGRA_RT5677
> +       tristate "SoC Audio support for Tegra boards using a RT5677 codec"
> +       depends on SND_SOC_TEGRA && I2C && GPIOLIB
> +       select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
> +       select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
> +       select SND_SOC_RT5677
> +       help
> +         Say Y or M here if you want to add support for SoC audio on Tegra
> +         boards using the RT5677 codec, such as Ryu.
> diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
> index 5ae588c..9171655 100644
> --- a/sound/soc/tegra/Makefile
> +++ b/sound/soc/tegra/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_SND_SOC_TEGRA30_I2S) += snd-soc-tegra30-i2s.o
>
>  # Tegra machine Support
>  snd-soc-tegra-rt5640-objs := tegra_rt5640.o
> +snd-soc-tegra-rt5677-objs := tegra_rt5677.o
>  snd-soc-tegra-wm8753-objs := tegra_wm8753.o
>  snd-soc-tegra-wm8903-objs := tegra_wm8903.o
>  snd-soc-tegra-wm9712-objs := tegra_wm9712.o
> @@ -27,6 +28,7 @@ snd-soc-tegra-alc5632-objs := tegra_alc5632.o
>  snd-soc-tegra-max98090-objs := tegra_max98090.o
>
>  obj-$(CONFIG_SND_SOC_TEGRA_RT5640) += snd-soc-tegra-rt5640.o
> +obj-$(CONFIG_SND_SOC_TEGRA_RT5677) += snd-soc-tegra-rt5677.o
>  obj-$(CONFIG_SND_SOC_TEGRA_WM8753) += snd-soc-tegra-wm8753.o
>  obj-$(CONFIG_SND_SOC_TEGRA_WM8903) += snd-soc-tegra-wm8903.o
>  obj-$(CONFIG_SND_SOC_TEGRA_WM9712) += snd-soc-tegra-wm9712.o
> diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
> new file mode 100644
> index 0000000..6e98d10
> --- /dev/null
> +++ b/sound/soc/tegra/tegra_rt5677.c
> @@ -0,0 +1,351 @@
> +/*
> +* tegra_rt5677.c - Tegra machine ASoC driver for boards using RT5677 codec.
> + *
> + * Copyright (c) 2014, The Chromium OS Authors.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Based on code copyright/by:
> + *
> + * Copyright (C) 2010-2012 - NVIDIA, Inc.
> + * Copyright (C) 2011 The AC100 Kernel Team <ac100@lists.lauchpad.net>
> + * (c) 2009, 2010 Nvidia Graphics Pvt. Ltd.
> + * Copyright 2007 Wolfson Microelectronics PLC.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +
> +#include <sound/core.h>
> +#include <sound/jack.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +
> +#include "../codecs/rt5677.h"
> +
> +#include "tegra_asoc_utils.h"
> +
> +#define DRV_NAME "tegra-snd-rt5677"
> +
> +struct tegra_rt5677 {
> +       struct tegra_asoc_utils_data util_data;
> +       int gpio_hp_det;
> +       int gpio_hp_en;
> +       int gpio_mic_present;
> +       int gpio_dmic_clk_en;
> +};
> +
> +static int tegra_rt5677_asoc_hw_params(struct snd_pcm_substream *substream,
> +                                       struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +       struct snd_soc_card *card = rtd->card;
> +       struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
> +       int srate, mclk, err;
> +
> +       srate = params_rate(params);
> +       mclk = 256 * srate;
> +
> +       err = tegra_asoc_utils_set_rate(&machine->util_data, srate, mclk);
> +       if (err < 0) {
> +               dev_err(card->dev, "Can't configure clocks\n");
> +               return err;
> +       }
> +
> +       err = snd_soc_dai_set_sysclk(codec_dai, RT5677_SCLK_S_MCLK, mclk,
> +                                       SND_SOC_CLOCK_IN);
> +       if (err < 0) {
> +               dev_err(card->dev, "codec_dai clock not set\n");
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tegra_rt5677_event_hp(struct snd_soc_dapm_widget *w,
> +                       struct snd_kcontrol *k, int event)
> +{
> +       struct snd_soc_dapm_context *dapm = w->dapm;
> +       struct snd_soc_card *card = dapm->card;
> +       struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
> +
> +       if (!gpio_is_valid(machine->gpio_hp_en))
> +               return 0;
> +
> +       gpio_set_value_cansleep(machine->gpio_hp_en,
> +               SND_SOC_DAPM_EVENT_ON(event));
> +
> +       return 0;
> +}
> +
> +static struct snd_soc_ops tegra_rt5677_ops = {
> +       .hw_params = tegra_rt5677_asoc_hw_params,
> +};
> +
> +static struct snd_soc_jack tegra_rt5677_hp_jack;
> +
> +static struct snd_soc_jack_pin tegra_rt5677_hp_jack_pins = {
> +       .pin = "Headphone",
> +       .mask = SND_JACK_HEADPHONE,
> +};
> +static struct snd_soc_jack_gpio tegra_rt5677_hp_jack_gpio = {
> +       .name = "Headphone detection",
> +       .report = SND_JACK_HEADPHONE,
> +       .debounce_time = 150,
> +};
> +
> +static struct snd_soc_jack tegra_rt5677_mic_jack;
> +
> +static struct snd_soc_jack_pin tegra_rt5677_mic_jack_pins = {
> +       .pin = "Headset Mic",
> +       .mask = SND_JACK_MICROPHONE,
> +};
> +
> +static struct snd_soc_jack_gpio tegra_rt5677_mic_jack_gpio = {
> +       .name = "Headset Mic detection",
> +       .report = SND_JACK_MICROPHONE,
> +       .debounce_time = 150,
> +       .invert = 1
> +};
> +
> +static const struct snd_soc_dapm_widget tegra_rt5677_dapm_widgets[] = {
> +       SND_SOC_DAPM_SPK("Speaker", NULL),
> +       SND_SOC_DAPM_HP("Headphone", tegra_rt5677_event_hp),
> +       SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +       SND_SOC_DAPM_MIC("Internal Mic 1", NULL),
> +       SND_SOC_DAPM_MIC("Internal Mic 2", NULL),
> +};
> +
> +static const struct snd_kcontrol_new tegra_rt5677_controls[] = {
> +       SOC_DAPM_PIN_SWITCH("Speaker"),
> +       SOC_DAPM_PIN_SWITCH("Headphone"),
> +       SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +       SOC_DAPM_PIN_SWITCH("Internal Mic 1"),
> +       SOC_DAPM_PIN_SWITCH("Internal Mic 2"),
> +};
> +
> +static int tegra_rt5677_asoc_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct snd_soc_dapm_context *dapm = &codec->dapm;
> +       struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +       snd_soc_jack_new(codec, "Headphone Jack", SND_JACK_HEADPHONE,
> +                       &tegra_rt5677_hp_jack);
> +       snd_soc_jack_add_pins(&tegra_rt5677_hp_jack, 1,
> +                       &tegra_rt5677_hp_jack_pins);
> +
> +       if (gpio_is_valid(machine->gpio_hp_det)) {
> +               tegra_rt5677_hp_jack_gpio.gpio = machine->gpio_hp_det;
> +               snd_soc_jack_add_gpios(&tegra_rt5677_hp_jack, 1,
> +                               &tegra_rt5677_hp_jack_gpio);
> +       }
> +
> +
> +       snd_soc_jack_new(codec, "Mic Jack", SND_JACK_MICROPHONE,
> +                       &tegra_rt5677_mic_jack);
> +       snd_soc_jack_add_pins(&tegra_rt5677_mic_jack, 1,
> +                       &tegra_rt5677_mic_jack_pins);
> +
> +       if (gpio_is_valid(machine->gpio_mic_present)) {
> +               tegra_rt5677_mic_jack_gpio.gpio = machine->gpio_mic_present;
> +               snd_soc_jack_add_gpios(&tegra_rt5677_mic_jack, 1,
> +                               &tegra_rt5677_mic_jack_gpio);
> +       }
> +
> +       snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
> +
> +       return 0;
> +}
> +
> +static int tegra_rt5677_card_remove(struct snd_soc_card *card)
> +{
> +       struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
> +
> +       if (gpio_is_valid(machine->gpio_hp_det)) {
> +               snd_soc_jack_free_gpios(&tegra_rt5677_hp_jack, 1,
> +                               &tegra_rt5677_hp_jack_gpio);
> +       }
> +
> +       if (gpio_is_valid(machine->gpio_mic_present)) {
> +               snd_soc_jack_free_gpios(&tegra_rt5677_mic_jack, 1,
> +                               &tegra_rt5677_mic_jack_gpio);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct snd_soc_dai_link tegra_rt5677_dai = {
> +       .name = "RT5677",
> +       .stream_name = "RT5677 PCM",
> +       .codec_dai_name = "rt5677-aif1",
> +       .init = tegra_rt5677_asoc_init,
> +       .ops = &tegra_rt5677_ops,
> +       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +                       SND_SOC_DAIFMT_CBS_CFS,
> +};
> +
> +static struct snd_soc_card snd_soc_tegra_rt5677 = {
> +       .name = "tegra-rt5677",
> +       .owner = THIS_MODULE,
> +       .remove = tegra_rt5677_card_remove,
> +       .dai_link = &tegra_rt5677_dai,
> +       .num_links = 1,
> +       .controls = tegra_rt5677_controls,
> +       .num_controls = ARRAY_SIZE(tegra_rt5677_controls),
> +       .dapm_widgets = tegra_rt5677_dapm_widgets,
> +       .num_dapm_widgets = ARRAY_SIZE(tegra_rt5677_dapm_widgets),
> +       .fully_routed = true,
> +};
> +
> +static int tegra_rt5677_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct snd_soc_card *card = &snd_soc_tegra_rt5677;
> +       struct tegra_rt5677 *machine;
> +       int ret;
> +
> +#if defined(CONFIG_MODULES) && defined(MODULE)
> +       request_module("snd_soc_tegra30_i2s");
> +#endif

What do you think about the code above?

Basically we need to tell kernel that tegra_rt5677 module should be
loaded only after tegra_i2s module. Otherwise kernel fails to load
tegra_rt5677 with error:

 [   32.664123] tegra-snd-rt5677 sound.8: ASoC: CPU DAI (null) not registered
 [   32.671110] tegra-snd-rt5677 sound.8: snd_soc_register_card failed (-517)
 [   32.678702] platform sound.8: Driver tegra-snd-rt5677 requests
probe deferral


Normally depmod scans module function usage and builds dependency
graph, but in this case we do not use any functions from i2s module
and thus kernel does not know about this dependency.


> +       machine = devm_kzalloc(&pdev->dev,
> +                       sizeof(struct tegra_rt5677), GFP_KERNEL);
> +       if (!machine)
> +               return -ENOMEM;
> +
> +       card->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, card);
> +       snd_soc_card_set_drvdata(card, machine);
> +
> +       machine->gpio_hp_det = of_get_named_gpio(np, "nvidia,hp-det-gpios", 0);
> +       if (machine->gpio_hp_det == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
> +       machine->gpio_mic_present = of_get_named_gpio(np,
> +                       "nvidia,mic-present-gpios", 0);
> +       if (machine->gpio_mic_present == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
> +       machine->gpio_hp_en = of_get_named_gpio(np, "nvidia,hp-en-gpios", 0);
> +       if (machine->gpio_hp_en == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +       if (gpio_is_valid(machine->gpio_hp_en)) {
> +               ret = devm_gpio_request_one(&pdev->dev, machine->gpio_hp_en,
> +                               GPIOF_OUT_INIT_LOW, "hp_en");
> +               if (ret) {
> +                       dev_err(card->dev, "cannot get hp_en gpio\n");
> +                       return ret;
> +               }
> +       }
> +
> +       machine->gpio_dmic_clk_en = of_get_named_gpio(np,
> +               "nvidia,dmic-clk-en-gpios", 0);
> +       if (machine->gpio_dmic_clk_en == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +       if (gpio_is_valid(machine->gpio_dmic_clk_en)) {
> +               ret = devm_gpio_request_one(&pdev->dev,
> +                               machine->gpio_dmic_clk_en,
> +                               GPIOF_OUT_INIT_HIGH, "dmic_clk_en");
> +               if (ret) {
> +                       dev_err(card->dev, "cannot get dmic_clk_en gpio\n");
> +                       return ret;
> +               }
> +       }
> +
> +       ret = snd_soc_of_parse_card_name(card, "nvidia,model");
> +       if (ret)
> +               goto err;
> +
> +       ret = snd_soc_of_parse_audio_routing(card, "nvidia,audio-routing");
> +       if (ret)
> +               goto err;
> +
> +       tegra_rt5677_dai.codec_of_node = of_parse_phandle(np,
> +                       "nvidia,audio-codec", 0);
> +       if (!tegra_rt5677_dai.codec_of_node) {
> +               dev_err(&pdev->dev,
> +                       "Property 'nvidia,audio-codec' missing or invalid\n");
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       tegra_rt5677_dai.cpu_of_node = of_parse_phandle(np,
> +                       "nvidia,i2s-controller", 0);
> +       if (!tegra_rt5677_dai.cpu_of_node) {
> +               dev_err(&pdev->dev,
> +                       "Property 'nvidia,i2s-controller' missing or invalid\n");
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +       tegra_rt5677_dai.platform_of_node = tegra_rt5677_dai.cpu_of_node;
> +
> +       ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
> +       if (ret)
> +               goto err;
> +
> +       ret = snd_soc_register_card(card);
> +       if (ret) {
> +               dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
> +                       ret);
> +               goto err_fini_utils;
> +       }
> +
> +       return 0;
> +
> +err_fini_utils:
> +       tegra_asoc_utils_fini(&machine->util_data);
> +err:
> +       return ret;
> +}
> +
> +static int tegra_rt5677_remove(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card = platform_get_drvdata(pdev);
> +       struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(card);
> +
> +       snd_soc_unregister_card(card);
> +
> +       tegra_asoc_utils_fini(&machine->util_data);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id tegra_rt5677_of_match[] = {
> +       { .compatible = "nvidia,tegra-audio-rt5677", },
> +       {},
> +};
> +
> +static struct platform_driver tegra_rt5677_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +               .owner = THIS_MODULE,
> +               .pm = &snd_soc_pm_ops,
> +               .of_match_table = tegra_rt5677_of_match,
> +       },
> +       .probe = tegra_rt5677_probe,
> +       .remove = tegra_rt5677_remove,
> +};
> +module_platform_driver(tegra_rt5677_driver);
> +
> +MODULE_AUTHOR("Anatol Pomozov <anatol@google.com>");
> +MODULE_DESCRIPTION("Tegra+RT5677 machine ASoC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_DEVICE_TABLE(of, tegra_rt5677_of_match);
> --
> 2.2.0.rc0.207.ga3a616c
>
