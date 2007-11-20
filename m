From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: alsa timestamps
Date: Tue, 20 Nov 2007 16:54:32 +0200
Message-ID: <4742F528.3030905@cs.helsinki.fi>
References: <47413D60.9000404@cs.helsinki.fi>	<47418778.20609@cs.helsinki.fi>	<Pine.LNX.4.61.0711191405590.7813@tm8103.perex-int.cz>	<4741929A.5000005@cs.helsinki.fi>
	<s5habp9gg9c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh03.mail.saunalahti.fi (emh03.mail.saunalahti.fi
	[62.142.5.109]) by alsa0.perex.cz (Postfix) with ESMTP id 05E3524A22
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 15:54:37 +0100 (CET)
In-Reply-To: <s5habp9gg9c.wl%tiwai@suse.de>
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

Takashi Iwai kirjoitti:
> At Mon, 19 Nov 2007 15:41:46 +0200,
> Heikki Lindholm wrote:
>> Jaroslav Kysela kirjoitti:
>>> On Mon, 19 Nov 2007, Heikki Lindholm wrote:
>>>
>>>> Heikki Lindholm kirjoitti:
>>>>> Hello list,
>>>>>
>>>>> I took up some old dusty code of mine that uses snd_pcm_state followed 
>>>>> by snd_pcm_status_get_tstamp when in capture mode. The code used to 
>>>>> work, but now the returned timestamps are all zeroes. Is there some API 
>>>>> change done recently or is the whole timestamping deprecated or 
>>>>> something? I've tried with different drivers on ubuntu's alsa .14 and 
>>>>> gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
>>>>> TSTAMP_MMAP sw param.
>>>> I figured out that this doesn't happen when using hw:x,y devices. Is it 
>>>> a documented feature that some (software?) devices don't fill in timestamps?
>>> I think that it should be fixed. Could you send us 'snd_pcm_dump()' for a 
>>> non-working device? It's probably ommited code in direct pcm plugins (dmix 
>>> & etc.).
>> Here goes. The driver is snd_aoa. It seems as if the timestamp mode 
>> isn't propagated to the hw device.
> 
> AFAIK, the time-stamp mode isn't handled properly with direct plugins
> because of its nature.  Since the direct plugins share the same PCM
> hardware instance with multiple processes, you cannot change the
> parameter arbitrarily from a single client.
> 
> We may implement an emulation in alsa-lib instead, though...

For the time being, is there any other way of determining whether a pcm 
supports time stamps than just trying out and seeing if zero is all that 
comes out?

-- Heikki Lindholm
