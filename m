From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/11] ASoC: tlv320aic23: Cleanup manual
 bias level transitions
Date: Thu, 27 Nov 2014 11:15:38 +0000
Message-ID: <20141127111538.GO7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
 <1417031880-11364-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9211354693451416875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0312726606C
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:17:35 +0100 (CET)
In-Reply-To: <1417031880-11364-5-git-send-email-lars@metafoo.de>
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


--===============9211354693451416875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NBo+v+z9rqUBJl3+"
Content-Disposition: inline


--NBo+v+z9rqUBJl3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:54PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--NBo+v+z9rqUBJl3+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwfZAAoJECTWi3JdVIfQubwH/ju3/WPBvBSGngBegdKPBB4Y
HB3wMAmq5dGIhSIrKLQ28yBI1MBDLYHITSa1PR2+WVU917JMl+XZe8MQlmv7pEaj
wAJZugLsBcRPc+tc/+/pHuxS1CSs4dE+xWOgZD9yFBZSI4Utzl1ZHu5DKOv0TjVg
7s/O/Z1OGLAwBP6qBZSEfDpOspc5JYI+c36gbeYkbRx+07WbTPx5+cPk5TSBkPDK
UGtRYW0vt9OJCxXjOnjh7nP4S1KNX3LH29jjB23VqRKav+yaDiflNMj+Ma6af0uz
3mCy8vd8eiQuAs7wt8PB3ec1JlZC1jBxFGGRZcn1PvGdNV3UKAFqvKXcqXeIGrs=
=1kyC
-----END PGP SIGNATURE-----

--NBo+v+z9rqUBJl3+--

--===============9211354693451416875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9211354693451416875==--
