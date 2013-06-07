From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3] ASoC: fsl: add imx-wm8962 machine driver
Date: Fri, 7 Jun 2013 10:41:47 +0100
Message-ID: <20130607094147.GJ31367@sirena.org.uk>
References: <1370584787-9604-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7065051067970085989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E8B702656B3
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 11:41:49 +0200 (CEST)
In-Reply-To: <1370584787-9604-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, lgirdwood@gmail.com, rob.herring@calxeda.com, grant.likely@linaro.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7065051067970085989==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="prKJgtdAmn5IQEeG"
Content-Disposition: inline


--prKJgtdAmn5IQEeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 01:59:47PM +0800, Nicolin Chen wrote:

> +Optional properties:
> +- hp-det-gpios : The gpio port of Headphone jack detection.
> +- mic-det-gpios: The gpio port of Micphone jack detection.

These still need better documentation to say what they are electrically. =
=20
Like I say I really don't expect that your hp-det-gpio is actually
detecting headphones at all, I think it's detecting if something is
present in the jack.

Otherwise this looks good.

--prKJgtdAmn5IQEeG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsarXAAoJELSic+t+oim9z8kP/12mJzkq/dz9jgLNPJyJ0T13
tvCQgoaPbXbhay6eeXm41lPfFPPKckBvbB5pIF/gmZIQdN6Km35N4w+EZi4hmcP+
Zkt+OsuBDOlOT8IpqykXq6bjVumQzoV2tpznO67U3fW0YEbOKedCgJbO+FgobSzV
9kRPCiHesRZAKWs0KuiWUW19cKzkW37XENl3g30kDOGxyZzVAYahOViqEb1Tlxf1
ez5BLzGhdwdvTtv4EmOtLIuqc0P66AG76rywlAkniUZolTY9vvqfIDjJsSHsz5ec
H6IAIo+mGaG5koW5zwo5UUT1K8kNGDVpKwnyNtlTMd6kh4TMuZWJdXi10fZMjN2D
cw6tcegOrdtBIxQM15rjGT8f5X2WVT/FESuW5jtikjxYIfR9jT3oe2yod8LGBxc2
pfulOvtouIyBzWUzUlwnkgKB2kSR/8M5/7/Mbcg88jXNZlfM2LLy5MEIWKnqsnuQ
akoN/W0Oq5CMENrAX1jWuZWl8lRaypN0JTg23VNVmYtywVx4PagycA9wElBXVKO9
Ovi0gqLci1KNGAexLLcIN4NeIU0/YcLdJvUd3kUqe47TQ2qlX/KpUfjCVhiHADx3
UavmIX0/pmzscPb3R9F/ywDeDydL+XH6ZpExPneGpR2UBSBg3/YU+t2TdJ7wkbC5
MBhocSslALVW8jXrPZZn
=sdXd
-----END PGP SIGNATURE-----

--prKJgtdAmn5IQEeG--

--===============7065051067970085989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7065051067970085989==--
