From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 09:09:12 +0800
Message-ID: <i2k4f3252891004291809z5604e08chfbd8c0c000b4d517@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 623E92444A
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 03:09:14 +0200 (CEST)
Received: by pxi13 with SMTP id 13so3180953pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 18:09:12 -0700 (PDT)
In-Reply-To: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/30 pl bossart <bossart.nospam@gmail.com>

> Howdy,
> When PulseAudio is used and all PCM is routed through PulseAudio
> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
> PulseAudio uses a timer to refill buffers and the period interrupts
> are not used at all.
>
> So why not disable them entirely to reduce the number of wakeups? This
> is possible with a number of existing DMA controllers. The simple
> patch attached shows a proof-of-concept on HDAudio, it's been working
> for 5 hours on my Fedora12 laptop without any glitches and powertop
> does show _zero_ wakeups from the HDAudio controller (except on
> startup). I am told by my colleagues working in Windows environments
> that this is what's done on Vista/Windows7 btw. This isn't to say
> Windows is great but that artificial generation of not-needed
> interrupts is avoidable.
>

Do your test need the patch which you have posted to pulseaudio developer
mailing list

http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/6671

it seem that fix should be in driver side if it is hardware specific
