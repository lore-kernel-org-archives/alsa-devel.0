From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add ak4554 driver
Date: Wed, 3 Jul 2013 10:18:44 +0100
Message-ID: <20130703091844.GD27646@sirena.org.uk>
References: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
 <20130702094202.GZ27646@sirena.org.uk>
 <877gh88ls9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0215152727314616324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D11A3265549
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 11:18:47 +0200 (CEST)
In-Reply-To: <877gh88ls9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0215152727314616324==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wthRHICJPcnPKmvQ"
Content-Disposition: inline


--wthRHICJPcnPKmvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 06:39:05PM -0700, Kuninori Morimoto wrote:

> The image is like this, is it OK ?

> CPU-DAI1 (plaback only fmt = RIGHT_J) --+-- ak4554 (it doesn't have set_fmt())
>                                         |
> CPU-DAI2 (capture only fmt = LEFT_J) ---+

Yes, that's what I meant.

--wthRHICJPcnPKmvQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0+xxAAoJELSic+t+oim9FrUP/3BRkTNlck9vQD+rot6qsrMc
rIttsBdcrrd31/Pqa1hnZ/AmIUvSAck7zlm+IvQGBQuMmtyxqOXl/zKiuprETRGd
ImyiXmIkUOgJh0Z4VN+mC5WC7Hs+tN/PXtmtfglaqSVfVRbPdNuBihQfQr4zZRid
aQqbhdmom7gKp565NGp9Q17LWmG5MiOhFKl/0W2mKHEoMLI7NcwIDYRG6lX4iwse
dYG9Qbi+CGSC8rUNWXBDEyJ/xLt/M0LkewDn+agza/ZIx0CEBS9rKHbSrl+alUw/
DiV8iqiT5+4Fdo9YWKI5/ej366SA/nUUka9mU9X8Xq+EjwMo58aZLSutjwMrcnP7
WBJRJxxR6YQlSGOvLSIT5JXEthC3bN8G5LOmplM+z4oBgni1PcOJZv4NzlNdnrED
u9sjCPCjDCvNagjwTDGc4VMa5W5LJ77vla5KarQOYW8Y8tIosGq3VpTCIcb/8DvK
cHjjI6lwqWAqIehxhHos2+j2kN2yU1OJAl/5r78yrV5NxpaQI6fnVjNNUKrZBJEG
2SH5H/8CPE6Z1k9hiqPIkI9qsSZt4DTW3KLYe0W8DOkbbnKcogfHMqft+h9XB+58
g5LCB76rphaNhfSjPsqv81edxGDIkl+t/nFXfU0wYf5LwQ9hCa2TYuKrnzMCd0bP
ZkNF+LBmjeBeJVFKeflF
=bdsy
-----END PGP SIGNATURE-----

--wthRHICJPcnPKmvQ--

--===============0215152727314616324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0215152727314616324==--
