From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Reset pointer
 position when starting a stream
Date: Mon, 5 Mar 2012 13:09:18 +0000
Message-ID: <20120305130917.GL3224@opensource.wolfsonmicro.com>
References: <1330952535-30614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8043341091198322215=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A126F1041E2
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:09:19 +0100 (CET)
In-Reply-To: <1330952535-30614-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8043341091198322215==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Content-Disposition: inline


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 02:02:14PM +0100, Lars-Peter Clausen wrote:
> From: Mika Westerberg <mika.westerberg@iki.fi>
>=20
> Otherwise a wrong position will be reported after restarting a stream and=
 the
> first few samples might be skipped.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

I can't apply this without a signoff from Mika.

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVLr3AAoJEBus8iNuMP3dhToP/0qRP1s8rYskcCgpRA97VHpo
PR5gwVoJne4JtCRQz/9I7tsFiY2qEPZpapwBf0Z9g01jJYNC1NnY0PwqbOhO0WuR
RnJVexZf2pp2OQAnpJGXnQWinoC+cPr1NK2wFNrmExRI99qjMniBPGtkG34JHjeP
RB8y6019a67JW40wfDwNiVhiaN/Sb4eAwtArfjDgzQ1dQhwJI47Z5TiOT/N9AFi0
HxznMOsvBvzrA+OjQQfPrktaD7CB/Rk6AiKDPouTGyDk70XtJc+K+KhhehF8j+b0
OZ+2taZn1kxiCt2XI9DlIdPyTj0+Nyl0o76Dn3Rc4vAjAkCDRIyv9OPfiiEQkz6a
MGAEzrgl7pSu6UxY/EH2iH6WDZ6h2gFOKP6KUGb5yhDn3TOXlgWwtKY655T6WW/M
vObgSk2/k/zPo9IVuA0nwosEaxUdIYxg3n4B+w+EJAspBUYVPDkobGtkFT6izith
2TJMNFTnqAON6tVztfCU2KCoesY4qc9gSg23HfLYrh4PKS9Gr8aY7PRRCwjeMesU
A6q5keitkxaHBMDbtvn+c/f49mNIyI4ieM9VMHAIwh7K7OgpADIsmiGQChOz/Es+
qlm5nu3LvV1uInPEFj7xjcPFM04wq9YipJoOPYqchd3swXcFRDGrJTSHeNCkz0k+
Jc8tlGMpzgdCDdm23uDC
=Tl9b
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--

--===============8043341091198322215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8043341091198322215==--
