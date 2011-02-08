From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Re: MIDI playback not keeping steady time with recent
 kernels
Date: Wed, 09 Feb 2011 01:49:25 +1030
Message-ID: <4D515EFD.3040909@internode.on.net>
References: <559v18-575.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<bma128-mok.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>	<elo128-8u4.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<11c228-725.ln1@ppp121-45-136-118.lns11.adl6.internode.on.net>
	<4D512EA9.2020909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail05.adl6.internode.on.net (ipmail05.adl6.internode.on.net
	[150.101.137.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C2F024333
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 16:20:39 +0100 (CET)
In-Reply-To: <4D512EA9.2020909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Clemens Ladisch wrote, on 08/02/11 22:23:
> Arthur Marsh wrote:
>>>> Arthur Marsh wrote, on 05/02/11 17:30:
>>>>> MIDI playback either through xmms or aplaymidi won't keep regular time,
>>>>> sounding weird going faster and slower under any kind of system load
>>>>> except when nothing else is running.
>>
>> I've tried setting "options snd-timer timer_limit=x" where x is anywhere
>> from 5 down to 0, and seeing either:
>>
>> $ cat /proc/asound/seq/timer
>> Timer for queue 0 : HR timer
>>     Period time : 0.004000250
>>     Skew : 65536 / 65536
>>
>> or "system timer" in place of "HR timer".
>>
>> In all cases, under sufficient load (which might be just running
>> aptitude -u), the tempo of the MIDI file play-back slows right down.
>
> The ALSA interfaces of both the system timer and the HR timer do not
> handle delayed interrupts correctly.  Please try the patch below, and if
> it fixes the HR timer, tell me if you're OK with the published tag
> Reported-and-tested-by: Arthur Marsh<arthur.marsh@internode.on.net>.
>
>
> Regards,
> Clemens
>
> --- a/sound/core/hrtimer.c
> +++ b/sound/core/hrtimer.c
> @@ -45,12 +45,13 @@ static enum hrtimer_restart snd_hrtimer_
>   {
>   	struct snd_hrtimer *stime = container_of(hrt, struct snd_hrtimer, hrt);
>   	struct snd_timer *t = stime->timer;
> +	unsigned long oruns;
>
>   	if (!atomic_read(&stime->running))
>   		return HRTIMER_NORESTART;
>
> -	hrtimer_forward_now(hrt, ns_to_ktime(t->sticks * resolution));
> -	snd_timer_interrupt(stime->timer, t->sticks);
> +	oruns = hrtimer_forward_now(hrt, ns_to_ktime(t->sticks * resolution));
> +	snd_timer_interrupt(stime->timer, t->sticks * oruns);
>
>   	if (!atomic_read(&stime->running))
>   		return HRTIMER_NORESTART;
>

OK, I applied this patch.

When the MIDI file was playing:

$ cat /proc/asound/seq/timer
Timer for queue 0 : HR timer
   Period time : 0.004000250
   Skew : 65536 / 65536

I still experienced some slow-down and speed-up under heavy load.

Thanks for the patch. I'm happy to do any further testing you can suggest.

Regards,

Arthur.
