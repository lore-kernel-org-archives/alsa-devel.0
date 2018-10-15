From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 3/9] ASoC: sun8i-codec-analog: split
 regmap code into separate driver
Date: Mon, 15 Oct 2018 10:24:00 +0200
Message-ID: <20181015082400.kapwi475pievgbry@flea>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-4-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7069990156963149359=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E5604267864
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 10:24:01 +0200 (CEST)
In-Reply-To: <20181013165329.13363-4-anarsoul@gmail.com>
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


--===============7069990156963149359==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="om5xpw6ih4dvbj6x"
Content-Disposition: inline


--om5xpw6ih4dvbj6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 13, 2018 at 09:53:23AM -0700, Vasily Khoruzhick wrote:
> It will be reused by sun50i-codec-analog later.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/Kconfig                |   7 +-
>  sound/soc/sunxi/Makefile               |   1 +
>  sound/soc/sunxi/sun8i-codec-analog.c   |  79 +------------------
>  sound/soc/sunxi/sunxi-adda-pr-regmap.c | 102 +++++++++++++++++++++++++
>  sound/soc/sunxi/sunxi-adda-pr-regmap.h |   7 ++
>  5 files changed, 119 insertions(+), 77 deletions(-)
>  create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.c
>  create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.h
>=20
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 22408bc2d6ec..3932f0238add 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -23,7 +23,7 @@ config SND_SUN8I_CODEC
>  config SND_SUN8I_CODEC_ANALOG
>  	tristate "Allwinner sun8i Codec Analog Controls Support"
>  	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> -	select REGMAP
> +	select SND_SUNXI_ADDA_PR_REGMAP
>  	help
>  	  Say Y or M if you want to add support for the analog controls for
>  	  the codec embedded in newer Allwinner SoCs.
> @@ -45,4 +45,9 @@ config SND_SUN4I_SPDIF
>  	help
>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>  	  A10 and affiliated SoCs.
> +
> +config SND_SUNXI_ADDA_PR_REGMAP
> +	tristate
> +	select REGMAP
> +

This is just a minor nitpick, but I'd rename it to
SND_SUN8I_CODEC_ADDA, to be consistent with the rest of the
drivers/Kconfig symbols.

With that fixed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--om5xpw6ih4dvbj6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvETp8ACgkQ0rTAlCFN
r3Q6wA/9Hrqv8BNUcPjhcxEq4QaKMBb9lit0KIrOfzA/25KIwK7G4pd7latKfymN
EJCFFIALQqUwW2LClKf3S2DCVMW72gpyrWnF7gz2+ppd2cJnvawBRh++9F+T360N
6horTQ3JoAonBd45UyyUYHnqH7S7S7TsoDGxe0ngPr43zlsadg2b2s9cR+8Cq6tE
rOFstAr1xzRRSgDyKI7WWdvFENUIZmitVi9tSSUwaYYuuo6SYZJ5rh0DsV6K1cQi
JEoi/23g4vjLQfInOfv8n3CxSWK+ZnEJ+P9p/a9V9YzFSOeRRQO1iFcuSyUTHTOp
t7ThbjTV/f8Eb2WV7Ye4Fb/6yWHDr24BgFLsK1GtUVTyelVhcT5CuapOC27u9s9b
mgjF9Mtp+Xx/T1tF65NdHlo5J9Qqt6lm4EtVfB7eSI1t2QhW4sbst1OVGncO0QC6
tAS8LxIz2N8quwEpBsnEOdfm45e3oVD7E/cz8701hWt0bLRyVaHqWrU9W6qfmjPY
y7Mi4GxBLHe8pEpMetiFso1XEJR8Akson5VhjSf45Lut+cDs9AN5GIqwTW03IfR/
fArnFUUM2dRtZMv/XrGL/atbWaRhVFM1SAAwCJp/HcIaAnHsWv8ZXXO3iJRt6V40
Ua6h2WGGqDj+tX72+4LGOQTfw2i6KDx4FE/P0mv/49H23qYaYcU=
=26nQ
-----END PGP SIGNATURE-----

--om5xpw6ih4dvbj6x--

--===============7069990156963149359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7069990156963149359==--
