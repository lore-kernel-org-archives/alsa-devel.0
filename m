From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: sound: sun4i-spdif: Fix dma-names warning
Date: Tue, 27 Aug 2019 19:14:09 +0100
Message-ID: <20190827181409.GH23391@sirena.co.uk>
References: <20190827142547.14577-1-mripard@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0330511891581656483=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827142547.14577-1-mripard@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <mripard@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0330511891581656483==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fez1/uVX7m6GpeOd"
Content-Disposition: inline


--fez1/uVX7m6GpeOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2019 at 04:25:43PM +0200, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Even though the H6 compatible has been properly added, the exeption for t=
he
> number of DMA channels hasn't been updated, leading in a validation
> warning.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  This
doesn't even have ASoC in it...

--fez1/uVX7m6GpeOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lcvAACgkQJNaLcl1U
h9AQNwf/Wko2ywl/1pCNlhI8r5T9icdRCSO3aCusrcNdTqFPwCKGaybfQwcs7T1i
0ljLfvQoPvxUH1pj+ed4D4e1D+L2MNaGgm30zRQvPmoldJ23rYC3scQgom5ejb8Z
EfLTB7ogGLiwIysbn4eZojzA9AfJwkXdCsFPSR55iSGop/lztHREVQEGnW6Ktw+7
U52qHI6sJ0mYGJgA39HQarp4lwVuSHRgouhsvA/6CXQ4sLUxTwZYNZwh4hKd/c3u
+T0CZ022i3XwoWwGrD5VreO1Yas3ZU3jf7vT4gnpOrSH+oonnwHBfFl9nDCMMJB6
IDS3MJpUDnm64N8iliKuxAO3z3Jgow==
=7aoP
-----END PGP SIGNATURE-----

--fez1/uVX7m6GpeOd--


--===============0330511891581656483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0330511891581656483==--
