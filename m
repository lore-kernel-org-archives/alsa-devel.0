From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Mon, 3 Jan 2011 23:04:11 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C10F2F06@bgsmsx502.gar.corp.intel.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
	<20110102134715.GE4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
	<20110103154319.GC6783@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2EC9@bgsmsx502.gar.corp.intel.com>
	<20110103162826.GA7370@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 529E81038C7
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 18:34:39 +0100 (CET)
In-Reply-To: <20110103162826.GA7370@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> > Yes, this patch had only the machine specific controls and dai link.
> > It also creates the audio platform devices soc-audio platform and codec
> device.
> > It doesn't do anything else
> 
> This is preceisely the problem.  As I said the machine driver should
> only be instantiating the machine driver.  Actual physical devices
> should be being instnantiated using the relevant buses.
> 
> Please look at how other platforms are doing this; you should be
> following the same process.
Thanks, I will add the soc-audio only and move the others to core.
So now this machine driver will only add machine controls and dai link along with soc-audio device.
Would that suffice

> > > What exactly is the msic CODEC?  Given the references to non-specific
> > > "vendor" registers it doesn't sound like a particular CODEC driver.
> 
> > Since Medfield platform is not declared yet we can't reveal the name of the
> > codec vendor. The Moorestown codecs which we will add will not be nameless
> > as this one and we will add as vendorversion.c format as in current codec
> > drivers. I will replace this msic driver name once the platform is publically
> > declared.
> 
> So you're saying this is a driver for a specific device that you're
> releasing under a code name?  That's not what the code looks like.
> None of this seems terribly clever for mainline; there's too many things
> about these drivers don't look like what you'd expect embedded audio
> drivers for Linux to look like from a 1000 foot level.
This is codec from TI and I will remove the msic name now.
It will now be ti-sn95031.c
Does this address your concern on this issue?

~Vinod
