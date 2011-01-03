From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Mon, 3 Jan 2011 16:28:26 +0000
Message-ID: <20110103162826.GA7370@opensource.wolfsonmicro.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
	<20110102134715.GE4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
	<20110103154319.GC6783@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2EC9@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1089F24372
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 17:28:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C10F2EC9@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 09:31:26PM +0530, Koul, Vinod wrote:

> > That helps but in that case you also need to remove all the device
> > registration stuff except for the actual machine driver from the init
> > and exit functions.  The CPU stuff is all a fixed property of the CPU
> > and should be reigstered by the architecture code (possibly with some
> > control for the individual machine), the CODEC should be being
> > enumerated by whatever normally does that.  The only thing this driver
> > should be doing is specifying how these things are connected.

> Yes, this patch had only the machine specific controls and dai link.
> It also creates the audio platform devices soc-audio platform and codec device.
> It doesn't do anything else

This is preceisely the problem.  As I said the machine driver should
only be instantiating the machine driver.  Actual physical devices
should be being instnantiated using the relevant buses.

Please look at how other platforms are doing this; you should be
following the same process.

> > What exactly is the msic CODEC?  Given the references to non-specific
> > "vendor" registers it doesn't sound like a particular CODEC driver.

> Since Medfield platform is not declared yet we can't reveal the name of the
> codec vendor. The Moorestown codecs which we will add will not be nameless
> as this one and we will add as vendorversion.c format as in current codec
> drivers. I will replace this msic driver name once the platform is publically
> declared.

So you're saying this is a driver for a specific device that you're
releasing under a code name?  That's not what the code looks like.
None of this seems terribly clever for mainline; there's too many things
about these drivers don't look like what you'd expect embedded audio
drivers for Linux to look like from a 1000 foot level.
