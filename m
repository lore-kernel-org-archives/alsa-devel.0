From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 17:44:39 +0100
Message-ID: <1272645879.3220.177.camel@odin>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E7724507
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 18:44:42 +0200 (CEST)
Received: by wwb24 with SMTP id 24so268837wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 09:44:42 -0700 (PDT)
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
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-04-29 at 17:38 -0500, pl bossart wrote:
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

How do you handle any clock drift here between the HDA hardware
interface clock and the PA timer ?

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
