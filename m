From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 06/14] SoundWire: Add register/unregister APIs
Date: Tue, 15 Nov 2016 19:25:45 +0530
Message-ID: <20161115135545.GM3000@localhost>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-7-git-send-email-hardik.t.shah@intel.com>
 <20161114133751.kqjgrtc7y2ltwbe7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161114133751.kqjgrtc7y2ltwbe7@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2016 at 01:37:51PM +0000, Mark Brown wrote:
> On Fri, Oct 21, 2016 at 06:11:04PM +0530, Hardik Shah wrote:
>=20
> > +static void sdw_mstr_release(struct device *dev)
> > +{
> > +	struct sdw_master *mstr =3D to_sdw_master(dev);
> > +
> > +	complete(&mstr->slv_released_complete);
> > +}
>=20
> Other buses don't do this...  this is a big warning sign that you're
> abusing the driver model.

The whole master enumeration stuff, as we discussed in LPC will go away now.
So it will be more like other buses :)

> > +/**
> > + * sdw_slv_verify - return parameter as sdw_slave, or NULL
> > + * @dev: device, probably from some driver model iterator
> > + *
> > + * When traversing the driver model tree, perhaps using driver model
> > + * iterators like @device_for_each_child(), you can't assume very much
> > + * about the nodes you find. Use this function to avoid oopses caused
> > + * by wrongly treating some non-SDW device as an sdw_slave.
> > + */
>=20
> This is also *very* scary, especially given that there's no analysis
> presented as to why there might be random other things on the bus.  Why
> does SoundWire need this when other buses don't?

Sure I will double check on this one and sounds to me we cna remove this..

>=20
> > +static struct sdw_slave *sdw_slv_verify(struct device *dev)
> > +{
> > +	return (dev->type =3D=3D &sdw_slv_type)
> > +			? to_sdw_slave(dev)
> > +			: NULL;
>=20
> This is needlessly obfuscated, if you want to write an if statement
> write an if statement.

Sure thing

> > +static int sdw_slv_match(struct device *dev, struct device_driver *dri=
ver)
> > +{
> > +	struct sdw_slave *sdw_slv;
> > +	struct sdw_driver *sdw_drv =3D to_sdw_driver(driver);
> > +	struct sdw_slave_driver *drv;
> > +	int ret =3D 0;
> > +
> > +
> > +	if (sdw_drv->driver_type !=3D SDW_DRIVER_TYPE_SLAVE)
> > +		return ret;
>=20
> Why do we need a check like this?

Since folks were doing both slave and master matches, this was done to be
double sure, but this will go away now.

> > +static int sdw_mstr_probe(struct device *dev)
> > +{
> > +	const struct sdw_master_driver *sdrv =3D
> > +					to_sdw_master_driver(dev->driver);
> > +	struct sdw_master *mstr =3D to_sdw_master(dev);
> > +	int ret;
> > +
> > +	ret =3D dev_pm_domain_attach(dev, true);
> > +
> > +	if (ret !=3D -EPROBE_DEFER) {
> > +		ret =3D sdrv->probe(mstr, sdw_match_mstr(sdrv->id_table, mstr));
> > +		if (ret < 0)
> > +			dev_pm_domain_detach(dev, true);
> > +	}
>=20
> This looks *very* broken.  Surely if we fail to attach a pm_domain for
> any reason other than one not being there to attach we shouldn't be
> trying to probe the device?

Yes I agree, we shouldnt be doing probing in that case. Will fix that up.

>=20
> > +EXPORT_SYMBOL_GPL(snd_sdw_master_register_driver);
>=20
> This is EXPORT_SYMBOL_GPL() but the bus itself is dual licensed GPL/BSD
> - seems a bit inconsistent.

Thanks for pointing this out. The symbols should use EXPORT_SYMBOL() only
and the ones which link to other kernel GPL ones would need to be GPL ones.

> > +/**
> > + * snd_sdw_master_add: Registers the SoundWire Master interface. This =
needs
> > + *	to be called for each Master interface supported by SoC. This
> > + *	represents One clock and data line (Optionally multiple data lanes)
> > + *	of Master interface.
> > + *
> > + * @master: the Master to be added.
> > + */
> > +int snd_sdw_master_add(struct sdw_master *master)
>=20
> This lies at the heart of the issues that seem to exist with the misuse
> of the driver model in this code.  Normally what we see is that the
> controller would instantiate as whatever bus type the controller is
> attached by (typically a PCI or platform device) and then it wouild
> register a bus with the bus subsystem which would then instantiate
> slaves.  Instead we have this system where the bus is registered by
> something in the system and then the master is a driver on the bus
> parallel to the slaves but with a separate driver type that causes
> confusion.  Without having seen a master driver it's not even clear how
> this is going to work and allow the master to talk to its own hardware.

Yes as discussed the whole master stuff will eb redone so you wont see these
bits in next rev.

--=20
~Vinod

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYKxPhAAoJEHwUBw8lI4NHF8IQALfBPtnbTD1stO6PydvzIHkV
MYTxfMxiU+JP8mP/VyQAdfqCmQ5cUz1AncpgKS0xj92EqupfKFsy9sQt0hJxsOOf
KTo1i9aieVbldTlpZvBUzHiEcl3mCahzFU7Pn7T2vrDgsT9chw+L3g99AL9/1Jik
89PtwXaV4IoVb16FmbpQ+TX+TA2soL2QuJ2USp/1Hg2TSYX75ooZRV22NywdafPN
sGKp8wZUFKgRkb5j4vu91kE1dC82FlY3Xt/HAKvTMMpZdxp//A322n0v63hOUo8L
nKvdyA0fCfcP3VC1DaYTizVTSYPlALu5qfyiCjMIsRlhbSVtStgq9ffjRPX6b2A5
LFMVc+C5tGcw6KEhRKHa8Q+gMdMbvXVDVvJgfz8OMxq7LP8/mjOVKe2p42cdd9JD
3ek60ZRbf76W3vEyrp72dmfCXM5+Y4bYi6CK2UXQDW2upObtWIyCR2LBKiwM0OJW
BZomvinIw62I+YbOFnXW5rHVO0ihQ0UbnE6H7wz3R/ul2KGUPfVqvX2X1A1pK+sU
5X0cEaPI2HX9gWudCBD7hiXJV8/3aMxS/uB0VrssmRtE2eKRJ3acBePYlFmix7Tm
MDCm3ZXh10h89Z1BDLV+uH/6kIaaDAC9AIOZHxOguHW6mKk+l71tgE1ov/aE9fmA
++HyvG5vs1XhlQa6yRtB
=4zgM
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
