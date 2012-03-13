From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/16] ASoC: core: Add macros for 8bit
 hwdep multi reg cntrl
Date: Tue, 13 Mar 2012 21:36:40 +0000
Message-ID: <20120313213639.GF3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-7-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8808125115348472065=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B9101043B9
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:36:42 +0100 (CET)
In-Reply-To: <1331651503-16917-7-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============8808125115348472065==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:33PM +0100, Ola Lilja wrote:

> Added four comvenience macros for hwdep multi register controls
> that exposes a single signed value while spanning multiple
> codec registers in a MSB/LSB manner.

What is a "hwdep multi register control" and when would someone want to
use one?  Especially the "hwdep" bit, it's very confusing, and since the
actual implementations of the controls aren't included it's hard to
tell...

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX73hAAoJEBus8iNuMP3d2QkP/RK4nneoa36/+/N6D0KbRT/e
wUbkpxTwUQOMETYxzVkkdgZb9aFPO9jYxrhU/Y+oC16z20MBlFRGJKfwrBJsiWjx
7d/vjo9+xwRZM1NXFhKnUx8ck5VnPwwy+qAIANTjWH3eOqDvQFfgfRUIFnI7xc/U
v8Y5eE6SpAj8M/aBDlg1G/WA90cSPTpvw+iKU7bNJnYCxlP5x53+lq3hxQykuCpW
bVjErKWnGWFaCMbtgTaDPUAdeHPImgIeCSQzw231qUjD7Q6hr0nay4YNCEIxdzKP
j4vX5QTrZZSL1bXNfUNoXw4HmTPVLgiPkMrvfGC2EQORVi91BJKdR7HW5U0H85+l
ECL6BlmRx0IF3zejJVF7cHbMJ/LhpeURS8lGPr61N8C66PEnftlChv2WCuAQXpi0
WRhRV7TvNgxOiUyQ8cWt8JxreZo9/jKiY6uC9FTAWSbliOgV7QjqgDkc1XZCZlVl
+jK1rIJtDb/8rb89BqBvwIM5Xip73+RM2AyDsxuH1HZbZQ8OfSWQVK2Q8rwAx/Fl
r9r6oiyuaz4IGy1vFChvAdqXQj09tFb26pWSGtZa/v8Hq0X3BepN1g8QMHxPSgZR
eSx6v2B/nJH77giha5Q2zb/dAkhWrfouw/dWVRfNt4wIC+oFvhh5D1Zv2Opm3jCA
9L+5EPzBY0mbgi3a7OFZ
=Lad6
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--

--===============8808125115348472065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8808125115348472065==--
