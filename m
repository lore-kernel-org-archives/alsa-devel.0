From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs42l73: Sync digital mixer
 kcontrols to allow for 0dB
Date: Fri, 11 May 2012 22:49:15 +0100
Message-ID: <20120511214914.GE29835@opensource.wolfsonmicro.com>
References: <1336758885-5830-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2071948136479007535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FA5910479D
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 23:49:19 +0200 (CEST)
In-Reply-To: <1336758885-5830-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============2071948136479007535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2012 at 12:54:45PM -0500, Brian Austin wrote:
> Some of the Digital mixer kcontrol max values were off by 1 not allowing a max of 0dB.

Applied, thanks.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrYlUAAoJEBus8iNuMP3dnpsP/22bKscf0cYRfumksOJij9wI
BTdbbvQalSxxs6fK0ztrlnOlsSBPaGg6D7blBxusFUmfQtq9NsQQr4DL0hVtK3BP
Mr637P4yzfPVxGSdcWHZ51QnP5Rx21rLz7e5R/Ky5rdiAaFt/2V/R32psxn516bn
tSwwLYGEHKfp9qRL1GiO+R5Pl9wolUMLWu+mCqw7IrdWaEsVKbXVppkwL3JTSexm
d33j5xMsqG8O4zrcjDVo5waBBUCS1m56X/p9Fyj6pSBMXi89ZRiiE1ph/R5WVddf
FwOWKCVO9b+oBdW3JapNCad7Y+xmXueDidyCGhNy1xSb2pRvfDXOk+DFlSyStEMh
hL+585BdoOOy2nE4bgNTMJPekpxmhISTEmK8DDX8ji4OKCZHIgwdFUoRV1R333tO
IhF9mX8VGUaahkgUh8BLI7d3hcurNpvG+ziMEpcAE8ziazoM+7/4FI1x1SYf3rsK
l62i6nm+s2euNIu0pyWlPdK+cAj/1dz3Khsc2lS1rYER6V3Xs8KVLnHvNX3CPzuW
U9/y+b4QHDXC9EzupIH559D8QNExUohwTAJs2ZEJIkqEKo7grcCnN/bv6Ecs2kAC
uhYcpYA6cGheNH1DfQRUNI9YZmPfkMMZwFHJhL3mtf6beeHOfxX6vwHykERM6FGd
KnYs9rB+q2rtEUH87+br
=j6ZV
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--

--===============2071948136479007535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2071948136479007535==--
