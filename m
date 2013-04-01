From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/13] ASoC: mxs-saif: remove mach header
	inclusion
Date: Mon, 1 Apr 2013 12:45:19 +0100
Message-ID: <20130401114519.GB18636@opensource.wolfsonmicro.com>
References: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
 <1364547350-30498-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2577325584162605095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFB25264ED5
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 13:45:20 +0200 (CEST)
In-Reply-To: <1364547350-30498-4-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2577325584162605095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2013 at 04:55:39PM +0800, Shawn Guo wrote:
> The header <mach/hardware.h> is not needed at all, and <mach/mxs.h> is
> needed only for macros MXS_SET_ADDR and MXS_CLR_ADDR.  Define the macros
> and remove the mach header inclusions.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWXMpAAoJELSic+t+oim9A4QP/2J0/vgoKTlnIY3v+n08LmGS
YpnpbbEPvjBeBnwLPa9xYg7GhxLsb3unYOIk35vU/pqEC+Uk8+e9hovsLQjMhISw
vg2oN7tG3bHWoW7ij4e5b4WCcZw+pNhNB7XHaYfuZNwGqw2QNzB3jdHfWIE8sQ9m
jRYHA7tnScMnHc663W2LfRjRKHKI3gyrqGyqtCGa/LPFCUj5DQK31Xw78RoUolZz
+Yi/OiZpGzG3m1HyoVgc1hWatvL04so/US/qbSpZd7BP6hL9lzvl6Fcw1H+M9/yd
1HBMHgt1e+JA323Ops122i9DMVLKTQ9ZecMZZmbPbkQG4hON2KvodQdPpzRbFUQY
vJDkMkXMEGlr9Dg2oN6t6hf2go2nydMu3UNm+x2zACWbbJ0UaddW1oLxKatyeLJ6
FNko5e3f36Nf9mFCi84rSFA22O3Jn5OzXJjtUEZKgzmLenBrRfKBYDGgS0dZLqIn
mPmETRUuzf3VerlekKplmUaB4isaTam6kWTtfWy84qCdgy1wxkdSSlZ2xjgFn7Yo
cdqyCWAflPDwIVTm2XlGHbrd6z7LgdijZLXYw11vA8tGsRaj19vQe6ZzoG+ykiab
tfm5TU65iBcHOTXvlH0h7JOm4TIVwHoFfF0iEOFgpXcF//XXbFBOeuMeAFdhyrAp
YyZLw/s6e//QMO+K0PDy
=nqUr
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============2577325584162605095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2577325584162605095==--
