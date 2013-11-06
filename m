From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: remove bogus period delta
 calculation
Date: Wed, 6 Nov 2013 09:42:14 +0000
Message-ID: <20131106094214.GE11602@sirena.org.uk>
References: <1383653634-13691-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383653634-13691-1-git-send-email-oskar@scara.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskar Schirmer <oskar@scara.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 12:13:54PM +0000, Oskar Schirmer wrote:
> Originally snd_hrtimer_callback() used iprtd->period_time for
> some jiffies based estimation to determine the right moment

Applied, thanks.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeg7zAAoJELSic+t+oim9a7EP/iPo0l0U1rZTYPoQcGJA/N+w
cPXGQgkmtVpM+AhOoHVywgdljveq757GQTW//o8D9v/UykdlWpeUdZqnl+JwE/zk
GnGcN10na46VzneZHNhqIU/U/Tgkdr3MDbbpynA+EXmUDt+A5xQNWTFOp/ThpLa4
PAW6hRDVyVWXrPcE/ENFOVZklFTByMgJrvJH/vLlpiOD+i8+GUv5NOE4jg724/uS
6EGgPhZWXI85Yzw3NeHhDY/6mqd3t17/iaMU6Ml+C859pv50+YjyiKTkC1Vnjpk3
1yVUYWYY2GTDeuuHCUOGCKFfHORIdpwUpyvD8BB/G9e2Q8SuMgD3DmfxdVgSzL05
fB4y1Ah/VjomxCpVwNu2FNTuSiESEnhnLY5HwNSlQEF5JvkYsBz2odNepQS9g4Si
FpJCmkMbXComKr1J38cABueFMtSpZAYD8Cp0qBIjMOo9dZ1kGzejuupyicSu8eGL
YqHe94qgEzEHv8cjN9ZA/EOaFWfNnGfVezHVQtbeZkP/0Kk56z6oSnKat5j8fepJ
zxqs1NWfALqxpEeS8xTviwhnEPeqbhRLFwLOXRQQMQK5WUs0TyHsiNM9zPv3KoCW
BjKCBF6++nw4jGw/f8+T5hU/QZ0fOcZE1NcDFGW/Gc4Ali9PFRdC+/NzovUjvA7V
Af9KjZh4vTX509eBFWi3
=M2lH
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
