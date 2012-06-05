From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Tue, 5 Jun 2012 11:10:48 +0100
Message-ID: <20120605101048.GI23408@opensource.wolfsonmicro.com>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
	<20120605064714.GL30400@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1113630973321591637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D011D10427F
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 12:10:49 +0200 (CEST)
In-Reply-To: <20120605064714.GL30400@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, dong.aisheng@linaro.org, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, shawn.guo@linaro.org, timur@freescale.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1113630973321591637==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cVp8NMj01v+Em8Se"
Content-Disposition: inline


--cVp8NMj01v+Em8Se
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 05, 2012 at 08:47:14AM +0200, Sascha Hauer wrote:

> Have you tried compiling this on PowerPC? devm_clk_get is only available
> with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.

I just reverted the commit, we can try again when PowerPC has been
updated somehow.

--cVp8NMj01v+Em8Se
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzdsVAAoJEBus8iNuMP3d35UP/iLl+yaJCe09EI95/lalGghk
B3wYpemAJ+FGLamZE34v3Zu52Z1Ex22Xni/Uvqj7bT5IxtBy2pg6nlo9ZWiNiFra
zjyTrLgGelC8Gw/FbBcOtNvG58Yn8QGMx/l0aKxldgz4jqQEoJJhiGLV/GoZcEfb
Or+z9ybe1AySQ6AlDHN0CVj6/uC7Z5pSdOg+cS9dz6oQ4sMXyHrNBjNvQAssrKSm
ClDeIZMSmDmRsWshtK08wa3+t5AsHNq8ascSqkZIruuSZh8NdLmHHHyhXY+bWzjO
p17pZKg1EgvNIcj1NPeTLXuAK1AH626J8Uiyag+k2hvb7jGDjDIiyFzx8IjVhOhs
SV2zmjlouUf6h21z/GDCd3jFxkDYAQTVuM2A0OaCxqgJ6hF4Rya5np0xUPD7wgrv
riQ9IJ0+bO6q9D7GDfrptzcHquox7l6sV6/sLuxinE03BkDoIcsUUWnlgvyi7//v
jc0XqLASMypsEZ7ozjyjd/fyOrLmPu6lxSzC6Rfnk+nfNM+KcP3DMJQe3IKIwbaI
2xWdLpTaAsPDM0oWmvwOh1PI4tfkElCJr2zvOvTDp73eCwLGhzahobvQJRHQ/T7g
94lh04yG1LCWf0mVpLr98gstQENh4jEiwXOIiqsRtB/MSrYPf1JzY56tR3pg/MNr
4rWr3H4H6aD0hRD39CSa
=kAE1
-----END PGP SIGNATURE-----

--cVp8NMj01v+Em8Se--

--===============1113630973321591637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1113630973321591637==--
