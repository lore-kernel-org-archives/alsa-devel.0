From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/32] ASoC: wm8350: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:17:17 +0000
Message-ID: <20141124181717.GU7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1334282757882054157=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 678BF260534
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:19:27 +0100 (CET)
In-Reply-To: <1416746269-4935-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1334282757882054157==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65fUfJaAyj3QT6Mb"
Content-Disposition: inline


--65fUfJaAyj3QT6Mb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:17PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--65fUfJaAyj3QT6Mb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3YtAAoJECTWi3JdVIfQ8QQH/3Gh0IARB1mE3oh6KfVxSdH2
4G6GOONrVV8+phRy9eZeTgPnYUeqpJRiVmftMupswnjleo445TuwAFqEgn+wHy0x
bILUYBAhD+pi+XLBPXwFjofIyY+13UbnqsYYA8wHJxErlfuD3T6K11N1YXPqYAmp
64luVuG2+a+JFbmXxecT3O6yKEY3nCvjFvV6HrTC4QYrGZmhzaaALOtfB9u8zv15
eZdXlntcMd/3d+hCnrXoQZff37Z4WdtYsbpBy51hRm3N/KhMurToC1KAr8ypTLwd
YaM2EITfjt0vCRj0TzC/bxu6iH4z8L1aZrLfm0KFa3MlvXtwPfzaD3sD5pJ5snI=
=mkf7
-----END PGP SIGNATURE-----

--65fUfJaAyj3QT6Mb--

--===============1334282757882054157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1334282757882054157==--
