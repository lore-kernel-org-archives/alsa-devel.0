From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Thu, 7 Jan 2010 15:59:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FC7E2454F
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 15:59:42 +0100 (CET)
In-Reply-To: <6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Jan 2010, pl bossart wrote:

>>> A wake-up is generated during the period interrupt, and a second
>>> wake-up is generated during the write loop, after the application was
>>> awaken but just before the pointers are updated. This second wake-up
>>> shouldn't exist, since the write loop actually fills the ring buffer.
>>> By the time the second wake-up is actually handled, there's really no
>>> space left in the buffer and a null event is generated; it'll wake-up
>>> the application a second time for nothing. Maybe we should move the
>>> call to snd_pcm_update_hw_ptr() after the transfer took place?
>>
>> The right fix should be to preserve wakeups when write operation is in
>> progress (also for interrupts). Something like this (untested):
>
> Thanks Jaroslav for your feedback. It seems your fix is similar to
> what I suggested, that is check the pointers and generate a wake-up
> after the write loop completes rather than right before the write
> starts. I modified your patch to correct the behavior when errors
> occur; the jumps to _end_wake compared to _end_unlock weren't self
> explanatory and not always consistent. I only perform a pointer update
> if nothing wrong happened. In case of errors, I unlock or just return
> the status as before. I am testing the changes and should have a patch
> shortly.
> Cheers

The improved and more clean fix in now in my tree:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6

Note that you should apply these 4 patches (in reverse order):

4: ALSA: pcm_lib - optimize wake_up() calls for PCM I/O
3: ALSA: pcm_lib - cleanup & merge hw_ptr update functions
2: ALSA: pcm_lib - add possibility to log last 10 DMA ring buffer positions
1: ALSA: pcm_lib.c - convert second xrun_debug() parameter to use defines

Patch #3 should definitely fix problems with large avail or delay values 
reported in PA. I finally figured the culprit (and decide to cleanup all
relevant code rather do just another workaround). In other words, new 
hw_ptr pointer should never be less than previous one now.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
