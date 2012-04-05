From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: drop Kconfig description for
 SND_SOC_TEGRA_DAS
Date: Thu, 5 Apr 2012 21:57:52 +0100
Message-ID: <20120405205752.GR3129@opensource.wolfsonmicro.com>
References: <1333653229-21345-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7072156262267096314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4F97243BC
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 22:57:54 +0200 (CEST)
In-Reply-To: <1333653229-21345-1-git-send-email-swarren@wwwdotorg.org>
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


--===============7072156262267096314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FbmEh7Ek6NM6xKh/"
Content-Disposition: inline


--FbmEh7Ek6NM6xKh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 01:13:49PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> The DAS, I2S, and SPDIF Kconfig options are intended to be selected by
> the Kconfig options for ASoC machine drivers. As such, they don't need
> to be user-visible themselves. Drop the description from the DAS variable
> to achieve this. I2S and SPDIF already don't have a description.

Applied, thanks.

--FbmEh7Ek6NM6xKh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfgdJAAoJEBus8iNuMP3d8dEP/1o8wlWjrm+7S5JoBG8KeUBm
pO0jA6SVIEp4+ThbTyMzFaN47T8XzYFFZtlRuQ9pytABEUU7YvxdomIbzeXL6eRd
XGIm5dXaucxyd3L3NdVD6NeDoeKCDFKkIe7VsHqgH2LSSy0V0/L8OVkgpQruDGOU
i0qmaFfYilQfsbZFifI3Sn8c00nu/BLxLCBmHa1tTZShl/R1+BD/SvVUzSGRJpqO
URUnSVYiYCqT8KL/HzF4SurQAuKG9jd9coyXhh0XyXj5XADGvTaOnCtrZ/U8+94U
H+vfONcgLdhtij/JvvBcWR1huVrlkRXzFvnxyig7KdSyXOGeAD6/RzGK8HJQmeXj
tJUkwa1V/daYbb+HLKX7WHoPoawD2fGYC8xuy/JAGVMkzjqO8PMB+IyB+z4Waoqm
OavMRNmvEmV9g0Uh8RCnBvLQoKOphg+xiNJMmTUS/+ywMsYFw4iPWAoM7fTsgwKu
9Li5ODzX4gFnxmhJKUqQyykrz/P0apTSiETj5jj3b+8+r81ZT5iabo248zJZVLPc
2AUS+jgM709m7HIOBDO2c/F/U00fnhSls5QnJXkEJyfEH5LH8JwABCXpSFK/MVe5
zmxFEP4//rQNvr98wxTSEnYFBs5B35fwNzR2vOP9peWenAyQhIQZDPP9SsTbeke6
BwHSY4SCL+AKmIesp1Jr
=Gn2W
-----END PGP SIGNATURE-----

--FbmEh7Ek6NM6xKh/--

--===============7072156262267096314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7072156262267096314==--
