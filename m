From: James Huk <huk256@gmail.com>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Mon, 18 Oct 2010 23:21:13 +0200
Message-ID: <AANLkTi=hrswMKjLvdoTKxaoWVe073WHEEEdQ+N+9jYoW@mail.gmail.com>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B2351103849
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 23:21:15 +0200 (CEST)
Received: by vws17 with SMTP id 17so838474vws.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 14:21:13 -0700 (PDT)
In-Reply-To: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

@Colin Guthrie:

> As a PA hacker, I'd be interested to know what apps were causing you
> problems when you used PA so that we could help make them better for
> other users who do want to use PA. If you could provide any details or
> debug info, that would be great.

Well let me name a few:

-Quake4 - sound worked, but some latency was growing with time - after
about 30-60 minutes game restart was required because sound latency
was around 1000 ms
-SDL based apps (zsnes is the one I use a lot) - sound was lower
quality with PA, than with clean ALSA or OSS4, even with
SDL_AUDIODRIVER=pulse (but in that case - this may be zsnes fault as
well)
-wine - even with PA patch, I got poor latency in some apps, and more
crashes than with clean ALSA/OSS4
-KEGA Fusion (Megadrive emulator = freeware but closed-source) - well,
this is a special case - PA acted pretty weird with this one. It
started OK - I used PA in debug mode so I could see something like:
"Fusion requested latency of 32 ms - settings minimum latency to 32 ms
- or something similar), so far so good. After some time though, PA
informed me about underruns and started to increase latency to 64,
128...and so on, which caused the emulator to crash (or rather
freeze). Now the weird part is - if I restarted the emulator without
restarting PA, it would set the latency back to the one that crashed
the emu in the first place, and not for the 32 ms it started with -
this of course caused emulator to freeze again. Restarting PA helped
for this(I mean PA would set minimum latency for 32 ms again) but
after few minutes - freeze again (with the same latency problem).

I don't know if this is a bug or a feature of PA, but it caused
troubles for this app (and probably others as well). I did noticed
that with low-latency kernel it was much more difficult to trigger
this bug, I also tried with RT kernel and was never able to trigger it
there either - even when system was on full load, but I didn't test RT
kernel for very long so...


>> Sorry for my English.
>No need to apologise for that, I think it was fine :)

Thanks - English is not my native language, so there probably are some
grammar errors in my posts - that's why I prefer to apologize up front
;]
