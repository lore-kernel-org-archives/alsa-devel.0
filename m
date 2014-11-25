From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Disable regmap helpers if regmap is
	disabled
Date: Tue, 25 Nov 2014 21:15:39 +0000
Message-ID: <20141125211539.GQ7712@sirena.org.uk>
References: <1416948063-1692-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0675461178888948996=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E9B2605BF
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 22:17:36 +0100 (CET)
In-Reply-To: <1416948063-1692-1-git-send-email-lars@metafoo.de>
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
Cc: Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0675461178888948996==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iCHaPkWk0Ne6xagp"
Content-Disposition: inline


--iCHaPkWk0Ne6xagp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 09:41:03PM +0100, Lars-Peter Clausen wrote:
> If regmap is disabled there will be no users of the ASoC regmap helpers.
> Furthermore regmap_exit() will no be defined causing the following compile

Applied, thaks.

--iCHaPkWk0Ne6xagp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPF6AAoJECTWi3JdVIfQd9MH/Rj5POXtnbCCQM5nxNVXHsaI
U2aEkPzu6UPCX1I9SXIGO61aii+QVaOeZbVWJg22yEnQpRWLHDbIsGRKLN/t+WQ/
8Ze3z8iOOuEvmE2ZPzI62moPf8dLJ5dSeZcrNp0DAoF45YjEwnnJi3r0/ZmoMB54
UL6zno7kpbeHrM8CjbniLcjxZxv1e9s8U4E8AWDWtkTih/ImRRvw6xvbkoOdGEsZ
WOfSl5HSAgEqGwdECy0EvLBV5e4vswC7AYR3v4k8K2vkze7NboqQ75Y/tZoTWe7B
448OoZ6tq5AO2LgZLusLCcLqJNNps9r9EghV8RlKHgQi1gKWnsYN1cKXnrZeqMw=
=NC0S
-----END PGP SIGNATURE-----

--iCHaPkWk0Ne6xagp--

--===============0675461178888948996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0675461178888948996==--
