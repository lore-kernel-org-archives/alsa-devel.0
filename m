From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] Add support for Tempo Semiconductor's
 TSCS42xx audio CODEC
Date: Wed, 15 Nov 2017 10:50:13 +0000
Message-ID: <20171115105013.445wksy7etz35njy@sirena.org.uk>
References: <20171114183408.20504-1-steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5610684538336193673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E73266E65
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 11:50:21 +0100 (CET)
In-Reply-To: <20171114183408.20504-1-steven.eckhoff.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5610684538336193673==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qogm75voyqnxgdja"
Content-Disposition: inline


--qogm75voyqnxgdja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 14, 2017 at 12:34:08PM -0600, Steven Eckhoff wrote:

> Currently there is no support for the TSCS42xx audio CODEC.

This driver is doing a lot of weird, non-standard stuff without any
explanation - quite a bit of this needs to be refactored to use standard
interfaces.  The code is mostly clean but if it doesn't fit in well with
the rest of the system that's an issue.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +What:		/sys/bus/i2c/devices/.../dsp/eq[n]_ch[n]_[ab][n]
> +Date:		November 2017
> +KernelVersion:	4.14
> +Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> +Description:	Sets the equalizer biquad coefficient

Don't add sysfs files for configuring DSP coefficients, use binary
controls like other drivers do so that all the audio configuration can
be done via one interface.

> +What:		/sys/bus/i2c/devices/.../controls/limit_en
> +Date:		November 2017
> +KernelVersion:	4.14
> +Contact:	Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
> +Description:	Enables the limiter

This isn't even a DSP coefficeint, this is just a standard on/off enable
control.  Why are you adding all this stuff that makes no attempt to use
standard interfaces?

> index c367d11079bc..34e911c1e082 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -217,6 +217,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
>  	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
>  	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
> +	select SND_SOC_TSCS42XX if I2C
>          help

Keep these lists sorted please.

> +			/* Write LSB first due to auto increment on MSB */
> +			ret = snd_soc_write(codec, R_DACCRWRL + j,
> +					fw->data[i + NUM_DACCR_BYTES - 1 - j]);
> +			if (ret < 0) {

Can't the device handle writing all three bytes at once (the regmap said
it could)?  If so that'd speed things up a lot.

> +	dev_info(codec->dev, "Loaded tscs42xx_daccram.dfw\n");

dev_dbg() at most.

> +#define NUM_CONTROL_BYTES 2
> +static int load_control_regs(struct snd_soc_codec *codec)
> +{
> +	const struct firmware *fw = NULL;
> +	int ret;
> +	int i;
> +
> +	ret = request_firmware_direct(&fw, "tscs42xx_controls.dfw", codec->dev);
> +	if (ret) {
> +		dev_info(codec->dev,
> +			"No tscs42xx_controls.dfw file found (%d)\n", ret);
> +		return 0;
> +	}

What exactly are these controls?

> +	for (count = 0; count < PLL_LOCK_TIME_MAX; count++) {
> +		reg = snd_soc_read(codec, R_PLLCTL0);
> +		if (reg < 0) {
> +			dev_err(codec->dev,
> +				"Failed to read PLL lock status (%d)\n", ret);
> +			break;
> +		} else if (reg > 0) {
> +			ret = true;
> +			break;
> +		}
> +		mdelay(1);

A mdelay() is going to spin the CPU, is that really required or would an
msleep() be fine?

> +static int tscs42xx_hw_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params,
> +		struct snd_soc_dai *codec_dai)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct tscs42xx_priv *tscs42xx = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	mutex_lock(&tscs42xx->lock);

Why is there locking here?  In general what is this lock for?

> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		ret = -EINVAL;
> +		dev_err(codec->dev, "tscs42xx slave mode not supported (%d)\n",
> +			ret);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(codec->dev, "Unsupported format (%d)\n", ret);
> +		break;
> +	}

Just remove the _CBS_CFS case, it's redundant.

> +	switch (ratio) {
> +	case 32:
> +	value = RV_DACSR_DBCM_32;
> +		break;
> +	case 40:

Please follow the kernel coding style.

> +static int tscs42xx_i2c_read(struct i2c_client *i2c, u8 reg, u8 *val)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(i2c, reg);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "I2C write failed (%d)\n", ret);
> +		return ret;
> +	}

Why not just use the regmap?

> +	ret = of_property_read_string(np, "mclk-src", &mclk_src);
> +	if (ret) {
> +		dev_err(&i2c->dev, "mclk-src is needed (%d)\n", ret);
> +		return ret;
> +	}

If this needs to be in the DT rather than determined by the machine
driver the mux should be a standard clock driver using the clock
bindings.

> +	if (!strncmp(mclk_src, "mclk", 4)) {
> +		tscs42xx->mclk = devm_clk_get(&i2c->dev, NULL);
> +		if (IS_ERR(tscs42xx->mclk)) {
> +			dev_info(&i2c->dev, "mclk not present trying again\n");
> +			return -EPROBE_DEFER;
> +		}

This is broken, it's just ignoring the error code and deferring even if
there is a definitive error from the clock API.

> +		tscs42xx->pll_src_clk = PLL_SRC_CLK_MCLK2;

What happened to MCLK1?

> +static int __init tscs42xx_modinit(void)
> +{
> +	int ret = 0;

module_i2c_driver().

--qogm75voyqnxgdja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloMG+IACgkQJNaLcl1U
h9Dkigf/e7MEpD5Y1VBkMQZudpPjRCDeFFALy5Cp0LcGihk+x110V1xeKn4gNr4g
aL4alxBfWnR+B1sBo15UxZOHYKpqrZiwhUw8k5FmEvF+GHLcA+xLn2gf7CsD2Gws
7ybak0Fd25HU9ov8yQ8W/QXlGGnWmm7hla9RhdHF8DWKECMHNwDu0IVkoYH4XcTf
HJXn/WqmsRRruOnlJrO8EjiXX0FVrrCvr2qfDl1Qu8Hp5492R2O0SZV4CnvELVG4
wxgF9qpTGPtEr7etam1iqzjkbEgfXNK6Bn+vztmc5SWb39aHsAlf81KPBZVWJSch
6PqbhTE+rWVWQHq3HILxDQpBo9ZBcQ==
=vk2e
-----END PGP SIGNATURE-----

--qogm75voyqnxgdja--

--===============5610684538336193673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5610684538336193673==--
