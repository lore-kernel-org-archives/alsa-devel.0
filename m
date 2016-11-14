From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 06/14] SoundWire: Add register/unregister APIs
Date: Mon, 14 Nov 2016 13:37:51 +0000
Message-ID: <20161114133751.kqjgrtc7y2ltwbe7@sirena.org.uk>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-7-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="usu34cv7hsv6khfh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-7-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--usu34cv7hsv6khfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2016 at 06:11:04PM +0530, Hardik Shah wrote:

> +static void sdw_mstr_release(struct device *dev)
> +{
> +	struct sdw_master *mstr = to_sdw_master(dev);
> +
> +	complete(&mstr->slv_released_complete);
> +}

Other buses don't do this...  this is a big warning sign that you're
abusing the driver model.

> +/**
> + * sdw_slv_verify - return parameter as sdw_slave, or NULL
> + * @dev: device, probably from some driver model iterator
> + *
> + * When traversing the driver model tree, perhaps using driver model
> + * iterators like @device_for_each_child(), you can't assume very much
> + * about the nodes you find. Use this function to avoid oopses caused
> + * by wrongly treating some non-SDW device as an sdw_slave.
> + */

This is also *very* scary, especially given that there's no analysis
presented as to why there might be random other things on the bus.  Why
does SoundWire need this when other buses don't?

> +static struct sdw_slave *sdw_slv_verify(struct device *dev)
> +{
> +	return (dev->type == &sdw_slv_type)
> +			? to_sdw_slave(dev)
> +			: NULL;

This is needlessly obfuscated, if you want to write an if statement
write an if statement.

> +static int sdw_slv_match(struct device *dev, struct device_driver *driver)
> +{
> +	struct sdw_slave *sdw_slv;
> +	struct sdw_driver *sdw_drv = to_sdw_driver(driver);
> +	struct sdw_slave_driver *drv;
> +	int ret = 0;
> +
> +
> +	if (sdw_drv->driver_type != SDW_DRIVER_TYPE_SLAVE)
> +		return ret;

Why do we need a check like this?

> +static int sdw_mstr_probe(struct device *dev)
> +{
> +	const struct sdw_master_driver *sdrv =
> +					to_sdw_master_driver(dev->driver);
> +	struct sdw_master *mstr = to_sdw_master(dev);
> +	int ret;
> +
> +	ret = dev_pm_domain_attach(dev, true);
> +
> +	if (ret != -EPROBE_DEFER) {
> +		ret = sdrv->probe(mstr, sdw_match_mstr(sdrv->id_table, mstr));
> +		if (ret < 0)
> +			dev_pm_domain_detach(dev, true);
> +	}

This looks *very* broken.  Surely if we fail to attach a pm_domain for
any reason other than one not being there to attach we shouldn't be
trying to probe the device?

> +EXPORT_SYMBOL_GPL(snd_sdw_master_register_driver);

This is EXPORT_SYMBOL_GPL() but the bus itself is dual licensed GPL/BSD
- seems a bit inconsistent.

> +/**
> + * snd_sdw_master_add: Registers the SoundWire Master interface. This needs
> + *	to be called for each Master interface supported by SoC. This
> + *	represents One clock and data line (Optionally multiple data lanes)
> + *	of Master interface.
> + *
> + * @master: the Master to be added.
> + */
> +int snd_sdw_master_add(struct sdw_master *master)

This lies at the heart of the issues that seem to exist with the misuse
of the driver model in this code.  Normally what we see is that the
controller would instantiate as whatever bus type the controller is
attached by (typically a PCI or platform device) and then it wouild
register a bus with the bus subsystem which would then instantiate
slaves.  Instead we have this system where the bus is registered by
something in the system and then the master is a driver on the bus
parallel to the slaves but with a separate driver type that causes
confusion.  Without having seen a master driver it's not even clear how
this is going to work and allow the master to talk to its own hardware.

--usu34cv7hsv6khfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKb4vAAoJECTWi3JdVIfQd+AH/iAap+IHAEGpgWigQVKV5pfd
vRGJCda5wO74fTGtdIoAcwOFfbB0Z/ZFvsRL7B6ZE2n878nPIYgsEwW+dTukoY9g
0CJjErNpgrWOyi5momDrRJAABC+fASVSQ2YS9fJkHXee7eZcJkHTANCfi1khz1DL
sDRmyVl9eTF03hnOa82iwbQLMLlGRobDrkpFenCQgW9mMUaGtZBw5mvawmJipuqj
Tkz137VyT9zHq4e90VzCIorgvYLJuG2Ig9STocXsc9XyQfdXbK4mPAOVfFOIqvGm
XHY6prRIG4O0hgyANkpQ6y3JI7BfEDhQwYe4DSVUhFENzRxEQmNCB7IVqQ4FyyE=
=lia7
-----END PGP SIGNATURE-----

--usu34cv7hsv6khfh--
