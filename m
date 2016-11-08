From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
Date: Tue, 8 Nov 2016 21:39:07 +0100
Message-ID: <20161108203907.wylvt3xvhx3mi3tg@lukather>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
 <20161108074414.vvnjj7aa26sloi2f@lukather>
 <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tbasm3c4jrykwwn4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--tbasm3c4jrykwwn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2016 at 03:57:48PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 8, 2016 at 3:44 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Mon, Nov 07, 2016 at 10:11:45PM +0800, Chen-Yu Tsai wrote:
> >> On Mon, Nov 7, 2016 at 9:08 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > The GR8-EVB comes with a wm8978 codec connected to the i2s bus.
> >> >
> >> > Add a card in order to have it working
> >> >
> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> > ---
> >> >  arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+), 0 deletions(-)
> >> >
> >> > diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/n=
tc-gr8-evb.dts
> >> > index 12b4317a4383..5291e425caf9 100644
> >> > --- a/arch/arm/boot/dts/ntc-gr8-evb.dts
> >> > +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
> >> > @@ -76,6 +76,20 @@
> >> >                 default-brightness-level =3D <8>;
> >> >         };
> >> >
> >> > +       i2s {
> >>
> >> "sound" might be a better node name? The I2S controllers are also
> >> named "i2s".
> >
> > I know, but we also had the codec and SPDIF on this board, so sound
> > was too generic to be meaningful I guess. I don't really care about
> > the name though, if you have any suggestion...
>=20
> Well people seem to use "sound" for the sound card nodes...
>=20
> What about "sound-analog" for this one, and "sound-spdif" for the
> SPDIF simple card? Or "analog-sound" and "spdif-sound" if that looks
> better.

sound-analog works for me. I'll either fix it in the v2, or while
applying.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--tbasm3c4jrykwwn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIjfrAAoJEBx+YmzsjxAg1XkP/2ZdcNXyEafsXjPc8Dd+FGru
ocYso9IAM5Mg81sJFKqWV9YVimxom5x/Q3VJPnGpEWlIT2IHi5z/Ea1oz2ZOZYK5
Kv+T0/TbKIwk0bKa0qo1tlj1s3pgD/c3q2OjiR+rMTxwRGovSYPs3sHZf5wFzG9S
tVzOXSzqQzH45VhLtPAHbw0VNc98glLTYdkwK3xN9DTg+VMRn2ksOQNH5/Ge9WkC
2wVg93qK0HHwkqG+vHO1rerVBroTfeLdJ1aq2zJqdmtAqsFJdeEsXJE+184kcA0u
UwizOHesv8nl9TCW/D7/M633NXGjIb55t9LbNYx44yIgfAM7lkdBEKmBVljryGHX
DfTgWp+DhgnSeFEu0wrDZKBs1GXkydnThj1193G5l9P65T9sS89FORziLvVT12Gz
Qnr26kxbyXU00uuP0Z1zS/nqlUHDQQM53eX0a7TKCum1dSxt4MGeTBmiGr/hdisi
z9wIbE5xoJtntgRZQabKjfCiiXtq2gSTMay0gYY8c8TOOindbj2TdCnm+6p+pia5
8Pau20/gQHn7Hzr0IFc+OqJknK5aj7BPtOEON23ez9KqZ0up709IXyKq07sbGS+Z
QhcOVhnhSmhFbFT9QkB5cYzpW9vA45LldsyqG45bKBfc0pWyZXqwNKIS1c1zH0df
2gVru5lMTIS2n6RvHtRu
=pWhf
-----END PGP SIGNATURE-----

--tbasm3c4jrykwwn4--
