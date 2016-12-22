From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: core: Add API to use DMI name in
 sound card long name
Date: Thu, 22 Dec 2016 11:07:45 +0800
Message-ID: <585B4381.20407@linux.intel.com>
References: <cover.1482324245.git.mengdong.lin@linux.intel.com>
 <748589b74f8f4a6fefe7e545c21a6db5e71a74e1.1482324245.git.mengdong.lin@linux.intel.com>
 <1482330431.2554.94.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A04E15@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BD9D26705E
 for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2016 04:05:04 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F881A04E15@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org



On 12/21/2016 11:46 PM, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
>> Sent: Wednesday, December 21, 2016 10:27 PM
>> To: mengdong.lin@linux.intel.com
>> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; tiwai@suse.de; Bossart,
>> Pierre-louis <pierre-louis.bossart@intel.com>; Koul, Vinod
>> <vinod.koul@intel.com>; Lin, Mengdong <mengdong.lin@intel.com>
>> Subject: Re: [PATCH 1/2] ASoC: core: Add API to use DMI name in sound card
>> long name
>>
>> On Wed, 2016-12-21 at 21:04 +0800, mengdong.lin@linux.intel.com wrote:
>>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>>
>>> Intel DSP platform drivers are used by many different devices but are
>>> difficult for userspace to differentiate. This patch adds an API to
>>> allow the DMI name to be used in the sound card long name, thereby
>>> helping userspace load the correct UCM configuration. Usually machine
>>> drivers uses their own name as the sound card name (short name), and
>>> leave the long name and driver name blank. This API will append the
>>> DMI info like vendor, product and board info, to the card name to make
>>> up the card long name. If the machine driver has already explicitly
>>> set the long name, this API will do nothing.
>>>
>>> This patch also allows for further differentiation as many devices
>>> that share the same DMI name i.e. Minnowboards, UP boards may be
>>> configured with different codecs or firmwares. The API supports
>>> flavoring the DMI name into the card longname to provide the extra
>>> differentiation required for these devices.
>>>
>>> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>>
>>> diff --git a/include/sound/soc.h b/include/sound/soc.h index
>>> 795e6c4..e4f1844 100644
>>> --- a/include/sound/soc.h
>>> +++ b/include/sound/soc.h
>>> @@ -497,6 +497,8 @@ void snd_soc_runtime_deactivate(struct
>>> snd_soc_pcm_runtime *rtd, int stream);  int
>> snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>>   	unsigned int dai_fmt);
>>>
>>> +int snd_soc_set_dmi_name(struct snd_soc_card *card, const char
>>> +*flavour);
>>> +
>>>   /* Utility functions to get clock rates from various things */  int
>>> snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>>> int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
>> @@
>>> -1094,6 +1096,8 @@ struct snd_soc_card {
>>>   	const char *name;
>>>   	const char *long_name;
>>>   	const char *driver_name;
>>> +	char dmi_longname[80];
>>> +
>>>   	struct device *dev;
>>>   	struct snd_card *snd_card;
>>>   	struct module *owner;
>>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c index
>>> aaab26a..8bcf241 100644
>>> --- a/sound/soc/soc-core.c
>>> +++ b/sound/soc/soc-core.c
>>> @@ -34,6 +34,7 @@
>>>   #include <linux/ctype.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/of.h>
>>> +#include <linux/dmi.h>
>>>   #include <sound/core.h>
>>>   #include <sound/jack.h>
>>>   #include <sound/pcm.h>
>>> @@ -1886,6 +1887,86 @@ int snd_soc_runtime_set_dai_fmt(struct
>>> snd_soc_pcm_runtime *rtd,  }
>>> EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>>>
>>> +/**
>>> + * snd_soc_set_dmi_name() - Register DMI names to card
>>> + * @card: The card to register DMI names
>>> + * @flavour: The flavour "differentiator" for the card amongst its peers.
>>> + *
>>> + * Intel DSP platform drivers are used by many different devices but
>>> +are
>>> + * difficult for userspace to differentiate, since machine drivers
>>> +ususally
>>> + * use their own name as the card name (short name) and leave the
>>> +card long
>>> + * name blank. This function will allow DMI info to be used in the
>>> +sound
>>> + * card long name, thereby helping userspace load the correct UCM
>>> +(Use Case
>>> + * Manager) configuration.
>>> + * Possible card long names may be:
>>> + * broadwell-rt286-Dell Inc.-XPS 13 9343-0310JH
>>> + * broadwell-rt286-Intel Corp.-Broadwell Client platform-Wilson Beach
>>> +SDS
>>> + * bytcr-rt5640-ASUSTeK COMPUTER INC.-T100TA-T100TA
>>> + * bytcr-rt5651-Circuitco-Minnowboard Max D0 PLATFORM-MinnowBoard
>> MAX
>>> + *
>>
>>
>> Lets keep it simpler, we dont need to prepend the driver name to the
>> longname as it's already available in driver_name.
>>
>> The purpose of the patch is to uniquely identify the machine, so we dont
>> need to provide or duplicate other information in the name.
>>
>> So longname should be "dmi-flavour" where dmi is product OR board (if
>> product is not available).
>>
>> Liam
>
> Hi Liam,
>
> Yes, there is some duplication. But may we keep this?
>
> It's because that if the card long name itself has all the information, the user space UCM code can just compare the configuration file names against the card long name, no need to involve the card name (driver name).
> In addition, I want to make the naming same as HD-Audio, their card long name is the card short name with some suffixes. Although HD-Audio does not use UCM now, but maybe in the future? So we can process ASoC and HD-Audio cards in the same way.
>
> Thanks
> Mengdong

Hi Liam,

I'll remove the driver name from the long name and keep the long name as 
"dmi-flavor" as you suggested. I found dmi info could be quite long and 
if we keep the duplicated info, we may not have enough room for the 
"flavor" field. user space can accept 80 characters at most.

I'll modify the UCM code.

Thanks
Mengdong
