From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: Aux dev initialization cleanup
Date: Wed, 2 Jul 2014 21:24:33 +0100
Message-ID: <20140702202433.GT410@sirena.org.uk>
References: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3757865075143793012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B6E265361
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 22:24:45 +0200 (CEST)
In-Reply-To: <1404245628-30877-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Sebastian Reichel <sre@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3757865075143793012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RvrrZ8vH9xW05bsQ"
Content-Disposition: inline


--RvrrZ8vH9xW05bsQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 10:13:44PM +0200, Lars-Peter Clausen wrote:
> This patch cleans up the way a aux dev is initialized and bound to the rtd. This
> is useful for both componentization (moving aux devs to the component level) as
> well as for the multi-CODEC support patches.

Applied all, thanks.

--RvrrZ8vH9xW05bsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtGp+AAoJELSic+t+oim9Pc0QAJpKAzMSIHDRrm8ySDA5hduK
hKeYMfG/cdJC3hOgUrRuYOnjaNYhPWlkAbEAp+Pir0yV9mbZJsdpyHhMpM4Py8a3
/mpQ2gEHzyFNccLBwfqYJ+WNQTOhXPIH8XpzC/hw+jnVItZGGI6tjAoGSuK4fUJD
wcySLXADuU2/LhofO4s2BZj/AeKPh5oMKMhzmCZV6Bmnj0RfBqLHXmxEBcM6Dpu3
NOLfAP3R/r8Fvbia6mQneyFDiZZu0IZlN8gq0a3ZsxHjof24Mu7/R1i3jWFk2oUc
aOzubWZVe8QYC6Dl7/2S4dyTdgWVpUwIv2cD3yhvviQk3ZRehFMvwUvH4AkuAgiC
CuRhKcH9SHxfd5jbZlP0kZ5ROM5bIno10mKuzr9cbdvqMe8tP/ZvOE00C7zJ8Oka
X48EcrbXhJ1UoJpwRG/Xetj4qYv2LihqB0NAK/8H0ANxnIfZCeKeY5y28D7fXwCb
Q85qCEZmA5o6xlcMqdwYt9II09xwgFty1Oj6E/c4Qo39GZe4XyeTE34rTYteqqGY
Z/9ejd27HkOxRRg0Uls/rrx/K1WqCTpExU4okN61pv+0dpv2unpyJjFaqaKIMLVX
OFxuJEBuGTBUpkfR5Pr5caswu4hhznMvXu1c6hTXniJ2gJ3w4PXksMgv4m7FHow7
SaOUcMkKPgf5qu1eUOHQ
=0GL0
-----END PGP SIGNATURE-----

--RvrrZ8vH9xW05bsQ--

--===============3757865075143793012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3757865075143793012==--
