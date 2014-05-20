From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 12/17] ASoC: fsl-ssi: set bitclock in
 master mode from hw_params
Date: Tue, 20 May 2014 23:08:02 +0100
Message-ID: <20140520220802.GC12304@sirena.org.uk>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-13-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842024750983420169=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 722E9265499
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:08:16 +0200 (CEST)
In-Reply-To: <1398682498-24357-13-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0842024750983420169==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hjpAA1SrfqQxXuPQ"
Content-Disposition: inline


--hjpAA1SrfqQxXuPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 12:54:53PM +0200, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> The fsl_ssi driver uses the .set_sysclk callback to configure the
> bitclock for master mode. This is unnecessary since the bitclock
> is known in hw_params. This patch removes the .set_sysclk callback
> and configures the bitclock from .hw_params.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

This isn't signed off either.  Are we positive that none of the users
set the bitclock to something non-default - there are devices out there
which require an unusual bitclock (eg, where it's also used as the
master clock and so needs overclocking)?

Providing a default as this does is a definite win, but allowing it to
be overridden may be needed sometimes (rarely fortunately).  Leaving a
stub set_sysclk() that just sets a variable and then using that value
instead of calculating in hw_params() would get the best of both worlds.

--hjpAA1SrfqQxXuPQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9I/AAoJELSic+t+oim937oP/ApIo0tYLiEvrz46eFeZ5Orb
5DBj8ekntwgYSM/PeYiF0AxpM3pg8KhrgzeFzQH/lbNXbV7owgRYGkkXqiDd5kDs
PBu4k33EOs2iQlfX1izp2/dhW1P7m+fkQGDlLRO5aAIOVwD9ySZk3eTO+TtYJ1l2
JS4Kd7ITtv8Utct9zPUXakyuXRFR51jq9Cj8DKD+1MaR7CNw+ogkL6BdpNb8Lh0B
mYdQDCB/KkIqI6jhFEQeWtXkg6mEXrceV2kQn53tZPn3i/ia7UrTxReFiWveNPIQ
CptJqRNqXImVGwTOsb/EaqKMF4Ue9ufelhmKxV7ntLusE0DZ6LvS6JKU8egSlnh8
FrdQoRhW0aIuFBoa841NBvOn97MBQ+RGQKQ2wFtsUJMwZC7J7quuaHHPUdMQ44c9
IvvYCHJ25HzZ4wCsOWeMxg1myXslzPvrpaGgj/KInuZhGNnTpn6Pyz1Cpzo/7PZK
W5gOYCwcC1+bnLskNauT1OExPUgAewfb+wq2dm4arackshhnOPCXSbgEiqJKy+L/
bmnkNAOIESjCHpQjOi9wWBKs5/c2FoIVSQt1c+x4INQbDPgNUcrayvwwApNlJ0Fq
5asRUPh5SRSi/Ti/xDkUlpKJAR4Fve3FWB1LMp/c2rNWX3JiysWSS+gx41aJ5WRP
jjD4JotnshObhH76W+Xp
=goJ6
-----END PGP SIGNATURE-----

--hjpAA1SrfqQxXuPQ--

--===============0842024750983420169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0842024750983420169==--
