From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WL1273 FM radio: Access I2C IO
 functions through pointers.
Date: Thu, 13 Jan 2011 17:12:02 +0000
Message-ID: <20110113171202.GG30351@opensource.wolfsonmicro.com>
References: <1294924965-6358-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1294925701.3453.5.camel@odin>
	<1294928273.6390.5.camel@masi.mnp.nokia.com>
	<20110113150113.GC20480@sirena.org.uk>
	<1294935501.6390.44.camel@masi.mnp.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 06F56103B4B
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:14:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294935501.6390.44.camel@masi.mnp.nokia.com>
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

On Thu, Jan 13, 2011 at 06:18:21PM +0200, Matti J. Aaltonen wrote:

> I'm not changing the MFD driver, the first version is hopefully going
> into the v. 2.6.38 kernel.

Oh, fail.

> At first I started to upstream all three parts of the driver at the same
> time, about a year ago. At first I sent all parts to the media list,
> there I was - quite reasonably - asked to send the codec to the alsa
> list. After some tuning and fine tuning the codec got accepted. But
> getting the rest of the driver in took much longer and in the process
> the MFD and V4L2 parts became incompatible with the codec.

This is something that should really have been brought up when making
changes.  It's really bad to just go and make other bits of the kernel
fail to build.

While looking at this I also notice that it's surprisingly difficult to
actually build any of this stuff - the MFD core can't be enabled
directly, it's only available if you enable the V4L driver, and the core
V4L build appears to be rather large adding a noticable amount of time
to the build needed to get coverage of the CODECs.  It'd be good if you
could fix this to remove the dependency, I'd really expect the MFD to be
able to build by itself.

> So we'll just wait until 2.6.38 is out and everything remains
> compilable... When 38 gets released the codec cannot be used with rest
> of the driver until this patch is applied, but that can be done when a
> suitable window opens, right? 

*Ideally* we'd have this API change included as part of the MFD driver
merge or included in 2.6.37 since otherwise we cause build issues.  ASoC
has already been sent to Linus for this merge window.  As it is I guess
we have to apply this and send a fix later.
