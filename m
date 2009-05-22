From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: more on appl_ptr and DMA overrun at end of stream
Date: Fri, 22 May 2009 09:07:43 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905220902570.4067@eeebox2.perex-int.cz>
References: <9e4733910905211144mfdc2947mbeb8872affb201cf@mail.gmail.com>
	<s5h1vqhhc77.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3CA243F0
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 09:07:43 +0200 (CEST)
In-Reply-To: <s5h1vqhhc77.wl%tiwai@suse.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 May 2009, Takashi Iwai wrote:

> At Thu, 21 May 2009 14:44:27 -0400,
> Jon Smirl wrote:
>>
>> I've been reading Lennart's article on glitch free audio....
>>
>> On my scatter/gather DMA hardware I generate an interrupt at the end
>> of each period. On the last period this causes ALSA to issue a
>> trigger(STOP). However, there is a latency from when that interrupt is
>> generated and when ALSA does the trigger(STOP). During that latency my
>> hardware starts playing the next buffer (which contains stale data).
>> Playing stale data causes a noise burst. I fixed this by programming
>> my DMA hardware to not overrun appl_ptr.
>>
>> There's another solution. ALSA already knows the stream ends
>> mid-period and pads out the partial period with silence. If it simply
>> padded out the next period with silence too the overrun problem would
>> become non-audible and there would time to process trigger(STOP).
>>
>> If padding out two periods at end of stream is possible, it then
>> becomes possible for me to turn off interrupts in my audio driver.
>
> This can be another interesting feature.  For example, you could add
> a soft-mute padding to avoid a click noise at the end instead of a
> whole silence.
>
> But, this kind of hack really depends on the hardware implementation.
> If a hardware has no DMA but require explicit writes, adding two
> periods is too much.  Just a few samples would be enough.

I agree to leave such things to lowlevel drivers.

> Or, in the case of normal PCI DMA transfer, how can it be stopped?
> That is, the stream is still running although it's claimed to be
> stopped.  If a period size is big (say over one second), the stop at
> the next interrupt doesn't sound good.

I would suggest to improve drain() logic in kernel with
snd_pcm_update_hw_ptr() calls and using proper timeouts for 
schedule_timeout().

Note that this situation were handled with dead and removed pcm tick API - 
although it required assistance (setup) from application.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
