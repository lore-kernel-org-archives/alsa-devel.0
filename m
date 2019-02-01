From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] ASoC: core: don't increase
 component module refcount unconditionally
Date: Fri, 1 Feb 2019 12:36:26 -0600
Message-ID: <a0e7bb9f-36a0-91a1-7b90-84a4c82cb54f@linux.intel.com>
References: <20190201172224.14549-1-pierre-louis.bossart@linux.intel.com>
 <20190201172224.14549-2-pierre-louis.bossart@linux.intel.com>
 <20190201181204.GA4296@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FE94267463
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 19:36:28 +0100 (CET)
In-Reply-To: <20190201181204.GA4296@vkoul-mobl>
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
To: Vinod Koul <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


On 2/1/19 12:12 PM, Vinod Koul wrote:
> On 01-02-19, 11:22, Pierre-Louis Bossart wrote:
>> The ASoC core has for the longest time increased the module reference
>> counts, even before the transition to the component model. This is
>> probably fine on most platforms, but it introduces a deadlock case on
>> Intel devices with the Skylake and SOF drivers which cannot be removed
>> due to their reference counts being modified by the core.
>>
>> In these 2 cases, the PCI or ACPI driver .probe creates a platform
>> device to let the machine driver .probe register the audio
>> card. Conversely the PCI or ACPI driver .remove will unregister the
>> platform device which results in the card being removed by the machine
>> driver .remove.
>>
>> With ascii art, this can be represented as
>>
>> modprobe
>> snd_soc_skl/
>> soc-pci-dev/sof-acpci-dev  ----------> pci/acpi probe
>>         ^                                    |
>>         |                     ---------------|
>>         |                    |               |
>>         |                    V               V
>>      increase            register        register machine
>>      refcount            component       platform_device
>>         ^                                    |
>>         |                                    |
>>         |                                    V
>>      component <----   register card  <---- probe
>>      probe
>>
>> The issue is that by playing with the component's module reference
>> counts during the card registration, it's no longer possible to remove
>> the module which controls the component. This can be shown, e.g. with
>> the following error:
>>
>> root@plb-XPS-13-9350:~# lsmod | grep snd_soc_skl
>> snd_soc_skl           110592  1
>>
>> root@plb-XPS-13-9350:~# rmmod snd_soc_skl
>> rmmod: ERROR: Module snd_soc_skl is in use
> Yup, that would be correct, the inuse is due to the fact the sound card
> is up and someone needs to unload the sound card to remove the
> reference.
>
> That can be done by doing the rmmod of machine driver first and IIRC
> that would remove the sound card and drop the reference and then
> snd_soc_skl can be unloaded.

It's a hack.

This doesn't follow the parent/child model and has issues with the 
topology cleanups, not to mention that you have a PCI/ACPI module which 
is completely crippled if you try things like suspend-resume.

In addition, this prevents you from testing the .remove path where you 
unregister the plaform_device. In other words you have no clean way of 
testing if your allocations/releases are correct from the PCI/ACPI level 
all the way to the component probe/free.

>
> Now one can argue that is not required, but I feel that is correct for
> core to hold references of modules the card is tied up to :)
>
>> Increasing the reference count during the component probe is not
>> useful. If the PCI/ACPI module is removed, the card will be removed
>> anyway.
>>
>> To avoid breaking existing platforms and allowing Intel platforms to
>> safely deal with module load/unload cases, this patch introduces a
>> flag which needs to be set during the component initialization. This
>> is a strictly opt-in capability that should only be used when the
>> handling of the component module does not require a reference count
>> increase to prevent removal during use.
>>
>> Note that this solution is not directly applicable to the legacy
>> Atom/SST driver, which uses a different device hierarchy. There are
>> however additional refcount issues which prevent the ACPI driver from
>> being removed. This is a different issue which would need a different
>> patch.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/soc.h  | 3 +++
>>   sound/soc/soc-core.c | 6 ++++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 95689680336b..eb7db605955b 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -802,6 +802,9 @@ struct snd_soc_component_driver {
>>   	int probe_order;
>>   	int remove_order;
>>   
>> +	/* signal if the module handling the component cannot be removed */
>> +	unsigned int ignore_module_refcount:1;
>> +
>>   	/* bits */
>>   	unsigned int idle_bias_on:1;
>>   	unsigned int suspend_bias_off:1;
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 9dad2b1498c1..80ab81f1df3d 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -947,7 +947,8 @@ static void soc_cleanup_component(struct snd_soc_component *component)
>>   	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
>>   	soc_cleanup_component_debugfs(component);
>>   	component->card = NULL;
>> -	module_put(component->dev->driver->owner);
>> +	if (!component->driver->ignore_module_refcount)
>> +		module_put(component->dev->driver->owner);
>>   }
>>   
>>   static void soc_remove_component(struct snd_soc_component *component)
>> @@ -1362,7 +1363,8 @@ static int soc_probe_component(struct snd_soc_card *card,
>>   		return 0;
>>   	}
>>   
>> -	if (!try_module_get(component->dev->driver->owner))
>> +	if (!component->driver->ignore_module_refcount &&
>> +	    !try_module_get(component->dev->driver->owner))
>>   		return -ENODEV;
>>   
>>   	component->card = card;
>> -- 
>> 2.17.1
