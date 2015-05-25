From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/5] ASoC: Add GPIO based jack device
Date: Mon, 25 May 2015 13:11:20 +0100
Message-ID: <20150525121120.GJ21391@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <1432332563-15447-4-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8893748934766613477=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8715F2607B6
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:03:30 +0200 (CEST)
In-Reply-To: <1432332563-15447-4-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, zhengxing@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--===============8893748934766613477==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hm39DdI+xc+0zcX9"
Content-Disposition: inline


--hm39DdI+xc+0zcX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 03:09:21PM -0700, Dylan Reid wrote:

> Add a jack device that allows for separate headphone and mic detect
> GPIOs.  This device will be used as an aux device and will registered
> the jack with the card at init time.

This looks basically fine, a couple of things below but they're
nitpicks.

> +- gpio-audio-jack,debounce-times	: Debounce time for each sw-det-gpio
> +					  entry.

specified in...?

> +config SND_SOC_GPIO_AUDIO_JACK
> +        tristate "GPIO based audio jack detection"
> +

This should surely depend on GPIOLIB || COMPILE_TEST.

> +	gpio_names = devm_kzalloc(dev, sizeof(*gpio_names) * priv->gpio_count,
> +				  GFP_KERNEL);

We have devm_kcalloc() (not that it makes a huge difference but may as
well be clear about the intent).

> +	if (!gpio_names)
> +		return -ENOMEM;
> +	gpio_report = devm_kzalloc(dev, sizeof(*gpio_report) * priv->gpio_count,
> +				   GFP_KERNEL);

Blank lines between blocks please.

> +	snd_soc_card_jack_new(component->card, jack_name, report_mask,
> +			      &priv->jack, NULL, 0);

Ignoring the return value here (not likely to fail but...).

> +static void gpio_audio_component_remove(struct snd_soc_component *component)
> +{
> +	struct gpio_audio_jack *priv = container_of(component->driver,
> +			struct gpio_audio_jack, component_drv);
> +	int i;
> +
> +	for (i = 0; i < priv->gpio_count; i++) {
> +		if (!IS_ERR(priv->gpios[i].desc))
> +			gpiod_put(priv->gpios[i].desc);
> +	}

I would have expected us to be acquiring and releasing the GPIOs in the
platform device probe, not in the ASoC level probe - that way we handle
deferred probe better.

> +static int gpio_audio_jack_probe(struct platform_device *pdev)
> +{
> +	struct gpio_audio_jack *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	priv->component_drv.probe = gpio_audio_component_probe;
> +	priv->component_drv.remove = gpio_audio_component_remove;
> +
> +	return devm_snd_soc_register_component(&pdev->dev, &priv->component_drv,
> +					       NULL, 0);

Why do we allocate a component driver structure per device?

> +static const struct of_device_id gpio_audio_of_match[] = {
> +	{ .compatible = "gpio-audio-jack", },

linux,gpio-audio-jack possibly.  Not entirely sure what the current best
practice is on that.

--hm39DdI+xc+0zcX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYxFnAAoJECTWi3JdVIfQidYH/2W/lT5pJ+v+Le7mG1IJ1bwM
89/EudVWduIXxNlrmzpn6KRCe+pGXEhF9FBN0Ctr8daIoTv8FimXIxlTr0NlBy2t
LEGULexrHME2CuYar6xhUSEsTCDss0D5761qdLJKGh7TlTbqlxvDBe0/JSDy6iyK
ehtdAIUV6N0V/5JVcUt1fDQ+ji0b0Ae3mofMAnROLGH4mVOV3usmZxjYCgbDP1xb
TmNStgiarmYAVS1Zmmsa0x5bullD/6V+jv5Ib5Xbs3BZFv53PAtcyriPB31LV3x6
pnlLK4fYa31bYQ0MTGTcNqLA0P3lXpyHzXKI7u9AgqPfqiHD9uOSJ5mJQLcm9CQ=
=hL62
-----END PGP SIGNATURE-----

--hm39DdI+xc+0zcX9--

--===============8893748934766613477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8893748934766613477==--
