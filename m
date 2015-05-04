From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da7210: Fix dependency to allow
 build with SND_SOC_I2C_AND_SPI
Date: Mon, 4 May 2015 12:54:12 +0100
Message-ID: <20150504115412.GE15510@sirena.org.uk>
References: <1430731682.32362.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5537084699250860133=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9134260588
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:15:34 +0200 (CEST)
In-Reply-To: <1430731682.32362.2.camel@ingics.com>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Dajun Chen <dchen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org


--===============5537084699250860133==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RpqchZ26BWispMcB"
Content-Disposition: inline


--RpqchZ26BWispMcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 05:28:02PM +0800, Axel Lin wrote:
> Since commit aa0e25caafb7 ("ASoC: da7210: Add support for spi regmap"),
> the da7210 codec driver supports both I2C and SPI buses.
> Thus update the dependency accordingly.

Applied, thanks.

--RpqchZ26BWispMcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR13jAAoJECTWi3JdVIfQ0RoH/0koHK8QgQom7fgM+paiJO5B
nerQdRH2helEZB+N7xuIzTImQgMqPbsuXUKydgENpIrZ7w7baTSqsNOvku4u1UoK
8A7dYJAUDu7pH7WGZ8/4MO2lGIlEVVBu8vTa5moRAsutJrDxrkWJNqw9P5hqTKtF
w6tfPgV2PtFsDy3kqCxgf28b4smvSjlqF7Tovx0KvFdn2HV1ce5hAUZXfiKRIl22
BYxrJug7VPbcX7Hy6J8yvt+igG7rdtFb+IW7gICnn1du5wpI5Yu9GEeE62ShYoml
+qID2zl8SIvBcFGhiN+q2lDeBg7DMO2Cr2mUHHSM3HWgtCcZDZ73mwYNL4VB/ps=
=3jUW
-----END PGP SIGNATURE-----

--RpqchZ26BWispMcB--

--===============5537084699250860133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537084699250860133==--
