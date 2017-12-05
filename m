From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64 SoC
Date: Tue, 5 Dec 2017 09:04:44 +0100
Message-ID: <20171205080444.zo2rlusqpjyraqcw@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8621498739931830147=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171203204157.20829-5-anarsoul@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8621498739931830147==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2h55f635xqxwe2sm"
Content-Disposition: inline


--2h55f635xqxwe2sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
> Digital part of audio codec block in the A64 is very similar to what
> is used by the A33(sun8i) devices. However, it uses different LRCK
> divider.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

What makes it impossible to derive from the sample rate and number of
channels?

Have you tried other sampling rates?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2h55f635xqxwe2sm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlomUxgACgkQ0rTAlCFN
r3T3Dw//UlwjE08mNutOjIyedPnFh+z15Qzr1LLsJB5Uf2ttbg3ZCWZUndC3x1Of
KWYrxekWLwvfpKJDVievWVQJTlKxGkDAeAEuUJfOL9J7yNyP16LSxhncFIYlzwl4
EECSAEYSHes/fmF2qiDojpEsfUm6cBPOMpC4x/efLAPlNQ86vvxlKkz0xdBLFqx9
MriTSc1LPLJNJgxbAGjG1JE23tnbeLYaQGapzkjkxVnGI/ddRouW+xeEtDmKIK8l
Rb+kE7dnSY/YncV44cLnu0MCdtmstfZKqYXA6f2IHdWNTNmO3K5xQaG/NaN3EfXd
dkRk+5tUh/C26aVUk6WPAfoPz4s34uHTdHj+KWVaKCSGKum68frNiRtFHe3C1Xkh
530O8t2C6jpCcxZkVaLM5PLGPmf8gjHIR4+pde9jP8Ax0JZC+7PtdBoGx3wA4B2y
n+53gXvXje5825i/mrzGcSr1wkDFCGlETGEHtwiz+AYETaXUOKFpXtu8F3kcqVET
cBGjCZTw1Eb+t82JF191NY95UwPZYfWlUesGsWwrO8N4Hv0wiGQKFRsc6oTxIW72
4uNtzop7H64fTqhEyXZTRvw94d6PX/92CC4XdRJpBEJHTUffeaLWjZk4DtAG6SWc
l66gnPHf7IRyO2In738XYO66lUKisAvHsFMaT6/pY15iG2Xv78k=
=wnTs
-----END PGP SIGNATURE-----

--2h55f635xqxwe2sm--


--===============8621498739931830147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8621498739931830147==--
