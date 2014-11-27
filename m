From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/11] ASoC: tlv320aic3x: Cleanup manual
 bias level transitions
Date: Thu, 27 Nov 2014 11:17:12 +0000
Message-ID: <20141127111712.GR7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8718632062932447970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5642660F8
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:19:18 +0100 (CET)
In-Reply-To: <1417031880-11364-8-git-send-email-lars@metafoo.de>
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


--===============8718632062932447970==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjIEObK1SeC6g69z"
Content-Disposition: inline


--bjIEObK1SeC6g69z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:57PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore.

Applied, thanks.

--bjIEObK1SeC6g69z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwg4AAoJECTWi3JdVIfQLygIAIM4Gb4cooyJhoJ2I6i39Gbp
6hd9sj3gpi+/7jQogfrdkD60hwepXhQehMvmq3RjxJefJnfPaWO0KQj4Y9bUH9Ne
orqZbZiNF/BqXTwyMGijSWqumFni7iVQZueDW3FPy0rDSxJe4nHGGUivM8jPf/iB
PrdbDZcmhnq2vB0zzzrCUUdAj6kIEPtSgqWdkC/sbiUyYjqG1B0WMI1CFDZboFIk
bLQSGI4SOhof9HeVPSp9jHH87eQeJuNMypD526O2lKqwUEONdq3Twu2xAqChxxTu
vJWi0ZHpL1qLGd1p5oeQ012is1fXtzKf5PfrD++XCv2oxnACO2MVtsIDzDfhNwo=
=J3U+
-----END PGP SIGNATURE-----

--bjIEObK1SeC6g69z--

--===============8718632062932447970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8718632062932447970==--
