From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: cleanup struct ak4642_priv
Date: Tue, 20 Nov 2012 18:43:26 +0900
Message-ID: <20121120094324.GD10560@opensource.wolfsonmicro.com>
References: <874nkk4nyl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5386733858222051318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9BF46265302
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 10:43:34 +0100 (CET)
In-Reply-To: <874nkk4nyl.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5386733858222051318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qTzJm9l2qECmSDiM"
Content-Disposition: inline


--qTzJm9l2qECmSDiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 01:34:46AM -0800, Kuninori Morimoto wrote:

> This patch cleaned struct ak4642_priv which had
> meaningless variable.
> Current struct ak4642_priv doesn't have member variable,
> but keep it.

If it's become empty why not just remove it?

--qTzJm9l2qECmSDiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQq1C2AAoJELSic+t+oim9iI4QAJA+fBZJ6V+tpqFr0UZ1A+PC
WuM1Cabcwl245YFYvyWP+jAd0+E4ZaAR0QYf5+6U+H5rtUZ8bVODuZr3b4DKPwGu
v4G+Q3y4qcttrdxN4W/dXR2F6d3swMlKQB8J3uuWZ9Qk7MXd1sM7mQTnljLaCYVU
4vOluvCFCURJRGbSTqGdulMwBlb5ZQCW0M85T5ZHm7aEepIfJVTaD9QtDfaxojLM
em5y7r+Y0QGPddW/QEWf6E8rbo+jfsQIycrdpjCrv/OutvXUEcTWQhdplDasEHIv
xtflMZCHtdpBkTI+sP0vrf5xHXJfLX7KeBooQqWfarsaBPDzInA2gZPlqCrahpo3
l0N8DPDt5lu6h5ktS3tD5+jUufhDwEr1ZqQyxOQb0TUYAb9rcD93hsuddTmVsIi6
SVGavXQFKMdG2LVE/vQCbjOynrYGL/nAJMo4MKwlvvPLxO30n8JpMiij2xQPg1BM
v6Wg/RwNIKYR+c9HdYGXthRSJOZo8UQTO/zckKLUyKmHIn4TgAFkC9TwoLjuPJ2i
MV64OpxhWKGP7OaNKxJuXjzHtlOgLAg/k8UU2Y4UnMELt1tTZt07v+H8PAqOxgmF
U7Dj7nFF9sBcxaHkV08q/EYbE8mINQiXKNuN8rq5gJYIrtjNMRUvwueRj9GY65oL
YbcLdxTrEN1CH8BBW4VQ
=9/d0
-----END PGP SIGNATURE-----

--qTzJm9l2qECmSDiM--

--===============5386733858222051318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5386733858222051318==--
