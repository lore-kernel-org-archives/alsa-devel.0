From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: AK4114 - capturing spdif input stops the stream
Date: Thu, 13 Mar 2008 15:11:50 +0100
Message-ID: <47D93626.2010605@insite.cz>
References: <47D85E20.7060109@insite.cz>	<s5hr6efdpv1.wl%tiwai@suse.de>	<47D922D0.8060006@insite.cz>
	<s5hfxuuvi9l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from prague.insite.cz (r3g29.net.upc.cz [213.220.198.29])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A831244CC
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 15:11:52 +0100 (CET)
In-Reply-To: <s5hfxuuvi9l.wl%tiwai@suse.de>
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
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai napsal(a):
> At Thu, 13 Mar 2008 13:49:20 +0100,
> Pavel Hofman wrote:
>> Takashi Iwai napsal(a):
>>> At Wed, 12 Mar 2008 23:50:08 +0100,
>>> Pavel Hofman wrote:
>>>> Hi,
>>>>
>>>> here is my scenario:
>>>>
>>>> ICE1724 card, trying to record from SPDIF input via AK4114, ICE1724 
>>>> slaved to SPDIF clock from the receiver.
>>>>
>>>> The card detects SPDIF input rate correctly (in my case ESI Juli where 
>>>> AK4114 is provided with independent clock signal to enable the rate 
>>>> detection). Let's say it is 192000.
>>>>
>>>> Now I want to arecord the input stream, let's say in CD quality, using 
>>>> the plug plugin. The command fails, because of the check in ak4114.c:
>>>>
>>>> res = external_rate(rcs1);
>>>> 	if (!(flags & AK4114_CHECK_NO_RATE) && runtime && runtime->rate != res) {
>>>> 		snd_pcm_stream_lock_irqsave(ak4114->capture_substream, _flags);
>>>> 		if (snd_pcm_running(ak4114->capture_substream)) {
>>>> 			printk(KERN_DEBUG "rate changed (%i <- %i)\n", runtime->rate, res);
>>>> 			snd_pcm_stop(ak4114->capture_substream, SNDRV_PCM_STATE_DRAINING);
>>>> 			res = 1;
>>>> 		}
>>>> 		snd_pcm_stream_unlock_irqrestore(ak4114->capture_substream, _flags);
>>>> 	}
>>>>
>>>> The stream gets stopped because res = 192000 and runtime->rate = 44100.
>>>>
>>>> The problem is that the capture device still offers all the available 
>>>> rates, instead of the single SPDIF input one. Thus, the plug plugin is 
>>>> not forced to convert from 192000 to 44100 and runtime->rate is 44100 
>>>> instead of 192000.
>>>>
>>>> Of course recording at 192000 works fine.
>>>>
>>>> What would be the best way to force the SPDIF capture device to offer 
>>>> (advertise) only the current rate? This functionality would have to be 
>>>> applicable only to the few cards correctly detecting incoming rate 
>>>> (unlike most ice1724 cards without independent clock in slave mode).
>>> What about to call snd_ak4114_check_rate_and_errors() at PCM open?
>>> You can pass AK4114_CHECK_NO_RATE to flags argument to skip the check
>>> there, at least.
>>>
>>>
>> Well, I would not want to skip the check for cards with functioning rate 
>> detection. Plus snd_ak4114_check_rate_and_errors gets called 
>> periodically afterwards.
> 
> Yes, but the check there is simply useless at open.  It's only for
> running states.  snd_ak4114_external_rate() would be simler, then.
> 
>> It would be great if the driver in slaved-clock mode cut its list of 
>> native sample rates to the only one currently fed to SPDIF input and 
>> detected by AK4114. A routine doing this would be called when switching 
>> clock to the slaved-clock mode and called again in 
>> snd_ak4114_check_rate_and_errors() when any change in input rate is 
>> detected (and the stream is not running). Going back to master-clock 
>> mode would restore the existing list of all the rates.
>>
>> In case of input sample rate change when the PCM stream is running, the 
>> stream would be stopped. This is already implemented in the current 
>> version of snd_ak4114_check_rate_and_errors()
>>
>> Unfortunately, I do not know how to change the rates list properly not 
>> to break something. If it is only about changing the HW params struct, 
>> that would be trivial.
> 
> Suppose that the slave <-> master mode change doesn't happen during
> the stream is opened, it's relatively easy.  So far, ice1724.c doesn't
> call spdif.ops.open/close callbacks.  Call them in *_spdif_open/close
> functions with NULL check. Then add open hook in juli.c so that you
> can change rates_min and rates_max to the currently detected rate at
> open...
> 
> Well, it's faster to write a patch than texts.
> 
> 
> Takashi

Thanks a lot. I will test it in the evening. The code looks simple now 
but without your help I would be stuck forever :)

Pavel.
