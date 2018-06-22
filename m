From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 1/3] ASoC: Add initial support for
 multiple CPU DAIs
Date: Fri, 22 Jun 2018 10:13:28 -0500
Message-ID: <dffba216-f4ff-4ec6-24f0-f9c7bbdf4b68@linux.intel.com>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-2-git-send-email-shreyas.nc@intel.com>
 <d6b2b5a1-a714-e72c-8012-52a40e4e9447@linux.intel.com>
 <20180622041437.GP3116@snc-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B5D4266D04
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 17:13:34 +0200 (CEST)
In-Reply-To: <20180622041437.GP3116@snc-desk>
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
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> +static int snd_soc_init_single_cpu_dai(struct snd_soc_card *card,
>>> +				   struct snd_soc_dai_link *dai_link)
>>> +{
>>> +	if (dai_link->cpu_name || dai_link->cpu_of_node ||
>>> +					dai_link->cpu_dai_name) {
>>> +		dai_link->num_cpu_dai = 1;
>>> +		dai_link->cpu_dai = devm_kzalloc(card->dev,
>>> +				sizeof(struct snd_soc_dai_link_component),
>>> +				GFP_KERNEL);
>>> +
>>> +		if (!dai_link->cpu_dai)
>>> +			return -ENOMEM;
>>> +
>>> +		dai_link->cpu_dai[0].name = dai_link->cpu_name;
>>> +		dai_link->cpu_dai[0].of_node = dai_link->cpu_of_node;
>>> +		dai_link->cpu_dai[0].dai_name = dai_link->cpu_dai_name;
>> Question: is cpu_dai[i].of_node defined for i>0 in the multi cpu_dai case?
>>
> 
> Yes, it should be defined.

I have limited understanding of how cpu_of_node would be handled and if 
there is any guidance for DT folks on how to deal with multiple cpu_dais.

> 
>>> @@ -1644,7 +1751,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>>   	unsigned int dai_fmt)
>>>   {
>>>   	struct snd_soc_dai **codec_dais = rtd->codec_dais;
>>> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>>> +	struct snd_soc_dai **cpu_dais = rtd->cpu_dais;
>>>   	unsigned int i;
>>>   	int ret;
>>> @@ -1659,35 +1766,44 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>>   		}
>>>   	}
>>> -	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
>> why was this comment removed?
>>
> 
> Looks like I messed up resolving ocnflicts while rebase
> 
>>>   	/* the component which has non_legacy_dai_naming is Codec */
>>> -	if (cpu_dai->component->driver->non_legacy_dai_naming) {
>> Not sure if the code refactoring below makes sense in a codec-codec link,
>> you probably wouldn't have multiple cpu_dais then, would you?
> 
> Yes, a valid point. You suggest to leave this piece of code as is ?

Not necessarily. I don't understand how the codec-codec and multi 
cpu_dais intersect, all I am asking for is a check if this change is 
needed or not.

>   
>>> -		unsigned int inv_dai_fmt;
>>> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
>>> +		struct snd_soc_dai *cpu_dai = cpu_dais[i];
>>> +		unsigned int inv_dai_fmt, temp_dai_fmt;
>>> -		inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
>>> -		switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>> -		case SND_SOC_DAIFMT_CBM_CFM:
>>> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
>>> -			break;
>>> -		case SND_SOC_DAIFMT_CBM_CFS:
>>> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
>>> -			break;
>>> -		case SND_SOC_DAIFMT_CBS_CFM:
>>> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
>>> -			break;
>>> -		case SND_SOC_DAIFMT_CBS_CFS:
>>> -			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>>> -			break;
>>> -		}
>>> +		temp_dai_fmt = dai_fmt;
>>> +		if (cpu_dai->component->driver->non_legacy_dai_naming) {
>>> -		dai_fmt = inv_dai_fmt;
>>> -	}
>>> +			inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
>>> -	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
>>> -	if (ret != 0 && ret != -ENOTSUPP) {
>>> -		dev_warn(cpu_dai->dev,
>>> -			 "ASoC: Failed to set DAI format: %d\n", ret);
>>> -		return ret;
>>> +			switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>>> +			case SND_SOC_DAIFMT_CBM_CFM:
>>> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
>>> +				break;
>>> +
>>> +			case SND_SOC_DAIFMT_CBM_CFS:
>>> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
>>> +				break;
>>> +
>>> +			case SND_SOC_DAIFMT_CBS_CFM:
>>> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
>>> +				break;
>>> +
>>> +			case SND_SOC_DAIFMT_CBS_CFS:
>>> +				inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>>> +				break;
>>> +
>>> +			}
>>> +
>>> +			temp_dai_fmt = inv_dai_fmt;
>>> +		}
>>> +
>>> +		ret = snd_soc_dai_set_fmt(cpu_dai, temp_dai_fmt);
>>> +		if (ret != 0 && ret != -ENOTSUPP) {
>>> +			dev_warn(cpu_dai->dev,
>>> +				"ASoC: Failed to set DAI format: %d\n", ret);
>>> +			return ret;
>>> +		}
>>>   	}
>>>   	
>>
> 
