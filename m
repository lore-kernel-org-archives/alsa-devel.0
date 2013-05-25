From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: ab8500-codec: Move codec ops on a separate
 structure
Date: Sat, 25 May 2013 15:59:35 -0400
Message-ID: <20130525195935.GB32043@sirena.org.uk>
References: <1369391960-27320-1-git-send-email-fabio.baltieri@linaro.org>
 <1369391960-27320-3-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369391960-27320-3-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2013 at 12:39:16PM +0200, Fabio Baltieri wrote:
> Define ab8500 codec operations structure on its own rather than inline
> with snd_soc_dai_drivers to clean up the code and make the style
> coherent with other codec drivers.

Applied this and the rest, thanks.

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRoRgkAAoJELSic+t+oim98+UP/RfNVp1HuvxBOSVx2mK+9Dk7
ZIOMlMNGsSJRCPFHNhE/xjumq1J0ipSQWzuTKAYK4dJ0MmwlMrnei24u4yDA7K9w
XL4AUR9GzZAPKRxMZA5evV84u+AMm0PyOkYl/Wh6W2wf2nUllMDeB4WAyRp1PR67
2pTDNEJIqO+Ortt2OHqdzgiPW1dt6a3zSPeYP8qKLq/337oB5G46HnKqvNHgutBi
kHYvqkeiDsdgDszJ09AZWGiZjAbOppi5JgK2G6pO4Jmfuf5PXGooKGExTn/56WAz
mo/v+Vv5/Dit+kL5lEpWr3NCeDPFGMKYAethSaPJRleBrwsunSs4n1I7du1TEZnE
/R3fgX11iFV5HJhHG4Cwoa0770Mi4m8kmbGNsKnR854poYlkjUm4K+cOL6i1Z5gR
KnhL4NavTcoVoXGjPS+gFfH0/49oR6gF3T014BjAF9SEzqIA+D61J/rDMxaU+UQ3
5o9XZPCLW8hxhRo5Fj5BOPXGKB98oblEneVMrfM5g41PPGPUN1CyE8p2KwNclX/q
eDIgXs3/8W8RtwK2GnVmo7xUsPa8l0lqOs5YPlj7bBMOXP5FlKyQksHvEV2wvYeC
qSlzin60IN9bMtmwNODi0i4WQZuDJHSirDNUIViq1S/G9cQvyS+KgnVD61w6APGz
JXfWXHqLiIXg3FGH+ss/
=fmj3
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
