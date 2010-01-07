From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Wed, 6 Jan 2010 22:59:22 -0600
Message-ID: <6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 61D0D24466
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 05:59:23 +0100 (CET)
Received: by pwi18 with SMTP id 18so44609566pwi.32
	for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2010 20:59:22 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

>> A wake-up is generated during the period interrupt, and a second
>> wake-up is generated during the write loop, after the application was
>> awaken but just before the pointers are updated. This second wake-up
>> shouldn't exist, since the write loop actually fills the ring buffer.
>> By the time the second wake-up is actually handled, there's really no
>> space left in the buffer and a null event is generated; it'll wake-up
>> the application a second time for nothing. Maybe we should move the
>> call to snd_pcm_update_hw_ptr() after the transfer took place?
>
> The right fix should be to preserve wakeups when write operation is in
> progress (also for interrupts). Something like this (untested):

Thanks Jaroslav for your feedback. It seems your fix is similar to
what I suggested, that is check the pointers and generate a wake-up
after the write loop completes rather than right before the write
starts. I modified your patch to correct the behavior when errors
occur; the jumps to _end_wake compared to _end_unlock weren't self
explanatory and not always consistent. I only perform a pointer update
if nothing wrong happened. In case of errors, I unlock or just return
the status as before. I am testing the changes and should have a patch
shortly.
Cheers
- Pierre
