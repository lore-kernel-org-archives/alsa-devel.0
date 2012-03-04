From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/20] ASoC: imx: separate imx-pcm bits
 from imx-ssi driver
Date: Sun, 4 Mar 2012 13:41:35 +0000
Message-ID: <20120304134135.GG3083@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-10-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8496005326177782701=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47651245A1
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 14:41:37 +0100 (CET)
In-Reply-To: <1330788001-10158-10-git-send-email-shawn.guo@linaro.org>
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


--===============8496005326177782701==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2012 at 11:19:50PM +0800, Shawn Guo wrote:
> Currently the imx-ssi.c[h] accommodates the imx-pcm common bits which
> are shared between imx-pcm-dma-mx2 and imx-pcm-fiq drivers.  It assumes
> that imx-pcm-dma-mx2 and imx-pcm-fiq will always be used together with
> imx-ssi driver.  However this becomes untrue when we see that driver
> sound/soc/fsl/fsl_ssi could possibly work with imx-pcm-dma-mx2 too.

I was going to apply this and the next patch but they depend on the
audmux stuff so they'll at least have to wait until that gets applied.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU3EIAAoJEBus8iNuMP3dawEP/031l3IFsZG4/2dw9qoYtzIU
2DwVmXEeDr4SxwU0fESq+lQifg8ANPsm+36n1C4JDykE5mNAwJ/8GOUFRu7q/blV
JCH+p7on2COGjVp+ay//I6la3FmGL+zbHUxCQvFL7yPRv+ToaXMHIndgO4qLs/eq
wdG3TxcFPNj7mQR5LR8cZqPm69IlvLkXvLm7ub+kehT/kYAEcTtNnemHtWMVcTUU
+hMAVvROgotrKSMcuc+/qUVvOYvic8q3N+g3zKtOu3gmfpe1qfh43VbAv0TRW86v
QGV1IcCD+C6sPIbXfPfw7IlAtPxKN5YF6FiabtQyovfz5hQirIPjcIv6xnUSvD9g
LKaoUFWpitj99uoMr5g+9Y830FFnI6bkeh5sFZLns5+VU9yR/cAcmXNxoqc7yVfc
8P5a6TXzwwpaxa38gXfgOyKZXce1/MKUYJOB0fXBFhoiy8VO998Qcn2L70lwFsSl
i6ARa18PECe2bYnHEYm1VGiN6z2Q+zkxTHSd1Df4LxgoYg2TxMm6LP78QpJ3l/+b
KPoUPzlWL+AEnif/++KPMtw8RoXW+9wVVIz07gvG8/LX5EKYuoCEAtJV/7JB6Ebs
XG4cCnUec7PMiMcWCgka12al9ojmWwy5vjUfoE3jdQ1fSBNZAPdTof7J+vzyh+BA
UZW0sa0Y8jRsLL1jtRZV
=ctg0
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============8496005326177782701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8496005326177782701==--
