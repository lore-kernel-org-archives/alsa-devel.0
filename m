From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: defer the probe if
	clock is not found
Date: Tue, 16 Jul 2013 16:53:35 +0100
Message-ID: <20130716155335.GN22506@sirena.org.uk>
References: <1373937447-28722-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8703201359288283136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 474B726507D
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 17:53:40 +0200 (CEST)
In-Reply-To: <1373937447-28722-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8703201359288283136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1R6ZDISWaA1muLP0"
Content-Disposition: inline


--1R6ZDISWaA1muLP0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 09:17:27AM +0800, Shawn Guo wrote:

> It fixes the regression on imx28 since commit 9e13f34 (ASoC: sgtl5000:
> Let the codec acquire its clock).

Looking at the code the race has always been there, the same issue
exists in the old code in the machine driver.  But I guess there may
have been some (surprising given that we now wait for an I2C device to
be registered) reordering.

> I'm still not going to fix this regression during -rc at clock core
> level with the risk of breaking clock API users and being yelled by
> clock maintainer.

I'd be much happier with this if there were at least some effort being
made to discuss the issue at a generic level.  If we were adding a new
API for deferring clocks (which was the suggestion) then there'd be no
risk to existing users...

> +		/* Defer the probe to see if the clk will be provided later */
> +		if (ret == -ENOENT)
> +			return -EPROBE_DEFER;

What's magic about -ENOENT here?

--1R6ZDISWaA1muLP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5Wx8AAoJELSic+t+oim9SDQQAJcad4ZsBhsvmtIcMPiclHkj
YGAcGbg3HmWWMr2hbnZLSyj9ejRt2b0+69H/ufT5e1wdR3ghgqU+4bWnnBdVdvCL
bdKJUdeQUbYPqPaW1tVdUDoEhESg+Ktylt+o0kpTr+1fJXGyYGSsrFD7ETUGlAm8
fuuhILhKXS6KaIlpuKz5QxIZ7Isy+BOcIiOOp4Q4tyZpFDZMFBzs+HQSczeNDi4n
DIR7xWUE2svbM6xRki1Any3RnUX15zsHk0mT2adXe/wdNsN0oMk4FKfEVvaVIbXs
kgg1D/ni//Tp/CAMEgGb7JqY2ohd0e/T5IwUfHMVVQrmca7sS1Qvjd4gCmzpV6mn
9XKnkwNwbHiPeLnm3JX2u+2nFScX4YQmhQV0k82wEHzTgyApZq8ytjpsvsaVK/L4
PQY/Xy9LoheRXJaK+j1WaJP5hcYd+MamWkJQTWL0B/Y91HzlYm24xH6NrjfHi7XM
yFKRnkHxzufz815JUdQNVsPgB2t9Ha0Q9dRMdHpJEfGnyP6rSIWGF9h8SN7ncqmm
f3RLZQ8PJqrSckVGhfNp+QWvUNNhfdjfeXvBiq+xAEIYvuix+ZHhP1RlNhR1VuIB
6Rezkn3KKc/t5QQ96Yd9BL/6X7LtuE6+64g/cO5k/vdNRSwTIM2pHSNi+eBtaNmt
NXgFz5FkPMMjAK3GiYkX
=NYdN
-----END PGP SIGNATURE-----

--1R6ZDISWaA1muLP0--

--===============8703201359288283136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8703201359288283136==--
