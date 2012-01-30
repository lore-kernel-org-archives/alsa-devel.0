From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/3] regmap: Properly round reg_bytes and
	val_bytes
Date: Mon, 30 Jan 2012 14:35:29 +0100
Message-ID: <20120130133529.GF15596@pengutronix.de>
References: <1327677023-29310-1-git-send-email-w.sang@pengutronix.de>
	<20120127162837.GB18572@opensource.wolfsonmicro.com>
	<20120128011403.GA6669@pengutronix.de>
	<20120130132134.GB4882@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3799630366093645253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C546910393E
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 14:35:30 +0100 (CET)
In-Reply-To: <20120130132134.GB4882@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3799630366093645253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Clearly we *can* but there's other bits (chiefly the cache code once we
> acquire the ability to do block operations from cache) which really want
> stuff to be 8 bit aligned.  I deliberately chose to make things byte
> aligned so we have to think about this stuff before we do things that
> make byte aligned stuff hard, it felt like if we were going to take a
> complexity hit we probably want it to be on the odd register formats as
> pretty much all of the more demanding modern devices seem to be going
> for multiples of 8 bits.

Understood. I'd think we will find a non-intrusive way when a more generic
format_x_y-function seems worthwhile.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8mnKEACgkQD27XaX1/VRuOUgCgkLlMNT015CBrdYZsUdMLAzaj
62UAoJP8bYRSKDU/H6Ogs7g7li5QRV3J
=Chy0
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--

--===============3799630366093645253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3799630366093645253==--
