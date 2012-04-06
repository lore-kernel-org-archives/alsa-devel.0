From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: use devm_ APIs in SPDIF driver
Date: Fri, 6 Apr 2012 18:24:20 +0100
Message-ID: <20120406172420.GI19424@opensource.wolfsonmicro.com>
References: <1333732444-9872-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5080033953142262817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 06898104474
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Apr 2012 19:24:24 +0200 (CEST)
In-Reply-To: <1333732444-9872-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5080033953142262817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2012 at 11:14:04AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The devm_ APIs remove the need to manually clean up allocations,
> thus removing some code.

Applied, thanks.

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfya3AAoJEBus8iNuMP3dqtgP/i60lNR/nzwlx1d1Tr1h9Km9
yjXTe39Vdux96O1V5FRkAXA/Z3GG3eOh4uGYsw1HdjLLp/Bft9ZU6GkKaDjBdOQf
TV16Uf/VEvGgVxPlDR4TJP2hIE1b361gPOJYgMjlw9cBMQefMlPvW/3p3j8jqYqg
rQlzzO6AS8OmJy0TANou/OYxCIx+9PCi3UyPQil8/c8zHs+AvPHZiD9H0dVCvz9X
0KWp7+LTUbjI/wBqH8Ag38uEY/fGeqoDQ6LNOe+BoUQu5rLqLch92AfxiDnr8USq
FS655qB2rJNCZrxkuNBX+BPm7RA2mhXuZAKKv2ugcJ18bxmnjKMBHhjWS69rLman
TigM4JUvY43xAtxabQhq0bFervi8AWeyR5NvrqqSZCqKN2ekUKT3BxKQvE8/tyDj
TnPw9iAAbIABfaiuwDQ009ligsE4wKKSR+vd0CNw1eu/Kbli8hXhmFjqNRpfWxWc
ARj/tvkvjsz7bMsNcuwUoynZUkAuYlZhWUEm6P+9SEXg4e5WnLdWe/PNWXgwFAKz
YQMMGoMKqtvsplHhVGGl2hx1k5Q0PUTfu1G45EG9d9bpVaNeNHBpSGDoNxU3svx9
Gp01BhYf4yRPR6zrlt1pu8pILJqxBrsE9PUcu9qVt3ly7u25urEs2qeFMOilJSTD
zn4Wtm6C7mq9B70mcQyb
=mpF6
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--

--===============5080033953142262817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5080033953142262817==--
