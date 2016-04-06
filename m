From: Han Lu <han.lu@linux.intel.com>
Subject: Re: [PATCH V6 1/2] ASoC: core: add API for registering
 and cleaning up DMI card names
Date: Wed, 6 Apr 2016 14:27:32 +0800
Message-ID: <5704AC54.7080607@linux.intel.com>
References: <cover.1459917632.git.han.lu@intel.com>
 <6287b9f5fe030cfd444e75abcdeab4df87f8be7a.1459917632.git.han.lu@intel.com>
 <5704A83F.6070900@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4513E26506E
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 08:26:47 +0200 (CEST)
In-Reply-To: <5704A83F.6070900@sakamocchi.jp>
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

Hi,

On 04/06/2016 02:10 PM, Takashi Sakamoto wrote:
> Hi,
>
> On Apr 6 2016 13:43, han.lu@intel.com wrote:
>> From: "Lu, Han" <han.lu@intel.com>
>>
>> Add core API for registering and cleaning up DMI card names, so user
>> space utils such as PA and UCM can distinguish various products.
>> Previously on ASoC, the card short name, driver name and long name are
>> all the same as the machine driver name.
>> The patch adds more board information:
>>    card driver name --->  machine driver name
>>    card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
>>    card long name and
>>    card component   --->  short name;driver name;(DMI_SYS_VENDOR,
>>                           optional);(the firmware name, optional)
>>
>> Signed-off-by: Lu, Han <han.lu@intel.com>
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 02b4a21..911d09e 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -486,6 +486,9 @@ void snd_soc_runtime_deactivate(struct 
>> snd_soc_pcm_runtime *rtd, int stream);
>>   int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>       unsigned int dai_fmt);
>>
>> +int snd_soc_set_card_names(struct snd_soc_card *card, const char 
>> *firmware);
>> +void snd_soc_cleanup_card_names(struct snd_soc_card *card);
>> +
>>   /* Utility functions to get clock rates from various things */
>>   int snd_soc_calc_frame_size(int sample_size, int channels, int 
>> tdm_slots);
>>   int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index d2e62b15..0cfffff 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/ctype.h>
>>   #include <linux/slab.h>
>>   #include <linux/of.h>
>> +#include <linux/dmi.h>
>>   #include <sound/core.h>
>>   #include <sound/jack.h>
>>   #include <sound/pcm.h>
>> @@ -1828,6 +1829,92 @@ int snd_soc_runtime_set_dai_fmt(struct 
>> snd_soc_pcm_runtime *rtd,
>>   }
>>   EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>>
>> +/**
>> + * snd_soc_set_card_names() - Register DMI names to card
>> + * @card: The card to register DMI names
>> + * @board: DMI_BOARD_NAME or DMI_PRODUCT_NAME
>> + * @vendor: DMI_SYS_VENDOR, optional
>> + * @firmware: The firmware name, optional
>> + *
>> + * This function registers DMI names to card for the userspace to 
>> distinguish
>> + * different boards/products:
>> + *   card driver name --->  machine driver name
>> + *   card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
>> + *   card long name and
>> + *   card component   --->  short name;driver name;(DMI_SYS_VENDOR, 
>> optional)
>> + *                          ;(firmware name, optional)
>> + *
>> + * Returns 0 on success, otherwise a negative error code.
>> + */
>> +int snd_soc_set_card_names(struct snd_soc_card *card, const char 
>> *firmware)
>> +{
>> +    int ret = 0;
>> +    size_t buf_size, name_size;
>> +    const char *board, *vendor;
>> +    char *longname;
>> +
>> +    board = dmi_get_system_info(DMI_BOARD_NAME);
>> +    if (!board)
>> +        board = dmi_get_system_info(DMI_PRODUCT_NAME);
>> +    if (!board) {
>> +        dev_err(card->dev, "ASoC: the board/product name is empty!\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    vendor = dmi_get_system_info(DMI_SYS_VENDOR);
>> +
>> +    /* card driver name */
>> +    card->driver_name = card->name;
>> +
>> +    /* card short name */
>> +    card->name = board;
>> +
>> +    /* card long name */
>> +    buf_size = sizeof(card->snd_card->longname);
>> +    name_size = strlen(card->name) + strlen(card->driver_name) + 4;
>> +    if (vendor)
>> +        name_size += strlen(vendor);
>> +    if (firmware)
>> +        name_size += strlen(firmware);
>> +    if (name_size > buf_size)
>> +        return -ENOMEM;
>> +
>> +    longname = kmalloc(buf_size, GFP_KERNEL);
>> +    if (!longname)
>> +        return -ENOMEM;
>> +    snprintf(longname, buf_size, "%s;%s;",
>> +            card->name, card->driver_name);
>> +    if (vendor)
>> +        strlcat(longname, vendor, buf_size);
>> +    strlcat(longname, ";", buf_size);
>> +    if (firmware)
>> +        strlcat(longname, firmware, buf_size);
>> +
>> +    card->long_name = longname;
>> +
>> +    /* card component */
>> +    if (sizeof(card->snd_card->components) < name_size
>> +            + strlen(card->snd_card->components))
>> +        return -ENOMEM;
>> +
>> +    ret = snd_component_add(card->snd_card, card->long_name);
>> +
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_set_card_names);
>> +
>> +/**
>> + * snd_soc_cleanup_card_names() - cleanup registered DMI names
>> + * @card: The card to cleanup
>> + *
>> + * This function cleanup the registered DMI names from card
>> + */
>> +void snd_soc_cleanup_card_names(struct snd_soc_card *card)
>> +{
>> +    kfree(card->long_name);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_cleanup_card_names);
>> +
>
> Hm. How about do it in a path to release devres? In short,
>
> When registering card instance, devm_card_release is assigned to the 
> resource.
> devm_snd_soc_register_card()
> ->devres_alloc(devm_card_release, sizeof(*ptr), GFP_KERNEL);
>
> When releasing the resource:
> (sound/soc/soc-devres.c)
> ->devm_card_release()
>   (sound/soc/soc-core.c)
>   ->snd_soc_unregister_card()
>     ->kfree(card->long_name) (yours)
>
> I just have a quick glance. It's better for you to confirm it in your 
> case.
My concern is that driver developers may set card->long_name without calling
snd_soc_set_card_names(), for example, in card definition: (not sure if 
it's rare)
   static struct snd_soc_card XXX_card = {
       .long_name = "XXXX",
       ...
   }
I cannot kfree card->long_name in this case. So I added two APIs and 
they are supposed
to be used in pair.

BR,
Han

>
>
> Regards
>
> Takashi Sakamoto
>
>>   static int snd_soc_instantiate_card(struct snd_soc_card *card)
>>   {
>>       struct snd_soc_codec *codec;
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
