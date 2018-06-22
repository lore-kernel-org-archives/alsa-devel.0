From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Thu, 21 Jun 2018 19:35:57 -0500
Message-ID: <d6b2b5a1-a714-e72c-8012-52a40e4e9447@linux.intel.com>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-2-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D37E267610
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 02:36:00 +0200 (CEST)
In-Reply-To: <1529492057-32627-2-git-send-email-shreyas.nc@intel.com>
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
To: Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, ckeepax@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org



>   	/* close any waiting streams */
> @@ -552,16 +565,21 @@ int snd_soc_suspend(struct device *dev)
>   	}
>   
>   	list_for_each_entry(rtd, &card->rtd_list, list) {
> -		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +		struct snd_soc_dai *cpu_dai;
>   
>   		if (rtd->dai_link->ignore_suspend)
>   			continue;
>   
> -		if (cpu_dai->driver->suspend && cpu_dai->driver->bus_control)
> -			cpu_dai->driver->suspend(cpu_dai);
> +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> +			cpu_dai = rtd->cpu_dais[i];
>   
> -		/* deactivate pins to sleep state */
> -		pinctrl_pm_select_sleep_state(cpu_dai->dev);
> +			if (cpu_dai->driver->suspend &&
> +					cpu_dai->driver->bus_control)
> +				cpu_dai->driver->suspend(cpu_dai);
> +
> +			/* deactivate pins to sleep state */
> +			pinctrl_pm_select_sleep_state(cpu_dai->dev);
> +		}
I am not sure I get the relationship between cpu_dai and pins. Is this 
always safe/ok to play with the pincrtl before all cpu_dais are suspended?
Or should you implement this with two loops, one to suspend and one to 
deactivate pins?
> @@ -845,35 +882,47 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
>   {
>   	struct snd_soc_pcm_runtime *rtd;
>   	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
> -	struct snd_soc_dai_link_component cpu_dai_component;
> +	struct snd_soc_dai_link_component *cpu_dai_component;
>   	struct snd_soc_component *component;
> -	struct snd_soc_dai **codec_dais;
> +	struct snd_soc_dai **codec_dais, **cpu_dais;
>   	struct device_node *platform_of_node;
>   	const char *platform_name;
>   	int i;
>   
>   	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
>   
> +	cpu_dai_component = dai_link->cpu_dai;
> +
>   	if (soc_is_dai_link_bound(card, dai_link)) {
>   		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
>   			dai_link->name);
>   		return 0;
>   	}
>   
> +	if (dai_link->dynamic && dai_link->num_cpu_dai > 1) {
> +		dev_err(card->dev, "ASoC: Multi CPU DAI not supported for FE");
> +		return -EINVAL;
> +	}
> +
>   	rtd = soc_new_pcm_runtime(card, dai_link);
>   	if (!rtd)
>   		return -ENOMEM;
>   
> -	cpu_dai_component.name = dai_link->cpu_name;
> -	cpu_dai_component.of_node = dai_link->cpu_of_node;
> -	cpu_dai_component.dai_name = dai_link->cpu_dai_name;

Have you checked if there are any side effects of using
cpu_dai_component = dai_link->cpu_dai;
instead of a local variable?

if you are not sure, it may be worth implementing as a separate patch 
first before introducing the multi-cpu part, at least to allow for git 
bisect to identify issues?
>   
> +static int snd_soc_init_single_cpu_dai(struct snd_soc_card *card,
> +				   struct snd_soc_dai_link *dai_link)
> +{
> +	if (dai_link->cpu_name || dai_link->cpu_of_node ||
> +					dai_link->cpu_dai_name) {
> +		dai_link->num_cpu_dai = 1;
> +		dai_link->cpu_dai = devm_kzalloc(card->dev,
> +				sizeof(struct snd_soc_dai_link_component),
> +				GFP_KERNEL);
> +
> +		if (!dai_link->cpu_dai)
> +			return -ENOMEM;
> +
> +		dai_link->cpu_dai[0].name = dai_link->cpu_name;
> +		dai_link->cpu_dai[0].of_node = dai_link->cpu_of_node;
> +		dai_link->cpu_dai[0].dai_name = dai_link->cpu_dai_name;
Question: is cpu_dai[i].of_node defined for i>0 in the multi cpu_dai case?

> @@ -1644,7 +1751,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>   	unsigned int dai_fmt)
>   {
>   	struct snd_soc_dai **codec_dais = rtd->codec_dais;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai **cpu_dais = rtd->cpu_dais;
>   	unsigned int i;
>   	int ret;
>   
> @@ -1659,35 +1766,44 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>   		}
>   	}
>   
> -	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
why was this comment removed?

>   	/* the component which has non_legacy_dai_naming is Codec */
> -	if (cpu_dai->component->driver->non_legacy_dai_naming) {
Not sure if the code refactoring below makes sense in a codec-codec 
link, you probably wouldn't have multiple cpu_dais then, would you?
> -		unsigned int inv_dai_fmt;
> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> +		struct snd_soc_dai *cpu_dai = cpu_dais[i];
> +		unsigned int inv_dai_fmt, temp_dai_fmt;
>   
> -		inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
> -		switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> -		case SND_SOC_DAIFMT_CBM_CFM:
> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
> -			break;
> -		case SND_SOC_DAIFMT_CBM_CFS:
> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
> -			break;
> -		case SND_SOC_DAIFMT_CBS_CFM:
> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
> -			break;
> -		case SND_SOC_DAIFMT_CBS_CFS:
> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> -			break;
> -		}
> +		temp_dai_fmt = dai_fmt;
> +		if (cpu_dai->component->driver->non_legacy_dai_naming) {
>   
> -		dai_fmt = inv_dai_fmt;
> -	}
> +			inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
>   
> -	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
> -	if (ret != 0 && ret != -ENOTSUPP) {
> -		dev_warn(cpu_dai->dev,
> -			 "ASoC: Failed to set DAI format: %d\n", ret);
> -		return ret;
> +			switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +			case SND_SOC_DAIFMT_CBM_CFM:
> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
> +				break;
> +
> +			case SND_SOC_DAIFMT_CBM_CFS:
> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
> +				break;
> +
> +			case SND_SOC_DAIFMT_CBS_CFM:
> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
> +				break;
> +
> +			case SND_SOC_DAIFMT_CBS_CFS:
> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> +				break;
> +
> +			}
> +
> +			temp_dai_fmt = inv_dai_fmt;
> +		}
> +
> +		ret = snd_soc_dai_set_fmt(cpu_dai, temp_dai_fmt);
> +		if (ret != 0 && ret != -ENOTSUPP) {
> +			dev_warn(cpu_dai->dev,
> +				"ASoC: Failed to set DAI format: %d\n", ret);
> +			return ret;
> +		}
>   	}
>   
>   	
