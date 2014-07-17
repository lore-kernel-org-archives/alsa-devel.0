From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 2/3] ASoC: add es8328 codec driver
Date: Thu, 17 Jul 2014 20:57:09 +0100
Message-ID: <20140717195709.GI17528@sirena.org.uk>
References: <1405388494-21232-1-git-send-email-xobs@kosagi.com>
 <1405388494-21232-3-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ARHwKispuqSRPZ/2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405388494-21232-3-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ARHwKispuqSRPZ/2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 15, 2014 at 09:41:33AM +0800, Sean Cross wrote:

> Add a codec driver for the Everest ES8328.  It supports two separate audio
> outputs and two separate audio inputs.

This looks mostly fine so I've applied it, there are some issues below -
please send followups fixing them.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		reg = ES8328_DACCONTROL2;
> +
> +	else
> +		reg = ES8328_ADCCONTROL5;

Coding style, extra blank line in the middle of the if ().

> +	switch (params_rate(params)) {
> +	case 8000:
> +		val = es8328_sample_ratios[ES8328_RATE_8019];
> +		break;
> +	case 11025:
> +		val = es8328_sample_ratios[ES8328_RATE_11025];
> +		break;
> +	case 22050:
> +		val = es8328_sample_ratios[ES8328_RATE_22050];
> +		break;
> +	case 44100:
> +		val = es8328_sample_ratios[ES8328_RATE_44100];
> +		break;
> +	default:
> +		dev_err(codec->dev, "%s: unknown rate %d\n",
> +			 __func__, params_rate(params));
> +		return -EINVAL;
> +	}

The array serves no function given that you're never iterating over it
or anything - either have the array be a lookup table or just put the
constants in the switch statement directly.  You're also calling the
array "_sample_ratios" but it actually appears to be sample rates.

> +	snd_soc_write(codec, ES8328_MASTERMODE, ES8328_MASTERMODE_MSC);
> +
> +	clk_rate = clk_get_rate(es8328->clk);
> +	if (clk_rate == ES8328_SYSCLK_RATE_1X)
> +		snd_soc_write(codec, ES8328_MASTERMODE,
> +				ES8328_MASTERMODE_MSC);
> +	else
> +		snd_soc_write(codec, ES8328_MASTERMODE,
> +				ES8328_MASTERMODE_MCLKDIV2 |
> +				ES8328_MASTERMODE_MSC);

update_bits().

> +		snd_soc_write(codec, ES8328_CHIPPOWER,
> +				ES8328_CHIPPOWER_ADCDIG_OFF |
> +				ES8328_CHIPPOWER_DACDIG_OFF |
> +				ES8328_CHIPPOWER_ADCSTM_RESET |
> +				ES8328_CHIPPOWER_DACSTM_RESET |
> +				ES8328_CHIPPOWER_ADCPLL_OFF |
> +				ES8328_CHIPPOWER_DACPLL_OFF |
> +				ES8328_CHIPPOWER_ADCVREF_OFF |
> +				ES8328_CHIPPOWER_DACVREF_OFF);
> +		break;

This looks like most if not all of it should be in DAPM, especially the
DAC and ADC power - the device is wasting power on the ADC during
playback for example.  Looking at the code I suspect that some of these
should be done as supply widgets.

> +static int es8328_suspend(struct snd_soc_codec *codec)
> +{
> +	es8328_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}
> +
> +static int es8328_resume(struct snd_soc_codec *codec)
> +{
> +	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
> +
> +	regcache_mark_dirty(regmap);
> +	regcache_sync(regmap);
> +
> +	es8328_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	return 0;
> +}

But leave the regulators and clocks enabled?

--ARHwKispuqSRPZ/2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyCqRAAoJELSic+t+oim9zvAP/3Z0A/prp9QSsXtN12Qmit2Z
U0S9cBaKAScjCCUCV3KyPRx7n0jMpS/ZAzd7zkFBeKLom/R/nRPiJg+M40rlbeqn
VME3zexiL2Nz2iMnac/awnn0Or/25wCj3AqND5hLxIJwMLknCmO2kZkvMzt0PilP
0sR8PmRSFQZzMMWJMxIysShrmENki7K7nroqqNIrCT4EM68tfV79JvumR88EoMD3
neg2kbbJqHauH8OCKXnu/yg+SsglMLYLXVlQ7xnHLH+/BECAeBW/JugPHb05NEcb
mbpSkGraKcLsv54XZW+ReZq8h+Myncdqr4Bhjfpu/OQN+fUz3sQqb89Ioi/QALVE
A4X/tPFOR0OIHYv8KGdm46m3B9m3EONQzRPIVm32l6fk7zKIdg3RrAJ34YsyvVk1
E7SJwxM1XThgmWclkIVc04NwuY+ZBLvXxdlNNNrlZLeqf3koiX1e2Bw9XLWdbGi8
9kc+jxRbL5TpdQxNlfzgElXtZf3Zp0cA2rCP/jiUvtr4cnkIigy2DXuPVYckSVrP
ZDkcihjjq9fQEYoQVsFB/c6UaEVBbJ7I06Njn8rpgt+iBxuFTEzowKPGMCJGuDQj
dDNjZsiKH/AQZvIsak3TREwgzsGKC4EBCfhjt1iNmNa+UIDyBYi1QKEi5qEPAoWA
ujJRoSP0LVW0CT0LLnRr
=D4Et
-----END PGP SIGNATURE-----

--ARHwKispuqSRPZ/2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
