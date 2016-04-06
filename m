From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH V5 1/2] ASoC: core: add API for registering
	DMI card names
Date: Wed, 6 Apr 2016 14:47:14 +0900
Message-ID: <5704A2E2.2050907@sakamocchi.jp>
References: <cover.1459825282.git.han.lu@intel.com>
 <e5fef19b244bc77ffb9bdbf97be747c0c7c90a82.1459825282.git.han.lu@intel.com>
 <57034F4D.7000508@sakamocchi.jp> <57048F2D.5020100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B9AD1265843
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 07:47:18 +0200 (CEST)
In-Reply-To: <57048F2D.5020100@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Han Lu <han.lu@linux.intel.com>, han.lu@intel.com, broonie@kernel.org, tiwai@suse.de, vinod.koul@intel.com, pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 6 2016 13:23, Han Lu wrote:
>
>
> On 04/05/2016 01:38 PM, Takashi Sakamoto wrote:
>> Hi,
>>
>> On Apr 5 2016 13:26, han.lu@intel.com wrote:
>>> From: "Lu, Han" <han.lu@intel.com>
>>>
>>> Add core API for registering DMI card names, so user space utils such
>>> as PA and UCM can distinguish various products.
>>> Previously on ASoC, the card short name, driver name and long name are
>>> all the same as the machine driver name.
>>> The patch adds more board information:
>>>    card driver name --->  machine driver name
>>>    card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
>>>    card long name and
>>>    card component   --->  short name;driver name;(DMI_SYS_VENDOR,
>>>                           optional);(the firmware name, optional)
>>>
>>> Signed-off-by: Lu, Han <han.lu@intel.com>
>>>
>>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>>> index 02b4a21..4e80444 100644
>>> --- a/include/sound/soc.h
>>> +++ b/include/sound/soc.h
>>> @@ -486,6 +486,9 @@ void snd_soc_runtime_deactivate(struct
>>> snd_soc_pcm_runtime *rtd, int stream);
>>>   int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
>>>       unsigned int dai_fmt);
>>>
>>> +int snd_soc_set_card_names(struct snd_soc_card *card, const char
>>> *board,
>>> +        const char *vendor, const char *firmware);
>>> +
>>>   /* Utility functions to get clock rates from various things */
>>>   int snd_soc_calc_frame_size(int sample_size, int channels, int
>>> tdm_slots);
>>>   int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
>>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>>> index d2e62b15..a06b9b9 100644
>>> --- a/sound/soc/soc-core.c
>>> +++ b/sound/soc/soc-core.c
>>> @@ -48,6 +48,9 @@
>>>
>>>   #define NAME_SIZE    32
>>>
>>> +#define LONGNAME_SIZE    80    /* size of longname[] in struct
>>> snd_card */
>>> +static char card_longname[LONGNAME_SIZE];
>>> +
>>
>> I'm not a developer for SoC sound interfaces or Skylake something,
>> however I wonder the reason to add fiile local variable for this
>> purpose. Could I request your intension about it?
>>
>> Here, I assume a platform with some sound intefaces (I don't know we
>> rarely have the situation or not). If several drivers are probed for
>> these interfaces, the 'snd_soc_set_card_names()' might cause a race
>> condition between the drivers against the local variable. However,
>> there's no usage of lock primitive.
>> Additionally, when probing processing finishes for the second driver,
>> the local variable changes its contents. Then, ALSA core returns the
>> renewed string as the component of the first driver. This is not good.
>>
>> If it's too rare that a platform with several interfaces, please
>> inform it to me.
> Thanks for reviewing.
> I allocated an array here just intending for drivers to store
> card->long_name, since I
> assumed (by mistake) that one platform has only one interface.
> I'll use dynamic allocate and cleanup instead.

For example, we can see Allwinner A31 has two interfaces for audio 
functionality. See clause '8.9. DIGITAL AUDIO INTERFACE' and '7.5.2. 
HDMI BLOCK DIAGRAM' in this user manual:

http://dl.linux-sunxi.org/A31/A3x_release_document/A31/IC/A31%20user%20manual%20V1.1%2020130630.pdf

The data for these interfaces is transferred by different DMA contexts, 
thus I can assume a different driver is developed for each interface. 
Depending on the driver implementations, your code might cause a bug for 
them.

(I'm not a developer for SoC interface, so have no detail about it, of 
cource.)


As another advice, when you add static variable to keep it in ELF .data 
section and the variable is just referred to by one function, it's 
better to constrain the scope of the variable by adding it inner the 
function. For example, in your case, this is better practice:

int snd_soc_set_card_names(struct snd_soc_card *card,
                            const char *board,
                            const char *vendor, const char *firmware)
{
     static char card_longname[LONGNAME_SIZE];
     ...

Please notice that callers are still under the race condition against 
the variable.


Regards

Takashi Sakamoto

> BR,
> Han
>>
>>>   #ifdef CONFIG_DEBUG_FS
>>>   struct dentry *snd_soc_debugfs_root;
>>>   EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
>>> @@ -1828,6 +1831,70 @@ int snd_soc_runtime_set_dai_fmt(struct
>>> snd_soc_pcm_runtime *rtd,
>>>   }
>>>   EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
>>>
>>> +/**
>>> + * snd_soc_set_card_names() - Register DMI names to card
>>> + * @card: The card to register DMI names
>>> + * @board: DMI_BOARD_NAME or DMI_PRODUCT_NAME
>>> + * @vendor: DMI_SYS_VENDOR, optional
>>> + * @firmware: The firmware name, optional
>>> + *
>>> + * This function registers DMI names to card for the userspace to
>>> distinguish
>>> + * different boards/products:
>>> + *   card driver name --->  machine driver name
>>> + *   card short name  --->  DMI_BOARD_NAME or DMI_PRODUCT_NAME
>>> + *   card long name and
>>> + *   card component   --->  short name;driver name;(DMI_SYS_VENDOR,
>>> optional)
>>> + *                          ;(firmware name, optional)
>>> + *
>>> + * Returns 0 on success, otherwise a negative error code.
>>> + */
>>> +int snd_soc_set_card_names(struct snd_soc_card *card, const char
>>> *board,
>>> +        const char *vendor, const char *firmware)
>>> +{
>>> +    int ret = 0;
>>> +    size_t name_size;
>>> +
>>> +    if (!board) {
>>> +        dev_err(card->dev, "ASoC: the board/product name is empty!\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    /* card driver name */
>>> +    card->driver_name = card->name;
>>> +
>>> +    /* card short name */
>>> +    card->name = board;
>>> +
>>> +    /* card long name */
>>> +    name_size = strlen(card->name) + strlen(card->driver_name) + 4;
>>> +    if (vendor)
>>> +        name_size += strlen(vendor);
>>> +    if (firmware)
>>> +        name_size += strlen(firmware);
>>> +    if (name_size > LONGNAME_SIZE)
>>> +        return -ENOMEM;
>>> +
>>> +    snprintf(card_longname, LONGNAME_SIZE, "%s;%s;",
>>> +            card->name, card->driver_name);
>>> +    if (vendor)
>>> +        strlcat(card_longname, vendor, LONGNAME_SIZE);
>>> +    strlcat(card_longname, ";", LONGNAME_SIZE);
>>> +    if (firmware)
>>> +        strlcat(card_longname, firmware, LONGNAME_SIZE);
>>> +
>>> +    card->long_name = card_longname;
>>> +
>>> +    /* card component */
>>> +    if (sizeof(card->snd_card->components) < name_size
>>> +            + strlen(card->snd_card->components))
>>> +        return -ENOMEM;
>>> +
>>> +    ret = snd_component_add(card->snd_card, card->long_name);
>>> +
>>> +    return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(snd_soc_set_card_names);
>>> +
>>>   static int snd_soc_instantiate_card(struct snd_soc_card *card)
>>>   {
>>>       struct snd_soc_codec *codec;
>>
>> Regards
>>
>>
>> Takashi Sakamoto
