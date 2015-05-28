From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Fix noise generator gain TLV
Date: Thu, 28 May 2015 15:02:31 +0100
Message-ID: <20150528140231.GW21577@sirena.org.uk>
References: <1432819692-30122-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1368176915339391759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA1E26610B
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 16:02:37 +0200 (CEST)
In-Reply-To: <1432819692-30122-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1368176915339391759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1KGYfHOCPIQBbQil"
Content-Disposition: inline


--1KGYfHOCPIQBbQil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 02:28:12PM +0100, Richard Fitzgerald wrote:
> The Arizona codec drivers had an incorrect dB scaling for the
> noise generator gain that started at 0dB and went upwards.
> Actually the highest setting is 0dB.

Applied, thanks.

--1KGYfHOCPIQBbQil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZx/2AAoJECTWi3JdVIfQG/AH/AyGXw6rukqbewB4oSbmj0i4
96EFnFWS/rFmdNx7lemE7uOmpQFlNKDkVt/jCvT45pliZyLtOtlVVI1Y9QGf5P0/
RfanRfu99AjS6L35pGZFxJ5tEZcxG3teJQ262JuPWw1FcC/az2rFLBLA4RcGbHzJ
9MwHf5TGAyrocJSBIem8WdhAXZLa71MO3DacEixa8q7fAkUNIq9ElejHi1pb+Toz
v/iOl0YnBgoJpv2cflqnq0hvJjrOoAzpnLNW7qJwdLc7Wq1pmv5/rCBaJJw0IXCP
2yjlvDCqd9pYKs9drDHKlhLQSR7aaot+zV8tMafJKjJNW7P2+jb0Eea9sX3UCpU=
=DJak
-----END PGP SIGNATURE-----

--1KGYfHOCPIQBbQil--

--===============1368176915339391759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1368176915339391759==--
