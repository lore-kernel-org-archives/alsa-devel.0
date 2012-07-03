From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: add missing registers
	and bits
Date: Tue, 3 Jul 2012 19:53:27 +0100
Message-ID: <20120703185326.GX29030@opensource.wolfsonmicro.com>
References: <4FEAA303.5020806@aksignal.cz>
	<20120627120130.GJ308@opensource.wolfsonmicro.com>
	<4FF2BE57.3050602@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6452623635946358450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58D6124603
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 20:53:28 +0200 (CEST)
In-Reply-To: <4FF2BE57.3050602@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6452623635946358450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Content-Disposition: inline


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 11:41:43AM +0200, Prchal Ji=C5=99=C3=AD wrote:
> Adds missing register default values to cache.
> Adds register and bit shift definitions in header file.
> Changes are for TLV320AIC310x based on data sheet.

This still doesn't apply, please regnerate against current ASoC and
check that your mail client isn't mangling the patch when you send it.

It should also be being split into two, one to add the new register
defines and one for extending the cache.

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8z+fAAoJEBus8iNuMP3dROwQAIeiDCH7opaEs59mFztagJ+i
QAQ9bqarubqMaznAX/M+8nWS13ySq9uO8/5Sqj4Tevy0KT1CebFPT23fssyTfpOg
z3IaJ2+lXQh2wkpapaz8l0fIIoqh6IGqcp+aIiqsHTxohivSRc2GuTc55OKa5bfH
T5iee0ovi354AGGFnpNRAbKWK+WpSh79ckzgq8/djkxfmplGZNUoHZ1b5GpLC4cZ
9Bu5tqDWvF0iRXsRu936Sx1M1yAef5a5zNaPG6K/RhrflSCnZdsHA38482dFvB4o
7j0Lv7DiozYe4fpZ5IjQoim45IqefVBW9UsAKzn1YZt8ynsiv2Y15i4GB3Q99FUm
oJSQdsk5f7rshjIc1QXSv/ddZpHcRFOLoJEjEXF1V5zfbG6MQ7UQ4D0IeW1oR/QS
yq03BkWDhEMy9UqOoi/fLETH6RbeWyMzSmYiEkPfE6XY3OGsSfHzhmt0VfvzvKZ8
tAmi9fc7Qb48xR1zk9E+C7ZATVnwEYJDHlW3wGaW42d9y/SqNvgW3xnAFPnHsW2g
g+Mb7CcZdX+9vFpSPqgE8L8u5ifwi9M0wSAjqQ0AnhHd8KKS5OeYuvJ1iWF57x0x
G9mrw16UorCimTc83TrcIp0v8gWkVbyyxOoQqJ3lWJxlVD8hC7Ojq8jNiGlGaiSI
g4oTib3KB2xPJhaYAwkY
=GihL
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--

--===============6452623635946358450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6452623635946358450==--
