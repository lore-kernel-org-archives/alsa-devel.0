From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: ipq806x: Add I2S PCM platform driver
Date: Tue, 25 Nov 2014 22:01:55 +0000
Message-ID: <20141125220155.GV7712@sirena.org.uk>
References: <1416423169-21865-6-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yHybtreh+GYqnN39"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-6-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--yHybtreh+GYqnN39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:45AM -0800, Kenneth Westfield wrote:

> +	.periods_min		=	LPASS_MI2S_NO_OF_PERIODS,
> +	.periods_max		=	LPASS_MI2S_NO_OF_PERIODS,

As Pierre said this is really odd - it appears to be just a single
possible value.

> +static irqreturn_t lpass_pcm_mi2s_irq(int intrsrc, void *data)
> +{
> +	int dma_ch;
> +	uint32_t ret = IRQ_NONE;
> +	uint32_t has_xrun, pending;
> +
> +	struct snd_pcm_substream *substream = data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;

Here we rely on runtime.

> +
> +	if (prtd) {
> +		dma_ch = prtd->lpaif_info.dma_ch;
> +	} else {
> +		pr_debug("%s: received interrupt w/o runtime\n", __func__);
> +		return IRQ_NONE;
> +	}

Here we print (as a debug message, not a dev_err()) an error saying we
lack a runtime (actually it's private data).

> +	if (unlikely(has_xrun) && substream->runtime &&
> +			snd_pcm_running(substream)) {

Here we check if runtime (which we already dereferenced) is non-NULL.

> +	if (pending & LPAIF_UNDER_CH(dma_ch)) {
> +		snd_pcm_period_elapsed(substream);
> +		pr_debug("%s: xrun warning\n", __func__);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	if (pending & LPAIF_ERR_CH(dma_ch)) {
> +		pr_debug("%s: Bus access warning\n", __func__);
> +		ret = IRQ_HANDLED;
> +	}

These errors should be logged as such.

> +static int lpass_pcm_mi2s_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct lpass_runtime_data_t *prtd = runtime->private_data;
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +	prtd->pcm_stream_info.pcm_prepare_start = 0;
> +	prtd->pcm_stream_info.period_index = 0;
> +	return 0;
> +}

This appears to ignore the params passed so hw_params() seems like the
wrong place - open()?

--yHybtreh+GYqnN39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPxTAAoJECTWi3JdVIfQ9q8H/iq1GkQ5MYXjHUOkPL3aLb2o
la2Wrr5upXrzmUBJvBdrUmVwYBfNjVLdoSa5kvoGUDm0evGWhB6O7ZfvBeHEhxUf
060OG5kyZk1i9XV25ENy+CM1mi0V4sgQon5kij+X4B0u3HnpOhx4HrMsRwZ9P1Nl
8dvHhcx0460JmljcnOglAe1UqW34fTkiJC3mpccyT98TTUZljWSlsoGgyPb50O5C
BkHwl+UuWnUgnxjrw3aJ681SBBbrNt6s0LGNaQe1MEE/XcGa5HkH66RFPolRnxsN
AFe93Zqv9mQ94r7o1z560FF6Ry/A/y0eWtJiiRGGSWsiJSfQjejGW44dZhnhfjs=
=vt2D
-----END PGP SIGNATURE-----

--yHybtreh+GYqnN39--
