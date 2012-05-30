From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 V2] ASoC: fix pxa-ssp compiling issue
	under mach-mmp
Date: Wed, 30 May 2012 11:18:44 +0100
Message-ID: <20120530101843.GG9947@opensource.wolfsonmicro.com>
References: <1337915528-11887-1-git-send-email-zhouqiao@marvell.com>
	<CAMPhdO9kzTzY-uxz0dCLTW98oQ0pxdQH9CQY375s+Kx7kpc3yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2697859487666459585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAMPhdO9kzTzY-uxz0dCLTW98oQ0pxdQH9CQY375s+Kx7kpc3yw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2697859487666459585==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 25, 2012 at 12:20:21PM +0800, Eric Miao wrote:

> Part of job of #ifdef ... #endif, and cpu_is_pxa*() is to reduce code size when
> the support for these SoCs are not compiled, but providing the overall
> maintenance burden and ugliness, I'm fine with the changes here.

I did suggest that we should just ensure the macros for the PXAs were
defined on MMP as well which would seem even simpler...

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxfP2AAoJEBus8iNuMP3dMf8QAIeqjzOeH1i8wieZt8uM28gm
rif0I+AR+GJkQ9138FjOtd7cEMOE8aBM9NZ/sYMUKtwqj2VPnOET4SX8hR6HgmJ1
y9tPy5mq57qDyt864lJELjOZMe37cBk9xxzbzzUAYBn3hJtA33uqS2dyh95gx2Up
j3knmuRl6W+gF5DLKNiOS3frgEsUcFqcuIsYyw5vIGSSFJK/O4HIbqVbS1GkdcJy
bmuN3GDnpY8aPc+vF0GOLo6IND0HKEwGVZda3eL+avaKxz2842MwhDD7kCGAfnV+
QfQHGPI964FOHEtqXhDZWVSsiFzzEvBRAqNZ+ti9NJnqB8u7RJywd5FHELq3U2DK
9s1wL0jlbWQ7c2hrinZaksJewLCV+qvaiisJtciBCZ5uHKr+rQynCXEYJlgq7oFn
Mzuceu4iBbK38xmbvlVdd28s3dFveg1NSEJhFdj9+hNH324vpPKjOueECbHyqCzV
vcbQx3o3ADnp+/SvGf5WhPs3KuBjFy5aCLfh3id8g0vgyDrsxCUkgUxb8vCuoGtP
c8hMiy12GasBhVsWp2zagVhadEpbM/PV6KJzmOr1AjPlFM1GcAp5Vy1HtaCWBGMf
ObnTqdWfJnsTkXVcF3lht5Ijz0HzEwi4W7b6nqfRBgWqljnyRd33ABwbZE8pyxxl
QJuG2h5H7UQgmMkfqm+Z
=3KHC
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============2697859487666459585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2697859487666459585==--
