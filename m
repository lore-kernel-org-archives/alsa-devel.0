From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] s3c2412-i2s: Fix dai registration
Date: Mon, 30 Apr 2012 23:46:11 +0100
Message-ID: <20120430224605.GA27450@opensource.wolfsonmicro.com>
References: <201204301317.21519.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3616315415281435946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ED431041E0
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 00:46:14 +0200 (CEST)
In-Reply-To: <201204301317.21519.heiko@sntech.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3616315415281435946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2012 at 01:17:21PM +0200, Heiko St=FCbner wrote:
> As s3c2412-i2s is using the s3c_i2sv2 it should call the more specialised
> s3c_i2sv2_register_dai instead of simply calling snd_soc_register_dai.

Applied, thanks.  Please always use subject lines appropraite for the
subsystem.

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnxYiAAoJEBus8iNuMP3d5kMQAI4GU76KttfmoERLWgnxZRXe
77i27xScl3ZjxN4Fl/yqIwcZW0A/jUjnOO6CdC/k9vx+UyGPaJtG97luS6BbaGuN
4pSzOXe4jGJR/DNeFxQwsZYPcTyj1wF+o2Tl0He3RpVACXRhcOWXU4tqK8jOzNo4
gjj/yc8hQHKLn7+Yoy30bY0aiOEWsaUlhz8K/2ehuFJOmdroFIVX+Rb7k8cJogtm
wVTVRdz4Uo86oDoUalAIMTAUTTJVekyJRfSJYU8erX+iH2Su5SSl1v1a4gZqiKo8
92o2tFDs93qBSSQgzu/IQ2ArEYR7C9tQYhTgG7fMGLSaK3PP3mRvoTvPly+RFUQf
MAxdaxBvmZAMS3M/c6+wijO53uJRCNOX3OFHa0Ec/IdSxO8RcLrcxuWRNDQafkY5
RoXdYR7Gksg5M1OSZ54RtS7v83klCoYSe8E0EKebf0bebAL7jZsZ403IPf9Xd+1h
VOmXS1KGBG8K5yz2kzeu+os4T2SQzT4Zj5jOuxBAtUbTljkU0UATHf2KA1OpFuDl
Uz5Rcnk2wIwhtbA4qndiKBpjkr2VZ1yUtRLmJTSqcaDg4sp615xDGH+mezGtyxZf
Rug7l39TOuhK0F7Pcwm3n8FfDiE7pYgI11jL9KPQE3Ki8ZHEcukYY2CrcXAgsT8N
WpDwCo/QYawHF5T+2LJ3
=pP+v
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--===============3616315415281435946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3616315415281435946==--
