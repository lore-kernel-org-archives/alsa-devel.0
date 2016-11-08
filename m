From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
Date: Tue, 8 Nov 2016 08:44:14 +0100
Message-ID: <20161108074414.vvnjj7aa26sloi2f@lukather>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0392799188043817032=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============0392799188043817032==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qxjcnworssfre7k4"
Content-Disposition: inline


--qxjcnworssfre7k4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 10:11:45PM +0800, Chen-Yu Tsai wrote:
> On Mon, Nov 7, 2016 at 9:08 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The GR8-EVB comes with a wm8978 codec connected to the i2s bus.
> >
> > Add a card in order to have it working
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-=
gr8-evb.dts
> > index 12b4317a4383..5291e425caf9 100644
> > --- a/arch/arm/boot/dts/ntc-gr8-evb.dts
> > +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
> > @@ -76,6 +76,20 @@
> >                 default-brightness-level =3D <8>;
> >         };
> >
> > +       i2s {
>=20
> "sound" might be a better node name? The I2S controllers are also
> named "i2s".

I know, but we also had the codec and SPDIF on this board, so sound
was too generic to be meaningful I guess. I don't really care about
the name though, if you have any suggestion...

> Otherwise,
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--qxjcnworssfre7k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIYJKAAoJEBx+YmzsjxAgo+cP/jkgGy+35Chjud7fSEEaIU9q
Z4LoS7kN6w8T/yE2L7ZMVgLHrCKYPge3B5FYjFjSwHREXD+OUQbh9vgr8YiAx3Mm
/lj7xXIX1deUVEAqYQMP+zgtI4Ud4HYbGm9vnORHuA0Df1HnXk7vv/olsD9+84cr
Vrj3XoncmQzhyQ/cucgc42tXdbNPLlzQP+phftZD166PaMsXiDGTzZUszBgoJJTR
GWNxGaxQAS+UjsawPrApW6TkecdvwHZ05B+s86/0yEzkBExkR8xnN3SAu6gg0Gqn
k++5jjX28V4+SLjXUiueqN4jfT3V9Dlc9WSFanExGb93TfQqh1UnpBc6oNI6QRzk
3YW8PLi6WRkrlUvKOVmQaoZDXKJm2JorrF2N9unuLKAei2f8Dp0cOABB9hZc5B1U
CSVAQRkMc5pY3EKQhvB/szrlyvvi7HcfeOJEIwKDH3l0npXl9FB41KEU9IRGoLHO
WVYusHxAZtcBby1GayPrOtI98ftXr+F4xGjS3CZrAP6g3gQjy8Vzco7dyr1VFPwI
wI6gPVJ/EEgE/tcAh+ITGV38ENdFSzpeK8wpvdHZ3zTZ9bs3txagehRWJiASD5Bw
WM9Oax7kqdiRayCQB1eMoVqUYa32dFa8wnktX1s6sTkAVmWnd8aEBLKdV8o2QPgY
T0PwF6M/71Ysl/NtDo2E
=uXVQ
-----END PGP SIGNATURE-----

--qxjcnworssfre7k4--


--===============0392799188043817032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0392799188043817032==--
