From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: atmel-i2s: add driver for the new Atmel I2S
 controller
Date: Tue, 29 Sep 2015 15:26:14 +0200
Message-ID: <560A9176.9070007@atmel.com>
References: <cover.1443452274.git.cyrille.pitchen@atmel.com>
 <9b9890682c47fd2669aeed529225ebf44eca5cf6.1443452274.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9b9890682c47fd2669aeed529225ebf44eca5cf6.1443452274.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Le 28/09/2015 17:05, Cyrille Pitchen a =E9crit :
[...]
> +	/* Get audio clocks to generate the I2S Master Clock (I2S_MCK) */
> +	dev->aclk =3D devm_clk_get(&pdev->dev, "aclk");
> +	dev->gclk =3D devm_clk_get(&pdev->dev, "gclk");
> +	if (IS_ERR(dev->aclk) && IS_ERR(dev->gclk)) {
> +		/* Master Mode not supported */
> +		dev->aclk =3D NULL;
> +		dev->gclk =3D NULL;
> +	} else if (IS_ERR(dev->gclk)) {
> +		err =3D PTR_ERR(dev->gclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the PMC generated clock: %d\n", err);
> +		return err;
> +	} else if (IS_ERR(dev->aclk)) {
> +		err =3D PTR_ERR(dev->aclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the PLL audio clock: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Do hardware specific settings to initialize I2S_MCK generator */
> +	if (dev->caps && dev->caps->mck_init) {
> +		err =3D dev->caps->mck_init(dev, np);
> +		if (err)
> +			return err;
> +	}
> +
> +	/* Enable the peripheral clock. */
> +	err =3D clk_prepare_enable(dev->pclk);
> +	if (err)
> +		return err;
> +
> +	dev->dev =3D &pdev->dev;
> +	dev->regmap =3D regmap;
> +	platform_set_drvdata(pdev, dev);

those last 3 lines should be moved before calling dev->caps->mck_init()=
,
otherwise dev->dev would not be initialized yet if dev_err() is called =
by
atmel_i2s_sama5d2_mck_init().

Will be fixed in the next series.
[...]
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
