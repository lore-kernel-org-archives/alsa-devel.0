From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/21] ASoC: Ux500: Enable ux500 MSP driver
 for Device Tree
Date: Thu, 26 Jul 2012 12:45:55 +0100
Message-ID: <20120726114554.GC3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-20-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0545008955621974186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14333265E67
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:45:54 +0200 (CEST)
In-Reply-To: <1343298534-13611-20-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============0545008955621974186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F+wU6CH2q8RBGewX"
Content-Disposition: inline


--F+wU6CH2q8RBGewX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 11:28:52AM +0100, Lee Jones wrote:

>  arch/arm/mach-ux500/board-mop500-msp.c |   14 --------------
>  arch/arm/mach-ux500/board-mop500.c     |    2 --
>  arch/arm/mach-ux500/board-mop500.h     |    2 --
>  sound/soc/ux500/ux500_msp_dai.c        |    6 ++++++
>  sound/soc/ux500/ux500_msp_i2s.c        |   33 +++++++++++++++++++++++++++++---

Always provide documentation for DT bindings.

> +void ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
> +			struct ux500_msp *msp,
> +			struct device_node *np)
> +{
> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
> +		msp->use_pinctrl = true;
> +	else
> +		msp->use_pinctrl = false;
> +}
> +

This doesn't seem particularly sane...  why is this conditional?

--F+wU6CH2q8RBGewX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQES2wAAoJEBus8iNuMP3d3FwP/2EJ6Y0YfHkCVFQMqzKcNZfj
pUHjxnKqLLpm3AbxPWdX87XsLjFeSxGmu25Z1y1sbWVrQQtpQhGDbMYTRs3ylWiQ
wwWhkTLvJZ60dNk0SnPkZzNOdHQcP6BvQqVcURYs4BB/83O20890pEWAMw8Nkiqc
7erZdOAlvrAPI1eOMbHZUMmFZI/Ldm+3cO5OBiSKuBTGQxEod2LD6Jh6a9lEuhhE
wG5MujwM2fYwJTzErsMN407725Xixy7rC6K//X7GfcjIz+Rk+e3QmBl+BE1b9y7u
8OM5QzweCZYfY4CHnYiCnA1OgTQv6Uvkrr2h6EmO0RNxrf/wu57YPeUd1GbXS0BQ
gDrTOeVn8tQmS9fj2xtXWul8/Hm9knofXEQfz7N8t8js0LQinD9PkbB473Xosaey
/87W6mk0BH9QNg/573WKL76tCy8OV09q01WFezuY6BB+1Bf2bGM3NSPJ7REKTym3
+PqKx5Ohc1xClJoIKwARWQvywInLauINVTKV9Kuqi78VZ0wW82tjWBKw4CabN0EH
6L45QETCyGgVfCdU9I2n+mQNkkP/eaIrWsLdyFX3ryrkp1UyoB1G3r7iQt9l6f8d
2Fhe39vY8yXDURw48V9LYS94pJo+bKHGV9NxpR5EAibT9z6mc7+7Ajz0Y8844LAx
tHQYKB5fvyb2sS1E+EEz
=+r3M
-----END PGP SIGNATURE-----

--F+wU6CH2q8RBGewX--

--===============0545008955621974186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0545008955621974186==--
