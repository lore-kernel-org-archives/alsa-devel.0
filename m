From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2] ASoC: pcm: Store component running state
Date: Wed, 9 Oct 2013 19:22:02 +0100
Message-ID: <20131009182202.GX21581@sirena.org.uk>
References: <20131009141242.GE19005@pengutronix.de>
 <1381329076-12022-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5118718572696327203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CC63261609
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 20:22:09 +0200 (CEST)
In-Reply-To: <1381329076-12022-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5118718572696327203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HxEkdbCoFEDbFH5U"
Content-Disposition: inline


--HxEkdbCoFEDbFH5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 04:31:16PM +0200, Markus Pargmann wrote:
> Store the state of the components to detect not matching START/STOP
> command pairs. Otherwise a component's trigger function may be called
> twice with the same command which can lead to problems.

> This is a patch which stores the state of platform, cpu_dai and codec_dai to
> call their trigger functions only if they are not already in the correct state.

No, this seems way too complex and fragile.  The original idea was
better though I'm still not convinced it actually fixes the problem you
think it fixes.

--HxEkdbCoFEDbFH5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVZ7HAAoJELSic+t+oim9EfwP+wYy3vm420vlz5D0ySoxGu9U
Qqvs+bDJO47sC0rtwCdK6dyml7UdqjCcHkF51P9NirPXvwhVAGfx17mGhVf1t50o
uz2Mn3j3/xdnfLWHnpRxc2oqNekq7mTMyGAJvZ4Q36dg/n11oedwPa5vMkJr60+k
6eu+bErPybRp1Ab+NGkufYc1XfflHSbRCIngBY6Q4GHfnozV0ZFGSaisBvkZ0SUd
W5Ud+QR9j7+6LTys074hHV+YXEWKRRaMN8GvSHGh1hvyPGXtcN92RcHi6WnJRVql
O0q3lBmjs29ZLrjvNU69hZ+TWre8tEefsB/T9UtGZ1bEv0ybtQMIHXPu1Y1Eaq0u
vby5zKK6xhUroOvVxRPssPkOb6GYQBGSnc85s5nuYK0b4828ljaWZh+alBHRxTza
fEgezVyQBEfu4OE6Fnwuk8I7KxNNDSoSjkcrJCrjwWdHoQoNclAzC+/6I9ZNNa7r
acG8YkvvfziJbTA7RWT63wYrECTUD5HPlKJAB0diLQqfbpTmgYHMtZC+QOV0NPjr
mU6QMK0e56TYmyYlhixP0LsMvXaSfWzwQewufejDMqmDHPqT8h/mnGDaH2k1Ah4m
DYLnU/6IXhOEuEOVSirPgOoQ5yWutAVW2GDdnArtucrTsxaXNbdMMpYv6W7FOqL7
6NyBsyWv70ze/tK+oVSL
=L+OZ
-----END PGP SIGNATURE-----

--HxEkdbCoFEDbFH5U--

--===============5118718572696327203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5118718572696327203==--
