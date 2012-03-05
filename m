From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Mon, 5 Mar 2012 00:26:36 +0000
Message-ID: <20120305002635.GA23798@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1060544554363597739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D8E624425
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 01:26:38 +0100 (CET)
In-Reply-To: <4F54053F.9070502@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1060544554363597739==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:

> To answer your question: I was lead to believe that the individual ALSA=
=20
> callback functions are atomic.  So one thread should not be trying to=20
> start playback while another thread is simultaneously trying to stop it.

That's correct, there's ALSA level locking.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVAg1AAoJEBus8iNuMP3dIT4P/io7sKeSQ7hRd3fgLQn3tYJf
p1Xcpn9+QMCHXIrxIaZ1dL6z5PWBhrRF7pqj7CxkzQ2gbust/x9dbSPGv3hmUfr4
115X+ViPG+kEFonbxT7eZyD5aNCPwqhHAXcln1OrC/KVp5Sp48VSENckdsxiQAPP
wBJJr2ta9JtLFQrxZy0hRwFf9kI+aTC0GLgixr21dEwKMLr+CMIJj2tBkF5NR4Hk
HB2qnn2lKqrFFEiCNYkH0PtmHUPmAHZLUBaaIbEiZtOkp/RfnWyhKPdJmxDQ7e+D
bI98wReYdDKl62rXx+pXRSRP5NPsmDC9hh4clAQNjz7VXcE+GfB0KDP9ZL2EjDV+
FtvVOJoUgkTgNojRLMu/0SAbOv1rLL8HmelmnDDsKeVpL8viuhzdwgBqM8xI+WWL
ygh3lG/4/yRpfxAe2U02UUT9yT4+SohBVhGQVV1Aka4WnMKvsSDkVDp6XI1ggB6L
3cGn0+hu2mNeX/4cYAW69wE3k+DoTcW0pe6gJnqHVoYc4e4J+du6Dz694uMdE2U4
6XGCfvXbqRwjDFrCgnmMN0tCMROVhq2sGHUu2a1amsBvB4s1Pgmt5abNc4dEHdXr
/F6kJabT9fDHVPHYI8aer3ai0kF/Z78hptO9YhGohQAvi+BvCy15Umi3rfKSaXKD
6Yy1B9qiaDqse2fO+uYZ
=dO7p
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--===============1060544554363597739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1060544554363597739==--
