From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm-adsp: Add missing MODULE_LICENSE
Date: Fri, 4 Jul 2014 12:47:23 +0100
Message-ID: <20140704114723.GB19453@sirena.org.uk>
References: <1404452861-8951-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472810757836926717=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BAC62659A3
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 13:47:36 +0200 (CEST)
In-Reply-To: <1404452861-8951-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Praveen Diwakar <praveen.diwakar@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0472810757836926717==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2014 at 11:17:41AM +0530, Vinod Koul wrote:
> From: Praveen Diwakar <praveen.diwakar@intel.com>
>=20
> Since MODULE_LICENSE is missing the module load fails,
> so add this for module.

Always CC maintainers on patches (in this case the Wolfson people),
especially for something like licensing.

> Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
> ---
>  sound/soc/codecs/wm_adsp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 0600271..2537725 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -1758,3 +1758,5 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(wm_adsp2_init);
> +
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.7.0.4
>=20
>=20

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtpRIAAoJELSic+t+oim9ZKgQAID0kMOkz2A0mjt00q6F9GFu
np7RaT4A/IxK88eipu8eQOdXzzFe2nqaHdJzcz3meQkPj/Ejd12v6kuriQw3P776
EZURhtrZ6UZyfxu0u0wqNfEYpyU95nQ7c0A1gxxN5QqxgTh42mVL/YUu4jF1LXvg
jftOfEZTBKtTivw135zrDFYcBZrgqeWkKl76ccNP0tbBmS2ndUIs2F4AWYQwkkmz
YqBpBX8T8PQUgE5b39PdMOjuwfHAPzn3EKcoM7KczWJEYQgV46r9Fxf4Y+vMaFja
LjaCiXRLwTIoErpeUGpYZeK+tOSfvqE3afzlVDzmHqWgy8DU/E+PbyiYdn2znSt0
O2sqNWWyh7jFfEf2hlRka/f7ruV0c5As4fWx/HqF9iIWyedTEBHwrLok3cf9Gd6W
QCNwqHK/anbogxYx+oNWiunZ97qwhLlirRftjeFxsaW7oHqybrB1ZXaoRXkfsitc
cb8ngDGXNklqsPvZ8GFMTPmdO22b5Y0RSy94Krmi4QcZ4azvvpVYyBzIK9OUtdr8
AhtkmL4WaBawFayp0CySzqMpT8IC/drFPDeLddfPlB0n1SZsl6AvbXUSJr2y8x6E
qECGorIXf5QRcmOyBeH2WSaiBltm/SCBvanvp1TA9MhLNOpfpyOq6EcudGxHRUUO
zQKSDk703yVaacdZhElx
=EZrf
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============0472810757836926717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0472810757836926717==--
