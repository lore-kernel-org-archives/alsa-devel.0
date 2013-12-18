From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
Date: Wed, 18 Dec 2013 19:20:40 +0000
Message-ID: <20131218192040.GN31886@sirena.org.uk>
References: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4705232827074769277=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C79A2617B6
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 20:20:45 +0100 (CET)
In-Reply-To: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, leon@leon.nu
List-Id: alsa-devel@alsa-project.org


--===============4705232827074769277==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2013 at 09:58:10AM +0800, bardliao@realtek.com wrote:

This is an improvement but there are still quite a few problems here.

> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index bc12676..b31615c 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -48,6 +48,7 @@ snd-soc-pcm1792a-codec-objs := pcm1792a.o
>  snd-soc-pcm3008-objs := pcm3008.o
>  snd-soc-rt5631-objs := rt5631.o
>  snd-soc-rt5640-objs := rt5640.o
> +snd-soc-rt286-objs := rt286.o
>  snd-soc-sgtl5000-objs := sgtl5000.o
>  snd-soc-alc5623-objs := alc5623.o
>  snd-soc-alc5632-objs := alc5632.o

Keep this file sorted please.

> +static int rt286_hw_read(void *context, unsigned int reg, unsigned int *value)

To repeat what I said when reviewing the first version of this you
should be using regmap not open coding your register I/O.  This looks
totally standard...

> +int rt286_jack_detect(struct snd_soc_codec *codec, bool *hp, bool *mic)
> +{
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int val;
> +	int i;

> +EXPORT_SYMBOL_GPL(rt286_jack_detect);

Use the standard jack detection APIs.

> +	if (rt286->pdata.irq_en)
> +		rt286_index_update_bits(codec,
> +			NODE_ID_VENDOR_REGISTERS, 0x33, 0x0002, 0x0002);

Why would the system ever want to supply an interrupt and not use it?

> +	/* Set configuration default  */
> +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> +		NODE_ID_MIC1, 0x00);
> +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> +		NODE_ID_DMIC1, 0x00);
> +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> +		NODE_ID_DMIC2, 0x00);

Why are the silicon defaults not adequate?

> +static int rt286_hp_event(struct snd_soc_dapm_widget *w,
> +			   struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	unsigned int val;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		val = snd_soc_read(codec, NODE_ID_HP_OUT) & 0x8080;
> +		switch (val) {
> +		case 0x0:
> +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> +				NODE_ID_HP_OUT, 0xb000);
> +			break;
> +		case 0x8000:
> +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> +				NODE_ID_HP_OUT, 0x9000);
> +			break;
> +		case 0x0080:
> +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> +				NODE_ID_HP_OUT, 0xa000);
> +			break;
> +		}

This is rather unclear.  What is it doing?

> +static int rt286_set_dai_sysclk(struct snd_soc_dai *dai,
> +				int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
> +
> +	pr_debug("%s freq=%d\n", __func__, freq);

dev_dbg().

> +static int rt286_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_PREPARE:
> +		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level)
> +			rt286_write(codec, AC_VERB_SET_POWER_STATE,
> +				NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D0);
> +		break;
> +
> +	case SND_SOC_BIAS_OFF:
> +		rt286_write(codec, AC_VERB_SET_POWER_STATE,
> +			NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D3);
> +		break;

These aren't matched - you power up when leaving standby but only power
down when you go to off.  That's a bit odd and probably won't do the
right thing and will leave the CODEC powered up all the time since you
don't set idle_bias_off (though perhaps you should).

> +static int rt286_probe(struct snd_soc_codec *codec)
> +{
> +	hw_configure(codec);

Just inline hw_configure(), there's no point having a separate function
with only one use in a tiny function.

> +static int rt286_remove(struct snd_soc_codec *codec)
> +{
> +	rt286_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}

The framework should power down the device for you.

> +struct snd_soc_dai_driver rt286_dai[] = {
> +	{
> +	 .name = "rt286-aif1",
> +	 .id = RT286_AIF1,
> +	 .playback = {
> +		      .stream_name = "AIF1 Playback",
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = RT286_STEREO_RATES,
> +		      .formats = RT286_FORMATS,
> +		      },
> +	 .capture = {
> +		     .stream_name = "AIF1 Capture",
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = RT286_STEREO_RATES,
> +		     .formats = RT286_FORMATS,
> +		     },
> +	 .ops = &rt286_aif_dai_ops,
> +	 },

Your code handles up to 16 channels, and looking at the code I suspect
you need symmetric_rates.

> +
> +	ret = devm_snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt286,
> +				     rt286_dai, ARRAY_SIZE(rt286_dai));
> +	if (ret < 0)
> +		goto err;
> +
> +	return 0;
> +err:
> +	return ret;
> +}
> +
> +static int rt286_i2c_remove(struct i2c_client *i2c)
> +{
> +	snd_soc_unregister_codec(&i2c->dev);

Remove this, the whole point of devm_ is that it cleans up for you.

I'm also not seeing any code for interrupts even though there appears to
be some code to initialise them in the driver.

> +static int __init rt286_modinit(void)
> +{
> +	return i2c_add_driver(&rt286_i2c_driver);
> +}
> +
> +module_init(rt286_modinit);

module_i2c_driver().

> +#define NODE_ID_AUDIO_FUNCTION_GROUP			0x01
> +#define NODE_ID_DAC_OUT1				0x02
> +#define NODE_ID_DAC_OUT2				0x03
> +#define NODE_ID_ADC_IN1					0x09
> +#define NODE_ID_ADC_IN2					0x08
> +#define NODE_ID_MIXER_IN				0x0b
> +#define NODE_ID_MIXER_OUT1				0x0c
> +#define NODE_ID_MIXER_OUT2				0x0d
> +#define NODE_ID_DMIC1					0x12
> +#define NODE_ID_DMIC2					0x13
> +#define NODE_ID_SPK_OUT					0x14
> +#define NODE_ID_MIC1					0x18
> +#define NODE_ID_LINE1					0x1a
> +#define NODE_ID_BEEP					0x1d
> +#define NODE_ID_SPDIF					0x1e
> +#define NODE_ID_VENDOR_REGISTERS			0x20
> +#define NODE_ID_HP_OUT					0x21
> +#define NODE_ID_MIXER_IN1				0x22
> +#define NODE_ID_MIXER_IN2				0x23
> +#define TOTAL_NODE_ID					0x23

> +#define CONNECTION_INDEX_MIC1				0X0
> +#define CONNECTION_INDEX_DMIC				0X5

These need namespacing if they're device specific.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsfWEAAoJELSic+t+oim9tboP/icpGFVw8BQxsUH6iD74wnUM
sAzXdZbYrHOup2ImODLqdAzDsRjmc6WuxFKu333ZEKCWOEM5X3c5uoBXkG/w3Zjp
CbiYJX+kg4SCDMTsyaT1yltNDenFBbdeehJQMhVWaMTf57GJ4W5eWb6ib827jmYn
FV8nENOnXG7K/YLgLSt/PI5HYiUcyHpW1iof4SGytbApbrb1GBdopkyEeUyb8lrF
3eGh9Z9mxy7hbjYQ4H70cLy29+taHaWIBq0ygMIUfLuHkhmCJH+W9JTtT1wQKdcA
Z9C//zRPsvlg0Ym3X1yKGNyRkV/1wIZmSluDDoP4/Lf7khi9d7Dx08McW0530CrY
L5wguJ0oPU9ZxCky9edoCYHTCz2n488YApCd9GK7+Ot2/kS5KFNirkMu4umYbM8x
bKZos8DksgCfDSpzKPi0g0vU+15rFN1llVPOwG5dlQIBb9qWez8KaS+K25KBJYzw
AhTVc6+iayPl4PTJHJrrgJeIvgyABEd0JF+JEiYHmSFOXQsTQi79ekyvw9iz0/+F
c1A6pCj+kJ/s31ui1XUUUIz8FbTKevGQ+8LFOn2o8Lm0GEmptij8YjOXtax6gWl2
nypCRaz90PXiYYH+5yZdEYiESkWFma3RxnHFzqgdvgRpCcQ58oFX6PJWFpNq+t0z
xmzu+1pf3CiI6KKWgX2u
=kjY9
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--

--===============4705232827074769277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4705232827074769277==--
