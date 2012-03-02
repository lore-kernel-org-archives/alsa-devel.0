From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Fri, 2 Mar 2012 13:59:59 +0000
Message-ID: <20120302135959.GG3230@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6320461690693506961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A49724451
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 15:00:04 +0100 (CET)
In-Reply-To: <1329904151-5927-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6320461690693506961==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 10:49:08AM +0100, Lars-Peter Clausen wrote:
> This patch adds a set of functions which are intended to be used when
> implementing a dmaengine based sound PCM driver.

Having this framework is a substantial win and I got bored waiting for
the repost of this and the subsequent patches (especially given that the
merge window is drawing nearer).  Since the fix for ep93xx is so simple
and it works on i.MX I went ahead and applied everything except the
ep93xx conversion.  Thanks!

Please resend the ep93xx conversion along with the tweak to the core so
we can get that working.  It would also be good to update FSI to use
this library as it's also using dmaengine (the patch having been merged
just before this one it got missed in the updates I expect).

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUNJYAAoJEBus8iNuMP3diQQP/j1ajeMcdTHaHTooobD/vJn5
07dbD10kRrObehoj3uGXmfUE/a8HIwetOgjIZ/Sz+c7PrBI7sMNX5P+Jl3l52Sg+
9FzEURrTgZJkJmyVZ4TV6kvnzaaSpq1Zgj/Y7LJfHnn/EVZZf44yRlno92dUU9dJ
mwz/IF2wHy/MUT8vjljoQLEL5W1OJqe55deKaHkX0xFWNbe69r63y0MgsbuMOtib
y3oplDpQN5aOwxiiWQ1FIcqpuYGr4ESYoMd3NYO64bK59VkBMpI4zOeckUDm10H+
KgLFjfkhaPr+RgPrIqUxcW5InTMT+oLdl68UfQsILo1BIndbdMJ0A/e0dcW9K+Ag
Je+AUgwQs38XS8fCGP6vy9FvUMfle2EFn1UhEnG/0nGFh3H24UbMOipGjt5oC8j7
CPuqH0I5HBxzkkf+Pk2Z0UuYP5R1DsQYzFjPNNe5pjlPGtZL3ZFOlhKiZBbTzgoH
h7KeLk+1oDiiN3Ql6LNPlpN8CtKEe5ZiFuHvssoOzcbtecWmLh8VudyoNby5njV1
Fx8R0alBZPrmGICUnQxMlLujhE/CDVL6sGkLvaG0/AdDHbAAlcDohwfduqAjZTq4
4HTZ7Dwe/Ko21d7LyTH+smCxgrtJSYyKMt524WATP+wsSdpO6svEi4fKxw1qdm9m
8kl/Bddqd6NGBAAmo3Uo
=eYbI
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--

--===============6320461690693506961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320461690693506961==--
