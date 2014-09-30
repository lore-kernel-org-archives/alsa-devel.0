From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 0/2] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Tue, 30 Sep 2014 20:10:30 +0100
Message-ID: <20140930191030.GK4273@sirena.org.uk>
References: <cover.1411547014.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1411547014.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 10:23:34AM +0200, Jean-Francois Moine wrote:
> The NXP TDA998x HDMI transmitter may transmit audio to the HDMI link
> from 2 different sources, I2S and S/PDIF.
>=20
> This patch set adds an interface between the HDMI transmitter and
> the HDMI CODEC.

I'd really like to see some of the other people who are working with
HDMI reviewing this - this is a generic part which seems to be very
widely used so we need to make sure that what's being done works for
other systems.  Jyri, I see you're on CC?

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKwAlAAoJECTWi3JdVIfQH1MH/3CB9KcMtVo91cYIGvwoDf7G
9bnZgjZihsfen3s+tExspWb38pBZKUmDP+W82O9Qdzr58ir0KpE4RdbtyL9jpSGZ
5pc2apejQwKkuvgZsVrRiuk0vM1c2+Sf+E7D8gL4CiSAT7SJhqgG0x0dveSRG4Hp
t+s3Q5cymJphI1YE0EeNE1QwjCvXWQW2nrr6Km7X/JtbCrhbs6pOBWxoGNPgIW7o
yDjvUQWDfLU3AcKD/P7TAXstScJU8hYR4XUGoxJRbP25c3dcsJJhJvDFhz/YXfMF
nhlKYKzwVzgJtnM8k70ZxZyWasqAiSkKoDLXr6mHLjZKMO9i6eZDf3hglhkuXCY=
=hbwq
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--
