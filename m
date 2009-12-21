From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
	is exceptionally large: 349696 bytes (1821 ms).
Date: Mon, 21 Dec 2009 11:41:35 +0800
Message-ID: <4f3252890912201941h1940c8a1j7fccd135e027b1b2@mail.gmail.com>
References: <1261191766.18070.10.camel@localhost.localdomain>
	<4f3252890912191547x1996cf7es190e8dac71dacaae@mail.gmail.com>
	<1261272369.18070.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EA56103821
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 04:41:37 +0100 (CET)
Received: by pwi18 with SMTP id 18so12037929pwi.32
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 19:41:35 -0800 (PST)
In-Reply-To: <1261272369.18070.42.camel@localhost.localdomain>
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

2009/12/20 Chris <cpollock@embarqmail.com>

> On Sun, 2009-12-20 at 07:47 +0800, Raymond Yau wrote:
> > I can reproduce this bug on pulseaudio-0.9.14 by
> >
> > aplay -v --period-size=32  any_rate_not_equal_44100Hz.wav
> >
> >
> Note - I reported this as bug#
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4834 on 14
> December.
>
>
>
http://thread.gmane.org/gmane.linux.alsa.devel/60371

It seem that PA using one or two periods per buffer , the watermark is
alwaysl 20ms for ens1371 for both cases.

when the alsa application (e.g. aplay ) using two periods per buffer , the
buffer are almost 50% full at all time (i.e 175 ms watermark is much higher
than PA glitch mode 's 20ms watermark )

The possibilty of getting underrun is quite high when PA server/PA client
cannot fill the 350 ms buffer in 20ms
