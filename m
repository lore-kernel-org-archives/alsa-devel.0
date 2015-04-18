From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: at91sam9g20ek: Automatically
 disconnect non-connected pins
Date: Sat, 18 Apr 2015 13:20:04 +0100
Message-ID: <20150418122004.GN26185@sirena.org.uk>
References: <1428743923-26675-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1409260861825041322=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C746261B20
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 14:20:14 +0200 (CEST)
In-Reply-To: <1428743923-26675-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1409260861825041322==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Content-Disposition: inline


--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 11:18:43AM +0200, Lars-Peter Clausen wrote:
> According to the schematics the both LHPOUT and RHPOUT are connected to the
> external connector. RHPOUT is missing from the DAPM routes, but otherwise
> they seem to be complete.

Applied, thanks.

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkvzAAoJECTWi3JdVIfQiI4H/2DLBHCRu5E/3whZt25V7VmI
MDCpLENbiplY/aO01tbwtGQf5+IHDkK3K5E13H+rMg7IqUMQm2ewN7WRApWcXFQl
+PTbYDQgvZrQR421tWqVBYzWg46BwBuwXSR40kDmqK8cbk9c7tewLhjvSM+jTcBS
Innx4zDpiK0/MUHaK7/nOGpiONLjFg0EfAV0LUliv4Cft+QyUn/fxLorYq1rHiXJ
OTh/s7/Mci+D1Gnuy0CZmgf2r4moGrrqmwaZMu7exIwCPQZUMVxkF5EvX3evTqWy
86lc2bIowHu4BeZ0ZW/MC7AJrRGy49oybNm7MEJ4EEVvjxzIXXjI2UXw8r7ea4M=
=Lr7Y
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--

--===============1409260861825041322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1409260861825041322==--
