From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Allow imx-pcm-{dma,
	fiq}.c to be modules
Date: Fri, 5 Jul 2013 22:19:20 +0100
Message-ID: <20130705211920.GK27646@sirena.org.uk>
References: <201307051745.16140.arnd@arndb.de>
 <20130705173321.GE27646@sirena.org.uk>
 <201307052255.10765.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8812868601210211054=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D260265898
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 23:19:23 +0200 (CEST)
In-Reply-To: <201307052255.10765.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8812868601210211054==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ESod/vG06iFAbj33"
Content-Disposition: inline


--ESod/vG06iFAbj33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2013 at 10:55:10PM +0200, Arnd Bergmann wrote:
> On Friday 05 July 2013, Mark Brown wrote:

> > Is this actually OK with the FIQ APIs?

> I don't know. Why wouldn't it?

It was the only reason I could think of why that'd have been done.

> Other users of the same interfaces (mx1_camera, spi-s3c24xx) can also be
> modules, so I wouldn't expect a fundamental issue.

OK.

--ESod/vG06iFAbj33
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1zhVAAoJELSic+t+oim99/kP/28JYWCNMPVUQP43nBiyAvdT
BHZX5wESwQHMV0lQ7jfGvYcpN9aLW0NmxDgSbg1W7/rZHvwR20NAS+dFqZ3Pxyeq
zMX5O+T4OefimcSyr/pv/fujYr+3R7SpVkb03w53UraimtrLfq+ULvWaDVmmylLl
WT+dDcTuzcFSW3d/3OqSJQSqM/g2fc/9fxGNV8x60MTEx4j3Wq0zv5S8RTnjlEHx
4TY28EB9e9qbtgiXVHZSJMXA+F4jAACLEprgaiolF6PGxxjslnatX1eIxlZGhENe
CZYUWgO9kv0P9d5PLgPhJeywRP5EkkMxCHe0XLyI/lvEvzDqBNAeIawDl+E0faC9
YZJ19vWWxRPiu96MUoTGWFgn9aVqKVU3kDL0uciOyGXv5FVWBh0ubEIYT9kphW0v
9c8Q118cseNdhfB5FPRVPSQsJYFGjI/SueirdM/S4Z38UfQOlqi3Ap3LOjU3f5zH
O86z0AFI0v7hQcGHdscJQbkwByRpJOp3+eNvpXKbT2E1ioDfq5ISY9pcec1Njlzn
weo1Al9KhlOeGoCLDZLoE6D3F8ohj3mKc3PNaFfLcE9ZrFQBM99neVYBBvd+AbFm
asUPGmrX2QZhufIKj9lJUR3S7srgQ7jVK610qAKt8n++PZThUxkd1QvEhyHw6EAy
9Q1N8dSK9Em5BZLIHMWO
=ayce
-----END PGP SIGNATURE-----

--ESod/vG06iFAbj33--

--===============8812868601210211054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8812868601210211054==--
