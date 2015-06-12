From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Use devm_gpiod_get_optional
	for hp-detect
Date: Fri, 12 Jun 2015 11:54:02 +0100
Message-ID: <20150612105402.GI1921@sirena.org.uk>
References: <1434100755.7458.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1420412001287881787=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 94BB62667E4
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:54:25 +0200 (CEST)
In-Reply-To: <1434100755.7458.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1420412001287881787==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u/L2/WlOHZg+YGU4"
Content-Disposition: inline


--u/L2/WlOHZg+YGU4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 05:19:15PM +0800, Axel Lin wrote:
> Since hp-detect is optional, use devm_gpiod_get_optional instead.
> In additional, it should return error if devm_gpiod_get_optional fails.

Applied, thanks.

--u/L2/WlOHZg+YGU4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerpKAAoJECTWi3JdVIfQuNwH/0g88MI/uWr54cREe9v+mYym
HxaeW9wocCBSJ6A0QNQ1dxv4MAtNn9kNUbhdAHl6HZbh03d7nWV4hINJbNBVeMvM
Y6AWzZn2Pf9XwjKJEvX9/m87tTqTUvSiXwmIZxhzczV25/W3NYdYn3+801KecyEq
l7SD458l53jQ7ShyKnPFZA7qSrlJJdJgiovmCVXuABrn0GPDgiwrDqLfhnZRqiwS
CbtVVb4IjY1LIN/GoNPtq+NIU4b1Vi1RPZDQzjbey45BtqfwOYErejvl9u/Jq7Ip
PQ3o578U41e44W3Zxra8cYYL2qRar6LEpvFpmt0tQJ0YPAYT393NpWc+zSznRY4=
=5WKX
-----END PGP SIGNATURE-----

--u/L2/WlOHZg+YGU4--

--===============1420412001287881787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1420412001287881787==--
