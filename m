From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v6 2/4] ASoC: atmel-ssc-dai: register dai and pcm directly
Date: Fri, 16 Nov 2012 10:25:47 +0900
Message-ID: <20121116012544.GI4387@opensource.wolfsonmicro.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <1352887751-21848-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352887751-21848-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 14, 2012 at 06:09:09PM +0800, Bo Shen wrote:
> change the method for register dai and pcm
>   - let the atmel-ssc-dai no longer as a standalone platform device
>   - remap ssc and then register dai directly
>   - register pcm from dai directly
>   - modify the code which related with this change

Applied, thanks.

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpZYJAAoJELSic+t+oim9VqMP+wSqLa9ncS8hF7sCcLaGMk4Z
+KdXxrMPhhDZmgYQ4OfTssL1CMkK2QkwR81e0thzNfjzQLRB+4z+OmBnyYaStnMP
Eh0gKR5we1hNWfZdBKFQudHUeiCsIOAM0tCUmtL9gyoIx+/32GgNClS3wuVVgh7V
HPdE+yVuTjImHhzAoz7F58aUmQ5nfje99BNBMbdsUH25Hk5Yw3P2EiMcAcIqEPSB
ueFCw0+Q8Za1JFhyjDB6VgZO9TjkUTLefT0wSgVS10gPeUZ192IvjUSZjG2FEcwI
9uGwC9J+lFfCnCQrlz660f3beqB9QeaA/lhv9+FVDXVQfj/Tl3HGSr1FKOnynp5U
RC1ZNq0aL/Ln8KFiz20QQrjKxIMg0dAYe9U99z4e0cRzcz+IMAGAZnEKSpMMOS7W
AdbJjG12Q707zx01JemwiqZ1TIN9p0jm1PhI0XSh9PTug70ZQ9r5FAbBlsYUAPVq
kCy0pAJNXahd2l2+/t44tvA3acK4jjXEf9/yIQbWvRTjygEVGRn73OQP9cSGGwdq
00BAun0mepqlA7PETCn2V4LYBRrHGggRpPVFvJFoz09phsK9idLU/8F5Ljx20pEP
3SJERgBPFwyJeQudiuBH7/NZopPvaUAU7je3o09JmavKHaocmFUkalCFuP3iPfxX
VEXz8+D1xzKigk/ltabs
=jkWc
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
