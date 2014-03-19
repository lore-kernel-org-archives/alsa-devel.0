From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/13] ASoC: Drop ASoC level caching from
	hw_write/hw_read
Date: Wed, 19 Mar 2014 12:58:50 +0000
Message-ID: <20140319125850.GF11706@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1415567669225774538=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34CEA26506D
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 13:59:11 +0100 (CET)
In-Reply-To: <1395129736-11938-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============1415567669225774538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qIIpL/PjEPCxtmPP"
Content-Disposition: inline


--qIIpL/PjEPCxtmPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 09:02:08AM +0100, Lars-Peter Clausen wrote:
> All drivers using these functions now do regmap level caching. So this is dead
> code and can be removed.

I actually have a version of this in my tree already, a cleaned up
version of the patch I posted while I was travelling which I couldn't
test at the time.  Since this one seems to depend on other stuff in your
series which I don't want to apply before the merge window I'm thinking
applying the version I have already - OK?

--qIIpL/PjEPCxtmPP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKZSHAAoJELSic+t+oim9LgUQAIep8YJcD3eHrqcaAPPkACvm
3qrioiYAo5gSShXnGD+ZaRzzCjMmv/f7NOLaqQjMgcqm67Mum++Lhsxd2hK66Tfq
gz0JRmFQMi5Hsjli7Dwad8SiVjzelERN8gQ6oGpRVJ0fwIDvEB1viTmO9SP2WzEX
sg7rO4aK1nyAWRgVkLTkZ+mt+ku8kT5tIDEqYxUHvg9XMtgwxeRHLWXvwCun6FtI
aKPKtsUZz0sgcC7UCb2mhaobLOkUg91urFuflU9EXKz4HWpkZm30ezSYLzZ9MXBv
2zE7Z4XZS/Jcr79V4its3B/qysMhShHRAem/tWl2fpPves7EhQ8PB/cYQzfIJhpp
l7JahciPZc9S25z7zsazQFWantiTE/8NKphpGfhluwmwM1uVUjxgFF8YCiuOynQt
eMLsgw+YSn1ouSqzFV997TzmVX9PtLAXYF9uzuAKcXK4XfOMgz4jFunDjFpi1BM4
M6yMputaSYfa7rLu+5ILmEHIRy+FrxfT4kQR+Nf6tPTnobUxHVj+44aRR3kuuywL
QF/YSwVdzh0HT3zNUR4f94zqne/eXWeHve1Dflfb2geUT8lT+GxCViSb6ieiuCsz
A/zTpitU77GQjgvGyYhQnRyPGmKtyjuJM1d1kFz1Dmn8cEoslXdcZTafLrXbp/ab
uUhOEcNGpI7NHHgktdqO
=rpvv
-----END PGP SIGNATURE-----

--qIIpL/PjEPCxtmPP--

--===============1415567669225774538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1415567669225774538==--
