From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Mon, 11 Jan 2010 12:36:03 -0600
Message-ID: <6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B20810383C
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 19:36:04 +0100 (CET)
Received: by pzk14 with SMTP id 14so1944675pzk.23
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 10:36:03 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
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

> The improved and more clean fix in now in my tree:
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=1250932e48d3b698415b1f04775433cf1da688d6
>

The race condition is definitely gone. However I still see a NULL
event in snd_pcm_playback_poll() in pcm_native.c.

[13312.575829] snd_intel8x0_interrupt
[13312.575839]  snd_intel8x0_update
[13312.575847] snd_pcm_period_elapsed
[13312.575853]  snd_pcm_update_hw_ptr0
[13312.575862]    snd_pcm_update_state
[13312.575870]     wakeup in snd_pcm_update_state: avail 8194, avail_min 8192
[13312.575894] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8194 avail_min 8192
[13312.581259] snd_pcm_lib_write1: in
[13312.581267] snd_pcm_lib_write1 loop
[13312.581273]  snd_pcm_update_hw_ptr0
[13312.581282]    snd_pcm_update_state
[13312.581312] snd_pcm_lib_write1: end
[13312.581317]    snd_pcm_update_state
[13312.581328] ALSA: null poll event, avail 262 avail_min 8192
[13312.746498] snd_intel8x0_interrupt
[13312.746511]  snd_intel8x0_update
[13312.746520] snd_pcm_period_elapsed
[13312.746526]  snd_pcm_update_hw_ptr0
[13312.746536]    snd_pcm_update_state
[13312.746544]     wakeup in snd_pcm_update_state: avail 8194, avail_min 8192
[13312.746571] ALSA: poll event  POLLOUT|POLLWRNORM, avail 8194 avail_min 8192
[13312.751990] snd_pcm_lib_write1: in
[13312.751998] snd_pcm_lib_write1 loop
[13312.752004]  snd_pcm_update_hw_ptr0
[13312.752013]    snd_pcm_update_state
[13312.755285] snd_pcm_lib_write1: end
[13312.755293]    snd_pcm_update_state
[13312.755305] ALSA: null poll event, avail 265 avail_min 8192

I couldn't figure out who generates this null event, and even better
it does not show in the report printed by my test app. I am somewhat
lost here as to how snd_pcm_playback_poll works.
- Pierre
