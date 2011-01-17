From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Mon, 17 Jan 2011 13:56:34 +0000
Message-ID: <20110117135634.GB21113@opensource.wolfsonmicro.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
	<20110113171202.GG30351@opensource.wolfsonmicro.com>
	<1294990984.6390.81.camel@masi.mnp.nokia.com>
	<20110114122250.GC20846@opensource.wolfsonmicro.com>
	<1295254346.25951.23.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EE4510381F
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 14:56:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295254346.25951.23.camel@masi.mnp.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 10:52:26AM +0200, Matti J. Aaltonen wrote:
> On Fri, 2011-01-14 at 12:22 +0000, ext Mark Brown wrote:

> > As things stand the only way the CODEC driver can be built is if V4L is
> > enabled, which like I say isn't a trivial build.  This isn't ideal when
> > trying to get build coverage of the CODEC drivers for work on the core,
> > it adds noticable additional delay.

> The codec can be compiled alone as the comment in
> sound/soc/codecs/Kconfig suggest:

> > help
> > Normally ASoC codec drivers are only built if a
> > machine driver which uses them is also built since
> > they are only usable with a machine driver. 
> > Selecting this option will allow these drivers to be
> > built without an explicit machine driver for test
> > and development purposes.

I'm not entirely clear how that follows from the above?  The issue here
is primarily in terms of test building with SND_SOC_ALL_CODECS.

> And as I said, with my original design the core (MFD) could have been
> compiled (and used) with either child driver: the codec and the V4L2
> part. A fact is that Mauro didn't accept that structure, he wanted to
> have all functionality (except for the audio) in the V4L2 driver.

I don't particularly care if the resulting driver is useful but it
should at least be possible to build the two subsystems independantly.
If it's not even possible to do that then why is there a MFD driver in
the first place?

> And also the question is: what should be done now or next. If you mean
> that the dependence between V4L2 part and the core should be removed,
> that's easy to do but what's we gain with that? I would like to return
> to the original structure, but that doesn't seem to be possible?

It means we'd be able to get build coverage of each subsystem without
having to enable the other, having to pick up only the core rather than
an entire new subsystem.
