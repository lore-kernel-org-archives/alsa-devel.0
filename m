From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: snd_pcsp locking mess
Date: Tue, 27 May 2008 21:40:13 +0400
Message-ID: <483C477D.2000207@aknet.ru>
References: <20080518172258.D0DFB108060@picon.linux-foundation.org>	<4830737B.70108@aknet.ru>	<s5hve1ac05g.wl%tiwai@suse.de>	<4831B260.1060802@aknet.ru>	<s5hhccrx2ey.wl%tiwai@suse.de>	<4835D774.3070306@aknet.ru>	<s5hprrduwdk.wl%tiwai@suse.de>	<483C10E7.7070203@aknet.ru>
	<s5h4p8jbvaj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.mtu.ru (smtp05.mtu.ru [62.5.255.52])
	by alsa0.perex.cz (Postfix) with ESMTP id DBC6F24462
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 19:40:13 +0200 (CEST)
In-Reply-To: <s5h4p8jbvaj.wl%tiwai@suse.de>
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

Hello.

Takashi Iwai wrote:
> Well, let's take a look back how the callbacks are called.
> The callbacks that are called during PCM running are the following:
> 
> - hrtimer callback gets called from hrtimer:
>   This updates the pcsp port and updates the PCM pointer.
>   
> - PCM pointer callback:
>   This returns the current PCM pointer
> 
> So, actually between these calls, we have only one thing to protect -
> the PCM pointer.  The DMA-buffer readiness is necessary only for
> hrtimer callback.
OK.

> And, in addition, we need to call somewhere snd_pcm_period_elapsed()
> when the period is finished.  This can be done in a tasklet.
What is the difference between calling
everything in softirq (current solution)
and calling snd_pcm_period_elapsed() in
a tasklet, with the rest in a hardirq
context? What will this solve?

> Now, remember that hrtimer is started only via trigger start
> callback.  That is, hrtimer callback isn called first after PCM is
> actually started; hence the DMA buffer is ready when it's called.
> 
> Then, if we assure that the DMA buffer isn't changed and the PCM
> substream still exists during hrtimer callback (and/or its execution
> finishes), hrtimer callback can safely run without *any* lock.
OK so how do you protect the PCM pointer
after all? Even in your example you use
the chip->substream_lock for that (why?),
so it doesn't look like you run a callback
without any lock at all.

> This is pretty easy.  We just need to add appropriate calls to
> synchronize the finish of hrtimer (and tasklet) at each place that can
> change the DMA buffers.
I wonder if this is SMP-safe (comments
below).

> +/*
> + * Force to stop and sync the stream
> + */
> +void pcsp_sync_stop(struct snd_pcsp *chip)
> +{
> +	local_irq_disable();
So what will happen if the timer callback
is executing on another CPU at that point?

> +	pcsp_stop_playing(chip);
This will set chip->timer_active to 0,
but who knows if the callback on another
CPU have already passed the check or not?

> +	local_irq_enable();
> +	hrtimer_cancel(&chip->timer);
> +	tasklet_kill(&pcsp_pcm_tasklet);
Ouch, IIRC all three are discouraged to
use...

I (hopefully) now understand the logic
you are trying to explain, and I don't
think it is completely trouble-free (I
may be wrong of course, but certainly
it won't be straightforward for every
reader why is that code correct).
So the question is still why not to
simply use snd_pcm_stream_lock(). And
if right now it is barely usefull, then
why it can't be improved to simply not
require a second lock that guards a
substream itself?
