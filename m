From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: mxs-saif: add record function
Date: Mon, 22 Aug 2011 13:30:54 +0200
Message-ID: <20110822113054.GC2006@pengutronix.de>
References: <1313942545-21403-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6883650456670863204=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 714EE1038AF
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 13:30:58 +0200 (CEST)
In-Reply-To: <1313942545-21403-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6883650456670863204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2011 at 12:02:25AM +0800, Dong Aisheng wrote:
> 1. add different clkmux mode handling for record.
> SAIF can use two instances to implement full duplex (playback &
> recording) and record saif may work on EXTMASTER mode that is
> using other saif's BITCLK&LRCLK.
> The clkmux mode is determined by saif's platform data and machine
> specific clkmux setting is done in pdata->init().
> 2. support playback and capture simutaneously however the sample
> rates can not be different due to hw limitation.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>

Will test and review, but probably not before Wednesday.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5SPe4ACgkQD27XaX1/VRvZKgCeJUkRcFiV3S/nx9qZffLBz1SZ
RoAAoLKHW2qu2Ikq59xAEjSCETN5gg1j
=z6jQ
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============6883650456670863204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6883650456670863204==--
