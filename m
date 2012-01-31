From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] ASoC: max9768: Fix up review comments in
 max9768 driver
Date: Tue, 31 Jan 2012 12:04:02 +0100
Message-ID: <20120131110402.GL2471@pengutronix.de>
References: <1328007673-16695-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6090024411668327806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 702AE103A53
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 12:04:04 +0100 (CET)
In-Reply-To: <1328007673-16695-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6090024411668327806==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RD6GsZsdEJvsf78O"
Content-Disposition: inline


--RD6GsZsdEJvsf78O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 11:01:13AM +0000, Mark Brown wrote:
> The Mute Switch should be called Playback Switch to match the volume
> and the regmap core has been updated so we don't need to mark all the
> registers as non-volatile.
>=20
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks for picking this up!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--RD6GsZsdEJvsf78O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8nyqIACgkQD27XaX1/VRsckACgx0zgdJl81FgCwy32opgEXsSN
FG8AoMn836vyQoabucJzhldEfwmaE2eC
=zx25
-----END PGP SIGNATURE-----

--RD6GsZsdEJvsf78O--

--===============6090024411668327806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6090024411668327806==--
