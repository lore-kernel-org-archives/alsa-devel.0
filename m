From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Tue, 25 Nov 2014 21:53:42 +0000
Message-ID: <20141125215342.GU7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e7QQlpvAaNXS6X0y"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-5-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--e7QQlpvAaNXS6X0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:44AM -0800, Kenneth Westfield wrote:

> +	if (channels == 8) {
> +		if (bit_width == 24 &&
> +			((samp_freq != 176400) &&
> +			(samp_freq != 192000)))
> +			return 2;
> +		return 1;

Coding style - there's more brackets than are needed coupled with some
strange indentation (eg, the second samp_freq line being indented to the
outside bracket when it's still within that bracket).  Use of switch
statements would probably help, at least on channels.

> +static int lpass_cpu_mi2s_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params,
> +					struct snd_soc_dai *dai)
> +{
> +	uint32_t ret = 0;
> +	uint32_t bit_act;
> +	uint16_t bit_div;
> +	uint32_t bit_width = params_format(params);
> +	uint32_t channels = params_channels(params);
> +	uint32_t rate = params_rate(params);
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +	struct mi2s_hw_params curr_params;
> +
> +	bit_act = snd_pcm_format_width(bit_width);
> +	if (bit_act == LPASS_INVALID) {

snd_pcm_format_width() returns an error code on error, LPASS_INVALID is
not an error code.  Check the return value for error codes...

> +		dev_err(dai->dev, "%s: Invalid bit width given\n", __func__);
> +		return -EINVAL;

...and just return them.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		/* disable SPKR to make sure it will start in sane state */
> +		lpaif_cfg_i2s_playback(0, 0, LPAIF_MI2S);

Shouldn't we be doing this on probe and/or resume if it's required?

> +
> +		/*
> +		 * Set channel info, it will take effect only if SPKR is
> +		 * enabled
> +		 */
> +		ret = lpaif_cfg_mi2s_playback_hwparams_channels(channels,
> +						LPAIF_MI2S, bit_act);
> +	} else {
> +		dev_err(dai->dev, "%s: Invalid stream direction\n", __func__);
> +		return -EINVAL;
> +	}

If the device only supports playback no need to have any conditional
code here, the core will prevent capture being started.

> +	ret = clk_set_rate(lpaif_mi2s_osr_clk,
> +		(rate * bit_act * channels * bit_div));
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in setting mi2s osr clk\n",
> +				__func__);
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(lpaif_mi2s_osr_clk);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in enabling mi2s osr clk\n",
> +				__func__);
> +		return ret;
> +	}
> +	prtd->lpaif_clk.is_osr_clk_enabled = 1;

Coding style, more blank lines between blocks here.  Also not clear why
we're tracking if the clock is enabled when we do it unconditonally.

> +static int lpass_cpu_mi2s_prepare(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Remove empty functions.

> +static int lpass_cpu_mi2s_startup(struct snd_pcm_substream *substream,
> +					struct snd_soc_dai *dai)
> +{
> +
> +	lpaif_mi2s_osr_clk = clk_get(dai->dev, "mi2s_osr_clk");
> +	if (IS_ERR(lpaif_mi2s_osr_clk)) {
> +		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
> +				__func__);
> +		return PTR_ERR(lpaif_mi2s_osr_clk);
> +	}

No, request resources in probe().  That way deferred probe works and we
don't get mysterious errors at runtime if things go wrong.

--e7QQlpvAaNXS6X0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPplAAoJECTWi3JdVIfQmPgH/AgJcwctbPFljgqASvsSRgz4
EgJfUKA+0q/jHStT4NljEqLJfCdcS2lYv/nJmEu+mjWnSZ0FBpmAln1fWCAf7+YX
+cqAzXcgafwNftdQ7Ss+m9AS1r0gNhNKdHFtZZKXSldaJL5+27McRAlS8i/6WZDZ
dE6kVHDjdue1qePo5ve31DChUV+KRZrKkBveoJRbVuE3+UUla8B9/ZJCCT9Q1Sv0
7eD9EDtoKlnXw8p89kLQhM5IGYSxilKPOofLQqF3oqBY740yoPgXwlk1fL0xB5Nd
pcNcEXlYkueY92HQCualexrvtewI6FPuI6kTpeLbHXVK/PcvXmOOErU9zRpzzyg=
=mdCi
-----END PGP SIGNATURE-----

--e7QQlpvAaNXS6X0y--
