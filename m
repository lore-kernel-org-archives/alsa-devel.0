From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
Date: Wed, 3 Dec 2014 18:23:51 +0000
Message-ID: <20141203182351.GF7712@sirena.org.uk>
References: <547F3CAC.9050105@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+GIKAiFp5Dbav/rq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547F3CAC.9050105@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>
List-Id: alsa-devel@alsa-project.org


--+GIKAiFp5Dbav/rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 04:39:08PM +0000, Andrew Jackson wrote:

> Convert to driver to use either platform_data or device-tree for configur=
ation
> of the device.  When using device-tree, the I2S block's configuration is =
read
> from the relevant registers: this reduces the amount of information requi=
red in
> the device tree.

This really needs to be split into two or more patches, there's a whole
bunch of refactoring to support this DT stuff which should be separate
=66rom the DT addition itself.  Right now it's hard to tell what each
individual bit of the code is supposed to be doing, the patch is far too
large and doing far too many individual things.

> +	if (dev->using_pd) {
> +		ret =3D dev->i2s_clk_cfg(config);
> +		if (ret < 0) {
> +			dev_err(dev->dev, "runtime audio clk config fail\n");
> +			return ret;
> +		}
> +	} else {
> +		u32	bitclk;

Having this whole separate path for using platform data feels icky, we
don't want to have completely separate flows like this.  Checking for
the callbacks being there is probably fine but just having totally
separate code paths is a bit icky.

--+GIKAiFp5Dbav/rq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf1U2AAoJECTWi3JdVIfQ8tcH/AkmB70sD7ZWq+QCDY9tjJOO
l6DNCLlshYInmUDMDPPMn/w0k9vy0S4wv8waOTgYgyugy8LuXMqHr/Q5HArIqkdo
57E9cA5zhFX6NPQWXhtOArS1npHFSCDvCjo6SOFBy13w6xj39RuAnvgRHT63A6nf
Ce5Q8bo+ujItwXvogSBnmXO8dPFVnH4z4mwdqDXDYTD+jRc7U368fz1xjUhrbbvT
936UdZQcJlL/F63MddT3M5mt9ovb/On+SJO5IcHO1ndZ+zwDoHfODOPC/UgxFpVY
0ULU7UWiU40+9+XgXsrMRD/YtUZWtLx7y8oADiQWQejBMtEJWvbrkIrRqQY7GL0=
=nw9H
-----END PGP SIGNATURE-----

--+GIKAiFp5Dbav/rq--
