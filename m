From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 10/17] ASoC: fsl-ssi: Transmit enable
	synchronization
Date: Tue, 20 May 2014 23:04:25 +0100
Message-ID: <20140520220425.GA12304@sirena.org.uk>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-11-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8124432409454090605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 548F4265361
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:04:42 +0200 (CEST)
In-Reply-To: <1398682498-24357-11-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8124432409454090605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HLWlMrl8LtY8zWoR"
Content-Disposition: inline


--HLWlMrl8LtY8zWoR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 12:54:51PM +0200, Markus Pargmann wrote:
> When the fsl-ssi unit is used in i2s slave mode, it is possible that the
> SSI unit starts transmitting data on the wrong channel. This happens
> because the SSI does not synchronize with the left-right-clock by
> default.

Applied, thanks.

--HLWlMrl8LtY8zWoR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9FmAAoJELSic+t+oim9KrMP/Rw9w81oMxDW7WxbGjxQHQjC
Wh1s8U8DtQzK43Ih6Ft7AAwo58A8+7XLNfzKIliswtDrbGn7+G+ceIQdL7WK91ij
YEgub8cjIrTKEv3SwInV3qX+GBzI6nZBqvdh+gwV0N1aEAFf19bPzrUom84DhkXg
uYA61HiuVgtZuICX18YGlmPdXmm0EPUZtNoHE+1LAH3pg3RMdMenSUifG0qTqzud
eMa9GWXlBhOGyHZIUfwgoHDDjKpoEWkRpPOQxrSNeLCvMXZoDl+5TXaeHGSpv2Fz
FI6YVV1jjM9veqI6a7G94YMoO3S7ei280sgtvbIuYSNdbIkexp0+h8ksMQ85bjRI
Lq5Kbmk3EdV0YR5KeUf2dpzAaJ8rbfGjxZTvxJ7wmV4xL3lVD8GJ0IFaP0Rtv04I
Fn8Mtg7q6tbGxJX/xTTllqsn1Ks4rmpdh9CAAObUIehsugrrHc37JJF2AO7L1zTh
KVcZA8iKMFzJ1xUlPc5hUvJ5P2A/6N8TuSyJEHITs9vjelHtUl/n4T9jgckZddDT
s+oH3Zuwjx7W+mXgRYMC5nODO/9/Z6udZHG1jYHNGUlKzWxbm/rcIF8kzjEcWiyt
vGQRmi5tyY0gUwY/VryTzV5kN2X5e0FPc9FaeKC1oPw2g3V+VTHJJmLC3REvHGCo
WWUsNOuX0/V5aFHyxAgf
=kZqC
-----END PGP SIGNATURE-----

--HLWlMrl8LtY8zWoR--

--===============8124432409454090605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8124432409454090605==--
