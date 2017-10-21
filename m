From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 07/14] regmap: Add SoundWire bus support
Date: Sat, 21 Oct 2017 17:14:46 +0530
Message-ID: <20171021114446.GI30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-8-git-send-email-vinod.koul@intel.com>
 <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171021093426.vzhv3ponaxhi4yw3@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 10:34:26AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:23AM +0530, Vinod Koul wrote:
> 
> > + *  BSD LICENSE
> > + *
> > + *  Copyright(c) 2015-17 Intel Corporation.
> > + *
> > + *  Redistribution and use in source and binary forms, with or without
> > + *  modification, are permitted provided that the following conditions
> > + *  are met:
> 
> Really unhappy with the dual licensing for regmap code, this is
> interface code for some GPL only kernel code and...

Yeah Greg has same concern wrt core code, I am looking with folks who
understand this more than I do and will update.

> > +static int regmap_sdw_write(void *context, unsigned int reg, unsigned int val)
> > +{
> > +	struct device *dev = context;
> > +	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> > +
> > +	/* Check for Slave */
> > +	if (!slave)
> > +		return 0;
> 
> We silently ignore the device not existing?

Yes will log this one

> > +static struct regmap_bus regmap_sdw = {
> > +	.reg_read = regmap_sdw_read,
> > +	.reg_write = regmap_sdw_write,
> 
> Given that the bus appears to support bulk operations why are we
> implementing this with reg_read() and reg_write()?

Well it is just the start. I would like to have base SOundWire supported
upstream first, have some Slave drivers as well. Its real pain for codec
folks to keep updating their code as we keep developing.
We do plan to add more features as we go along. And yes bulk ops are right
at the top of this list

> 
> > +		return ERR_PTR(ret);
> > +
> > +	return __regmap_init(&sdw->dev, &regmap_sdw,
> > +			&sdw->dev, config, lock_key, lock_name);
> > +}
> > +EXPORT_SYMBOL(__regmap_init_sdw);
> 
> ...this is just an obvious attempt to allow non-GPL code to directly use
> GPL code.

Sorry that was not the aim. We wanted the code to be shared with RTOS code
so they can use stuff from here. I understand the concerns raised and will
surely address that.

-- 
~Vinod
