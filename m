From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 11:42:28 +0000
Message-ID: <20120225114227.GB3167@opensource.wolfsonmicro.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<20120224141207.GI5450@opensource.wolfsonmicro.com>
	<20120225012845.GF24268@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970879977490472057=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DDDC24442
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 12:42:30 +0100 (CET)
In-Reply-To: <20120225012845.GF24268@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============1970879977490472057==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2012 at 09:28:47AM +0800, Shawn Guo wrote:

> Per discussion [1], the whole point we move to fsl_ssi is that we can
> reuse the DT support already in fsl_ssi.  If it's something we should
> not use for IMX, I fail to see why we should make this move.

I was assuming that the idea was to share the code for device control
as the same IP block was being deployed in the various Freescale SoCs
- if the only thing they have in common is the device tree support it
would be a bit strange to merge them.

Note that it's purely the bit where the machine driver is instantiated
=66rom the SSI (which is just one or two of several properties) that I'm
talking about here, the bindings for the SSI itself look good.

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPSMkcAAoJEBus8iNuMP3dPJ8P/3TY8PxjGLuIsQW93nl49yXe
TeYGGAf4TN7oLVB1QtAktY28OTOSeahc6HY+z2atcik57nKnH5wOma/PsgZl03L0
mz5FVusawg16+tGd6MUekfs9FHOLvu+setSqvlyvddDLAemI1tQ15usj0nMwatAw
LyDjeMd6PXmIK3rIRSHnCf4l3WZmR5LraOUzzvDFrY1IRX/zOUJYr1cim6QObJar
F/O9RAWD9Gy9Mpzl5Gw4o5vDRefzijbohNHLj6zFEr4epoWMYqRyzXJqG8e35B4S
dXN07dEzGzaiSPBg03E7YnXmA+UaE26hATOJNtrRhMBgyISWnNxUeoja7pbU8tYK
ODfcQmTAUeoOtHDH9dMl7PNSPYdFb1Du/kbYE0xaLKmJFWWb3iAl8fV1wdwsEpuO
gOwZmUEK9dm1Q0BdwneSfxndudOt7wXV2lZqeCl/OENz/1enVPnhDSkLyAcqH/1G
9l5FqOukrsBCFMSgFjjegiA65O3hauFjXEZCSfuSkuybQC7a9dge3rn6LmblHlOx
2Ev6OoeFgyTtkLOBAo1XljKLjb8v8WCeUR2W0B9ioXibwYU5nNpi/jBQM5iPgCgU
yzbqynEooSR/fTip+inhACmkcJoW2wB1BfisQJE+AvCXDyXj+xnGNCE/6g+3JiFT
Aboml4ZYYNLCxqhqk4Ji
=sHrV
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--

--===============1970879977490472057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1970879977490472057==--
