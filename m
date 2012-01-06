From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Public ridicule due to sound/soc/soc-core.c abuse
 of the driver model
Date: Fri, 6 Jan 2012 15:49:27 -0800
Message-ID: <20120106234923.GI2893@opensource.wolfsonmicro.com>
References: <20120106194052.GA7781@kroah.com>
	<20120106201458.GF2893@opensource.wolfsonmicro.com>
	<20120106205036.GB13857@n2100.arm.linux.org.uk>
	<20120106234135.GH2893@opensource.wolfsonmicro.com>
	<20120106234445.GC13857@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DB68103B4E
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 00:50:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120106234445.GC13857@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Frank Mandarino <fmandarino@endrelia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 06, 2012 at 11:44:45PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2012 at 03:41:39PM -0800, Mark Brown wrote:
> > This only helps this specific device model bit of things, if anything is
> > still actually holding a reference to the device and tries to use it
> > after we tore away the resource underneath it we'll still explode (never
> > mind the fact that we're backing this stuff up with some global pointers
> > to other devices which may or may not actually be there...).

> Err what?  Explain showing the code where you think this is the case
> with the patch I proposed please.

These aren't new problems being introduced, they're preexisting problems
which aren't fixed by this (hence why I say it "only helps with this
specific device model side of things") but can come up in pretty much
the same circumstances.
