From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/11] ASoC: Untangle AC'97 support form
	the core
Date: Tue, 18 Nov 2014 15:30:51 +0000
Message-ID: <20141118153051.GQ22111@sirena.org.uk>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7045076193099308937=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B6BC2604B0
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 16:31:31 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============7045076193099308937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xiprIVX1FSGBv8kC"
Content-Disposition: inline


--xiprIVX1FSGBv8kC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 10:41:42PM +0100, Lars-Peter Clausen wrote:

> Depends on asoc/topic/ad1980, asoc/topic/wm9705 and asoc/topic/wm971x

You've generated this against something other than the merge down of
those things since git isn't able to find the SHAs it was generated
against and apply it automatically with --threeway (so possibly also not
-next?).  I had to manually resolve a lot of patch applications.

Anyway, that all seemed to work easily so I applied it but you might
want to check it all worked out.

--xiprIVX1FSGBv8kC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa2YqAAoJECTWi3JdVIfQheoH/0xkIg1rLfE9Yz3O1ty4DCW3
4BnvENDeGCNwVb4yNiXDbBcT10Rn1RQZhdMKnBKLb0x/Wj6YRxTmZjcZhVxfNuXp
2JiQM16z4x3zoLd+/LwUsO/B3Byhw90hsXXFxPD6udgYtUvSOWkperDLJM7lw0FN
Hj1sPzN45svu62IpfID4BIGxyhM+g7uCoXpFDELCe/G8t/VuUgKeGvFy0SQyGqob
8Kd8jGsDOIZ/iJ3briwoy+vpxOni0/OCZ5nRIfXv5rvdZZCtYw7Y5bHiJAuH/fks
21rDrNKuwVaHin0e9uPO++vvGlUjme5Y2jOwckoPoLPkTEXngICuFxGpFugW2vA=
=daFx
-----END PGP SIGNATURE-----

--xiprIVX1FSGBv8kC--

--===============7045076193099308937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7045076193099308937==--
