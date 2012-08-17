From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: tlv320aic3x: Add device tree
	bindings
Date: Fri, 17 Aug 2012 23:45:13 +0100
Message-ID: <20120817224512.GL18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8179298287243478362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B96E726619E
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 00:15:28 +0200 (CEST)
In-Reply-To: <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, peter.ujfalusi@ti.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8179298287243478362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2012 at 06:12:05PM +0530, Hebbar, Gururaja wrote:

> +- gpio-reset - <int> -  gpio pin number used for codec reset

This should be a standard DT GPIO reference by phandle like:

	gpio = <&gpio1 16 0>;

There's quite a few examples in tree.

Otherwise this looks good.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsluAAoJEFJkBDiqVpZ4o8gP/2aaH1RQXSDY02h5ZQk98bIq
TCbKNYacplJDvqm+LQgPdv90cGuzXExSVcqnSdczBZZUO26WmBaJ2VWN4++YxnUC
KzpGVvk8pk6yktEwUmIXJJ+3wzGnc2G3/ti64LnGNQNy8PI0+96k7KAqeiS8RB9L
i4TfC+YJd1+zno3vlpNb3WqstSNly4mktdrBGLmARqdTYlL1Q2jJR/NaCRxzkZ15
f0ESewsnATYS+tRG/InT/wR9uiun+GSxS3VCrDIDM+b4EOS99fTC6oV7VNq1j1v8
ze4SVgzlwR4h7W5SfEw19lvVArJcfsoWhHpSPAXgOHt33aC/9tFHMTgvCyOhg0Qq
CuYdON6znN9U+eivuYq4I44q7gk8czjPmsynjGCCnLbv3vbIwI4kgTe1kSbMFh8u
kNzps85sD8cwnyYlwcrM976D/ISMriCNsMjEnNp3is6aAxDthsNSx5I0l51OTJBm
Xxy8XKyxmAT/v9u0n1+pwjyeLo5g5q6aFoMuvrQU3hwOBXDbQqgC7HgBaBmr28vZ
zc8Bz0POJjcu9vqC1McuJ4AVvaES3Bynq3oYHocXlHacAJeUVo4gSFccKZDmP/zR
Se2iohTfRIt37FZpieEC288njv4GVCuuOu55b4CtZ9FTFwT4Z2oJxV+A2TQrLLke
HUI2GhBfDXABsg3HxgpT
=d3hz
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--

--===============8179298287243478362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8179298287243478362==--
