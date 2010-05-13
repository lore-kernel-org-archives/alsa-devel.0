From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Thu, 13 May 2010 08:04:46 +0800
Message-ID: <AANLkTinldjj9GuxteZiN8DzeA-gRNao-HWwqkFxOPyYy@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
	<AANLkTimPaE9JTd8XIVcM6JQvmD73JHkSWMjKT8zsdGR2@mail.gmail.com>
	<20100512141653.GB4312@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DE8D245E1
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 02:04:47 +0200 (CEST)
Received: by pxi13 with SMTP id 13so359052pxi.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 17:04:46 -0700 (PDT)
In-Reply-To: <20100512141653.GB4312@sirena.org.uk>
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

2010/5/12 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Wed, May 12, 2010 at 08:50:42AM -0500, pl bossart wrote:
>
> > This might be almost equivalent to the timer approach in terms of # of
> > wakeups, however the timer can be reprogrammed on-the-fly whereas
> > periods can only be changed by closing and reopening the device. You
> > can also adjust the timer shall underflows occur. And the timer slack
> > lets the kernel group events. Not to mention that you will need
>
> The timer is also useful for allowing PulseAudio to dynamically adjust
> the period size as the runtime situation changes - if you're running
> high latency streams and have a low latency application start up then
> PulseAudio can just change the timer to get more frequent events.
>

how low latency can PA provide ?

any tool to measure the latency ?

seem alsa-lib/test/latency did not work on pulse device
