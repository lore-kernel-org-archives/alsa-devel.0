From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: select SND_SOC_FSL_SAI or SND_SOC_FSL_SSI
 depending on SoC type
Date: Fri, 29 Jan 2016 12:16:24 +0100
Message-ID: <20160129111624.GO4130@sirena.org.uk>
References: <1453293038-16032-1-git-send-email-LW@KARO-electronics.de>
 <20160128223352.GB4130@sirena.org.uk>
 <20160129065938.6e89fc37@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l7GkBbkEatsaRqBf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160129065938.6e89fc37@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--l7GkBbkEatsaRqBf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2016 at 06:59:38AM +0100, Lothar Wa=DFmann wrote:
> On Thu, 28 Jan 2016 23:33:52 +0100 Mark Brown wrote:
> > On Wed, Jan 20, 2016 at 01:30:38PM +0100, Lothar Wa=DFmann wrote:

> > > -	select SND_SOC_FSL_SSI
> > > +	select SND_SOC_FSL_SAI if SOC_IMX6UL
> > > +	select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX

> > Does this card not work for older i.MXs (which had the same SSI/AUDMUX
> > combination as the majority of the i.MX6 family) as well?

> Our baseboard contains an SGTL5000 codec which is working with
> i.MX25, i.MX27, i.MX5, i.MX6Q, i.MX6DL with the fsl_ssi and imx-sgtl5000
> + imx-audmux driver, on i.MX28 with the mxs-saif and mxs-sgtl5000 driver
> and on i.MX6UL with the fsl_sai + simple-card driver.

That's your base board but that doesn't really help other users who may
be using this driver (and even for your system I'm not clear how
any configuration without an i.MX6 will enable a CPU DAI driver with
this change).

--l7GkBbkEatsaRqBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWq0oBAAoJECTWi3JdVIfQpLsH/A3WkErKw2l7yAF15Qihn49r
9ynzVT7QkCWWruvepUA5eybAy8/SXUYHp9OeT1zu6rghTfjtGLIzXERq17uk/t4W
NeslZnahKlcRZ2cKeh1+ZwU6YV0WRumkcd8kNSIQdcZJ+PZFBKPutmP7oXC9JWvb
yJPE59F2abjU4m+6yFvph51P4ZAKS6IJxQtxdxQEH42/VBNZXQ+UdmJ0lQmfO7P2
Z7nCB8WsWnGLlhAVYtl22N0xoJsJS5MhAfUJ9+BsNW2LJv2PxODyjTkNTHcDxW4H
Eo9vo6Mr96ExubY4oEecv2sKWiTx0PKw+8laZh2THlsYOjO8m9kiC547JKaXioU=
=QSN0
-----END PGP SIGNATURE-----

--l7GkBbkEatsaRqBf--
