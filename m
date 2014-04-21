From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] ASoC: Change return type of
	snd_soc_write() to int
Date: Mon, 21 Apr 2014 11:36:49 +0100
Message-ID: <20140421103649.GG12304@sirena.org.uk>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
 <1397897042-20092-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5004434922969213483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33598261A98
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 12:37:08 +0200 (CEST)
In-Reply-To: <1397897042-20092-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Sven Brandau <brandau@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============5004434922969213483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MQ0Pr/tyewiyxL8j"
Content-Disposition: inline


--MQ0Pr/tyewiyxL8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 19, 2014 at 10:43:57AM +0200, Lars-Peter Clausen wrote:
> The CODEC's write callback can return a negative error code, make sure to pass
> that on correctly.

Applied, thanks

--MQ0Pr/tyewiyxL8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVPS+AAoJELSic+t+oim9uV4QAIE0cK+SKhUWHyMq0Oqevj1/
BxtVlGGY9NKnpT7Eo8FYh1ypOcsX8QFKJOotsnoGhqTdrx3WozQTJmBJS6PWS8Ur
+AnIUzqmL2eH2/G31CB2eDqk2lqTS8P5fmZ24vIRklxGQg4ucqD/ALOY5KF8Quk3
KTb+xTh//1HZr9wc6vhpJeNZZnLq5o5NiAnBdaWQZM73fXPsyDCRe9i7Q3XCArt3
EV3GB2EVlpJSIdi1Oyblb+TZnVgGoVAlv5nrpY3tuF+VeWcUduszQ6qxYY3iJUl/
Xntv/Se0hYK1b8PmkV0Gj9KcqNFp5NpaBO+5ZXC/NEIG99wavLOiue8PKQ5XhfKj
fBmOxnhLehddNofqNNs3MAry5pt5Z0r9dN+xqGIRJSSYZ/yYCtzUrBUpQDyBnOBF
EstlUCKxkBfRJQs+GeO+sWotZ6RlyPsWBOdeKRrwp1H0K2Ld5KxUsm06Ouqtyzit
dt/vp2UXn9lNispWKZs1GcR4crBRXWOI6JYb68gl3Dt9/ehcM58iv8R0+rofvf2m
d+zjc7kmiAMzubPiBgzTIlj/MUxD/OVXvQC0OnLiBBxZeZdFYyLemI8L6Mg54U/4
nLi2U0MkUPZPx2/8CpgvT+GbYLdKtpSvhGzHcwUv52i2j54AYHrFd31z+wumcH3O
fjvk4lBPgie5zHWKHhA1
=ZF5o
-----END PGP SIGNATURE-----

--MQ0Pr/tyewiyxL8j--

--===============5004434922969213483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5004434922969213483==--
