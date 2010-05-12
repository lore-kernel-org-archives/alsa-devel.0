From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 22:41:39 +0800
Message-ID: <AANLkTikjhUxZxvNYnXlnb8yxmmrj3OdE6fxmjWPzLTXX@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BD2EE1038A3
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 16:41:40 +0200 (CEST)
Received: by pvg6 with SMTP id 6so93596pvg.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 07:41:39 -0700 (PDT)
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

The problem is PA require hw_ptr with precision but PA server did not
provide same precision to PA client through alsa-pulseaudio plugin , this
inaccuracy lead to underrun easily
