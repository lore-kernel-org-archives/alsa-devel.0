From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Thu, 29 Mar 2012 17:30:59 +0100
Message-ID: <20120329163059.GW3668@opensource.wolfsonmicro.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
	<20120329160916.GG19506@S2101-09.ap.freescale.net>
	<4F748C8E.1010702@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6377898897315764412=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42F83104527
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:31:01 +0200 (CEST)
In-Reply-To: <4F748C8E.1010702@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6377898897315764412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf/2YuBwNTyt+peV"
Content-Disposition: inline


--Qf/2YuBwNTyt+peV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 11:23:42AM -0500, Timur Tabi wrote:

> I do have one question though.  I don't know much about the clock layer.
> When you do this:

> 	ssi_private->clk = clk_get(&pdev->dev, NULL);

> What clock are you getting?

The default clock - personally I much prefer always naming the clocks
even if there's one of them but more people seem to prefer this style.

--Qf/2YuBwNTyt+peV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdI49AAoJEBus8iNuMP3dUy4P/1m4r5DRRAUSgHHgfJ1S63U7
lNcgE9XxlaFOPF/uVbebp6SimDB770SlA+V/KGkWm8vf01OUAW4voZItRTUNSTUm
mnHjCtsB1VyiVqZ4t4iO5KWkOkqKYKwefQPyV089RyZrQnxmpYVeADv7QO31GlzO
ppl+EhxSiYJa4BqAkhiV/ja8cSUC65LPnMwm+gsrriuu+mN9NIjA5DAmPJ1y2nlN
CJM5byJtQL4imXWR6b4FqdjQyxB/QbK7TfMzXNlIc3Yyrdly/8A+BK4HnqJRW69B
s8ZYNLyKISUl8TH07vdEvvpbThzZG6ibP+HErgH7lYOg6tBAWyMwg2V3tw6JbKod
b18R93wXsu0rwdzTW0LGqApsANxN4piP1vGwLD/+0+ln26oLhHhytx5gfDPitLDq
7qQu3afmewhBZgNYOlYvJFhOpDZe1p0yYMwRem92HJgwLDDSNvgMXtHdt6l3PqNO
y6UQ3eZqgFaLJbPzWrxNmmxBpWKUwgfCNo6Mdg7mzTcN2AMr2YuhoVKgiugpFYJs
wZjRh02Ie80hVMdFgSxoYR0MpnPua+8OseSnDwG3Cf6sFji/xwYqjnpRMUx8t2m1
F0wS2j0+rXLaW27cMq695f1BKqnNfc0MgocEdZBvL+IXMmyd6UjdL/Ivq94Zk5Ix
SOr6uLpoHJ7fI1XWNLwn
=kOOK
-----END PGP SIGNATURE-----

--Qf/2YuBwNTyt+peV--

--===============6377898897315764412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6377898897315764412==--
