From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776 codec ALSA driver
Date: Tue, 17 Apr 2012 17:18:21 +0100
Message-ID: <20120417161820.GP6652@opensource.wolfsonmicro.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
 <1334611118-10301-4-git-send-email-linux@rainbow-software.org>
 <20120417150234.GB22575@sirena.org.uk>
 <201204171813.44044.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3loezlmesXOUD0D5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201204171813.44044.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3loezlmesXOUD0D5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 06:13:40PM +0200, Ondrej Zary wrote:
> On Tuesday 17 April 2012 17:02:34 Mark Brown wrote:

> > Same comments as the previous patch, this should be using ASoC.  In this
> > case the device has in fact been supported in mainline since 2.6.32...

> Yes, the driver is there - but I dont's see any way to use it. ASoC was n=
ot=20
> designed to be used with sound cards and nobody has ever used any ASoC dr=
iver=20
> in a sound card driver. I don't feel like breaking a working driver (with=
 16=20
> subdrivers for many more card types).

What makes you cleaim that "ASoC was not designed to be used with sound
cards"?  Implementing sound cards is the sole purpose of ASoC...

--3loezlmesXOUD0D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjZfGAAoJEBus8iNuMP3d5oMP/jtrhSyJc18HfaP85HWspLcK
997C+Oyv7dawLx/FoEvlLKN+jVjS8+tr+S9Euz6jdszZbCIw2o26znVb21PagyAL
U/q6WpZnSnA7JfzGNAlfJjCgQaH/KebdebdXeFWe5285i6wyfHM+IdfRxrFSox4l
PSnTQWqsJWFbGfjIGg1mo9sNLUUq8GnAM5OnrEYbBb0pHJDvBOrUDfg79TAb3DwD
xi//OCMHdafZwJECGN4sUxWRULk0wkye5xCafNilYNLR5a+2Gb+2JQ8kH0TXRqVs
JPr5CaRO6ncMVXdoJd7xqsxaFBdkf2roRZK7mDH6JjunmpgeXsnIlVLFLS9C6Lzz
tqarznF2BTESO3SpSCx+5IkmyZFkhHQDj3/YJJjdjzSpNhznX0ze7Q5flV6CBPOr
JejgsrdHoUGTHkRO8tTnVg3iV5yd4Bdm2x26kxJ6poifEiy3jhT4Lt65IcOxXZa8
qufNHu4jJD+hAcm6DzsG+K7CRKQol04WDGt/iAtLikEMTHGlk8Z7Kd4Hj7vjKDDW
yk2FI0I2CsfLW+/4wEgl1qX/41er4kCnm6PR1LHo5VxD+NNGWsd8uDCj7oO/OFJF
vqakvng+GnAnwRU9KdN6UVILRdA/eSAD39G3cIIm/wqXHUOiNjCBVmIW39aw3O3T
2L3m4+p8LsQdhZfkPLgf
=pbus
-----END PGP SIGNATURE-----

--3loezlmesXOUD0D5--
