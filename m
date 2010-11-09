From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Hang in snd_pcm_writei with alsa-pulse plugin
Date: Tue, 9 Nov 2010 20:20:39 +0800
Message-ID: <AANLkTinhPaMbJ7DHfbZngaiWwZU7yMULRNgk4nD=DPbW@mail.gmail.com>
References: <20101101013819.GA22823@flim.org> <4CCEF918.90807@colin.guthr.ie>
	<AANLkTikxDrqXGVwk=-dGokWWxbHyeLKNEZzM3pvH2QKv@mail.gmail.com>
	<20101102044421.GA2588@flim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B7C1910384E
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:20:42 +0100 (CET)
Received: by eyg24 with SMTP id 24so3480163eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 04:20:40 -0800 (PST)
In-Reply-To: <20101102044421.GA2588@flim.org>
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

2010/11/2 Matthew Gregan <kinetik@flim.org>

> At 2010-11-02T10:43:54+0800, Raymond Yau wrote:
>
>
> Thanks for confirming that you can reproduce the problem.  I've since
> discovered that it's possible to produce the same problem with the
> PulseAudio API directly, so I'll take this up on pulseaudio-discuss@.
>
> Cheers,
> -mjg
>

A buggy PA client can easily crash the PA server

http://0pointer.de/lennart/projects/pulseaudio/doxygen/sample.html

PulseAudio supports any sample rate between 1 Hz and 192000 Hz

http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7759

Just change the rate of your program ptest.c from 48000 Hz to 1 Hz , this
will abort the PA server

E: sink-input.c: Assertion 'tchunk.length > 0' failed at
pulsecore/sink-input.c:551, function pa_sink_input_peek(). Aborting.

Seem that PA server did not check whether the info send by the PA client is
really supported by the server
