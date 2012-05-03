From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Thu, 3 May 2012 16:03:38 +0200
Message-ID: <CAFz=ag6d+zcHrNhxKwaTHQYb04GJEKDXjowz4NhXtERAV-zjag@mail.gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
	<CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ABCC8104450
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 16:03:39 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1926551yhn.38
	for <alsa-devel@alsa-project.org>; Thu, 03 May 2012 07:03:38 -0700 (PDT)
In-Reply-To: <CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some more observations:

I've measured the latency on the same machine running Windows 7 using
Centrance's latency test utility (http://centrance.com/downloads/ltu/)
and got much better results than under Linux. That's a bit
disappointing...

I don't know if these latencies come xrun-free since I don't know how
to detect xruns on Windows. On the other hand, telling Jack not to
complain about xruns from Alsa (softmode) I can get down to 64
frames/period and 2 periods/buffer without any noticable glitches or
crackles (playing a sine test tone). Maybe the Windows driver just
doesn't complain either?

Nevertheless, I'm a bit surprised that just starting Jack without any
clients will result in a flood of xruns at small buffer sizes. Is
there anything we can do about it? Is this to be expected? Is this a
flaw in Alsa, Jack or the USB stack? Is there a way to debug these
xruns?

Any suggestions?

Regards,
Felix
