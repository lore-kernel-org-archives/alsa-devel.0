From: Han Lu <han.lu@linux.intel.com>
Subject: Re: [PATCH V7 1/2] ASoC: core: add API for registering
 and cleaning up DMI card names
Date: Thu, 7 Apr 2016 17:43:20 +0800
Message-ID: <57062BB8.5070302@linux.intel.com>
References: <cover.1459926898.git.han.lu@intel.com>
 <61f4ce19dfebc462623ef95d959f49e98c09cd2a.1459926898.git.han.lu@intel.com>
 <5704DB51.4020303@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DC01C265158
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:42:23 +0200 (CEST)
In-Reply-To: <5704DB51.4020303@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, han.lu@intel.com, broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/06/2016 05:48 PM, Takashi Sakamoto wrote:
> Hi,
>
> On Apr 6 2016 16:29, han.lu@intel.com wrote:
>> From: "Lu, Han" <han.lu@intel.com>
>>
>> Add core API for registering and cleaning up DMI card names, so user
>> space utils such as PA and UCM can distinguish various products.
>> Previously on ASoC, the card short name, driver name and long name were
>> all the same as the machine driver name.
>> The patch adds more board information:
>>    card driver name     --->  machine driver name
>>    card short name      --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
>>    card long name and
>>    card component       --->  short name;driver name;(DMI_SYS_VENDOR,
>>                               optional);(the firmware name, optional)
>>
>> Signed-off-by: Lu, Han <han.lu@intel.com>
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 02b4a21..911d09e 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -486,6 +486,9 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
>>   int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>   	unsigned int dai_fmt);
>>   
>> +int snd_soc_set_card_names(struct snd_soc_card *card, const char *firmware);
>> +void snd_soc_cleanup_card_names(struct snd_soc_card *card);
>> +
>>   /* Utility functions to get clock rates from various things */
>>   int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
>>   int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index d2e62b15..c1f3520 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> (omit)
>> +/**
>> + * snd_soc_cleanup_card_names() - cleanup registered DMI names
>> + * @card: The card to cleanup
>> + *
>> + * This function cleanup the registered DMI names from card
>> + */
>> +void snd_soc_cleanup_card_names(struct snd_soc_card *card)
>> +{
>> +	kfree(card->long_name);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_cleanup_card_names);
>> +
> In linux kernel development, such a function with a little statements
> tends to be 'static inline function' defined in a header, instead of
> maintaining more symbols. I think some APIs of Linux workqueue are good
> examples to you. See 'include/linux/workqueue.h'.

Thanks. Since we need to pass the string (firmware name) from machine
driver to core anyway, I guess one API is a must, but the cleanup API may
not necessary if there's no allocation. I'll rethink of it.

BR,
Han
>
>
> Regards
>
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
