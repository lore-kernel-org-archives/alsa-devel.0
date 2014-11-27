From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/11] ASoC: tlv320dac33: Cleanup manual
 bias level transitions
Date: Thu, 27 Nov 2014 11:17:44 +0000
Message-ID: <20141127111744.GS7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7081728581326481260=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 434FE265DF6
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:19:41 +0100 (CET)
In-Reply-To: <1417031880-11364-9-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7081728581326481260==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PU0PYmknCmKnuH9n"
Content-Disposition: inline


--PU0PYmknCmKnuH9n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:58PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore.

Applied, thanks.

--PU0PYmknCmKnuH9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwhXAAoJECTWi3JdVIfQlosH/izbEE4xZCGrnoGfCjBtTYAE
xa02kLc4S3POHUbvr66UMAZBompfHC9ZAuVUCFhNiE593d45pd38vqdlWoQtp8yM
EvyPlvm3MkehFFrcPoxjW4yLQEe1xlXN4QXJq1WFbRCQmlmfGR43p04zcEIbUXvk
Q3Dn0dmM1bfZBc+PJp91LZDFqflAIHoIJSqCThns3EQ6czP0f1wsehdgkUSPgRmX
8+Q46SOTTwTJWLhVKzLY/CfQ985KUscjihR7NznHa+qyV1l+L+lf0HBNABJOMtQe
ZbJTX9vNrb1AYyZVGGtH16qcL3nBPXDHnH00EnCTJHI0Tf7TFkfHRMQWkv1fODw=
=Opoc
-----END PGP SIGNATURE-----

--PU0PYmknCmKnuH9n--

--===============7081728581326481260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7081728581326481260==--
