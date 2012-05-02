From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Wed, 2 May 2012 10:07:08 +0100
Message-ID: <20120502090708.GE4075@opensource.wolfsonmicro.com>
References: <20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
	<4F9E4CB6.7090606@stericsson.com>
	<20120430100452.GE3170@opensource.wolfsonmicro.com>
	<4FA0EBF7.2090903@stericsson.com>
	<20120502081709.GA4075@opensource.wolfsonmicro.com>
	<4FA0F008.4020108@stericsson.com>
	<20120502084104.GB4075@opensource.wolfsonmicro.com>
	<4FA0F789.20708@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4263366978073666763=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 226F41043F9
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 11:07:11 +0200 (CEST)
In-Reply-To: <4FA0F789.20708@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4263366978073666763==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2012 at 10:59:53AM +0200, Ola Lilja wrote:

> Yes, but the codec-driver has dependency to another driver. For AB8500
> codec-driver it needs the MFD-driver. This AB8500-core driver can be deselected
> in menuconfig and then our whole ASoC-driver will be unavailable, even though
> the other two codec-drivers actually could be used.

I'm really having a hard time seeing this as a problem, especially given
that the ab8500 is the core system PMIC so there's a whole raft of
additional functionality that'd be lost.  I'd also be surprised if the
interconnects between the devices could be expressed without excessive
pain, or alternatively if there's no interconnects I'd expect to see
multiple sound cards.

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPoPk0AAoJEBus8iNuMP3d3JkP/2ExoDy+ZFDoEQKgVrPE8dY8
agCRaeA3tXVBOjUiK0+d8sadYEPjVn0y9QCeIdar0TjMi7CAEngFuDOI2/FmVuZy
LqptYQIZFw/Zhf+jnFkH/2IIHbyle8HzvQEFTxI8KDS2uRHQXw7DRavtyNGHsayh
qWw7PDyvvqPhXMT8ygndi4vaAq+NxnWEYauBwEPY9xXWV8fc5ylTO5S2/S4fucos
nNljWnfysFsokvwnec+jGVnFBaW5jjKyIwHZzSNGsFngAl5yiOgTj3XWPB42nfHj
yFhMxp0Ek1znJIJHaPeaarTguWB9d08iyqjiOiA1ltjg6UVd1ClwcTrIXFYfJgbk
FHmpFRWaafY+iQdQUJqv9nJ+RHPR3pQs5wqvT9tLQ+c7+tAITQMlFymYwVK8Rt+k
/9addgTGO9XRtcBvJBaiLg0vnfQRdCtM+8wCo3iGY4LSPBJiS2snoDD5yWpy4fL9
KJOWT0Po2/tcb+LUQZDd0NzYGThBd0oMaXySvdlO+IIKrD3R/UMSyvfNhZQ9lywR
WnxJkOpnyhgV/S1YtFLY80/qkHp/fMbYZt3rrnh4j71b9sCN7rpavrGc0Na0vFIC
7VMQ6/LIs488NjWRMaC3iP83Quol4ESuhU6eNjLaWYTq1XLprmJFrKOPb1ieGgIs
k99bWeouGI0avQ0ZJGYf
=p2D4
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

--===============4263366978073666763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4263366978073666763==--
