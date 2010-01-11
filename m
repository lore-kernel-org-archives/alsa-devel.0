From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Mon, 11 Jan 2010 12:45:09 -0600
Message-ID: <6160a5131001111045y7262deearf7b72f9002cb0718@mail.gmail.com>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
	<6160a5131001062059i1ef74831p4210987579feb759@mail.gmail.com>
	<alpine.LNX.2.00.1001071552060.4210@eeebox2.perex-int.cz>
	<6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 65DCF24415
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 19:45:11 +0100 (CET)
Received: by pwi18 with SMTP id 18so5879705pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 10:45:09 -0800 (PST)
In-Reply-To: <6160a5131001111036v355685c9j89e85cd13e82e3dc@mail.gmail.com>
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

> I couldn't figure out who generates this null event, and even better
> it does not show in the report printed by my test app. I am somewhat
> lost here as to how snd_pcm_playback_poll works.

Not sure if this is related to my previous post, but PulseAudio seems
to only sleep every other time poll is called. Somehow there's still a
spurious wakeup.

E: rtpoll.c: rtpoll_run
E: rtpoll.c: poll timeout: 188 ms
E: rtpoll.c: Process time 0 ms; sleep time 188 ms
E: rtpoll.c: rtpoll_run
E: rtpoll.c: poll timeout: 189 ms
E: rtpoll.c: Process time 0 ms; sleep time 0 ms
E: rtpoll.c: rtpoll_run
E: rtpoll.c: rtpoll finish
E: rtpoll.c: rtpoll_run
E: rtpoll.c: poll timeout: 188 ms
E: rtpoll.c: Process time 0 ms; sleep time 189 ms
E: rtpoll.c: rtpoll_run
E: rtpoll.c: poll timeout: 189 ms
E: rtpoll.c: Process time 0 ms; sleep time 0 ms
