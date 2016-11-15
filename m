From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 01/14] SoundWire: Add SoundWire bus driver documentation
Date: Tue, 15 Nov 2016 19:59:14 +0530
Message-ID: <20161115142914.GN3000@localhost>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-2-git-send-email-hardik.t.shah@intel.com>
 <20161114141548.GL1575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161114141548.GL1575@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2016 at 02:15:48PM +0000, Charles Keepax wrote:
> > +static int my_sdw_register_master()
> > +{
> > +	struct sdw_master master;
> > +	struct sdw_master_capabilities *m_cap;
> > +
> > +	m_cap = &master.mstr_capabilities;
> > +
> > +	/*
> > +	 * Fill the Master device capability, this is required
> > +	 * by bus driver to handle bus configurations.
> > +	 */
> > +	m_cap->highphy_capable = false;
> > +	m_cap->monitor_handover_supported = false;
> > +	m_cap->sdw_dp0_supported = 1;
> > +	m_cap->num_data_ports = INTEL_SDW_MAX_PORTS;
> > +
> > +	return snd_sdw_master_add(&master);
> > +}
> > +
> > +Master driver gets registered for controlling the Master device. It
> > +provides the callback functions to the bus driver to control the bus in
> > +device specific way. Device and Driver binds according to the standard
> > +Linux device-driver bind model. Master driver is registered from the
> > +driver init code. Below code shows the sample Master driver
> > +registration.
> > +
> > +static struct sdw_master_driver intel_sdw_mstr_driver = {
> > +	.driver_type = SDW_DRIVER_TYPE_MASTER,
> > +	.driver = {
> > +		.name   = "intel_sdw_mstr",
> > +		.pm     = &intel_sdw_pm_ops,
> > +	},
> > +
> > +	.probe          = intel_sdw_probe,
> > +	.remove         = intel_sdw_remove,
> > +	.mstr_ops       = &intel_sdw_master_ops,
> > +	.mstr_port_ops = &intel_sdw_master_port_ops,
> > +};
> > +
> > +static int __init intel_sdw_init(void) {
> > +	return snd_sdw_master_register_driver(&intel_sdw_mstr_driver);
> > +}
> 
> Would be good to hear some detail the reasoning for the design
> choices here? Normally (I2C/SPI) the master sits on whatever bus
> the host uses to talk to the master so often this might be the
> platform bus for memory mapped devices, it then creates a bus and
> slaves register to that. This also has the nice property that its
> easy to create devices that sit behind other buses, for example
> here we might want a SoundWire master that sits behind a SPI bus.
> But you seem to have gone in the other direction and have the
> master sitting on the same bus as the slaves.

Since the controller on our SoC was enumerable, people went with this
approach. In this hindsight that may not have been the best choice.

So it will be fixed in next rev.

-- 
~Vinod
