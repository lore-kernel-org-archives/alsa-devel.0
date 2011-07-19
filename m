From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 11:04:04 +0200
Message-ID: <20110719090404.GD1951@pengutronix.de>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
	<20110718191602.GA8576@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1464734420924692132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CB9B92414F
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 11:04:06 +0200 (CEST)
In-Reply-To: <20110718191602.GA8576@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============1464734420924692132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>     pls check http://comments.gmane.org/gmane.linux.alsa.devel/83781
>=20
>     I think Mark is right, sgtl5000 already declared its register_step is=
 2, soc_cache.c
>     should generate a dense cache layout instead of padding it by driver.

Thanks for the pointer. I can follow Mark's reasoning. In fact, I was
wondering why ASoC does not consider the step, but I assumed it was
intentional. With my holidays coming along, nothing I am going to
tackle in the next time, though ;)

>     But after check soc_cache.c, ASoC mix up index and register address t=
o index cache,
>     and many places need to modify to correct it, so I think we should re=
-consider
>     if register_step !=3D 1 is not a common case.

I think it should be properly fixed in ASoC. It should be carefully
done, but otherwise not be a major task IMO. Note that sgtl5000 will
need adaptions nonetheless. Which brings me back to the question: In
what setup did the driver work for you? Did you have regulators on that
board? I am still trying to understand the side-effects of what I am
seeing...

Mark: Will you pick up patches 1 and 2 nonetheless?

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk4lSIQACgkQD27XaX1/VRt80gCfezQgd1imCQeuWVY2VJiAUMk2
6QoAoJqrF3B5LMM9QJ3fK1654L1a8IRV
=unFG
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

--===============1464734420924692132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1464734420924692132==--
