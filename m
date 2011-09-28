From: Abdelghani Ouchabane <abdelghani@ezono.com>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Wed, 28 Sep 2011 15:19:13 +0200
Message-ID: <4E831ED1.5000608@ezono.com>
References: <4E817010.7030607@ezono.com>	<s5hipodciju.wl%tiwai@suse.de>	<4E82D2C6.9060307@ezono.com>	<s5hpqikbx42.wl%tiwai@suse.de>	<4E83116A.7070000@ezono.com>	<s5hipocbva1.wl%tiwai@suse.de>	<4E83184E.10203@ezono.com>
	<s5h4nzwbtoh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ezo.ezono.com (ezo.ezono.com [50.22.105.208])
	by alsa0.perex.cz (Postfix) with ESMTP id A76171039A8
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 17:19:21 +0200 (CEST)
In-Reply-To: <s5h4nzwbtoh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 28 Sep 2011 14:51:26 +0200,
> Abdelghani Ouchabane wrote:
>   
>> Takashi Iwai wrote:
>>     
>>> At Wed, 28 Sep 2011 14:22:02 +0200,
>>> Abdelghani Ouchabane wrote:
>>>   
>>>       
>>>>     
>>>>         
>>>>> OK, it's good to hear.  So 3.1 kernel is fine as is.  Only 3.0 and
>>>>> earlier can get Oops with buggy BIOS setups.
>>>>>
>>>>> I can easily fix it up, but maybe better first stabilize 3.1 and make
>>>>> similar 3.0 stable patch.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>   
>>>>>       
>>>>>           
>>>> Do I need to contact the manufacturer of my board to fix the BIOS as 
>>>> well, or it can be fixed by a patch?
>>>>     
>>>>         
>>> The easiest way is to create a file and feed via "patch" option of
>>> snd-hda-intel module as Clemens suggested.
>>>
>>>   
>>>       
>> I have three systems with the same hardware and software,
>>
>> in /proc/asound/card0/codec#2
>>
>> system 1 : Subsystem Id: 0x7fafffdd
>> system 2 : Subsystem Id: 0xffffffff
>> system 3 : Subsystem Id: 0xff7f7fa3
>>
>> Why the "Subsystem Id" is different between the three systems?
>>     
>
> Don't know.  All look very broken.  Are the machines really OK?
>
>   
Yes , they are.
>> Is there a way to don't use it in :
>>
>> [codec]
>> vendor-id subsystem-id address
>>
>> If I set the right subsystem-id in 
>> /lib/firmware/forgotten-ezono-hda-settings, the kernel doesn't crash and 
>> the sound works perfectly.
>>
>> I need one /lib/firmware/forgotten-ezono-hda-settings for all systems 
>> and I can not get "Subsystem Id" before loading snd_hda_intel successfully
>>
>> Any idea please?
>>     
>
> You could apply the patch like below, and pass 0 or -1 to vendor and
> subsystem ids.
>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
> index bf3ced5..c074ed2 100644
> --- a/sound/pci/hda/hda_hwdep.c
> +++ b/sound/pci/hda/hda_hwdep.c
> @@ -649,8 +649,8 @@ static void parse_codec_mode(char *buf, struct hda_bus *bus,
>  	*codecp = NULL;
>  	if (sscanf(buf, "%i %i %i", &vendorid, &subid, &caddr) == 3) {
>  		list_for_each_entry(codec, &bus->codec_list, list) {
> -			if (codec->vendor_id == vendorid &&
> -			    codec->subsystem_id == subid &&
> +			if ((vendor <= 0 || codec->vendor_id == vendorid) &&
> +			    (subid <= 0 || codec->subsystem_id == subid) &&
>  			    codec->addr == caddr) {
>  				*codecp = codec;
>  				break;
>
>   
Thanks a lot.
