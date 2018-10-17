From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 2/9] ASoC: sun8i-codec: Don't hardcode
 BCLK / LRCK ratio
Date: Wed, 17 Oct 2018 09:12:48 +0200
Message-ID: <20181017071248.65g7m6ih2swazjh4@flea>
References: <20181016030239.15449-1-anarsoul@gmail.com>
 <20181016030239.15449-3-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0293758875609816602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C3DB4267545
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 09:12:59 +0200 (CEST)
In-Reply-To: <20181016030239.15449-3-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============0293758875609816602==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7uqovd7mi7tmfyhv"
Content-Disposition: inline


--7uqovd7mi7tmfyhv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Oct 15, 2018 at 08:02:32PM -0700, Vasily Khoruzhick wrote:
> BCLK / LRCK ratio should be sample size * channels, but it was
> hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
>=20
> Calculate it basing on sample size and number of channels.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index fb37dd927e33..2467fab94a19 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/log2.h>
> =20
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -52,7 +53,6 @@
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
>  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
> @@ -257,8 +257,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, uns=
igned int fmt)
>  }
> =20
>  struct sun8i_codec_clk_div {
> -	u8	div;
> -	u8	val;
> +	unsigned int	div;
> +	u8		val;
>  };

Do we still need that type change? It looks like you're not using it
anywhere in that patch.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7uqovd7mi7tmfyhv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvG4O8ACgkQ0rTAlCFN
r3Qv5w//ZfbHwfGovd9EcRaBkOrP40bl+whU/UHnPGGxkuAn1D20i6Bc9ayBrIbv
2pI7fNcM2HaV8g7jxggdmOflOQb/fenBQ1uxeXWB3jHy0kpy+AHLne05GkiR44OI
jcSS2RZH2V0HunC/Ellybge3ODwMF2skhR0R+vAq8gHAOfMO+buf8ymXobX2QB3D
OnpbkrwN6Cm8ccCugBxG/m5Gn4C8SrXkiiXUnTWlTKxgUMnAUzqIYMlvUg2+q79m
fFeWFy10c3Q2ZJnlCcixCicXCloQMHCKi4+2iEb8+jI6w+DqiyWZ+jetuLJqsAXc
PuOReooNr/vsOMWparVNJWD0rPvuVpF29gq74U/hgMn2OGlVpeuZnEAU7kBNrahN
TH9hJGrEgYb75EhIF4927z+qmrwBPuHnqfcLuj/Csu5K0TsdU/Dsn8JAMVWGaA2+
npovG76RCQ0/9pCMkx/U9wE4dKxh5ilM/aHSfPfmvWeOIW9tPElfJeP7sapfTwg4
bq3Gnezp2UAW49uUDMmlHNwpGU3Xy+YZTCxIoGim1/LDL3Ba2A+02vUNcx3Tv0yf
YPHygkfPcSqfaAte+IDI0hNrp6t4YEJ3x0lY89GAPqRJN7yfqDnYaHZuxsPOTR+g
nsgXst0UhmJhWL6AoFzYbYnXotoEUCzWbQLfY3Q9oQ8XjUr6tQY=
=JnH+
-----END PGP SIGNATURE-----

--7uqovd7mi7tmfyhv--

--===============0293758875609816602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0293758875609816602==--
