From: WILMES Andreas <administrator@webspace.ms>
Subject: Re: [Alsa-user] Problems with Soundblaster X-Fi
Date: Mon, 15 Jun 2009 11:16:52 +0200
Message-ID: <4A361184.4080909@webspace.ms>
References: <4A35683E.70900@gmx.de> <4A3575BE.7090206@webspace.ms>
	<4A360322.7060703@gmx.de> <4A360FA5.6010604@webspace.ms>
	<4A36112E.3080901@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay006.isp.belgacom.be (mailrelay006.isp.belgacom.be
	[195.238.6.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 4632C1037FF
	for <Alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:16:58 +0200 (CEST)
In-Reply-To: <4A36112E.3080901@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Herrmann <daniel.herrmann1@gmx.de>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Herrmann wrote:
> WILMES Andreas schrieb:
>> Daniel Herrmann wrote:
>>> WILMES Andreas schrieb:
>>>> Daniel Herrmann wrote:
>>>>  
>>>>> Hey all,
>>>>>
>>>>> i tried out the new devel-snapshot including alsa-support for my 
>>>>> Soundblaster x-Fi card.
>>>>>
>>>>> Installed it via ./configure; make; make install and rebooted.
>>>>>
>>>>> The driver didnt load at all.
>>>>>
>>>>> Trying to load the driver manually brings up the following message:
>>>>>
>>>>>  
>>>>>> modprobe snd-ctxfi
>>>>>>       
>>>>> FATAL: Error inserting snd_ctxfi 
>>>>> (/lib/modules/2.6.28-11-generic/kernel/sound/pci/ctxfi/snd-ctxfi.ko): 
>>>>> Unknown symbol in module, or unknown parameter
>>>>>
>>>>>  
>>>>>> dmesg shows the following:
>>>>>>       
>>>>> [ 2146.563073] snd_ctxfi: disagrees about version of symbol 
>>>>> snd_ctl_add
>>>>> [ 2146.563081] snd_ctxfi: Unknown symbol snd_ctl_add
>>>>> [ 2146.563291] snd_ctxfi: disagrees about version of symbol 
>>>>> snd_pcm_new
>>>>> [ 2146.563295] snd_ctxfi: Unknown symbol snd_pcm_new
>>>>> [ 2146.563482] snd_ctxfi: disagrees about version of symbol 
>>>>> snd_card_register
>>>>>
>>>>> [...] and so on, about 60 lines
>>>>>
>>>>> [ 3198.031060] snd_ctxfi: disagrees about version of symbol 
>>>>> snd_pcm_period_elapsed
>>>>> [ 3198.031063] snd_ctxfi: Unknown symbol snd_pcm_period_elapsed
>>>>>
>>>>>  
>>>>>> lspci | grep -i audio
>>>>>>       
>>>>> 00:0a.0 Multimedia audio controller: Creative Labs SB X-Fi
>>>>>
>>>>> Currently using Ubuntu 9.04 Jaunty with the current 
>>>>> 2.6.28-11-generic kernel
>>>>>
>>>>> Maybe anyone has an idea, why i cant install the driver?
>>>>> It worked for me before, but unfortunatly i had to reinstall 
>>>>> ubuntu after getting a weird dependeny problem in apt.
>>>>> Not shure why it doesn't do so now...
>>>>>
>>>>> Thanks in advance for your help and thanks for the great work you do!
>>>>>
>>>>>     
>>>> I had the same error. Then I rebooted and the error disappeared. 
>>>> Hope that will help.
>>>>   
>>> Hm, i rebooted more than once - same error.
>>>
>>> Daniel
>>>
>> I deleted /usr/include/asm and I symlinked it to 
>> /usr/src/linux-headers-2.6.28-11/include/asm-generic and I did a 
>> recompile. After rebooting then the error disappeared.
>>
> HM... You deleted it and made a symlink from it? How does this work? 
> How can i link something deleted?!
>
> Can't follow you ;)
Oh I'm Sorry.
/usr/include/asm was a static folder containing a lot of files before. I 
linked /usr/src/linux-headers-2.6.28-11/include/asm-generic to 
/usr/include/asm then.
