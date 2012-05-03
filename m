From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Thu, 3 May 2012 10:39:29 +0200
Message-ID: <CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E0DAC10405F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 10:39:29 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1668464yhn.38
	for <alsa-devel@alsa-project.org>; Thu, 03 May 2012 01:39:29 -0700 (PDT)
In-Reply-To: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,


2012/5/1 Grant Diffey <gdiffey@gmail.com>:
> I can't seem to get below 512frames in flight (2 256sample frames or 4 128
> or 8 64's) without consistant overruns.

at least at 44.1 and 48 kHz I can get it to run without consistent
xruns with 3 periods/buffer and 128 frames/period.
For 88.2 and 96 kHz I need to go to 4 periods/buffer. Less than 128
frames/period lead to consistent xruns no matter how many
periods/buffer I use.

I've been using a kernel freshly cloned from Tiwai's git with the
latest rt patch on a rather slow laptop. I've switched to Fedora on
that machine a couple of days ago so I don't know yet if my system
settings are properly adjusted for Jack, yet.

> This leads to rather high latencies (22ms+) or is this conclusion bogus?

Yes, I guess that this conclusion is bogus.

First, even at 44.1 kHz I think that you rather get 11.6 ms latency
(512/44.1). At 96 kHz this reduces to 5.3 ms.

I've even done some measurements using jack_iodelay. At 96 kHz I get a
total round trip latency of 17.5 ms. According to the jack_iodelay
manpage this corresponds (if I get it right) to an hardware
input/output latency of the device of ~584 frames (6.1 ms).

This would lead to the (maybe bogus) conclusion that we have a total
output latency of 11.4 ms.

By the way, if you're using jack2 you would probably want to start it
in synchronous mode (with the -S option ). Otherwise you get an
implicit extra period/buffer. (I guess you already know that.)

@Daniel: I could not find any difference between my latest
"old-streaming-logic" kernel and my latest "new-streaming-logic"
kernel.

Regards,

Felix
