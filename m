From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Wed, 7 Mar 2012 21:08:33 +0000
Message-ID: <20120307210833.GO3107@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<4F57CDAC.9030604@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5599123619165844310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47E54104139
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 22:08:37 +0100 (CET)
In-Reply-To: <4F57CDAC.9030604@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5599123619165844310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U2TwCo+MHNvvM16y"
Content-Disposition: inline


--U2TwCo+MHNvvM16y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2012 at 03:05:48PM -0600, Timur Tabi wrote:

> This happens frequently to my drivers whenever something in ASoC changes.
>  And it's a pain to debug because ASoC never tells me what's wrong.

Turn on the debug logging in soc-core.c and it'll chatter away about
what's up; not finding cards is a perfectly normal thing s we're not too
verbose.

--U2TwCo+MHNvvM16y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPV84KAAoJEBus8iNuMP3dp7MP/3MZ/pgPwU6GfXcIT6zGAPT2
ce83BNG86jFaYMnXt/slNymbkz4XwSCfMRBpXuBMazvEeOKodsWTwU73pfJyZuvg
euPWyI3RWg0oxMl3uMNDnMAhHFvR+64yAkKk0TlR5HvxJMrsc5bHTJM+ev0kDyWF
d7oO3uHhBd0zgSfqbDGOg/jUiYb+OPBIE9P7MEndrmBL4hsywavuqYk3S4dVQMor
f3C2Sq32Rvfbv99PhN8woISUmGsw48URAXwhJlNG+tQQ9UBadQvPPv8Y8KM+aDob
qMsER65QvbYHntmE+Er8GiYjxmaav/JGNe05ndk6ikl1f260EieUhSUwDbACdVw0
9qP0JTkxz1x2W71YakVpDrXsFUqjtD75gGjrHKqWAz8ShasdhkAj5nstKpnxMfJI
CvIU05aDGOgT7wtBm+pqlnM8L4h8CWzaaLe1N4XmURFyxbieSGPRRD9+1yvnyjX4
p5dcreuTN6z+r5YkWM7UNziqp2MIE6t9b0vHsD56YCGdEQLTJWmcrpTppLP4m2ke
WcmQviKtCYnI6iccjIt1qrXOTH1+zuAgnrDyr091lSkCuQaZvtnwK0Pm8Zw00CmE
FadWxLP7ZGcsiBdNM90N2gLKI1fpy5yyoSJdeR6fQY7TqCa1Q6Q1IxB0Kqn53oHu
vpKRvarbak+ayW1UzUv7
=S1Nx
-----END PGP SIGNATURE-----

--U2TwCo+MHNvvM16y--

--===============5599123619165844310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5599123619165844310==--
