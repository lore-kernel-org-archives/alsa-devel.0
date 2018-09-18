From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] sound: soc: wm8903: Cut gpio_base data
Date: Tue, 18 Sep 2018 12:52:20 -0700
Message-ID: <20180918195220.GX2471@sirena.org.uk>
References: <20180918191233.17178-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1388204362779040168=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D05A426788E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:52:23 +0200 (CEST)
In-Reply-To: <20180918191233.17178-1-linus.walleij@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>, patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1388204362779040168==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QQ0dNM4HnH4+xgqD"
Content-Disposition: inline


--QQ0dNM4HnH4+xgqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 12:12:33PM -0700, Linus Walleij wrote:
> This variable is only used inside the file, and we should
> never hard-code the GPIO base, so delete this.

Adding the Cirrus people again...  hard coding the GPIO base is needed
for board file based systems if they're using GPIO numbers isn't it?

>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  sound/soc/codecs/wm8903.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index 23e43ff40ded..545512dc4c45 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -144,7 +144,6 @@ struct wm8903_platform_data {
> =20
>  	int micdet_delay;      /* Delay after microphone detection (ms) */
> =20
> -	int gpio_base;
>  	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin =
mux */
>  };
> =20
> @@ -1876,17 +1875,12 @@ static const struct gpio_chip wm8903_template_chi=
p =3D {
> =20
>  static void wm8903_init_gpio(struct wm8903_priv *wm8903)
>  {
> -	struct wm8903_platform_data *pdata =3D wm8903->pdata;
>  	int ret;
> =20
>  	wm8903->gpio_chip =3D wm8903_template_chip;
>  	wm8903->gpio_chip.ngpio =3D WM8903_NUM_GPIO;
>  	wm8903->gpio_chip.parent =3D wm8903->dev;
> -
> -	if (pdata->gpio_base)
> -		wm8903->gpio_chip.base =3D pdata->gpio_base;
> -	else
> -		wm8903->gpio_chip.base =3D -1;
> +	wm8903->gpio_chip.base =3D -1;
> =20
>  	ret =3D gpiochip_add_data(&wm8903->gpio_chip, wm8903);
>  	if (ret !=3D 0)
> --=20
> 2.17.1
>=20

--QQ0dNM4HnH4+xgqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhV3MACgkQJNaLcl1U
h9CqIQgAhAfBQSZLbxsZbsZfxNthtJ54EdNpuKIwaUa6du5KC72l2Mykx1iPq+dX
TmQncERIKWrXpCLT6lL4kFVJkxhIaVzOBczXerTBXbFRm/I8E4BIbcso6PzG+ung
ggjHGrN69mC5KBZH91KfiTxIJp3LRSl8UccANkOwZBM8CjGZ/4caqGj/6bVMSDAr
27dylaKm/Qufj7bfCYsnoAaJ2dvjV6/YrXUv9L+9lth7aq3OPxyMYIydAq/0Wfkh
PNXpMgpy3zuXNJeJDFeS94ijgWg8uQ0ur60+A5jpf9jI+I9UMupgx6jIsUAMCS+J
PeSQAVqL0U1JAVU0abdorDV6IjLoNg==
=fBEJ
-----END PGP SIGNATURE-----

--QQ0dNM4HnH4+xgqD--

--===============1388204362779040168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1388204362779040168==--
