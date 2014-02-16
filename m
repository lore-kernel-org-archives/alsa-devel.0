From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: make REVISION_ID readable
Date: Sun, 16 Feb 2014 09:09:47 +0800
Message-ID: <20140216010947.GR4451@sirena.org.uk>
References: <1392335664-6586-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5611351079385418170=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 65539261673
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 02:58:26 +0100 (CET)
In-Reply-To: <1392335664-6586-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5611351079385418170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9R6240woFu/reHS"
Content-Disposition: inline


--/9R6240woFu/reHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 04:54:24PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The REVISION_ID register is not currently marked readable. snd_soc_read()
> refuses to read the register, and hence probe() fails.

Applied, thanks.

--/9R6240woFu/reHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAA/YAAoJELSic+t+oim95T0QAJf1OuPSjimt+04MgdxfgR5o
5dlweabirL+UIs2qEuXmSv1yFtq7TFlUXIQCTVodM48WRG+NI/7AIUrOJ9mRxMpn
2oCwDNr7QXRyR+6BrsWa4ZXXgUyUxILGCS1ynzXWg/mtNDglIIkKBAVda5VExXwM
Eb+z6mju9SHB+woqoA2YlrP634hLB9Cpc1VyH/5x9VNuRSeC8ZfHtksWnwS84Frw
Hvs8G7okH38tciHOAqMMBq7cD3JTE6WPiJhS9+L+9gyU3akl19P9G7GKTlwVdJj2
7LHFjKwHAa6ZrhwfhV71nWjzgqUWxLSlLF3EUw0OA2Wyww21mWXBp7YghmbdKIr7
msjYmYYdOKUxMSqbuER/WWDOSdtKCDJThQkCZlLXpZ2K2kuSL9sMDmuMgusdt6rY
m4sryFbfxVm2d6qPpfH6Qgc1fy6YBV0UEMFkm2uFl1EDX9kwNQfuZhwF4DFgBhpz
lww7o8EtGO9rRw/CuYW2z50P2HbIKSDKp1fSQFYmVw6lAyXamCfLb1teDkdL4Qd3
TmJsFnnIUL8RPoqsGYyeNMI0bLBE4iWs7gLAgmcBQZOdFaXQSc9CGD1d/G77ugIp
FE81Mlt4yRSiJiiJi6dbIONHSch9PZRUtmnBdmUqdnYkoNyGLta3zTFszqHW8RCc
wTTnCihvDAA0IG+75IsA
=mZpL
-----END PGP SIGNATURE-----

--/9R6240woFu/reHS--

--===============5611351079385418170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5611351079385418170==--
