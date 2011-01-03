From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Mon, 3 Jan 2011 15:43:20 +0000
Message-ID: <20110103154319.GC6783@opensource.wolfsonmicro.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
	<20110102134715.GE4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29DDB2414A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 16:43:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
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

On Mon, Jan 03, 2011 at 11:09:16AM +0530, Koul, Vinod wrote:

> > If this is intended to be
> > a generic driver that manages the interaction with your BIOS then I'd
> > expect to see something like that.  If it's a driver for a specific
> > system then I'd expect the driver to say what it's a driver for.

> No, per your suggestion we made it machine specific driver. Yes will rename it
> to mid_machine_mfld as this is Medfield specific machine driver
> Does that fix your concern?

That helps but in that case you also need to remove all the device
registration stuff except for the actual machine driver from the init
and exit functions.  The CPU stuff is all a fixed property of the CPU
and should be reigstered by the architecture code (possibly with some
control for the individual machine), the CODEC should be being
enumerated by whatever normally does that.  The only thing this driver
should be doing is specifying how these things are connected.

> > Also, looking at your CODEC driver I'm not seeing anything that looks
> > like the handling for the three "nameless" CODEC vendors you've got -
> > given that you've got vendor workarounds in the code there this is
> > really surprising.

> The msic.c is msic codec which is specific to Medfield platform only. The other
> three codecs are for Moorestown and we will add them ( 3 separate codec drivers)
> when we add Moorestown machine (next after completing this)

What exactly is the msic CODEC?  Given the references to non-specific
"vendor" registers it doesn't sound like a particular CODEC driver.
