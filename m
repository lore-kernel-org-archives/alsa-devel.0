From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend] ASoC: fsl-ssi: Fix bitclock
 calculation for master mode
Date: Wed, 25 Mar 2015 09:58:15 -0700
Message-ID: <20150325165814.GJ3572@sirena.org.uk>
References: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507502371593835269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A5182612C6
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 17:57:51 +0100 (CET)
In-Reply-To: <1427121972-5059-1-git-send-email-mkl@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0507502371593835269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 03:46:12PM +0100, Marc Kleine-Budde wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> in fsl_ssi_set_bclk we are looking for the best divider by iterating
> over all possible dividers. The divider is in the range 1..256, so

This doesn't apply against current code, please check and resend.

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEukmAAoJECTWi3JdVIfQIm4H/jQeht9sZPoYYA6KeLZcpi/i
9xMuk9xhf9iFjOWT2GXElsvsR/D8T1XmwCFLp2jOhNyDG9FtPh5y52FwcXSrCfip
APL8aJJ5KIZURmVre3fFuhWb9OG0qlY1QnRIF0pNeL2+Pw+H62gSQzAJoZLhTWKa
YO9cuhhxD0+RX0R/KKNFI3FlS/WCQlwHwT+2HEMEuvrbFMwU5k5HhiLKhLqHFJHi
Ls72zEdJ1W8ts1L7PYocfIAq8jhUF4mSeJHkMPG9ZBI+3/6LIobVz7DLl2cRZHaz
9suT392hok9nApYZlKSzfEKiOJjizB20jcZLHTCe5QA7YSn8PxN4hHepAbMHXKM=
=y/+R
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--

--===============0507502371593835269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0507502371593835269==--
