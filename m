From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 4 Jun 2012 15:17:53 +0100
Message-ID: <20120604141752.GH7538@opensource.wolfsonmicro.com>
References: <1338547834-22714-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2352170259545762005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A3EB2415E
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 16:17:55 +0200 (CEST)
In-Reply-To: <1338547834-22714-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2352170259545762005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 12:50:34PM +0200, Ola Lilja wrote:

> +/*
> + * Extended interface for codec-driver
> + */

So, a few issues below.  Could you please submit a version with this
extended API removed or made driver internal as much as possible?  The
rest of the driver looks good so it'd be good to split this stuff out
and review separately.

> +int ab8500_audio_init_audioblock(struct snd_soc_codec *codec)
> +{
> +	int status;
> +
> +	dev_dbg(codec->dev, "%s: Enter.\n", __func__);
> +
> +	/* Reset audio-registers and disable 32kHz-clock output 2 */
> +	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
> +				AB8500_STW4500CTRL3_CLK32KOUT2DIS |
> +					AB8500_STW4500CTRL3_RESETAUDN,
> +				AB8500_STW4500CTRL3_RESETAUDN);
> +	if (status < 0)
> +		return status;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ab8500_audio_init_audioblock);

This is really odd (I'm sure I've queried this on previous versions of
the driver) - why is something else reinitialising the device?
Shouldn't the CODEC driver be doing this by itself - if nothing else I'd
expect it to cause confusion if the device is reinitialised underneath
the driver?

I didn't register this last time as I'd assumed that the issue was a
missing static rather than something else calling the function.

> +int ab8500_audio_setup_mics(struct snd_soc_codec *codec,
> +			struct amic_settings *amics)
> +{

Similar thing here, I'd expect this to just be platform data.

> +int ab8500_audio_set_ear_cmv(struct snd_soc_codec *codec,
> +			enum ear_cm_voltage ear_cmv)
> +{
> +	char *cmv_str;
> +
> +	switch (ear_cmv) {
> +	case EAR_CMV_0_95V:
> +		cmv_str = "0.95V";
> +		break;
> +	case EAR_CMV_1_10V:
> +		cmv_str = "1.10V";
> +		break;
> +	case EAR_CMV_1_27V:
> +		cmv_str = "1.27V";
> +		break;
> +	case EAR_CMV_1_58V:
> +		cmv_str = "1.58V";
> +		break;
> +	default:
> +		dev_err(codec->dev,
> +			"%s: Unknown earpiece CM-voltage (%d)!\n",
> +			__func__, (int)ear_cmv);
> +		return -EINVAL;
> +	}
> +	dev_dbg(codec->dev, "%s: Earpiece CM-voltage: %s\n", __func__,
> +		cmv_str);
> +	snd_soc_update_bits(codec, AB8500_ANACONF1, AB8500_ANACONF1_EARSELCM,
> +			ear_cmv);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ab8500_audio_set_ear_cmv);

This is *possibly* OK, though again it does look platform dataish.

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzMOIAAoJEBus8iNuMP3drK8P/i1wtgPrWXlNRrU9EMf1ly7n
8HPhw7pCVSdYvYoicLXhOs5ta/CU5RWK4FgxAuVoOS8yI4KDi08otBYen3PpmqPD
nwOy9UgpDdNJKZ7yAbmA1w2GNS6ktP83k+eZ8LvxIP2uCO9h/rIjSscuIcmTZIje
OWvrgHYiGapU4wt+JLmfgL9wYBGN9/42uezUYKMI3lX6UYAzmWgbzeF3IXBvzzys
gy0LFA/rCHXqZp7rLwq5t0KvfIfppPin8lMKxAh3itqFyJSjSUlrIIEgA6TXI3/8
7h59MsO2jVsx1ffucJF965I7Ovvp1EiKq2IPmQ0H30Hz9GpnNeD0FYz0sjayB6Ou
7WgJdCjE1QhkbdADxy8EkIdpGFOFTXQ4xjFvKxJglGekwuVZZxg+PwmLSpZGw38G
+4rw5mXODgK3EtryIRYmoHzM5mSX5pxWQjk5378DqeX6ojzvp27EkELC71WEo5Bp
5mGZD1zlqmse+6YUP8nOwU13qY6toENkzz/tG0CoN+BcG2UE7fE+mRK2RdG1AF/A
1rImeJqFxeiyDr7ZtqWco8pohWb7AzVgaSp9aQ3k3cz9k3z+Fe//6VlNLjQqObIc
jjyceWdexhzg3WoBmh+Y3UZ7rgmSXuNFwamMq1Ondmd/ljiQIwIwq65H2w0VPQP9
f8P+Qo1J0EXSBCkoEI6c
=+4uk
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--

--===============2352170259545762005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2352170259545762005==--
