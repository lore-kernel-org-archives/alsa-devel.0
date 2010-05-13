From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 13 May 2010 15:27:10 +0800
Message-ID: <AANLkTinIiCR7ctLQhq1kudg5Jx9RcMfld4uhmUI1tr_i@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 174722415F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 09:27:11 +0200 (CEST)
Received: by pzk40 with SMTP id 40so590534pzk.23
	for <alsa-devel@alsa-project.org>; Thu, 13 May 2010 00:27:10 -0700 (PDT)
In-Reply-To: <AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
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

2010/5/12 pl bossart <bossart.nospam@gmail.com>

> > It seems the requirement is just to have as least wakeups as possible
> > in order to
> > maximize power savings.
> > If so, then how about setting the period size slightly smaller than
> > the ring-buffer: the
> > difference being just enough to refill the ring buffer. Of course, you
> > would have to
> > enforce full-buffer-size as the start threshold.
> > We do just that to implement low-power-audio-mode for latest Samsung
> > SoC's I2S blocks.
>
> Thanks for the heads-up Jassi, this is interesting info that does show
> the need to reduce the number of wakeups in embedded low-power
> solutions...
> This might be almost equivalent to the timer approach in terms of # of
> wakeups, however the timer can be reprogrammed on-the-fly whereas
> periods can only be changed by closing and reopening the device. You
> can also adjust the timer shall underflows occur. And the timer slack
> lets the kernel group events. Not to mention that you will need
> specific apps written to make use of this mode. The only drawback of
> the timer approach is that you need to keep track of drifts between
> system and audio clock and that you need the hardware and driver to
> report the hw_ptr with precision.
>

it depend on the ratio of watermark and the buffer time

PA use 20 ms watermark and 2 s buffer time which require the driver report
hw_ptr with precision . if the watermark is 50% of the buffer time ,this
will fall back to the traditional model two periods per buffer

so it depend on whether PA allow user to adjust the watermark for their
desktop or laptop
