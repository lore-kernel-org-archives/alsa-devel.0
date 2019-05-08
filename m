From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/3] ASoC: rt5677: allow multiple interrupt sources
Date: Wed, 8 May 2019 16:36:23 +0900
Message-ID: <20190508073623.GT14916@sirena.org.uk>
References: <20190507220115.90395-1-fletcherw@chromium.org>
 <20190507220115.90395-2-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lfL9iWt62hyVv4Jn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190507220115.90395-2-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--lfL9iWt62hyVv4Jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 04:01:13PM -0600, Fletcher Woodruff wrote:

> This patch does not add polarity flipping support within regmap-irq
> because there is extra work that must be done within the irq handler
> to support hotword detection. On the Chromebook Pixel, the firmware will
> disconnect GPIO1 from the jack detection irq when a hotword is detected
> and trigger the interrupt handler. Inside the handler, we will need to
> detect this, report the hotword event, and re-connect GPIO1 to the jack
> detection irq.

Please have a conversation with your firmware team about the concept of
abstraction - this is clearly a problematic thing to do as it's causing
the state of the system to change for devices that are mostly managed
=66rom the operating system.  It's not clear to me that this shouldn't be
split off somehow so that it doesn't impact other systems using this
hardware.

I'm actually not entirely clear what the code that does the "reconnect
GPIO1 to the jack detection IRQ" bit is, I couldn't find anything
outside of the initial probe.

> -	if (rt5677->irq_data) {
> -		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1, 0x8000,
> -			0x8000);
> -		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x0018,
> -			0x0008);
> -
> -		if (rt5677->pdata.jd1_gpio)
> -			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
> -				RT5677_SEL_GPIO_JD1_MASK,
> -				rt5677->pdata.jd1_gpio <<
> -				RT5677_SEL_GPIO_JD1_SFT);
> -
> -		if (rt5677->pdata.jd2_gpio)
> -			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
> -				RT5677_SEL_GPIO_JD2_MASK,
> -				rt5677->pdata.jd2_gpio <<
> -				RT5677_SEL_GPIO_JD2_SFT);
> -
> -		if (rt5677->pdata.jd3_gpio)
> -			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
> -				RT5677_SEL_GPIO_JD3_MASK,
> -				rt5677->pdata.jd3_gpio <<
> -				RT5677_SEL_GPIO_JD3_SFT);
> -	}
> -

There's a lot of refactoring in the patch here which makes it very hard
to follow what the actual change is.

> +		}
> +	}
> +exit:
> +	mutex_unlock(&rt5677->irq_lock);
> +	return IRQ_HANDLED;
> +}

We uncondtionally report the interrupt as handled?

> +static void rt5677_irq_work(struct work_struct *work)
>  {
> -	int ret;
> -	struct rt5677_priv *rt5677 =3D i2c_get_clientdata(i2c);
> +	struct rt5677_priv *rt5677 =3D
> +		container_of(work, struct rt5677_priv, irq_work.work);
> =20
> -	if (!rt5677->pdata.jd1_gpio &&
> -		!rt5677->pdata.jd2_gpio &&
> -		!rt5677->pdata.jd3_gpio)
> -		return 0;
> +	rt5677_irq(0, rt5677);
> +}

I couldn't find anything that schedules this.  What is it doing, why is
it here (and this is an example of a really complex to review bit of the
change due to refactoring BTW, the diff is really unhelpful)?

> +static void rt5677_irq_bus_sync_unlock(struct irq_data *data)
> +{
> +	struct rt5677_priv *rt5677 =3D irq_data_get_irq_chip_data(data);
> +
> +	regmap_update_bits(rt5677->regmap, RT5677_IRQ_CTRL1,
> +			RT5677_EN_IRQ_GPIO_JD1 | RT5677_EN_IRQ_GPIO_JD2 |
> +			RT5677_EN_IRQ_GPIO_JD3, rt5677->irq_en);
> +	mutex_unlock(&rt5677->irq_lock);
> +}

Is this the bit that reenables the interrupt?  Isn't this just a quirk
to rewrite the masks frequently, that'd seem easier than doing so much
open coding?

> +	/* Select and enable jack detection sources per platform data */
> +	if (rt5677->pdata.jd1_gpio) {
> +		jd_mask	|=3D RT5677_SEL_GPIO_JD1_MASK;
> +		jd_val	|=3D rt5677->pdata.jd1_gpio << RT5677_SEL_GPIO_JD1_SFT;
> +	}
> +	if (rt5677->pdata.jd2_gpio) {
> +		jd_mask	|=3D RT5677_SEL_GPIO_JD2_MASK;
> +		jd_val	|=3D rt5677->pdata.jd2_gpio << RT5677_SEL_GPIO_JD2_SFT;
> +	}
> +	if (rt5677->pdata.jd3_gpio) {
> +		jd_mask	|=3D RT5677_SEL_GPIO_JD3_MASK;
> +		jd_val	|=3D rt5677->pdata.jd3_gpio << RT5677_SEL_GPIO_JD3_SFT;
> +	}
> +	regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1, jd_mask, jd_val);
> +
> +	/* Set GPIO1 pin to be IRQ output */
> +	regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1,
> +			RT5677_GPIO1_PIN_MASK, RT5677_GPIO1_PIN_IRQ);

Are other GPIO outputs supported by the chip?  How does this interact
with the jdN_gpio settings above?

--lfL9iWt62hyVv4Jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzShvYACgkQJNaLcl1U
h9Akegf9EmRVQ8cOM0I85C0Md26UevTf1xeVygJTSaK3D7zYEY7AZikGu56Bifnb
3hSo0k2ReKPTd3OvIvBB7EEO4qtxpTtC6sSgehRJCyMTRcZwVjHFVyyIoVANr7Df
sEu5tpreRSUaOMbpXCxervtk0o0TrwPVZGcrSAGPrElU5ZqF4A+9okT2w1okMF/f
jfNc8amvzxrPb7PNMs3Wa514eKoFftmaKWKD5mLQA6/GDEhAK9O8eWaaIItmC7Qv
iXnJ8msdv52xvDaaQ0eyMcJPLy/HwVMtswVuIef1FP8SpboBC/2ZP6kpStf4oeph
hbbnKPTlo3ir7D3JnFqqYWoeZcvVnQ==
=QWkD
-----END PGP SIGNATURE-----

--lfL9iWt62hyVv4Jn--
