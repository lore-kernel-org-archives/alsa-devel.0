From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Tue, 19 Jun 2018 09:46:26 +0100
Message-ID: <f3f677bf-d0b5-baab-cf7c-4a7d7588259b@linaro.org>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id CB5E7266D4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 10:46:28 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so20426320wmg.2
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 01:46:28 -0700 (PDT)
In-Reply-To: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks Rohit for the patch!

On 18/06/18 12:16, Rohit kumar wrote:
> This patch adds sdm845 audio machine driver support.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   .../devicetree/bindings/sound/qcom,sdm845.txt      |  87 ++++
>   sound/soc/qcom/Kconfig                             |   9 +
>   sound/soc/qcom/Makefile                            |   2 +
>   sound/soc/qcom/sdm845.c                            | 539 +++++++++++++++++++++
>   4 files changed, 637 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

Split the bindings into a separate patch!

>   create mode 100644 sound/soc/qcom/sdm845.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> new file mode 100644
> index 0000000..fc0e98c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> @@ -0,0 +1,87 @@
> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> +
> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,sdm845-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.
> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board.
> +
> +- cdc-vdd-supply:
> +	Usage: Optional
> +	Value type: <phandle>
> +	Definition: phandle of regulator supply required for codec vdd.
> +
> += dailinks
> +Each subnode of sndcard represents either a dailink, and subnodes of each
> +dailinks would be cpu/codec/platform dais.
> +
> +- link-name:
> +	Usage: required
> +	Value type: <string>
> +	Definition: User friendly name for dai link
> +
> += CPU, PLATFORM, CODEC dais subnodes
> +- cpu:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: cpu dai sub-node
> +
> +- codec:
> +	Usage: required
> +	Value type: <subnode>
> +	Definition: codec dai sub-node
> +
> +- platform:
> +	Usage: opional

Optional
> +	Value type: <subnode>
> +	Definition: platform dai sub-node
> +
> +- sound-dai:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
> +
> +Example:
> +
> +audio {
> +	compatible = "qcom,sdm845-sndcard";
> +	qcom,model = "sdm845-snd-card";
> +	pinctrl-names = "pri_active", "pri_sleep";
> +	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
> +	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
> +
> +	qcom,audio-routing = "PRI_MI2S_RX Audio Mixer", "Pri-mi2s-gpio";
> +
> +	cdc-vdd-supply = <&pm8998_l14>;
> +
> +	fe@1 {
Lets not use fe or be reference here, its just a link.

> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +		platform {
> +			sound-dai = <&q6asmdai>;
> +		};
asmdai has sound-cell specifier as 1, so this will dtc will throw 
warning for this.

have a look at how 8996 is done.

> +	};
> +
> +	be@1 {
> +		link-name = "PRI MI2S Playback";
> +		cpu {
> +			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +};
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 87838fa..09de50d 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -90,3 +90,12 @@ config SND_SOC_MSM8996
>             Support for Qualcomm Technologies LPASS audio block in
>             APQ8096 SoC-based systems.
>             Say Y if you want to use audio device on this SoCs
> +
> +config SND_SOC_SDM845
> +	tristate "SoC Machine driver for SDM845 boards"
> +	depends on QCOM_APR
> +	select SND_SOC_QDSP6
> +	help
> +	  To add support for audio on Qualcomm Technologies Inc.
> +	  SDM845 SoC-based systems.
> +          Say Y if you want to use audio device on this SoCs
> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
> index 206945b..ac9609e 100644
> --- a/sound/soc/qcom/Makefile
> +++ b/sound/soc/qcom/Makefile
> @@ -14,10 +14,12 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
>   snd-soc-storm-objs := storm.o
>   snd-soc-apq8016-sbc-objs := apq8016_sbc.o
>   snd-soc-apq8096-objs := apq8096.o
> +snd-soc-sdm845-objs := sdm845.o
>   
>   obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
>   obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
>   obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
> ++obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o

?? looks like typo here.

>   
>   #DSP lib
>   obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> new file mode 100644
> index 0000000..70d2611
> --- /dev/null
> +++ b/sound/soc/qcom/sdm845.c
> @@ -0,0 +1,539 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/component.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/atomic.h>

> +#include <linux/of_device.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include <linux/soc/qcom/apr.h>
> +#include "qdsp6/q6afe.h"
> +
> +#define DEFAULT_SAMPLE_RATE_48K		48000
> +#define DEFAULT_MCLK_RATE		24576000
> +#define DEFAULT_BCLK_RATE		1536000
> +
> +struct sdm845_snd_data {
> +	struct snd_soc_card *card;
> +	struct regulator *vdd_supply;
> +	struct snd_soc_dai_link dai_link[];
> +};
> +
> +static struct mutex pri_mi2s_res_lock;
> +static struct mutex quat_tdm_res_lock;
> +static atomic_t pri_mi2s_clk_count;
> +static atomic_t quat_tdm_clk_count;
> +
> +static unsigned int tdm_slot_offset[8] = {0, 4, 8, 12, 16, 20, 24, 28};
> +static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int ret = 0;
> +
> +	switch (cpu_dai->id) {
> +	case QUATERNARY_TDM_RX_0:
> +	case QUATERNARY_TDM_TX_0:
> +		ret = sdm845_tdm_snd_hw_params(substream, params);
> +		break;
> +	default:
> +		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int sdm845_snd_startup(struct snd_pcm_substream *substream)
> +{
> +	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +
> +	pr_debug("%s: dai_id: 0x%x\n", __func__, cpu_dai->id);
> +	switch (cpu_dai->id) {
> +	case PRIMARY_MI2S_RX:
> +	case PRIMARY_MI2S_TX:
> +		mutex_lock(&pri_mi2s_res_lock);

Mutex and atomic variables looks redundant here.
Can you explain why do you need both?
> +		if (atomic_inc_return(&pri_mi2s_clk_count) == 1) { > +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_MCLK_1,
> +				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +		}
> +		mutex_unlock(&pri_mi2s_res_lock);
> +		snd_soc_dai_set_fmt(cpu_dai, fmt);
> +		break;
> +	case QUATERNARY_TDM_RX_0:
> +	case QUATERNARY_TDM_TX_0:
> +		mutex_lock(&quat_tdm_res_lock);
> +		if (atomic_inc_return(&quat_tdm_clk_count) == 1) {
> +			snd_soc_dai_set_sysclk(cpu_dai,
> +				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
> +				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
> +		}
> +		mutex_unlock(&quat_tdm_res_lock);
> +		break;
> +	default:
> +		pr_err("%s: invalid dai id 0x%x\n", __func__, cpu_dai->id);
> +		break;
> +	}
> +	return 0;
> +}
> +

...
> +
> +static int sdm845_sbc_parse_of(struct snd_soc_card *card)
> +{
> +	struct device *dev = card->dev;
> +	struct snd_soc_dai_link *link;
> +	struct device_node *np, *codec, *platform, *cpu, *node;
> +	int ret, num_links;
> +	struct sdm845_snd_data *data;
> +
> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	dev_info(dev, "Found %d child audio dai links..\n", num_links);

Looks unnessary!

> +	/* Allocate the private data and the DAI link array */
> +	data = kzalloc(sizeof(*data) + sizeof(*link) * num_links,
> +			GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	card->dai_link = &data->dai_link[0];
> +	card->num_links = num_links;
> +	card->dapm_widgets = sdm845_widgets;
> +	card->num_dapm_widgets = ARRAY_SIZE(sdm845_widgets);
> +
> +	link = data->dai_link;
> +	data->card = card;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +
> +		if (!cpu) {
> +			dev_err(dev, "Can't find cpu DT node\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
> +		if (!link->cpu_of_node) {
> +			dev_err(card->dev, "error getting cpu phandle\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		link->platform_of_node = of_parse_phandle(platform,
> +				"sound-dai", 0);
> +		if (!link->platform_of_node) {
> +			dev_err(card->dev, "error getting platform phandle\n");
> +			ret = -EINVAL;
> +			goto fail;
> +		}
> +
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
> +			goto fail;
> +		}
> +
> +		if (codec) {
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "error getting codec dai name\n");
> +				goto fail;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_suspend = 1;
> +			link->ignore_pmdown_time = 1;
> +			link->ops = &sdm845_be_ops;
> +			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
> +		} else {
> +			link->dynamic = 1;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +		}
> +

You could optimize this code, have a look at apq8096.c which does 
exactly same thing.

> +		ret = of_property_read_string(np, "link-name", &link->name);
> +		if (ret) {
> +			dev_err(card->dev,
> +				"error getting codec dai_link name\n");
> +			goto fail;
> +		}
> +
> +		link->dpcm_playback = 1;
> +		link->dpcm_capture = 1;
> +		link->stream_name = link->name;
> +		link++;
> +	}
> +	dev_set_drvdata(dev, card);
> +	snd_soc_card_set_drvdata(card, data);
> +
> +	return ret;
> +fail:
> +	kfree(data);
> +	return ret;
> +}
...
> +
> +static void sdm845_unbind(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	mutex_destroy(&pri_mi2s_res_lock);
> +	mutex_destroy(&quat_tdm_res_lock);
> +	if (data->vdd_supply)
> +		regulator_put(data->vdd_supply);
> +	component_unbind_all(dev, card);
> +	snd_soc_unregister_card(card);
> +	kfree(data);
> +	kfree(card);
> +}
> +
> +static const struct component_master_ops sdm845_ops = {
> +	.bind = sdm845_bind,
> +	.unbind = sdm845_unbind,
> +};
> +
> +static int sdm845_runtime_resume(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
> +
> +	if (!data->vdd_supply) {
> +		dev_dbg(dev, "no supplies defined\n");
> +		return 0;
> +	}
> +
> +	if (regulator_enable(data->vdd_supply))
> +		dev_err(dev, "Enable regulator supply failed\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sdm845_snd_driver = {
> +	.probe = sdm845_snd_platform_probe,
> +	.remove = sdm845_snd_platform_remove,
> +	.driver = {
> +		.name = "msm-snd-sdm845",
> +		.pm = &sdm845_pm_ops,
> +		.owner = THIS_MODULE,
not necessary!
> +		.of_match_table = of_match_ptr(sdm845_snd_device_id),
> +	},
> +};
> +module_platform_driver(sdm845_snd_driver);
> +
> +MODULE_DESCRIPTION("sdm845 ASoC Machine Driver");
> +MODULE_LICENSE("GPL v2");
> 
