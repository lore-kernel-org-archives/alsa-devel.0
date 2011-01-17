From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Mon, 17 Jan 2011 10:52:26 +0200
Message-ID: <1295254346.25951.23.camel@masi.mnp.nokia.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
	<20110113171202.GG30351@opensource.wolfsonmicro.com>
	<1294990984.6390.81.camel@masi.mnp.nokia.com>
	<20110114122250.GC20846@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 3300E1037F9
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 09:52:40 +0100 (CET)
In-Reply-To: <20110114122250.GC20846@opensource.wolfsonmicro.com>
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

On Fri, 2011-01-14 at 12:22 +0000, ext Mark Brown wrote:
> On Fri, Jan 14, 2011 at 09:43:04AM +0200, Matti J. Aaltonen wrote:
> > On Thu, 2011-01-13 at 17:12 +0000, ext Mark Brown 
> 
> > > This is something that should really have been brought up when making
> > > changes.  It's really bad to just go and make other bits of the kernel
> > > fail to build.
> 
> > I'm not exactly sure what you mean here... It's easy to say now - when
> > looking back that - the whole driver should have been handled more as a
> > whole. An ACK from you and an ACK from Samuel to the media guys etc...
> 
> If you're making an incompatible change in an API used by code that is
> already part of the kernel then you need to make sure that that code is
> updated as part of introducing the new API.

OK, I agree, that's something I overlooked...

> > > While looking at this I also notice that it's surprisingly difficult to
> > > actually build any of this stuff - the MFD core can't be enabled
> > > directly, it's only available if you enable the V4L driver, and the core
> > > V4L build appears to be rather large adding a noticable amount of time
> > > to the build needed to get coverage of the CODECs.  It'd be good if you
> > > could fix this to remove the dependency, I'd really expect the MFD to be
> > > able to build by itself.
> 
> > The codec can already be built alone, I can't see what benefit would
> > building the empty MFD driver offer. With the current structure nothing
> > can actually be done without the V4L2 driver. But if there's something I
> > don't get right now, I'll be happy make changes.
> 
> As things stand the only way the CODEC driver can be built is if V4L is
> enabled, which like I say isn't a trivial build.  This isn't ideal when
> trying to get build coverage of the CODEC drivers for work on the core,
> it adds noticable additional delay.

The codec can be compiled alone as the comment in
sound/soc/codecs/Kconfig suggest:

> help
> Normally ASoC codec drivers are only built if a
> machine driver which uses them is also built since
> they are only usable with a machine driver. 
> Selecting this option will allow these drivers to be
> built without an explicit machine driver for test
> and development purposes.

And as I said, with my original design the core (MFD) could have been
compiled (and used) with either child driver: the codec and the V4L2
part. A fact is that Mauro didn't accept that structure, he wanted to
have all functionality (except for the audio) in the V4L2 driver.

And also the question is: what should be done now or next. If you mean
that the dependence between V4L2 part and the core should be removed,
that's easy to do but what's we gain with that? I would like to return
to the original structure, but that doesn't seem to be possible?
