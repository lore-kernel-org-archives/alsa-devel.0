From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: devm_request_and_ioremap
Date: Mon, 6 Feb 2012 16:21:36 +0000
Message-ID: <20120206162136.GN3070@opensource.wolfsonmicro.com>
References: <20120124202203.GD1135@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1201242144580.1998@hadrien>
 <20120126110506.GB2611@pengutronix.de>
 <alpine.DEB.2.02.1201261220460.1851@localhost6.localdomain6>
 <20120126112242.GA9401@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1201261439460.1851@localhost6.localdomain6>
 <20120126135135.GD2611@pengutronix.de>
 <alpine.DEB.2.02.1202041922070.1974@hadrien>
 <20120204184638.GA10688@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1202042306520.1992@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="57SHPaztv6dlLu/a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1202042306520.1992@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dong Aisheng-B29396 <B29396@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--57SHPaztv6dlLu/a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 04, 2012 at 11:08:24PM +0100, Julia Lawall wrote:
> And how about a function devm_clk_get?  It looks like there would be
> around 150 opportunities for its use.

Note that currently there's no standard clk API so any work there is a
bit more painful than it perhaps should be.

--57SHPaztv6dlLu/a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL/3zAAoJEBus8iNuMP3d4rIP/3HSifxMrpLK8p9cxQBOHrFz
vM2d2T2QyHy/r9WOf47vmYxaC4rL10DylEmTHtY1Oy1mq3n+Nyvf6pfm1uSyd7S6
kzcZj0m9voDBsUNXerlbCMODwDzvq4MiOA3O5mYcn+FYP7Z86wpddMFLUauXAjc7
11QBW4UJv6orPXTjkM3KosF1y/AhuF08vnkATNeOtFVnDD14+2SK5NWv0gV7SPXu
szfDEhewSAcHMoc9VY2FYv6Gk83iv9SLz0CXjGsdkOZABjtFZ3nMFei54IrLNJRL
yvzVf81cEQLBLZKgsEC4XJIbE3JIop/IZAu+eZMffu/8f0j/LHQNd5pS7FcxHNJJ
2yMnIQkjGKx7e/iSkvuGYnSEpeoXMT/Pexxg3me4Sde7NFK1gotgIw8P0ofuLkAu
2gupl7giQAtFRrk2r1sGJ4DFUhFpa/qDzIvyqita+IpPhbF63l6Sg1otYF0BAitW
77ufJ8cODR8c+Z9S+ORH/w6KZP139S/fPutWFtxNlG1gMvvLwTLW2B7wkm/rbkiL
AtMQxzPBscyxfQgGbcg+Q6uVpqvnsgu9V7FrPRLAxCgvhqQzzcXnViUVZQrtg0vQ
mPACkr/kZWvw1Ybwh8XD/AwA9bOFuN3zcLtljrBCSqo4IjWRVRwR++PMs2KgIeYI
Bu7S4q8tUwVw/CXQg1My
=4dsq
-----END PGP SIGNATURE-----

--57SHPaztv6dlLu/a--
