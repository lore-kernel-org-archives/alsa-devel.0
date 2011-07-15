From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 00/10] ARM: mxs: add audio support
Date: Fri, 15 Jul 2011 22:39:01 +0200
Message-ID: <20110715203901.GB24047@pengutronix.de>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4940120528301777518=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B8B00103A4D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 22:39:03 +0200 (CEST)
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4940120528301777518==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
> This patch series is to add audio support based on saif for mxs platform.
> The driver only supports playback currently.
> For capturing, due to hardware limitation that we have to use two saif
> instances to implement full duplex (playback & recording), we need to
> figure out a good design to fit in ASoC as the following work.
>=20
> In addition, we simply just support master mode since saif tx can
> only work as a master due to hw limitation(rx can work in both
> master & slave mode).
>=20
> Code is written based on the branch imx-for-3.1 in sascha's tree
> http://git.pengutronix.de/git/imx/linux-2.6.git

Thanks! Branch can be found here:

git://git.pengutronix.de/git/wsa/linux-2.6.git mxs-audio-v3

Will test tomorrow!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4gpWUACgkQD27XaX1/VRujdACeMxgnEKVk95YhhWqg3LZiwmt7
iNAAoK6r9ToaRc7Dc1kDl/hyoALQ3LDv
=n2XZ
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--

--===============4940120528301777518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4940120528301777518==--
