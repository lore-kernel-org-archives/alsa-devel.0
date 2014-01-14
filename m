From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: atmel_wm8904: make it available
	to choose clock
Date: Tue, 14 Jan 2014 20:36:50 +0000
Message-ID: <20140114203650.GX15567@sirena.org.uk>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8829447784800677330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 967AA264FB0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 21:37:09 +0100 (CET)
In-Reply-To: <1389669956-2304-3-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, nicolas.ferre@atmel.com, Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8829447784800677330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v6gilOcl2gU05R9Q"
Content-Disposition: inline


--v6gilOcl2gU05R9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 11:25:55AM +0800, Bo Shen wrote:
> Make it available to choose the clock from TK pin or RK pin. This
> is hardware design decided.

> --- a/sound/soc/atmel/atmel_wm8904.c
> +++ b/sound/soc/atmel/atmel_wm8904.c
> @@ -108,6 +108,7 @@ static int atmel_asoc_wm8904_dt_init(struct platform_=
device *pdev)
>  	struct device_node *codec_np, *cpu_np;
>  	struct snd_soc_card *card =3D &atmel_asoc_wm8904_card;
>  	struct snd_soc_dai_link *dailink =3D &atmel_asoc_wm8904_dailink;
> +	struct atmel_ssc_info *ssc_info;
>  	int ret;
> =20
>  	if (!np) {
> @@ -115,6 +116,15 @@ static int atmel_asoc_wm8904_dt_init(struct platform=
_device *pdev)
>  		return -EINVAL;
>  	}
> =20
> +	ssc_info =3D devm_kzalloc(&pdev->dev, sizeof(*ssc_info), GFP_KERNEL);
> +	if (!ssc_info)
> +		return -ENOMEM;
> +
> +	ssc_info->clk_from_rk_pin =3D
> +		of_property_read_bool(np, "clk_from_rk_pin");
> +
> +	card->drvdata =3D (void *)ssc_info;

Shouldn't this code be in the DAI driver?  Otherwise this series looks
fine to me, though the DT folks might have something to say I guess.

--v6gilOcl2gU05R9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1Z/fAAoJELSic+t+oim9uCwP/AhnO/W9V0FYXNgrkZQjOI6d
1n1QeHGJiSw2soGqnv4FMwx0c23eIYvnL8fiHw04vZY4qyEQYDZdHv4Rgq99U4XX
6wfTDUi+atk3G7UP2nUIanmZqTNyUmkOI/plRcrQS+kqSuoJlH/bCwiNSi4ig+oU
5Bi/xyO7EJJvG+RasL0uBrU6nk3WpFc9JMXsXyy51A2Wnm5CK+/uXheSJOP3x5jg
Pywg40ld0E5P2Z6YItTUwIHQJk/odqe36dpC88pCRyAtQwby2Hq4oqX9M+flkZ0P
587JT6suCmxsHqgJveeQY2HT7QdyIDrz9JYLR0RGN+d3z2XAXUIsl6CnzNBavnYH
+MTpTR7J5ONkSRqM84VfQJGnfiUMtouzfRzweUO3jiJnyDIiKki/8VG3c6ttKiQu
V94i8Lai+F3CJPXoh5sudKDSVw+14R5KvH0MlqrjNQnNjc6+8oj64XJ0Zorfjec6
EltejJKwgQKjtCkqhJtlVI0TLvs5TWAZu7YaIQ45thT/vA2q9INEEfg9UOP11swv
W4qHnZvMPCixPXhD0+4PeJkJafEihtkvJuiS/IFAa6ID1Ygumh+97DEFTdMvslZ4
8yestG9mmU847ziUSh1+0ZTDzkSzHLyPy+H03tFfX/69muvnTPTBaGFRuTjugjOo
sH1yHarTztFhogG4Vmkk
=zanM
-----END PGP SIGNATURE-----

--v6gilOcl2gU05R9Q--

--===============8829447784800677330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8829447784800677330==--
