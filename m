From: Mark Brown <broonie@kernel.org>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Fri, 24 Oct 2014 15:04:40 +0100
Message-ID: <20141024140440.GG3729@sirena.org.uk>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
 <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8784145992136484207=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B76BF260573
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 16:04:58 +0200 (CEST)
In-Reply-To: <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jonathan Bennett <jbscience87@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org


--===============8784145992136484207==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NLGdgz3UMHa/lqP"
Content-Disposition: inline


--2NLGdgz3UMHa/lqP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 10:20:29AM -0200, Fabio Estevam wrote:
> On Fri, Oct 24, 2014 at 2:42 AM, Jonathan Bennett <jbscience87@gmail.com>=
 wrote:

> > + ssi_clk =3D devm_clk_get(&codec_dev->dev, "cko");
> > + if (IS_ERR(ssi_clk)) {
> > + pr_err("Could not get \"cko\" clock \n");
> > + return PTR_ERR(ssi_clk);
>=20
> I am not sure that adding the clock handling here is the correct approach.
>=20
> The dts you use looks like:
>=20
>    codec: wm8731@1a {
>       compatible =3D "wlf,wm8731";
>       reg =3D <0x1a>;
>       clocks =3D <&clks 173>, <&clks 158>, <&clks 201>, <&clks 200>;
>       clock-names =3D "pll4", "imx-ssi.1", "cko", "cko2";

> ,which does not match the current bindings for the wm8731. The wm8731
> driver could be extended to handle the clocks if needed, instead of
> handling them via machine driver.

The WM8731 doesn't have anything like that number of clock inputs so
hanging them off the WM8731 seems very confused.

--2NLGdgz3UMHa/lqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUSlxzAAoJECTWi3JdVIfQQoIH/39q3paUbREwems9Yfxb/6zT
RvvFCswuh1v5ll+Jz3B9mj39uSNdIwF7pMs3KQbuvDreAOIjeR75LIq7Ho1vXoyp
GAkNjTVsHK0nGkjEftjVVysHxWrHbFyr52hYG0PUvwg7Y2jYoc268J3XFe5NCK+a
rHIYoWnzoPjeur7kmRYeecr3FDJ4GmTwRtie7lK+D2BiY/SjZg05Flm4LESM2Npe
0IupHl7S6PID26wVGeUgbZYVx8tFtj6J+2eQgiCC7ux/z2WwzMMWtfUuLJJq5MCR
zqMxNwAXXKpBhYZaPykbPH0WR5J/8xkN1Q5583SE5ITOjbZMR7dxMWp2YoJkYXw=
=CnwA
-----END PGP SIGNATURE-----

--2NLGdgz3UMHa/lqP--

--===============8784145992136484207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8784145992136484207==--
