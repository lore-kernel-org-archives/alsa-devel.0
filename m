From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
 checking for each DAIs separately
Date: Fri, 2 Sep 2011 16:44:48 +0200
Message-ID: <20110902144448.GH1901@pengutronix.de>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8201009745519622980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 2D5A624414
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 16:44:51 +0200 (CEST)
In-Reply-To: <1314609314-22162-1-git-send-email-b29396@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8201009745519622980==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 29, 2011 at 05:15:14PM +0800, Dong Aisheng wrote:
> The orginal code does not cover the case that one DAI such as codec
> may be shared between other two DAIs(CPU).
> When do symmetry checking, altough the codec DAI requires symmetry,
> the two CPU DAIs may still be configured to run on different rates.
>=20
> We change to check each DAI's state separately instead of only checking
> the dai link to prevent this issue.
>=20
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Removes the race warning for me:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5g6+AACgkQD27XaX1/VRtNIQCggfxQv+8ira/PH/iTIkUaRZTp
7lUAoKk8bI9R3ElRiSZgpMJEyoS6AUoK
=gmLe
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--

--===============8201009745519622980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8201009745519622980==--
