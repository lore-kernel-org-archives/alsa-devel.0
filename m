From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK4458 DAC
	driver
Date: Wed, 31 Jan 2018 17:03:30 +0000
Message-ID: <20180131170330.GB7763@sirena.org.uk>
References: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5230913578563851617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A409267656
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 18:03:34 +0100 (CET)
In-Reply-To: <1517404809-25250-1-git-send-email-cosmin.samoila@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, linux-kernel@vger.kernel.org, wakasugi.jb@om.asahi-kasei.co.jp, linux-imx@nxp.com, Mihai Serban <mihai.serban@nxp.com>, daniel.baluta@nxp.com, mihai.serban@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5230913578563851617==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2018 at 03:20:09PM +0200, Cosmin-Gabriel Samoila wrote:

This looks pretty good overall, I've got some issues below but nothing
too major:

> +static int ak4458_i2c_remove(struct i2c_client *i2c)
> +{
> +	ak4458_remove(&i2c->dev);
> +	pm_runtime_disable(&i2c->dev);

It's weird that the runtime PM handling is here and not in the shared
code, and that it only exists in the I2C version.  Why is this?

> +static const struct soc_enum ak4458_dac_enum[] = {
> +/*0*/	SOC_ENUM_SINGLE(AK4458_01_CONTROL2, 1,
> +			ARRAY_SIZE(ak4458_dem_select_texts),
> +			ak4458_dem_select_texts),
> +/*1*/	SOC_ENUM_SINGLE(AK4458_0A_CONTROL6, 0,

The fact that you need these comments is why these arrays are a bad idea
- just use individually named variables as other drivers do.

> +static const struct snd_kcontrol_new ak4458_snd_controls[] = {
> +	SOC_SINGLE_TLV("AK4458 L1ch Digital Volume",
> +		       AK4458_03_LCHATT, 0/*shift*/, 0xFF/*max value*/,
> +		       0/*invert*/, latt_tlv),
> +	SOC_SINGLE_TLV("AK4458 R1ch Digital Volume",
> +		       AK4458_04_RCHATT, 0, 0xFF, 0, ratt_tlv),

It'd be more idiomatic to combine these into stereo pairs than have them
as single channel controls.

> +static const char * const ak4458_dac_select_texts[] = { "OFF", "ON" };

This looks like the users should be switch controls - what's the goal
here?

> +	rstn = snd_soc_read(codec, AK4458_00_CONTROL1);
> +	rstn &= ~AK4458_RSTN_MASK;
> +
> +	if (bit)
> +		rstn |= AK4458_RSTN;
> +
> +	snd_soc_write(codec, AK4458_00_CONTROL1, rstn);

This looks like an open coded snd_soc_update_bits()?

> +static int ak4458_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct ak4458_priv *ak4458 = snd_soc_codec_get_drvdata(codec);
> +	u8 format;
> +	int pcm_width = max(params_physical_width(params), ak4458->slot_width);
> +
> +#ifdef AK4458_ACKS_USE_MANUAL_MODE
> +	u8 dfs1, dfs2;
> +#endif

What's this and why is it a compile time option?

> +	case 32:
> +		if (ak4458->fmt == SND_SOC_DAIFMT_I2S)
> +			format |= AK4458_DIF_32BIT_I2S;
> +		else if (ak4458->fmt == SND_SOC_DAIFMT_LEFT_J)
> +			format |= AK4458_DIF_32BIT_MSB;
> +		else if (ak4458->fmt == SND_SOC_DAIFMT_RIGHT_J)
> +			format |= AK4458_DIF_32BIT_LSB;
> +		else if (ak4458->fmt == SND_SOC_DAIFMT_DSP_B)
> +			format |= AK4458_DIF_32BIT_MSB;
> +		else
> +			return -EINVAL;

This should be a switch statement.

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_B:
> +		ak4458->fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
> +		break;

All these cases seem to be the same?

> +static int ak4458_trigger(struct snd_pcm_substream *substream, int cmd,
> +			  struct snd_soc_dai *codec_dai)
> +{
> +	int ret = 0;
> +
> +	dev_dbg(codec_dai->dev, "%s(%d)\n", __func__, __LINE__);
> +	return ret;
> +}

Remove empty functions.

> +	ak4458->mute_gpio = of_get_named_gpio(np, "ak4458,mute_gpio", 0);
> +	if (gpio_is_valid(ak4458->mute_gpio)) {

Given that this is new code it'd be better to use GPIO descriptors, this
will also allow support for non-DT systems - use devm_gpiod_get() and
the matching APIs.

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpx9uEACgkQJNaLcl1U
h9Dplgf9ExkcH0EVVBV92qJzfdZ+BdQSH7X89xyHte5beAH/UqVUOcuYQp9rOkow
4yE/xB3BxN2elwnkiSKa9fkLrH7pejZIn3KJxloPXwRcrlKawUl91i/yoBjvisqy
yY6MKMcgHiqIUNcyfRv8nKaHPqMRiYQT4mIpOjkrsZFv/60rb5ZSpL5Mf9pYfy+S
a+dsQGwZMS7YYKNrOKOy4dRP9HI70Edd2CJrTp3A2w88jBWSSjfJ0bU//0lNYWga
glTz+r7QJfn6nQOaOL0SWGgWLMHsgqCM5l9IMh61J7CdUMLWKMz7hRUSJiIQuFir
Qep7SjeJIq5aDmzdvofWCW5hnQcjuw==
=gzQc
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============5230913578563851617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5230913578563851617==--
