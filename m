From: Vinod <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
Date: Thu, 21 Jun 2018 18:05:03 +0530
Message-ID: <20180621123503.GD27187@vkoul-mobl>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Rohit,

On 21-06-18, 16:23, Rohit kumar wrote:

> +static struct sdm845_snd_data *sdm845_sbc_parse_of(struct snd_soc_card *card)
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
> +		return ERR_PTR(ret);
> +	}
> +
> +	node = dev->of_node;
> +
> +	/* DAPM routes */
> +	if (of_property_read_bool(node, "qcom,audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(card,
> +					"qcom,audio-routing");
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	/* Populate links */
> +	num_links = of_get_child_count(node);
> +
> +	/* Allocate the private data and the DAI link array */
> +	data = kzalloc(sizeof(*data) + sizeof(*link) * num_links,
> +			GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	card->dai_link = &data->dai_link[0];
> +	card->num_links = num_links;
> +
> +	link = data->dai_link;
> +	data->card = card;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
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
> +		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
> +		if (ret) {
> +			dev_err(card->dev, "error getting cpu dai name\n");
> +			goto fail;
> +		}
> +
> +		platform = of_get_child_by_name(np, "platform");
> +		codec = of_get_child_by_name(np, "codec");
> +		if (codec && platform) {
> +			link->platform_of_node = of_parse_phandle(platform,
> +					"sound-dai", 0);
> +			if (!link->platform_of_node) {
> +				dev_err(card->dev, "error getting platform phandle\n");
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
> +			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
> +			if (ret < 0) {
> +				dev_err(card->dev, "error getting codec dai name\n");
> +				goto fail;
> +			}
> +			link->no_pcm = 1;
> +			link->ignore_pmdown_time = 1;
> +			link->ops = &sdm845_be_ops;
> +			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
> +		} else {
> +			link->platform_of_node = link->cpu_of_node;
> +			link->codec_dai_name = "snd-soc-dummy-dai";
> +			link->codec_name = "snd-soc-dummy";
> +			link->dynamic = 1;
> +		}
> +
> +		link->ignore_suspend = 1;
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
> +	return data;
> +fail:
> +	kfree(data);
> +	return ERR_PTR(ret);
> +}

this routine...

> +static int add_audio_components(struct device *dev,
> +				struct component_match **matchptr)
> +{
> +	struct device_node *np, *platform, *cpu, *node, *dai_node;
> +
> +	node = dev->of_node;
> +
> +	for_each_child_of_node(node, np) {
> +		cpu = of_get_child_by_name(np, "cpu");
> +		if (cpu) {
> +			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
> +			of_node_get(dai_node);
> +			component_match_add_release(dev, matchptr,
> +					sdm845_release_of,
> +					sdm845_compare_of,
> +					dai_node);
> +		}
> +
> +		platform = of_get_child_by_name(np, "platform");
> +		if (platform) {
> +			dai_node = of_parse_phandle(platform, "sound-dai", 0);
> +			component_match_add_release(dev, matchptr,
> +					sdm845_release_of,
> +					sdm845_compare_of,
> +					dai_node);
> +		}
> +	}
> +
> +	return 0;
> +}

And this one is generic DT parsing and seems quite similar to one in apq8096.c
Can we move these into a lib and use them instead of duplicating.

-- 
~Vinod
