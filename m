From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Add ADAU1977 driver
Date: Mon, 3 Feb 2014 18:40:26 +0000
Message-ID: <20140203184026.GL22609@sirena.org.uk>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
 <1391439428-3198-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8530368799839057849=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 514492610A6
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 19:40:34 +0100 (CET)
In-Reply-To: <1391439428-3198-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8530368799839057849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mGogChkTWDyM7+rg"
Content-Disposition: inline


--mGogChkTWDyM7+rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 03:57:08PM +0100, Lars-Peter Clausen wrote:
> This patch adds support for the ADAU1977, ADAU1978 and ADAU1979 audio CODEC
> devices. They are a family of 4-channel differntial input audio ADC devices.
> They can be connected to either a SPI or I2C bus.

To avoid tedious iteration of the driver for the DT bindings it's
generally helpful to submit the DT bindings as a separate patch.

>  sound/soc/codecs/adau1977-i2c.c        |  58 ++
>  sound/soc/codecs/adau1977-spi.c        |  73 +++

This isn't the general style, if we want to do that we should be
converting all the other drivers.

> +config SND_SOC_ADAU1977
> +	tristate
> +
> +config SND_SOC_ADAU1977_I2C
> +	tristate
> +	select SND_SOC_ADAU1977
> +
> +config SND_SOC_ADAU1977_SPI
> +	tristate
> +	select SND_SOC_ADAU1977
> +

Please make these user visible if OF is in use.

> +static struct i2c_driver adau1977_i2c_driver = {
> +	.driver = {
> +		.name = "adau1977",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = adau1977_i2c_probe,
> +	.remove = adau1977_i2c_remove,
> +	.id_table = adau1977_i2c_ids,
> +};

You should have explicit OF IDs.

> +	if (rate >= 8000 && rate <= 12000)
> +		ctrl0 = ADAU1977_SAI_CTRL0_FS_8000_12000;
> +	else if (rate >= 16000 && rate <= 24000)
> +		ctrl0 = ADAU1977_SAI_CTRL0_FS_16000_24000;
> +	else if (rate >= 32000 && rate <= 48000)
> +		ctrl0 = ADAU1977_SAI_CTRL0_FS_32000_48000;
> +	else if (rate >= 64000 && rate <= 96000)
> +		ctrl0 = ADAU1977_SAI_CTRL0_FS_64000_96000;
> +	else if (rate >= 128000 && rate <= 192000)
> +		ctrl0 = ADAU1977_SAI_CTRL0_FS_128000_192000;
> +	else
> +		return -EINVAL;

There's a couple of these rate range if trees - how about a lookup in an
array?

> +	if (!enable) {
> +		ret = regmap_update_bits(adau1977->regmap, ADAU1977_REG_POWER,
> +			ADAU1977_POWER_PWUP, 0);
> +		regcache_mark_dirty(adau1977->regmap);
> +	} else {
> +		ret = regulator_enable(adau1977->avdd_reg);
> +		if (ret)
> +			return ret;
> +		if (adau1977->dvdd_reg) {
> +			ret = regulator_enable(adau1977->dvdd_reg);
> +			if (ret)
> +				goto err_disable_avdd;
> +		}
> +	}
> +
> +	if (adau1977->reset_gpio)
> +		gpiod_set_value(adau1977->reset_gpio, enable);

_cansleep().

I'm not sure all this enable/disable logic within the function is
helping clarity here.  There seems to be no meaningful sharing between
the two branches, separate functions for power up and power down is
probably going to be clearer.

> +static int adau1977_mute(struct snd_soc_dai *dai, int mute, int stream)
> +{
> +	struct adau1977 *adau1977 = snd_soc_codec_get_drvdata(dai->codec);
> +	unsigned int val;
> +
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		return 0;

Why would this ever be called for an ADC?

--mGogChkTWDyM7+rg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7+KXAAoJELSic+t+oim91I0QAIoclxMu8XfG2Z8vsWK0AL55
D1u4IyBYjbP9PJMcfsFw84cw1xdY1rxHxaQPeqqdv86j1/70RaA8mFo98m7rD6G/
mpnuQyCFv4CeEUvVwbKL1SjsweAHyRvHeIozo7LsUOM1mrKYITLl1U8T5EnZ0p86
6FqfRfTAe3wXRowxXoY28L8Y/n9MHw5+Qg3+i0usd0+kD17+zgP/FBbzw2u6WBJh
ox4p+xUXwRrOW8MaJkjPZ9mixcZuPSurvji5vIZCnoxatHkVqNpJASE9+D3FYrkZ
CJVUH+TzZHxfcFem5oEdCeL5j0343tLoReI8jt7gpKw6635o4VL4jgoFwBxHe04O
eTRBpEmYGKdbGLqH9R6B9/HXhsp75uZgKye/53IPB3Z981C34gIpReCasyMctzmf
xHr1M7KpX3Q5CLMr8ZZp73x0p5AM3QI3SVyh1pSmSamtkAFWC9RxNZDn9hubj5rV
iVUUVRpNL55I2uhRolMUKplWy6y/j8C5lQhRhNEM15DkC1a/ukiaMk0YaSaiZAbW
cgsDENdT+AJp4JMZpXdCjOsTwKbNz2TSL8i/xtJe4i+7ft+G07FFrHBC9ofVMdp1
HS4Aomx6qI5QD6/8HR9GeF2lx67+867onxDH2zrU+QJyk1A9E2CJb3ExSMij5+dJ
UDFKvt8LnhPBAkK5bPlm
=Sq2f
-----END PGP SIGNATURE-----

--mGogChkTWDyM7+rg--

--===============8530368799839057849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8530368799839057849==--
