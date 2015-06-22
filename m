From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: use CONFIG_SND_SOC for
	intel boards
Date: Mon, 22 Jun 2015 16:39:23 +0530
Message-ID: <20150622110923.GF19530@localhost>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
 <1434738331-12518-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3339224142210547139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D07261B19
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 13:07:45 +0200 (CEST)
In-Reply-To: <1434738331-12518-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Michele Curti <michele.curti@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3339224142210547139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2015 at 11:55:26PM +0530, Vinod Koul wrote:
> The Intel boards directory was under CONFIG_SND_SOC_INTEL_SST so the
> machines which don't need these were not allowed to be
> selected/compiled without enabling this symbol The machine should be
> allowed to selected by ASoC and then they should select rest of
> symbols required
>=20
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>

And this should also have:

Reported-by: Michele Curti <michele.curti@gmail.com>

Sorry Michele, missed adding your earlier

--=20
~Vinod
> ---
>  sound/soc/intel/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
> index 3853ec2ddbc7..6de5d5cd3280 100644
> --- a/sound/soc/intel/Makefile
> +++ b/sound/soc/intel/Makefile
> @@ -7,4 +7,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) +=3D baytrail/
>  obj-$(CONFIG_SND_SST_MFLD_PLATFORM) +=3D atom/
> =20
>  # Machine support
> -obj-$(CONFIG_SND_SOC_INTEL_SST) +=3D boards/
> +obj-$(CONFIG_SND_SOC) +=3D boards/
> --=20
> 1.9.1
>=20

--=20

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVh+zjAAoJEHwUBw8lI4NH4LAP/1UeTks72ICSZnO2f/CBZ6JR
sYswwrf1x3h5wzv3VG3qZBJo9Qkb6g8HZc/u4bWtHGPlPAx8Nr1E2Cw90yMgkVC2
8WBbaunGoultKT30RXUmt1Ob7fkCIpVaTvF/P8bVa5WPF51ABu4pDfnKwCeseYS2
vvyVxNIFdO740xIkcmAgrn1kmXcy4Lmt3V5UC3k43gXwgqWTYX5NuBwaVwv7Ksx6
UGHyhLDkwpF9AcKo+BLzbe8XRI36zxb3h8TNLEMxPldaz6a5ZY4uiTk4rUK9Kzez
IEXeekgrMwjEUtWs4yswVCW2Y9nNvB10TZfeOrN5IxcjDWRvGI4PDGrDFXUQ11Y2
vWir6NBUjBsuO1/IkFe6Gx0T7CksZNILnbaANc+ZlkHnQGDRC5LacUasupW6nZrj
b7wX1ul7Fedg1r27pS2j5vgR4ic30/qEVK7EAqfC8R4IEAH2uddOJA4EvrQ92v3W
X3TFeOFwFAY/qrPdsujhF5UCFiWXIqNjiQgGUOf866GDu7x59gsPPc8t9Wtj2XdQ
Yk8EUDA9NVuz+F2KpUiKlqPGa6LioFsGQxKF/sHMIA2XqsZCfnQCfnop1jKFSrux
spQmTIdMej18JjMKgUsarw5HJUlzq9UVFOFmxTP+UNHpQkUV7v4Q6h4d5TYU0Xok
m/boOuU1H+kkifOjaOYL
=QbS3
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============3339224142210547139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3339224142210547139==--
