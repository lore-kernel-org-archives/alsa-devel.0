From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Fri, 14 Jan 2011 09:43:04 +0200
Message-ID: <1294990984.6390.81.camel@masi.mnp.nokia.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
	<20110113171202.GG30351@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C471244A5
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 08:43:11 +0100 (CET)
In-Reply-To: <20110113171202.GG30351@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-13 at 17:12 +0000, ext Mark Brown 
wrote:
wrote:
> I'm not changing the MFD driver, the first version is hopefully going
> > into the v. 2.6.38 kernel.
> 
> Oh, fail.

?

> > At first I started to upstream all three parts of the driver at the same
> > time, about a year ago. At first I sent all parts to the media list,
> > there I was - quite reasonably - asked to send the codec to the alsa
> > list. After some tuning and fine tuning the codec got accepted. But
> > getting the rest of the driver in took much longer and in the process
> > the MFD and V4L2 parts became incompatible with the codec.
> 
> This is something that should really have been brought up when making
> changes.  It's really bad to just go and make other bits of the kernel
> fail to build.

I'm not exactly sure what you mean here... It's easy to say now - when
looking back that - the whole driver should have been handled more as a
whole. An ACK from you and an ACK from Samuel to the media guys etc...

But I'm not trying to break the kernel or the build process or irritate
you. I'm just trying to get this driver in because that's a part of my
job. And on the other hand I've followed every bit of advice I've gotten
along the way.

> While looking at this I also notice that it's surprisingly difficult to
> actually build any of this stuff - the MFD core can't be enabled
> directly, it's only available if you enable the V4L driver, and the core
> V4L build appears to be rather large adding a noticable amount of time
> to the build needed to get coverage of the CODECs.  It'd be good if you
> could fix this to remove the dependency, I'd really expect the MFD to be
> able to build by itself.

My original plan was to have an MFD part with all the core functionality
and then the child drivers as two different clients to the core. With
that design it was possible to build the MFD with either, both or none
of the children... But the media people wanted an empty MFD part and all
basic functionality in the V4L2 driver. And the MFD driver was acked by
Samuel the MFD maintainer.

The codec can already be built alone, I can't see what benefit would
building the empty MFD driver offer. With the current structure nothing
can actually be done without the V4L2 driver. But if there's something I
don't get right now, I'll be happy make changes.

> > So we'll just wait until 2.6.38 is out and everything remains
> > compilable... When 38 gets released the codec cannot be used with rest
> > of the driver until this patch is applied, but that can be done when a
> > suitable window opens, right? 
> 
> *Ideally* we'd have this API change included as part of the MFD driver
> merge or included in 2.6.37 since otherwise we cause build issues.  ASoC
> has already been sent to Linus for this merge window.  As it is I guess
> we have to apply this and send a fix later.

OK, sounds good...

Cheers,
Matti
