From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC 01/14] SoundWire: Add SoundWire bus driver documentation
Date: Mon, 14 Nov 2016 14:15:48 +0000
Message-ID: <20161114141548.GL1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-2-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-2-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 06:10:59PM +0530, Hardik Shah wrote:
> This patch adds summary documentation of SoundWire bus driver support in
> Linux.
> 
> Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  Documentation/sound/alsa/sdw/summary.txt |  253 ++++++++++++++++++++++++++++++
>  1 file changed, 253 insertions(+)
>  create mode 100644 Documentation/sound/alsa/sdw/summary.txt
> 
> diff --git a/Documentation/sound/alsa/sdw/summary.txt b/Documentation/sound/alsa/sdw/summary.txt
> new file mode 100644
> index 0000000..dc62817
> --- /dev/null
> +++ b/Documentation/sound/alsa/sdw/summary.txt
> @@ -0,0 +1,253 @@
<snip>
> +Programming interfaces (SoundWire Master interface Driver)
> +==========================================================
> +
> +SoundWire bus driver supports programming interfaces for the SoundWire
> +Master and SoundWire Slave devices. All the code uses the "sdw" prefix
> +commonly used by SOC designers and 3rd party vendors.
> +
> +Each of the SoundWire Master interface needs to be registered to the Bus
> +driver.  Master interface capabilities also needs to be registered to
> +bus driver since there is no discovery mechanism as a part of SoundWire
> +protocol.
> +
> +The Master interface along with the Master interface capabilities are
> +registered based on board file, DT or ACPI.
> +
> +Following is the API to register the SoundWire Master device.
> +
> +static int my_sdw_register_master()
> +{
> +	struct sdw_master master;
> +	struct sdw_master_capabilities *m_cap;
> +
> +	m_cap = &master.mstr_capabilities;
> +
> +	/*
> +	 * Fill the Master device capability, this is required
> +	 * by bus driver to handle bus configurations.
> +	 */
> +	m_cap->highphy_capable = false;
> +	m_cap->monitor_handover_supported = false;
> +	m_cap->sdw_dp0_supported = 1;
> +	m_cap->num_data_ports = INTEL_SDW_MAX_PORTS;
> +
> +	return snd_sdw_master_add(&master);
> +}
> +
> +Master driver gets registered for controlling the Master device. It
> +provides the callback functions to the bus driver to control the bus in
> +device specific way. Device and Driver binds according to the standard
> +Linux device-driver bind model. Master driver is registered from the
> +driver init code. Below code shows the sample Master driver
> +registration.
> +
> +static struct sdw_master_driver intel_sdw_mstr_driver = {
> +	.driver_type = SDW_DRIVER_TYPE_MASTER,
> +	.driver = {
> +		.name   = "intel_sdw_mstr",
> +		.pm     = &intel_sdw_pm_ops,
> +	},
> +
> +	.probe          = intel_sdw_probe,
> +	.remove         = intel_sdw_remove,
> +	.mstr_ops       = &intel_sdw_master_ops,
> +	.mstr_port_ops = &intel_sdw_master_port_ops,
> +};
> +
> +static int __init intel_sdw_init(void) {
> +	return snd_sdw_master_register_driver(&intel_sdw_mstr_driver);
> +}

Would be good to hear some detail the reasoning for the design
choices here? Normally (I2C/SPI) the master sits on whatever bus
the host uses to talk to the master so often this might be the
platform bus for memory mapped devices, it then creates a bus and
slaves register to that. This also has the nice property that its
easy to create devices that sit behind other buses, for example
here we might want a SoundWire master that sits behind a SPI bus.
But you seem to have gone in the other direction and have the
master sitting on the same bus as the slaves.

> +
> +As shown above Master driver registers itself with  bus using
> +"sdw_mstr_driver_register" API, It registers using set of "mstr_ops" and
> +"mstr_port_ops" callback functions to the bus driver.
> +
> +"mstr_ops" is used by bus driver to control the bus in the hardware
> +specific way. It includes bus control functions such as sending the
> +SoundWire read/write messages on bus. The Bus driver also defines the
> +clock frequency and frameshape allocation needed by active stream and
> +configuration messages that need to be transmitted over the bus, to
> +maximize the bandwidth needed while minimizing the power. The "mstr_ops"
> +structure abstracts the hardware details of the Master from the bus
> +driver for setting up of the clock frequency and frameshape.
> +
> +"mstr_port_ops" is used by bus driver to setup the Port parameters of
> +the Master interface Port. Master interface Port register map is not
> +defined by MIPI specification, so bus driver calls the "mstr_port_ops"
> +call back function to do Port operations like "Port Prepare", "Port
> +Transport params set", "Port enable and disable". The implementation of
> +the Master driver can then perform hardware-specific configurations.

Thanks,
Charles
