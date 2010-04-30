From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 11:47:52 +0800
Message-ID: <l2z4f3252891004292047x53942f74labf5af17b6e4f53f@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 063F4244FA
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 05:47:56 +0200 (CEST)
Received: by pxi13 with SMTP id 13so3238440pxi.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 20:47:55 -0700 (PDT)
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
> There are probably some cases where you don't want this type of
> behavior (broken hardware, legacy code with multiple-buffering,
> disabled timer in PulseAudio), so I think it would make sense to
> request the disabling of interrupts when hw_params are set, since this
> is also the time when period sizes are set. I am aware that some
> changes would be needed in pcm_lib.c, where all the error checks are
> done. Takashi, Jaroslav, Lennart, what do you think?
> Feedback and suggestions welcome.
> Cheers
> - Pierre
>

How about SPDIF/HDMI and AC3 passthrough which PA seem not supported ?

what is your definition of legacy code with multiple buffering ?

How low latency can the application have when this mode can achieved ?

cases which may not want this type of behaviour
1) desktop computer which power saving is not main concern
2) players want to play interactive game or voip which require low latency
3) Consumers also want the ability to play back two different audio tracks,
such as a CD and a DVD simultaneously, which can't be done using current
audio solutions. Intel HD Audio features multi-streaming capabilities that
give users the ability to send two or more different audio streams to
different locations at the same time, from the same PC.

http://www.intel.com/design/chipsets/hdaudio.htm
