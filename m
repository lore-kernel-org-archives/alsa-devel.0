From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/6] ASoC: codecs: Add msm8916-wcd digital codec
Date: Tue, 6 Sep 2016 12:24:56 +0100
Message-ID: <20160906112456.GN3950@sirena.org.uk>
References: <1473155865-13361-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1473155865-13361-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iRy0ocDzxpWaNtI5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473155865-13361-3-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--iRy0ocDzxpWaNtI5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 06, 2016 at 10:57:41AM +0100, Srinivas Kandagatla wrote:

> +static const struct soc_enum rx_mix2_inp1_chain_enum =
> +SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B3_CTL, 0, 3, rx_mix2_text);

Indentation again.

> +	case SND_SOC_DAPM_PRE_PMU:
> +		if (++msm8916_wcd->dmic_clk_cnt == 1) {
> +			snd_soc_update_bits(codec, dmic_clk_reg,

This looks like you're open coding a supply widget.

> +		if (dmic == 1)
> +			snd_soc_update_bits(codec, LPASS_CDC_TX1_DMIC_CTL,
> +					    TXN_DMIC_CTL_CLK_SEL_MASK,
> +					    TXN_DMIC_CTL_CLK_SEL_DIV3);
> +		if (dmic == 2)
> +			snd_soc_update_bits(codec, LPASS_CDC_TX2_DMIC_CTL,
> +					    TXN_DMIC_CTL_CLK_SEL_MASK,
> +					    TXN_DMIC_CTL_CLK_SEL_DIV3);

This looks like you want a switch statement.

> +static int msm8916_wcd_digital_enable_clock_block(struct snd_soc_codec
> +						  *codec, int enable)
> +{

> +static int msm8916_wcd_digital_codec_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Remove empty functions.

> +static int msm8916_wcd_digital_startup(struct snd_pcm_substream *substream,
> +				       struct snd_soc_dai *dai)
> +{
> +	msm8916_wcd_digital_enable_clock_block(dai->codec, 1);
> +	return 0;
> +}
> +
> +static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
> +					 struct snd_soc_dai *dai)
> +{
> +	msm8916_wcd_digital_enable_clock_block(dai->codec, 0);
> +}

Two problems here: one is that the power management should be in DAPM,
the other is that the _enable_clock_block() function is totally
pointless - it has only these two call locations and there is absolutely
no shared code between the enable and disable paths so they should just
be inlined.

> +static int msm8916_wcd_digital_remove(struct platform_device *pdev)
> +{
> +	struct msm8916_wcd_digital_priv *priv = dev_get_drvdata(&pdev->dev);
> +
> +	clk_disable_unprepare(priv->mclk);
> +	clk_disable_unprepare(priv->ahbclk);
> +	snd_soc_unregister_codec(&pdev->dev);

This is disabling the clocks while the CODEC is still registered and
might be in use, you should unregister first.

> +static const struct of_device_id msm8916_wcd_digital_match_table[] = {
> +	{.compatible = "qcom,msm8916-wcd-digital-codec"},
> +	{}

Spaces please.

> +static struct platform_driver msm8916_wcd_digital_driver = {
> +	.driver = {
> +		   .name = "msm8916-wcd-digital-codec",
> +		   .of_match_table = msm8916_wcd_digital_match_table,
> +		   },

Please line up the }.

--iRy0ocDzxpWaNtI5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXzqeHAAoJECTWi3JdVIfQk0UH/0sZ3pRYFl6RwM9WJrZQ1vsm
KnJKIJfZBUgiV++hddaRMaao0spTBScTCvJruzzZCzhc8uS/9KtG4pLu/nwOfM4Q
bmHEzrxew/L/G7/AdtS1o5RtDyjeCKWdlL8p/4YQXjfLRhIn8B573CFr4KfR8APB
RxZWIMY+BZ+6JM/3v4O83ZPTa4kNQX9PSFLJFfQmYwI7FYYgHe8rZhFlExj5HA3o
WsCOAc99xwuaXJuLG4zr5cycVBqs4OBjD7Sw1G1ywhLNJO4CjgtIvmx2bv8GMIDm
CEMwDkvMXE2kEfsbXMb0wUOWQqHhZqDy9ZGMdJne/t69AJpYL+dRLC1fEVU5NDk=
=9P5h
-----END PGP SIGNATURE-----

--iRy0ocDzxpWaNtI5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
