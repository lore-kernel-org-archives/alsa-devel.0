From: Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v2 04/14] soundwire: Add MIPI DisCo property helpers
Date: Fri, 24 Nov 2017 21:34:49 +0530
Message-ID: <20171124160448.GB11781@buildpc-HP-Z230>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-5-git-send-email-vinod.koul@intel.com>
 <20171123143812.braw737aciq4qmb7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171123143812.braw737aciq4qmb7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 23, 2017 at 02:38:12PM +0000, Charles Keepax wrote:
> On Fri, Nov 10, 2017 at 05:19:06PM +0530, Vinod Koul wrote:

> > MIPI Discovery And Configuration (DisCo) Specification for SoundWire
> > specifies properties to be implemented for SoundWire Masters and
> > Slaves. The DisCo spec doesn't mandate these properties. However,
> > SDW bus cannot work without knowing these values.
> > 
> > The helper functions read the Master and Slave properties.
> > Implementers of Master or Slave drivers can use any of the below
> > three mechanisms:
> >    a) Use these APIs here as .read_prop() callback for Master
> >       and Slave
> >    b) Implement own methods and set those as .read_prop(), but invoke
> >       APIs in this file for generic read and override the values with
> >       platform specific data
> >    c) Implement ones own methods which do not use anything provided
> >       here
> > 
> > Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  5 files changed, 733 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/soundwire/mipi_disco.c
> > --- a/drivers/soundwire/bus_type.c
> > +++ b/drivers/soundwire/bus_type.c
> > @@ -135,6 +135,8 @@ static int sdw_drv_probe(struct device *dev)
> >  		return ret;
> >  	}
> >  
> > +	slave->ops = drv->ops;
> > +
> >  	ret = drv->probe(slave, id);
> >  	if (ret) {
> >  		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> > @@ -142,6 +144,22 @@ static int sdw_drv_probe(struct device *dev)
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
> > +	 *
> > +	 * TODO: check the timeouts and driver removal case
> > +	 */
> > +	if (slave->prop.clk_stop_timeout == 0)
> > +		slave->prop.clk_stop_timeout = 300;
> > +
> > +	slave->bus->clk_stop_timeout = max_t(u32, slave->bus->clk_stop_timeout,
> > +					slave->prop.clk_stop_timeout);
> > +
> >  	return 0;
> >  }
> >  
> 
> This brings up something I have been struggling with a little on
> both the soundwire and slimbus chains at the moment.
> 
> This happens after probe but if I am understanding right these
> properties might be required to communicate with the device.
> Which directly implies that probe shouldn't attempt to talk to
> the device? This is also implied in both series by the fact that
> probe will usually setup the things necessary for enumeration
> (power, clocks, etc). But it is fairly common in probe to at
> least do something like read some ID registers to check we are
> probing the right device.
> 
> On the slimbus side I guess you can get round this using the fact
> they have device_status callbacks to the driver so the driver can
> tell when the device is actually available, and could perform
> some actions when the device first becomes available on the
> bus. But this SoundWire chain doesn't have an equivalent.

We have similar device status callback (update_status) to report driver
about Slave status change. Bus calls update_status when Slave reports
status change (please check patch 09/14).

> Apologies for the long and slightly vague comment, but I guess my
> question is do you have a thought on how drivers should know when
> it is safe to communicate with a SoundWire device?

IMO it is safe to communicate with SoundWire device when the Slave
status is ATTACHED. In any case bus will report error if it is not able
to communicate with SoundWire device.

> Thanks,
> Charles

-- 
