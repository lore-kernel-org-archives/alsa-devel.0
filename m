From: Stefan Ringel <stefan.ringel@arcor.de>
Subject: Re: HD-Audio device unsuppored (Nvidia G2xx-series GPU
 implemented)
Date: Mon, 21 Dec 2009 15:41:47 +0100
Message-ID: <4B2F892B.7030009@arcor.de>
References: <4B238733.2070706@arcor.de>
	<s5heimxlrjd.wl%tiwai@suse.de>	<4B262682.60400@arcor.de>
	<s5h7hsplqlz.wl%tiwai@suse.de>	<s5h7hspjvpv.wl%tiwai@suse.de>
	<4B294E06.6060001@arcor.de>	<4B2CC8C7.4050507@arcor.de>
	<s5hmy1clhpt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46]) by alsa0.perex.cz (Postfix) with ESMTP id 08D47243CF
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 15:41:55 +0100 (CET)
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net
	[151.189.8.14]) by mx.arcor.de (Postfix) with ESMTP id 6501339A51D
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 15:41:53 +0100 (CET)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 50508114173
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 15:41:53 +0100 (CET)
Received: from [192.168.2.102] (dslb-094-222-026-034.pools.arcor-ip.net
	[94.222.26.34]) (Authenticated sender: stefan.ringel@arcor.de)
	by mail-in-17.arcor-online.net (Postfix) with ESMTPA id 1F2F33B2497
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 15:41:52 +0100 (CET)
In-Reply-To: <s5hmy1clhpt.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 21.12.2009 11:55, schrieb Takashi Iwai:
> At Sat, 19 Dec 2009 13:36:23 +0100,
> Stefan Ringel wrote:
>   
>> Am 16.12.2009 22:15, schrieb Stefan Ringel:
>>     
>>> Am 14.12.2009 18:45, schrieb Takashi Iwai:
>>>   
>>>       
>>>> At Mon, 14 Dec 2009 12:52:40 +0100,
>>>> I wrote:
>>>>   
>>>>     
>>>>         
>>>>>>         
>>>>>>             
>>>>>     
>>>>>       
>>>>>           
>>>>>>>> one codec-id missed (0x10de000d) and codec-name is "G2xx HDMI".
>>>>>>>>             
>>>>>>>>                 
>>>>>>       
>>>>>>
>>>>>> OK, I'll update.
>>>>>>         
>>>>>>             
>>>>>     
>>>>>       
>>>>>           
>>>> Below is the updated patch.  This also replaces the PCI ID check using
>>>> the generic hd-audio class check.
>>>>
>>>>
>>>> Takashi
>>>>
>>>>   
>>>>     
>>>>         
>>> Hi Takashi,
>>>
>>> I have a theory,
>>>
>>> 4 codec with 2 channels bundling to one pcm device for 8 channels
>>> uncompressed lpcm audio and compressed audio over first codec.
>>>
>>> Actual configuration is 4 separate pcm device.
>>>
>>>
>>>   
>>>       
>> Hi Takashi,
>>  
>> I tested your patch and it doesn't work.
>> I checked caps from nodes 0x04 and 0x05 and comparing with  
>> http://download.intel.com/standards/hdaudio/pdf/hda034-a2.pdf. document.
>> The configuration is 4 full HDMI codec not 4 2-channels pcm codec. It
>> have CP-flag, ext-channel and in pin-widget that HDMI-flag.
>>     
> But still it's not sure whether it's really compliant.
> Nvidia HDMI codecs have been incompatible with that standard although
> they have already supported 8 channels.
> And, one wonders why there are 4 HDMI codecs there.
>
> Anyway, try to set up just one codec and don't do anything else.
> If it's a standard codec, patch_intelhdmi.c would work.  Create a new
> patch code that ignores the instances with codec->addr > 1, so that
> you concentrate on only the first codec address.
> Or, patch_atihdmi.c can be used by changing the fixed pins...
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   

I tested your patch  with using HDA-Analyzer once again. I enabled and
disabled the codecs step to step and as I enabled the second codec I
hear rear left and rear right, but not other channels. As I enabled all
codecs I hear only rear
left and rear right.

Stefan Ringel <stefan.ringel@arcor.de>

-- 
Stefan Ringel <stefan.ringel@arcor.de>
