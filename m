From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] sound: soc: wm8903: Pull in platform
	data
Date: Tue, 18 Sep 2018 12:51:17 -0700
Message-ID: <20180918195117.GW2471@sirena.org.uk>
References: <20180918191226.17104-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9138024152262347393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48ACB26788E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:51:21 +0200 (CEST)
In-Reply-To: <20180918191226.17104-1-linus.walleij@linaro.org>
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


--===============9138024152262347393==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Wg5Vd7si6EhrIHA"
Content-Disposition: inline


--1Wg5Vd7si6EhrIHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2018 at 12:12:26PM -0700, Linus Walleij wrote:
> No platform in the kernel is using platform data to
> populate the WM8903 so pull it into the source file.
> This is done to handle further simplifications.

Please always copy maintainers on patches, adding the Cirrus people.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/sound/wm8903.h    | 24 ------------------------
>  sound/soc/codecs/wm8903.c | 24 ++++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/include/sound/wm8903.h b/include/sound/wm8903.h
> index b310c5a3a958..b2ef76d5d00d 100644
> --- a/include/sound/wm8903.h
> +++ b/include/sound/wm8903.h
> @@ -11,12 +11,6 @@
>  #ifndef __LINUX_SND_WM8903_H
>  #define __LINUX_SND_WM8903_H
> =20
> -/*
> - * Used to enable configuration of a GPIO to all zeros; a gpio_cfg value=
 of
> - * zero in platform data means "don't touch this pin".
> - */
> -#define WM8903_GPIO_CONFIG_ZERO 0x8000
> -
>  /*
>   * R6 (0x06) - Mic Bias Control 0
>   */
> @@ -245,22 +239,4 @@
>  #define WM8903_GP5_DB_SHIFT                          0  /* GP5_DB */
>  #define WM8903_GP5_DB_WIDTH                          1  /* GP5_DB */
> =20
> -#define WM8903_NUM_GPIO 5
> -
> -struct wm8903_platform_data {
> -	bool irq_active_low;   /* Set if IRQ active low, default high */
> -
> -        /* Default register value for R6 (Mic bias), used to configure
> -	 * microphone detection.  In conjunction with gpio_cfg this
> -	 * can be used to route the microphone status signals out onto
> -	 * the GPIOs for use with snd_soc_jack_add_gpios().
> -	 */
> -	u16 micdet_cfg;
> -
> -	int micdet_delay;      /* Delay after microphone detection (ms) */
> -
> -	int gpio_base;
> -	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin =
mux */
> -};
> -
>  #endif
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index 6cb3c153ba19..23e43ff40ded 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -124,6 +124,30 @@ static const char *wm8903_supply_names[WM8903_NUM_SU=
PPLIES] =3D {
>  	"DCVDD",
>  };
> =20
> +/*
> + * Used to enable configuration of a GPIO to all zeros; a gpio_cfg value=
 of
> + * zero in platform data means "don't touch this pin".
> + */
> +#define WM8903_GPIO_CONFIG_ZERO 0x8000
> +
> +#define WM8903_NUM_GPIO 5
> +
> +struct wm8903_platform_data {
> +	bool irq_active_low;   /* Set if IRQ active low, default high */
> +
> +        /* Default register value for R6 (Mic bias), used to configure
> +	 * microphone detection.  In conjunction with gpio_cfg this
> +	 * can be used to route the microphone status signals out onto
> +	 * the GPIOs for use with snd_soc_jack_add_gpios().
> +	 */
> +	u16 micdet_cfg;
> +
> +	int micdet_delay;      /* Delay after microphone detection (ms) */
> +
> +	int gpio_base;
> +	u32 gpio_cfg[WM8903_NUM_GPIO]; /* Default register values for GPIO pin =
mux */
> +};
> +
>  struct wm8903_priv {
>  	struct wm8903_platform_data *pdata;
>  	struct device *dev;
> --=20
> 2.17.1
>=20

--1Wg5Vd7si6EhrIHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhVzUACgkQJNaLcl1U
h9CWBwf+Ldo6qwqy3ziacyiR73qDOVXW0ixjUuW7PoD1Jop+5PzmpRZy39oiONcP
vqdotox3ObLl9GxjEy58swN4C0QqT7bf9dNMu4hiIPgAKSOqpbvKI3GBE6Psozvx
FyiR6HEA8K9bu8agYYx+7uCheacTjjwGqPNFe3rz/wve/NdVHWMfyQdqDTgsibTl
Kd6n1NV7BYpvOZ7JiD7eGiVvg4v50ft8Ov6FTDZVLcDEkhcyp7DKgEOpyJfr8M/p
JbyvNjluQAnmxGMv2DpkGX86tfmtZQ2bcLoyPlfVM4V/8sJzS+y7dmQqkq4neBeL
0Z6R5ZjqW43H7+HN8fNS6cKBfZwBAA==
=h5p3
-----END PGP SIGNATURE-----

--1Wg5Vd7si6EhrIHA--

--===============9138024152262347393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9138024152262347393==--
