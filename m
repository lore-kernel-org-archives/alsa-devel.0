From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] codecs: mc13783: add spi errate fix
Date: Mon, 9 Sep 2013 16:33:28 +0100
Message-ID: <20130909153328.GO29403@sirena.org.uk>
References: <1378735956-17318-1-git-send-email-s.trumtrar@pengutronix.de>
 <20130909145730.GF29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PeSNlYkxSF9b/2wn"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130909145730.GF29403@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--PeSNlYkxSF9b/2wn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 03:57:30PM +0100, Mark Brown wrote:
> On Mon, Sep 09, 2013 at 04:12:36PM +0200, Steffen Trumtrar wrote:
> > The MC13783 Chip Errata, Rev. 4 says, that depending on SPI clock
> > and main audio clock speed, the Audio Codec or Stereo DAC do sometimes
> > not start when programmed to do so. This is due to an internal clock
> > timing issue related to the loading of the SPI bits into the audio bloc=
k.
>=20
> Applied, thanks.

=2E..and reverted since PMIC_AUDIO_CODEC isn't defined.  Please fix and
resend.

--PeSNlYkxSF9b/2wn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLepEAAoJELSic+t+oim9cX0P/35/0iSt0pxm6UKuecXjESUf
L531Xezu56aRZDrQ9cnZoKr6oBnSM9wsVBv33WcDs5SianYWqOELy1dt+J5ovDvA
Qax+VaHIxTpFrMzLcm/my8xgsSz6GiAOwSFKYzxGUJJvv2XIOIsJ4J56R2Z2f6cc
r+qi8E0ApLNmwuDQUu1UYVngPJZNgaK3zvH/5emctJDeHz6JRBbDJApI0UpyavO7
FH4j6eJSWc5UFR85avXni4uXVYoFvkqJ12PBi1agDc2YXlCNO7EFl2gfzCkT1/Gv
+667UD3PcbFZtGtqgQ5bx4kj+7T56mYd11BYYIdt4wvULCvutWoKnzYvRsfK90DM
9NVYKCQkwmYxVn3xHJVTjwaiM1b4qm7/TlMkJLsVJWYR57cKsioUsNGJGUYEZyiP
OUk3Qn9DeQNTsIbes4fPGxTDBbk7aKPfVP3flwnIXmTyQIl8eF6XOk2P5ZbFobDF
fFeKkp7jsg6EjwKVkvEPvhmZXxn1G4Xq0nMfLGP0bEll3Gg0odT4Uzc0H6dADr9v
rakQqz9hMWP5K4skM2YNRlQcICjLQBSgK2aePGGFpQMMNCB5+gjtQZGDNe0MXNzm
669wZRCtPjHCJ4nHbgMBC0JT1Nhu1joBidFZaRtSHQ33YJIV9aKJJp1+TiBelXuS
IJiaEl16uRGDFge4ZZI3
=KE3o
-----END PGP SIGNATURE-----

--PeSNlYkxSF9b/2wn--
