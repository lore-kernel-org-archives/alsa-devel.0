From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] regmap: Properly round reg_bytes and
	val_bytes
Date: Mon, 30 Jan 2012 13:45:42 +0000
Message-ID: <20120130134542.GH4882@opensource.wolfsonmicro.com>
References: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
	<20120127162837.GB18572@opensource.wolfsonmicro.com>
	<20120128011403.GA6669@pengutronix.de>
	<20120130132134.GB4882@opensource.wolfsonmicro.com>
	<20120130133529.GF15596@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5096741371221182998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D24C103944
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 14:45:44 +0100 (CET)
In-Reply-To: <20120130133529.GF15596@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5096741371221182998==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 30, 2012 at 02:35:29PM +0100, Wolfram Sang wrote:

> Understood. I'd think we will find a non-intrusive way when a more generic
> format_x_y-function seems worthwhile.

Probably either your suggestion of just storing the shifts in there will
be it or it'll just turn out that there aren't actually enough odd
formats to make it worth worrying about the hard coding.  I was making
this decision before we had the cache or anything like that so was
thinking about what made sense for facilitating the infrastructure work.

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJp7/AAoJEBus8iNuMP3dedAP/RusWokPIArxozPc8siwRslj
85syTIpBuifJDZ/MvLtxGoqyuyJYX6bhTy0p7wYIHGp9MLydPK0igbI3HQEPYec/
0WJyCL1A6gEZnkvLqMK59eSzaFFCNMA+F8t8wddKj6613IXagCAEJ54VaLz3Auw/
9epWtqq5vMXR3Ueq7qhN4zDPIcE1sFE4RMld2ijXGXAsW/oLTDBG+94/7ul3agjo
VBHjVF9jxLqvO45sCKkZ0c9yEPRe8hBG9bC7RBJRiv9pUxVrfVoHSeBMuyzbdXju
rgrDUuv9PCoSV024LLxhmBrpv1fNq1poATr6e7g1Q3k+PMxIaoY//LczYSqMztiZ
C6/k6AaxBrV1MNGbVXtZgix4FVgDhzwMKyuIPLsBlHcx47iRUee8KvgEi74XQaDC
zzID6oFxtO94vukJPkWQwqBJcyqyzbL4JoaZ8IbLnliwdb8pHz5xp1bmQlwfU53R
sevZRsaspS+40xbz8hBt6Yph9uMqOOqtn9vzjAjYvMcECMcY+DAviiyb6SIACR+G
MGK5mdOPLFrM9d84lUBtr9J6MhdaeeqxY2ZXvgltXfA86m9nEgeiJgBjFpeu9jhf
wgPoroBv1TitNS8MQukp0I9pD515loYvCFlbO52LeSIOQ4fAzKBE8+siTFmjAno5
lgRWmpnTOk/2/pA3ZzV/
=Fvat
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--

--===============5096741371221182998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5096741371221182998==--
