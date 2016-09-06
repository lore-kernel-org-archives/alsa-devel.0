From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/6] ASoC: codecs: Add msm8916-wcd analog codec
Date: Tue, 6 Sep 2016 12:17:10 +0100
Message-ID: <20160906111710.GM3950@sirena.org.uk>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-2-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xP4xvRzdEG0QZ+Pj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473155865-13361-2-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--xP4xvRzdEG0QZ+Pj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2016 at 10:57:40AM +0100, Srinivas Kandagatla wrote:

> +static const struct soc_enum hph_enum =
> +SOC_ENUM_SINGLE_VIRT(ARRAY_SIZE(hph_text), hph_text);

Coding style, let's have some indentation please.

> +		if (w->reg == CDC_A_TX_1_EN)
> +			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
> +					    CONN_TX1_SERIAL_TX1_MUX,
> +					    CONN_TX1_SERIAL_TX1_ADC_1);
> +		else if ((w->reg == CDC_A_TX_2_EN) || (w->reg == CDC_A_TX_3_EN))
> +			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
> +					    CONN_TX2_SERIAL_TX2_MUX,
> +					    CONN_TX2_SERIAL_TX2_ADC_2);

This looks like it should be a switch statement.

> +	for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
> +		snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
> +			      wcd_reg_defaults_2_0[reg].def);

> +static int msm8916_wcd_analog_enable_spk_pa(struct snd_soc_dapm_widget *w,
> +					    struct snd_kcontrol *kcontrol,
> +					    int event)

We had some DAPM operations earlier, then the probe now we're back to
DAPM operations.  Seems a bit confused.

> +	//Path domain ???

C style comments please.

> +static int msm8916_wcd_analog_startup(struct snd_pcm_substream *substream,
> +				      struct snd_soc_dai *dai)
> +{
> +
> +	snd_soc_update_bits(dai->codec, CDC_A_MASTER_BIAS_CTL,
> +			    MASTER_BIAS_CTL_MASTER_BIAS_EN_MASK |
> +			    MASTER_BIAS_CTL_V2L_BUFFER_EN_MASK,
> +			    MASTER_BIAS_CTL_MASTER_BIAS_EN_ENABLE |
> +			    MASTER_BIAS_CTL_V2L_BUFFER_EN_ENABLE);
> +
> +	snd_soc_update_bits(dai->codec, CDC_D_CDC_RST_CTL,
> +			    RST_CTL_DIG_SW_RST_N_MASK,
> +			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
> +
> +	return 0;
> +}

I'm not quite sure what this is doing but it looks like something I'd
expect to be in DAPM and I can't see anything that undoes this on
teardown either.

> +static int msm8916_wcd_analog_parse_dt(struct device *dev,
> +				       struct msm8916_wcd_analog_priv *priv)
> +{
> +	struct device_node *np = dev->of_node;
> +	int ret, i;
> +	u32 res[2];
> +
> +	ret = of_property_read_u32_array(np, "reg", res, 2);
> +	if (ret < 0)
> +		return ret;

That's weird, why are we reading a reg property directly?  Not that we
ever look at the value we parsed...

> +static const struct of_device_id msm8916_wcd_analog_spmi_match_table[] = {
> +	{.compatible = "qcom,msm8916-wcd-analog-codec"},
> +	{}
> +};

Coding style, let's have somme spaces please.

--xP4xvRzdEG0QZ+Pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzqW1AAoJECTWi3JdVIfQtCQH/jkGuenV0rikC5qVKxL/Ergv
5xfJwJvy5yBfNZ6UclYQi/Q/Cf9fELZ4O4Ia2/AzHq4qDjUfe91/ItnhHAq8g1WT
1tU8q55xWGD3bI7I8E3EsPVqZswtbk33ChcJ12WuvedSwwMxsZboRy/wcyMQ8EYG
zy8Ntco3rI/alif3OgE3mjocwPTaCIi/AMk4TeCI4qbMeIhpMn2Fnhu6PG7+bySt
aT1iyklm/zDreDoYinOQ1OU0fOPui/vMYWJHzOsBaBdWeEEO72yr4rR29svspvmE
E8xL3/hnKOj/LReacGCUZ4OPtc+f26EYniGu90DUTqfoNn0Z88sr94/mlCIw9UM=
=6Igc
-----END PGP SIGNATURE-----

--xP4xvRzdEG0QZ+Pj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
