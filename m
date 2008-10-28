From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: sbxfi - What works/doesn't summary
Date: Tue, 28 Oct 2008 19:33:19 +0000
Message-ID: <490768FF.3020807@jasonline.co.uk>
References: <4906FA8C.4030501@jasonline.co.uk>	<490709EF.7090803@gmail.com>	<49074E98.7070506@jasonline.co.uk>
	<s5h3aigilum.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id 90AD92450C
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 20:33:14 +0100 (CET)
In-Reply-To: <s5h3aigilum.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 28 Oct 2008 17:40:40 +0000,
> Jason Harvey wrote:
>   
>> The Source wrote:
>>     
>>> You can't hear desktop sounds because they always use pulseaudio no 
>>> matter what sound system you select as default. For me pulseaudio 
>>> plays first sound fine after start, others are corrupt along with 
>>> sound from all other apps. I'll post hw_params later. Also pulseaudio 
>>> tends to crash often with this driver so I suppose your problem is the 
>>> same.
>>>       
>> Can confirm that once pulse (on FC9 at least) gets involved it sounds 
>> terrible.
>>
>> I worked out that I had removed a package pulseaudio-esound-compat at 
>> some point in the past and never realised that it contains the symlinks 
>> that gets Gnome to start the pulse server.
>> Once that was fixed the desktop effects started working but only out of 
>> my USB headset... and nothing I can find in the gui lets me do anything 
>> about it.
>>     
>
> In many cases, the pulse problem comes from the in accurate DMA position
> calculation.  PA is often too aggressively updating buffers.
>   
Thanks, I knew there was a reason I stripped pulse out of this machine 
when I installed FC9.
Is that a bug in pulse or is it something that will improve with the 
sbxfi driver?

>> mplayer and firefox/flash sound terrible, very tinny and scratchy.
>> This is with the base_rate=48000 option set in modprobe.conf
>>     
>
> Do you mean a regression with 48kHz in comparison with 96kHz?
>
>   
Sorry that was a bit ambiguous, I'd never tried 96kHz.
Have just changed base_rate to 96kHz and it performs identically to 48kHz.
Pulse mangles the sound in just the same manner at 48kHz or 96kHz.

While I was poking about in my alsa configuration I noticed that there 
is no /etc/alsa/cards/SBXFi.conf
I think pulse looks for it, get errors shown after running pulseaudio -vv
ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition 
'cards.SBXFi.pcm.surround51.0:CARD=0'  
Would that make any difference to anything?
(Sorry if pulse issues are totally off-topic)

Regards, Jason
