From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoc : cs42xx8 : merge cs42xx8-i2c.c into cs42xx8.c
Date: Thu, 16 May 2019 10:52:34 +0100
Message-ID: <20190516095234.GB5598@sirena.org.uk>
References: <e182bf72-c369-7344-e4d1-0524b09ca489@flatmax.org>
 <15b3a74a46f3c17f9240e5d90805e4056f80c55f.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5806011392624164275=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CB82F8078F
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 11:52:41 +0200 (CEST)
In-Reply-To: <15b3a74a46f3c17f9240e5d90805e4056f80c55f.camel@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "S.j. Wang" <shengjiu.wang@nxp.com>, "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "flatmax@flatmax.org" <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org


--===============5806011392624164275==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 06:34:47AM +0000, Daniel Baluta wrote:
> On Thu, 2019-05-16 at 16:15 +1000, Matt Flax wrote:

> > Is there a reason to keep these two related driver functions separate
> > ?

> cs42xxx codec has also an SPI interface. If anyone wants to implement
> support for that it would be easier with the current split.

Right, that's the reason for the split - the split would need to be
redone if anyone wants to add SPI support.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdMuEACgkQJNaLcl1U
h9B4/gf+NjLSAA6IupLoX3Fba1yPJQGR+BIHpC4hNUgTBX4dkVEnRAYOJAud0KIi
FuRnEy6qIemTDq87JFHB92Tqv8QXbyzjp/PSXr4mVKOSAgnwCDnrpG1jVV/NxaoY
EIDWb/wTGBRsP3tD0+0OMePIYL3YFq5tG/3u+pfvC09/oY7KLOucLqXwwnJg8OVb
X8tvgkBj8QJrhqznYIZbS1deeyuHFxdf9JD8ysMbFVqmZ1khv9aFrZk4MgFhYL4F
/anN5XSYEr8nObkKTcDjiYiYlaqtLH0QcHeCmXuscIrHF5jpv3ywaOLk12KCydrU
bwEERuGYbjgZDquC4EM3kjh0fXwKnw==
=j1CO
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

--===============5806011392624164275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5806011392624164275==--
