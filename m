From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH 04/14] soundwire: Add MIPI DisCo property
 helpers
Date: Fri, 20 Oct 2017 10:55:18 +0530
Message-ID: <20171020052518.GI30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-5-git-send-email-vinod.koul@intel.com>
 <s5hfuaftss5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hfuaftss5.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 19, 2017 at 11:02:02AM +0200, Takashi Iwai wrote:
> On Thu, 19 Oct 2017 05:03:20 +0200,
> Vinod Koul wrote:
> >  
> > +	slave->ops = drv->ops;
> > +
> >  	ret = drv->probe(slave, id);
> >  	if (ret) {
> >  		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> >  		return ret;
> >  	}
> >  
> > +	/* device is probed so let's read the properties now */
> > +	if (slave->ops && slave->ops->read_prop)
> > +		slave->ops->read_prop(slave);
> > +
> > +	/*
> > +	 * Check for valid clk_stop_timeout, use DisCo worst case value of
> > +	 * 300ms
> > +	 */
> > +	if (slave->prop.clk_stop_timeout == 0)
> > +		slave->prop.clk_stop_timeout = 300;
> > +
> > +	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
> > +					slave->prop.clk_stop_timeout);
> 
> Isn't it racy?
> Also what happens after removing a driver?  The clk_stop_timeout is
> kept high?

Well the spec mandates 300 as worst case, in practice this _should_ be
lesser. I need to double check on behaviour of clock stop on driver removal.
We need to keep in mind that multiple Slaves can be on a bus and removal
maybe from one of them, so we may not do clock stop.

> > +
> > +int sdw_slave_read_dpn(struct sdw_slave *slave,
> > +		struct sdw_dpn_prop *dpn, int count, int ports, char *type)
> 
> Missing comment for a public API function.

Ah missed this one. It was made public for debug, lets make it static now :)

-- 
~Vinod
