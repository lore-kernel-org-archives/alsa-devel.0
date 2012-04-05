From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: make Tegra20 drivers depend
 on Tegra20 support
Date: Thu, 5 Apr 2012 21:58:52 +0100
Message-ID: <20120405205851.GS3129@opensource.wolfsonmicro.com>
References: <1333653292-21390-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3402482171892242601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D14524838
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 22:58:54 +0200 (CEST)
In-Reply-To: <1333653292-21390-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3402482171892242601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Content-Disposition: inline


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 01:14:52PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Without this, the Tegra20 drivers can be built into a kernel that's
> built only for Tegra30.

Applied, thanks.

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfgdZAAoJEBus8iNuMP3dzX8P/38zB2Etb4p5RP2RSY4yWe+j
GAGU2TwC537UyJC/QOrE+f6PPzYyLlhk50TnKGJO1dN49mMAOoKV/KmoYMUWFwzC
AO2CR9BlbwI6+vN2xmJrI5xz9llLmwGbbyqPA5/kFRQfZntJRdjwflDsAbAlAtH5
Sg6j86OKj3TOi2FzV7idnVydpMxEh89JXKCkWqHo3CzyYX3LouVOCkHPHs1OFUMz
2A3+8bdltiwJTBNGT1tJkYcl7juDYlAkWa+zPWHdH5dKLJ+Ki/CPdHq+tBYqBIQb
0sV0rJD0CM1mFbSoqTDp4dGYa/oBxSdO127sb2Uulql+HKjIkods0Lu2DmGElly1
yZ0ED1Rp39rJbMHqN3zRmA1PgaLpoMyzOm5oPoqh8O68A9M+rnI0G5uAyybJecz7
yxpP149+cvtPEidzYeqpxAgSYWFzcv7SojrW90hfDhzfnnZuASemPDYltSJ1mUgq
qsM+dOTQe1FO3eioH3NiaFkmohK4X5pRaxrduaNJdIREDZPx2J58Gybo1FK4wfIr
kqHFV6bfYkoBag4iB5C+FYmHbJZK+rFXw9WpElCEI3ZWDRdmHLCKzkcNMkkxqtGL
29pE9Op29wx+rdJRtowUWh3qOYvDBnriXl7Erxf2cSdMpqhWOJJl1axKr5ZSbtSg
TfQPeIKrMdKPJEw6JmKk
=/0Br
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--

--===============3402482171892242601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3402482171892242601==--
