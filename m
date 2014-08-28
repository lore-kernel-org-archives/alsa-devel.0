From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs35l32: Remove unneeded
 regulator_bulk_free call in cs35l32_i2c_remove
Date: Thu, 28 Aug 2014 19:07:32 +0100
Message-ID: <20140828180732.GG29327@sirena.org.uk>
References: <1409219678.21395.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4182517608067164560=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F6B26A7A8
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 20:07:49 +0200 (CEST)
In-Reply-To: <1409219678.21395.4.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============4182517608067164560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 05:54:38PM +0800, Axel Lin wrote:
> The regulator_bulk_free() call is not required because current code is using
> devm_regulator_bulk_get().

Applied both, thanks.

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/2/hAAoJELSic+t+oim9D2sQAJU6OcrnLc5w4OteeTEsyW9i
kakabN5/2zwAS+BR7rE7MF8R6+GsfYIcM/teQ4HbXqSkPcYb5xsSlIVRVJCzYz8+
0Ft3XuwLJUWjxp3R23a/pGi8iyAYTFBpBFnw9RgraEmYyo3JVVCJ15KqtQaS23OL
rrXBWZQNCZyrZbt2LtWVNCWFTkAIKuTXLO/egxuV0Zp21IQyCowQ9NZNfRRr5lKt
It5HMOJgeUi8uvJ0GX4tcD2G7IhKSUN+aTGDXF2J8aTnGlJaBDO3CrcfUO/bN1X2
1Oyy8ZBadDkQTXsSuGAJGh/Hby6HTqaCiei/rMneBUPA86Xf+ZsqaC7FwPHhIUi3
gXLpFufm9irx7gEuo6lStc94rMgverj4yMNLOoq2SjrbOcq+PZIr0EusquQ67dSy
P8O7yCnF5Vo1st6FPK7t+pivVrTcpnBJT5r49gYFIRdUswDA3cY9jHaxKrbRQHVH
Y32YmlfdP3nNR/W5mw80dZpd4nM17u0MNPGLbOiyOKDOUeRgrgIAWQeOPeZhfbYT
FWhvbEUZDKLNEWjKqppXlBw5d9z7ZNT53GXIt4G9L50ySSTd2L/18eIiv+52+dEJ
NddxxjnP98tUCEv49w7SOCO9bylzEzeh899CSsJq9Lv+y7GckhS371x++/cA4MkK
walBteayRWB/KKr+leW1
=MHZD
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--

--===============4182517608067164560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4182517608067164560==--
