From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/6] ASoC: tlv320aic32x4: Support for
	regulators
Date: Mon, 27 Jan 2014 16:26:46 +0000
Message-ID: <20140127162646.GC11727@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-7-git-send-email-mpa@pengutronix.de>
 <20140127151533.GA11727@sirena.org.uk>
 <20140127161054.GB9934@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3499158909294135546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 84A6526501D
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 17:26:58 +0100 (CET)
In-Reply-To: <20140127161054.GB9934@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============3499158909294135546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDT+BabbEBWcQhh5"
Content-Disposition: inline


--oDT+BabbEBWcQhh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 05:10:54PM +0100, Markus Pargmann wrote:

> Do the normal bulk functions handle optional regulators?

No, the general idea is that these will need some individual code to
decide what to do if they are not present.

--oDT+BabbEBWcQhh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5ojDAAoJELSic+t+oim9sVoQAIv6ukQWt2sjJNPTPQFJNYH1
jzDH+f+oVNczWpJxj5bdkbw56d8EusHkdYDvrnp1d4xcsmM/filKFyEJxj3TkUNq
AGgdM6mihbwLdqWkE1c1gmKO6gBid8NC+j6bkBlOmyslSlNpWZJ9o67DeNhmYgLw
e3xImpErRrzKn2VUMxJibQH5iYMmXrhx4hQ1o4BJjwE+jvppGaZRal+og2K7dcmX
nVqHEuUIIT30iBUcQ4cistQzkLGLWfR/njG+ofVOq/ZpQbXRu+aO54XpebQ0Skre
aLLajbRjAjLFgUC8l3U7aSquv09o0KfMBAHUN1qCdO76QNh6tY0xxvZUdmd3DAEk
HzZMtJ/BiWWK1rBDO7fBQKj0WS3/d3iCjM+E5A1cP4b4qA3UnmPdu0t36sE08kaV
28bpXMnc5GAnh4zPrb1OZUoQtAHAGH3PaBYGlUc7nShSVtPPUH+ljPOEjAEzv5K9
sYhzy8M96L8EbZgFm2JPPnEDTdisZUdGEoTJUiKO9A5WMydJ7glyUnEuMqkdYbv2
EmSioAp848pBALY2aKsGGZ8z7wfZP6AHUmyDrm6wj6gmziC+dGoO/RTH8C4meloW
p+Ah3xUqETlRlb1uDwysLPj6P+EoudjP1NLTIa+ZJKoGlQSFbgbxDCVtGXgNVHpG
DLn50akyVa4L3+oTQYOf
=o1Zk
-----END PGP SIGNATURE-----

--oDT+BabbEBWcQhh5--

--===============3499158909294135546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3499158909294135546==--
