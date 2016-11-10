From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
Date: Thu, 10 Nov 2016 11:53:48 +0100
Message-ID: <20161110105348.hvpjpl5rn4zx5h2y@lukather>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
 <20161108074414.vvnjj7aa26sloi2f@lukather>
 <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esioogvnam673ic3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v6557B5dooERbKc709Hbrzb3vP8eoSj3nh6rKek7UwrgEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--esioogvnam673ic3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

1;4600;0c
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

I fixed it and applied.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--esioogvnam673ic3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYJFG4AAoJEBx+YmzsjxAgvAkP/3xdl7sFOmD3pX8tKVfJXahJ
GcstQd78/emslKkIJOW77YHolQbqiYB/PVcVEFP4eA1xySQzTG66l/bAoGdnUhyB
LPF7kHkEMkY1oPprcxRpHdcvkHExmZvj1PjWKTxWcA2eOmNgQiHz5D97DKwm7asd
crWLJcp1B6Y9I5USUinjwN1PmuRc7TNpvZUf0U/Sre6X1aBdhYmhF2mqfD71LWxb
C+awvRaRhx1ycbivPie0cSVrvUSa0VKpaNodqUFp2rv4KRCJCUXxgldwewUdOl0C
vGTLzdtZg+dmk84XQFNWWrHQ8j1MktB4snN/H/9lo9FV8dIdKO+LcEnWt2IngV0f
1S+q+SDu3WF7J3YNtRBkK2S8djCpvITwvCXa+3oKY1gZPbXhzcqZ2AANZFBTxGl0
+l/XSTvDvTQJPqdIT30OOfYr+BnZuzQSMoggsMqNBRDKsjmQwShDrC6uk5vY+drh
nMOaLbf9leQjYziXVg3jO7qhcLi3+SeXBe6lMuhfgZK3aeeGT5XLt+lf7ou7KopC
0YnUigH+QKbTbIV1PWNchWii0/anK9zJqjYeWC9gyCfulOQ2gsfrlFy1GLeeBcWN
+uKonu0m4IlqayjJrmjcaHwFbHO6rs2OOYnwLiQIwZXN13VLtoeocaDICwR7G50R
5o+mVgJXrdzVX4xrdEDR
=cv9/
-----END PGP SIGNATURE-----

--esioogvnam673ic3--
