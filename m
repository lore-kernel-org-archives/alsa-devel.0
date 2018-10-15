From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 4/9] ASoC: dt-binding: Add bindings for
 Allwinner A64 codec's analog path controls
Date: Mon, 15 Oct 2018 10:18:56 +0200
Message-ID: <20181015081856.yhug4axgoembmvqc@flea>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-5-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7999378830995193361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id ADB17267864
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 10:18:57 +0200 (CEST)
In-Reply-To: <20181013165329.13363-5-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7999378830995193361==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t6xcg734xvst7ocu"
Content-Disposition: inline


--t6xcg734xvst7ocu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2018 at 09:53:24AM -0700, Vasily Khoruzhick wrote:
> The internal codec on Allwinner A64 is split into 2 parts. The
> analog path controls are routed through an embedded custom register
> bus accessed through the PRCM block just as on A23/A33/H3.
>=20
> Add a binding for this hardware.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--t6xcg734xvst7ocu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvETW8ACgkQ0rTAlCFN
r3RaVw/7BZ1C7tKtqWv0pJPZGwma/Cih74/n3Smytm7eUkl7d1VdAeEoiIXSoHg6
KnCr5X/k7jHwlMtJ3Aawqgpc7bMnmiUKiF511EntlPMnHl/dOSqFWgz0leFauiZR
gwtCVCk7USz8tWBzkwYeJfmQQ89iVO9EjNJVgN85fTiwD0H59gNATdfLIjIPB11e
EDTKu53aJ7hu9ShhUDOiJxOvaEYPMQJodjcHxqs0PKBVuxrCgGdpmDNtDhooWI2D
LNJNCBkk+mqNq0b6nxXuUHBYryfifzkaMwSPj5HSZZ70zhwNwTTbr+a5bRLExv2L
YqsjsaEpwIyL1yiv49hF+XV9Gfolg7Ws4pVtbqaKnPYDxQm/FcMlB89Tp/ScKRTQ
aYXP8ZQu+Btlz93kztUSM3S4XLIbZA9pKnM9AQ8xSzsW5opFlwAaxXO9ZUK9pE12
nHpU1b6NT3TbT6ZyYdm15JbEKJqlYvdPsaLG1O2WKOXufGPGBVtRR/y/M0fnispK
ccmkbjOFBTzs4cYnAjQK7nF/6XjJroIjcYwFE40/RECbgMaXxytPBgf6l4YmL0Wi
9Hn3b1Y76Jb90fU2vu3xVOOJ5IuoRoDZ+AYuI7UUtJj4Sbhu7EfjxHwgc7Zh8aZD
qguWo0KZ1Bp9KjRVTpW9hJDJMavlq2MbMW81vPzvSFlv4W3wdWo=
=CE0J
-----END PGP SIGNATURE-----

--t6xcg734xvst7ocu--

--===============7999378830995193361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7999378830995193361==--
