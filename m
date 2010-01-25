From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Underrun problem and some basic queries
Date: Mon, 25 Jan 2010 11:56:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001251130110.4324@eeebox2.perex-int.cz>
References: <18229629.327131262603393053.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E67C72461C
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 11:56:36 +0100 (CET)
In-Reply-To: <18229629.327131262603393053.JavaMail.weblogic@epml01>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Jan 2010, ANISH KUMAR wrote:

>
> Dear ALSA Team,
> I have some queries.Please answer them.(previous post please ignore as they couldn't appear because of encoding problem)
> I am getting underrun problem whenever the playback is about to get finished.
> happening in snd_pcm_update_hw_ptr_post function:
> if (avail >= stop_threshold) {
>        if (substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
>            snd_pcm_drain_done(substream);
>        else
>            xrun(substream); //here it is happening..........
>        return -EPIPE; }
>
> 1. As i understand if i dont call drain function 
> this will happen.Ismy understanding correct?Because if am calling drain 
> function then thisproblem is not happening.If the application doesn't 
> call drain functionthen xrun is the only way to stop ALSA or does ALSA 
> detect that thereare no more samples to play and automatically stop the 
> play(if yes,canyou point out the source code)?

You showed the stop point in above if (avail >= threshold) condition.

> 2. snd_pcm_playback_avail() returns the number of samples that 
> stillneeds to be played?Below is the diagram which is my understanding.

No, it's the room for new samples to fill the ring buffer to full.

>    Ring buffer (DMA buffer created using preallocated buffer during system initalisation)
> -----------------------------------------------------------------
> |          |          |          |          |          |          |
> -----------------------------------------------------------------
>    ^  ^
>    |   |
> hw_ptr appl_ptr
> After first write call:
> -----------------------------------------------------------------
> |          |          |          |          |          |          |
> -----------------------------------------------------------------
>     ^                               ^
>     |                                |
> appl_ptr                     hw_ptr

If hw_ptr > appl_ptr then underrun occurs.

> So my understanding is once wait_for_avail_min returns 
> insnd_pcm_lib_write1 function.hw_ptr is increased by some 
> amount(periodsize) but appl_ptr will increase only when 
> wait_for_avail_minreturns.And difference of 
> (hw_ptr+runtime->buffersize-appl_ptr) will give us unplayed samples in 
> the case of playback?

No.

> Is this whole ring buffer is filled after the 
> snd_pcm_lib_write_transfer function is returned?

Not necessary. It depends how much samples an application feeds in.

> 3.In some rare cases (playback case) i have seen thatwait_for_avail_min 
> doesn't return and driver pointer function keeps ongetting called 
> causing hw_ptr to increase.This causessnd_pcm_playback_avail() function 
> to return a value less than avail_min(as hw_ptr is increasing and 
> appl_ptr is stagnant as it is stuck insnd_pcm_lib_write1 function) which 
> inturn causes wake-up fromsnd_pcm_update_hw_ptr_post() not to get 
> called.When this type ofscenario happens?Is it a normal scenario if 
> yes,then how will it willever come out from wait_for_avail_min? 
> According to my understanding appl_ptr will increase only when we return 
> from wait_for_avail_min?

I'm not sure if you're not mentioning a problem solved in:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=c91a988dc6551c66418690e36b2a23cdb0255da8

> 4.how does alsa know that it is running short 
> of data?As iunderstand that it does not free the memory and data is 
> onlyoverwritten.So how does it distinguish between old and new data?

Everything in ALSA PCM is about comparing hw_ptr and appl_ptr. So 
basically, the ring buffer size is maximum time for application to fill 
and for driver to eat samples. If this time is surpased, wrong things 
happen.

> 5.Burst of noise due to stale data problem reported by Jon Smirl and for 
> which Mr Jaroslav has suggested this solution 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-May/017119.html.Is 
> it implemented?

Nope. Patches are welcome.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
