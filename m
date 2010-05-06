From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 6 May 2010 09:24:05 +0800
Message-ID: <u2y4f3252891005051824vd4583966id36eec52dd016d7d@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id D178924383
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 03:24:07 +0200 (CEST)
Received: by pwj8 with SMTP id 8so2314816pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 05 May 2010 18:24:06 -0700 (PDT)
In-Reply-To: <w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
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

> Hi Clemens,
>
> >> When PulseAudio is used and all PCM is routed through PulseAudio
> >> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
> >> So why not disable them entirely to reduce the number of wakeups? ...
> >> There are probably some cases where you don't want this type of
> >> behavior (broken hardware, legacy code with multiple-buffering,
> >> disabled timer in PulseAudio),
> >
> > It's interesting that all ALSA applications except PA are "legacy".  :)
>
> Ha. Nice slip. I didn't mean legacy was bad... It's perfectly ok to
> use multiple buffers and interrupts in a variety of apps.
>
> >> so I think it would make sense to request the disabling of interrupts
> >> when hw_params are set, since this is also the time when period sizes
> >> are set.
> >
> > Yes.  For compatibility with the existing ALSA API, this needs to be
> > a flag that is not enabled by default.
>
> Agreed. This shouldn't even be mandatory since this option might not
> be possible in all platforms.
>
> >> I am aware that some changes would be needed in pcm_lib.c, where all
> >> the error checks are done.
> >
> > Plus all the API changes in the ALSA kernel framework, the ALSA kernel/
> > userspace interface, and the alsa-lib interface.
>
> I am not following this point. If you add a simple flag to an existing
> interface, why would we need to change the kernel/userspace inferface?
> This change should be possible in a backwards compatible manner as an
> additional option provided to the application developer.
> Cheers
> -Pierre
>

Do your proposal allow one application use "leagcy" method and the other
application use PA since my HDA codec seem allow multi streamming capture ?


card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
