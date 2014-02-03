From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: h1940_uda1380: Don't modify
	runtime->hw
Date: Mon, 3 Feb 2014 18:42:18 +0000
Message-ID: <20140203184218.GM22609@sirena.org.uk>
References: <1391444662-11933-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8260061235674682719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BE162610AB
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 19:42:26 +0100 (CET)
In-Reply-To: <1391444662-11933-1-git-send-email-lars@metafoo.de>
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
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8260061235674682719==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dc3VIgh5NkUOUh1j"
Content-Disposition: inline


--Dc3VIgh5NkUOUh1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 05:24:21PM +0100, Lars-Peter Clausen wrote:
> Individual components are not supposed to modify the runtime->hw struct itself
> as it is manged by the ASoC core. If a component wants to limit the list of
> supported rates it should set a rate constraint. The h1940_uda1380 already does
> this, so it is safe to just remove the code that modifies runtime->hw.

Applied both, thanks.

--Dc3VIgh5NkUOUh1j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7+MHAAoJELSic+t+oim9GtQP/j9ZYltD7DPLwda1RubX1zGQ
BKpu16WGsjrdCh/nREe3xM/lomM6gSMvIKnz8Wave6Q6ZSNR1Qr26laPAsP4veub
kPrOpBqeOBXP84FJDaX5Y9NRzlKmYZpGX2AusshHWpZcSwRuo8XqHPmdCIM52uGl
+FfCU5QmtNOntubrJGmbRWHN+qGMhrkuJOW5u05/r/HJU79AsfJC3i6QN0JTgWv3
gmGeMhOH73y1q4t2iU65bGDoRoDdL6ibKi8duDOEjNJw6Rq8uAwnVmJPtI/FpoRy
0nrZzfJsd3LD9Ylc/ycNC3eOOmVnJIUEFD75ilziu8iwUtQw7qBBsAtTsoozeT7t
OPrOQd3HcsH5MdTnywyod3y1sGLrTghMwIjf3EGqbOEIGj440MQwrlouQeUq0esP
xUoqtgCgDTEIvjUtX6vEz/yPghtnJyW+g0Qf3t9zRf4clmkoNyWstKjt/LJwvb7H
8qqXjfefD85e08/Nr3+B6JbwHcV8QE2K8TKgWwtW7ZEHbDTlI1OAPxwZee0IdlYi
Fq46p07WMBq1XGNyWJqWxbE+i1AcwSDt2hE+eKmK04zPnnWzrPO0Acd417P/Gs7k
XdVPVnxkRbdmzoouk11hvD5sPS7/d9lHfXK17lAZaHpOeiPSXI/ZUcv8WULgzLdi
GNs1xgryn0bwLJUs9fj/
=Ji0v
-----END PGP SIGNATURE-----

--Dc3VIgh5NkUOUh1j--

--===============8260061235674682719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8260061235674682719==--
