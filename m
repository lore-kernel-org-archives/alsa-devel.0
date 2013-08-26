From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: Remove unnecessary
	dev_set_drvdata()
Date: Mon, 26 Aug 2013 20:42:51 +0100
Message-ID: <20130826194251.GF10783@sirena.org.uk>
References: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4966488929658528106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A3B2261B1F
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 21:42:58 +0200 (CEST)
In-Reply-To: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4966488929658528106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2013 at 09:25:13AM -0300, Fabio Estevam wrote:
> Driver core clears the driver data to NULL after device_release or on probe
> failure, so just remove it from here.

Applied, thanks.

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSG6+qAAoJELSic+t+oim9zs8P/3+EJQC0XKcAgMi4egobfKLx
0wuMH3V9NwK49BZiwRVP9fn1Xm70t0kMh3HGAwigWaIinR0WXOU2NkRW9I4HSxIr
VBJyrNz7obA6fc1yKmatQlzEEhphTw5eJ+1TYzEaN7UpFpyKGT+K+q1vI4u+N+pr
JmK2UiwAGMLLtZ7o+CdVH6s5xglNhMiu4UCPvuhxVSkvdmnWGQ/KdSo/2+qSZUxT
nCKFyfh/NwMMt/IitygpREDVNmsD6zvaqftnG4gAvI680m4M1PEV6In3QJvJMZ3k
jKzehMmU1atGX36yyEjpeUa+35rK92SlkEAddEt0uiVYCcLkLokgIWnYZAC8CJt8
9TjBU67ZG9j5XRMCUYlga6bTiHWW+Wn911mLGsWiuS7Rb/haVelU+AQrdy7IL+YP
HpLw0AThrszkIdXXBJ0FUMluQ3G97aD8dcxfQnQAWGu3hBrmBSSLjF+jRf1e4PE3
+DJUrpPV5YkQ4IH1QaXYSYY1ZnXn4vihk/aa99Bs1J1Myb9rtJ2oo69RXvRmSeTq
tHH/SpCk/EWJTDinN93eVARjFCLVTGdbI6PozVYQMDzM/YBilxfIRu7mI/HaPzdo
+5uxVPUZpmxTMgdtfqdDVfcZVywKKSTJIxXXz1u7dbvgdHQGUOb5F4AxcjEer8r6
7qxBwx/zPB4ptSFET5M5
=Jgi4
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

--===============4966488929658528106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4966488929658528106==--
