From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH V3 2/2 RESEND] ARM: dts: bcm283x: Fix
	probing of bcm2835-i2s
Date: Thu, 22 Feb 2018 12:11:55 -0800
Message-ID: <871shcaino.fsf@anholt.net>
References: <1518778534-3328-1-git-send-email-stefan.wahren@i2se.com>
 <1518778534-3328-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003072645562715533=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 70E9026782F
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 21:11:59 +0100 (CET)
In-Reply-To: <1518778534-3328-3-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============2003072645562715533==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Tested-by: Matthias Reichl <hias@horus.com>

I've applied these 2 to bcm2835-dt-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlqPJAsACgkQtdYpNtH8
nuhpWA//Ycq4jAee62ig9gVmxi7DOXtC9xoDJFZL9f5jx4+i4LeEy2Wf2EATx/sr
er/e24DTTJQEUOVZB7/iYUHmBi1Wx4bedCIWmTVqav98N+nZXI0EG4JKzz6btG0j
DIzVt2Jwf/Z2H5hy3mDEAH7HBxKkA77XBTb9tfN/TDUMGBzxMDGJkbF8uYg7NnwV
qT4Z4FBe1y8BbKP017+KYBk5pQnRcH4uC69mqkGaW5yRXrvfYNTw4N0bUPyY6tVr
FrD2Wlm31zB9elRY71miVb/PoIdxRt3eEOLHFH86ARV9fwzkf5L1C7bHwpaDmAHB
O9NTyZa+8bz0Ol6FOhf9oZ8LUM3BGR9xH5rfLGT94Ex7nnLu2eN6d3qcEszUWgyt
yGGOjJ8q9ncnVYIkdYrFRDZTV3VQJdycJ0UH4R9oZeAxijltN0ysuO4cznXXjOVA
5JZru0/7wkmmIkc8jaUVqBFpDMCnSbG8xt4IYkyAhnGfn+1kNmXPjhpU3eRckvNO
jaxGSXLo+jG7az3+RAWblLq9uTRUBCIkeehmwdX5pvl4vaIQz/aZP97DDYShVjts
pdpDCbfoRV+uFvF8mWA7K38LOMzkrGwCsvQ9Vsaoo2AfbkJ2PV7jzgJ7S0XAH1Z4
IbH3ylnH2AeQDczCEeGLYQ4XUI9dmt80XAcdZGeZwAeicPQRaN0=
=xbJw
-----END PGP SIGNATURE-----
--=-=-=--

--===============2003072645562715533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2003072645562715533==--
