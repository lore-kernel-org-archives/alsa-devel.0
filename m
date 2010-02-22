From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Latency of mixer reconfiguration
Date: Mon, 22 Feb 2010 16:50:40 +0800
Message-ID: <4f3252891002220050n6198d49dn61ab6f1c0720c78e@mail.gmail.com>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
	<4f3252891002191959v418f6cb4u6cf4b4deb0a7a15b@mail.gmail.com>
	<20100221192621.GC30380@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f204.google.com (mail-px0-f204.google.com
	[209.85.216.204])
	by alsa0.perex.cz (Postfix) with ESMTP id D2E66103813
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 09:50:41 +0100 (CET)
Received: by pxi42 with SMTP id 42so1181735pxi.5
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 00:50:40 -0800 (PST)
In-Reply-To: <20100221192621.GC30380@tango.0pointer.de>
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

2010/2/22 Lennart Poettering <mznyfn@0pointer.de>

> On Sat, 20.02.10 11:59, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> >
> > 2010/2/19 Lennart Poettering <mznyfn@0pointer.de>
> >
> > >
> > > On Thu, 18.02.10 10:01, Mark Brown (
> broonie@opensource.wolfsonmicro.com)
> > > wrote:
> > >
> > >
> > > The current logic is to not do any software adjustment if the hardware
> > > adjustment is "close enough" to the total adjustment we want to do,
> > > tested against a threshold. Which I think is quite a reasonable
> > > approach because it enables/disables this feature not globally, but
> > > looks at each case and enables this logic only if it really has a
> > > benefit.
>
> > PA 's watermark is already 20 ms if you want to do any software
> adjustment
> > by PA server
>
> It's not necessarily 20ms. That's just the default (which we
> unfortunately had to pick very large, since ALSA right now does not
> inform us about transfer block granularity).
>

I think ALSA did inform the appliication the the granularit is period size,
it is the responsibilty of the application which use timer scheduling to
find out the optimum granularity which may varies with different sound card,
different CPU speed



>
> But anyway, whatever the watermark is: this is a latency we know
> about, which means that we can delay the hw mixer updating
> accordingly. But that works correctly only if the hw mixer updating is
> immediate. WHich it most likely is not.
>

do you mean PA server will perform snd_pcm_rewind when the user change the
mixer volume ?


>
> So we now the software volume adjustment latency. We don't know the
> hardware volume adjustment latency, and assume it is 0. If we knew
> both we could sync up both changes perfectly, but this way our model
> has a weakness.
>

I have doubt there is any benefit if you even know those hardware volume
adjust ment latency which varies even when using the same chipset by
different OEM vendor sound card


>
> Lennart
> lsa-devel <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>
>
