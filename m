From: Han Lu <han.lu@linux.intel.com>
Subject: Re: [PATCH V7 0/2] ASoC: Add core API to register and
 cleanup DMI names for card
Date: Thu, 7 Apr 2016 17:33:48 +0800
Message-ID: <5706297C.8080900@linux.intel.com>
References: <cover.1459926898.git.han.lu@intel.com>
 <s5h4mbfxgne.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ADAEA266195
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:33:28 +0200 (CEST)
In-Reply-To: <s5h4mbfxgne.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, han.lu@intel.com
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 04/06/2016 04:53 PM, Takashi Iwai wrote:
> On Wed, 06 Apr 2016 09:29:17 +0200,
> han.lu@intel.com wrote:
>> From: "Lu, Han" <han.lu@intel.com>
>>
>>   Share more product information, for user space utils such as PA and UCM to
>>   distinguish different products.
>>    1. Add core APIs to register and cleanup DMI names for card.
>>    2. Apply the APIs to bytcr-rt5640 driver.
> Han, one good advice is: be patient.  This is no urgent fix, so there
> is no many reason to rush too much with a pile of newer patchset.
> Give some more time for other people to review.

sorry, I was too hurry. I'll update patch after more review.
>
> About the patch: I still have a few concerns, and some are in the
> fundamental level:
>
> - Is calling dmi_*() function in ASoC core is appropriate and
>    preferred?

I was intended to add a common function for each machine driver to call, and
to add firmware name if necessary. I can move all dmi_*() functions to 
machine
drivers too, only pass the name strings as arguments.
>
> - When is this function supposed to be called?  Since you're accessing
>    card->snd_card, it must be after instantiation, that is,
>    snd_soc_register_card().  If so, it should be documented.  And, in
>    that case, there is no need to allocate a buffer; you can set the
>    strings directly in card->snd_card. (For snd_component_add(), you
>    may pass the card->snd_card->longname[]).
>
>    OTOH, if the function may be called before instantiation, the code
>    needs more rethink, including the string allocation and release.
the intention was to set the card->long_name, before the accessing to it in
snd_soc_instantiate_card():
     ...
     snprintf(card->snd_card->longname, sizeof(card->snd_card->longname),
          "%s", card->long_name ? card->long_name : card->name);
     ...
or it may be better to overwrite the card->snd_card->longname[] after
instantiation, so no need to allocate and release at all?
>
> - A semicolon is no taboo character, either.  A firmware or vendor
>    string may contain such a letter, too.  You need to either escape or
>    replace such a letter instead of praying the well-mannered
>    firmware.
so any printable ASCII character may have the same risk, may I use a control
code such as '\t', or a non ASCII value like 0x80?

BR,
Han
>
> thanks,
>
> Takashi
>
>>   changes on V7:
>>    1. Remove inconsistent API description
>>    
>>   changes on V6:
>>    1. Use dynamic allocate and cleanup for card long name
>>    2. Remove unneccessary arguments to simplify the API
>>    
>>   changes on V5:
>>    1. Use independent space to store card long_name, to avoid irrelavant
>>    info sharing from card component
>>    2. Use letter ';' instead of ':' to separate strings in long name, in
>>    case name strings may also contain ':' and confuse user
>>    3. Fix error that vendor name and firmware name were not optional
>>     
>>   changes on V4:
>>    1. Replace kmalloc() and snprintf() with ksaprintf() to simplify code
>>      
>>   changes on V3:
>>    1. Split the core API and the API call to two patches
>>    2. Replace misused strcat() with snprintf()
>>    3. Code and comment fix
>>
>> Lu, Han (2):
>>    ASoC: core: add API for registering and cleaning up DMI card names
>>    ASoC: bytcr-rt5640: register DMI names for card
>>
>>   include/sound/soc.h                   |  3 ++
>>   sound/soc/intel/boards/bytcr_rt5640.c | 18 ++++++++
>>   sound/soc/soc-core.c                  | 85 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 106 insertions(+)
>>
>> -- 
>> 2.5.0
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
