From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v7 0/3] ARM: mxs: add recording support for
	saif
Date: Thu, 24 Nov 2011 11:46:37 +0100
Message-ID: <20111124104637.GC2563@pengutronix.de>
References: <a> <1321977265-14959-1-git-send-email-b29396@freescale.com>
	<20111124073605.GI17979@S2100-06.ap.freescale.net>
	<20111124074619.GJ17979@S2100-06.ap.freescale.net>
	<20111124074938.GA8439@pengutronix.de>
	<20111124082312.GA18060@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5523989700764195752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 72A4D244F3
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 11:46:41 +0100 (CET)
In-Reply-To: <20111124082312.GA18060@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5523989700764195752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Also SND_SOC_MXS_SGTL5000 should probably depends on I2C_MXS than I2C.
> >=20
> > Please explain.
> >=20
> Sorry.  I meant 'select I2C_MXS'.

=46rom kconfig-language.txt:

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

So, NACK from me.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7OII0ACgkQD27XaX1/VRsizQCgwg9wVY34gEgCsvJvvVUuPyLv
/GQAoLM6+VimoOFydS2k7mLEBvumvvp4
=OieN
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

--===============5523989700764195752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5523989700764195752==--
