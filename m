From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 08:59:15 +0800
Message-ID: <w2q4f3252891004291759qf880c494nec124b070accf2e@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<t2n4f3252891004291618t56ceb79fm7eccade128f7d526@mail.gmail.com>
	<k2j6160a5131004291644rd8645dc7oecee28ee290b683f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 21ABC2443C
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 02:59:16 +0200 (CEST)
Received: by pvc30 with SMTP id 30so641489pvc.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 17:59:15 -0700 (PDT)
In-Reply-To: <k2j6160a5131004291644rd8645dc7oecee28ee290b683f@mail.gmail.com>
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

> > do you mean that it only work on HDaudio and not intel8x0 ?
> >
> > How about other drivers ?
>
> It's driver/hardware specific, I guess everyone would have to enable
> this in their drivers. I don't understand what 8x0 does...You're
> welcome to test and do the same for 8x0 if you have the specs and know
> how to disable interrupts.
>
>
Any side effect of this disabling interrupt  ?

Do you mean that all applications must use pulse api instead of alsa-pulse
plugin ?

Did your test included those voip application which require low latency ?

did your test only play one audio stream to the sound server ?

Do those alsa application still work with "hw" device when pulseaudio is
disabled ?
