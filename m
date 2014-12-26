From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V3 07/10] ASoC: ipq806x: Add I2S PCM platform driver
Date: Fri, 26 Dec 2014 17:03:40 +0000
Message-ID: <20141226170340.GH17800@sirena.org.uk>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
 <1419439330-2303-8-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vxNpRqk6sR1V+qwt"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419439330-2303-8-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--vxNpRqk6sR1V+qwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 08:42:07AM -0800, Kenneth Westfield wrote:

> +static inline u32 lpass_lpaif_int_retrieve(struct snd_soc_platform *platform)
> +{
> +	struct lpass_mi2s_data *drvdata =
> +		snd_soc_platform_get_drvdata(platform);
> +	u32 status_offset = LPAIF_DMAIRQ_STAT(LPAIF_IRQ_RECV_HOST);
> +	u32 clear_offset = LPAIF_DMAIRQ_CLEAR(LPAIF_IRQ_RECV_HOST);
> +	u32 chan_bitmask = LPAIF_DMAIRQ_ALL(LPAIF_DMA_RD_CH_MI2S);
> +	u32 value;
> +
> +	value = readl(drvdata->base + status_offset);
> +	value &= chan_bitmask;
> +	writel(value, drvdata->base + clear_offset);
> +
> +	return value;
> +}

More of these tiny inline functions in this driver, and in this case
there's a definite readability problem since this is not just
"retrieve", it's reading and acking the interrupts which means that...

> +static irqreturn_t lpass_pcm_mi2s_irq(int irq, void *data)
> +{
> +	struct snd_pcm_substream *substream = data;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> +	struct lpass_mi2s_data *drvdata =
> +		snd_soc_platform_get_drvdata(soc_runtime->platform);
> +	u32 xrun_bitmask = LPAIF_DMAIRQ_XRUN(LPAIF_DMA_RD_CH_MI2S);
> +	u32 period_bitmask = LPAIF_DMAIRQ_PER(LPAIF_DMA_RD_CH_MI2S);
> +	u32 error_bitmask = LPAIF_DMAIRQ_ERR(LPAIF_DMA_RD_CH_MI2S);
> +	u32 pending;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	pending = lpass_lpaif_int_retrieve(soc_runtime->platform);
> +
> +	if (unlikely(pending & xrun_bitmask) && snd_pcm_running(substream)) {
> +		dev_warn(soc_runtime->dev, "%s: xrun warning\n", __func__);
> +		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +		pending &= ~xrun_bitmask;
> +		ret = IRQ_HANDLED;
> +	}

...all this code working out if we actually handled an interrupt might
be lying.

> +	if (pending & period_bitmask) {
> +		if (++drvdata->period_index >= runtime->periods)
> +			drvdata->period_index = 0;
> +		snd_pcm_period_elapsed(substream);
> +		pending &= ~period_bitmask;
> +		ret = IRQ_HANDLED;
> +	}

If we miss an interrupt then...

> +static snd_pcm_uframes_t lpass_pcm_mi2s_pointer(
> +		struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> +	struct lpass_mi2s_data *drvdata =
> +		snd_soc_platform_get_drvdata(soc_runtime->platform);
> +	snd_pcm_uframes_t offset;
> +
> +	offset = drvdata->period_index * runtime->period_size;
> +
> +	return offset >= (runtime->buffer_size) ? 0 : offset;
> +}

...this will be broken.  Why is the pointer operation not reading from
the hardware?

> +static struct snd_pcm_ops lpass_pcm_mi2s_soc_ops = {
> +	.open		= lpass_pcm_mi2s_open,
> +	.hw_params	= lpass_pcm_mi2s_hw_params,
> +	.hw_free	= lpass_pcm_mi2s_hw_free,
> +	.prepare	= lpass_pcm_mi2s_prepare,
> +	.mmap		= lpass_pcm_mi2s_mmap,
> +	.pointer	= lpass_pcm_mi2s_pointer,
> +	.ioctl		= snd_pcm_lib_ioctl,
> +};

Again the start and stopn are misplaced and should be in the trigger
like with other drivers.

> +static void lpass_pcm_mi2s_soc_free(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream =
> +		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> +	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
> +	struct lpass_mi2s_data *drvdata =
> +		snd_soc_platform_get_drvdata(soc_runtime->platform);
> +
> +	lpass_pcm_mi2s_free_buffer(pcm, SNDRV_PCM_STREAM_PLAYBACK);
> +
> +	disable_irq(drvdata->irqnum);
> +	free_irq(drvdata->irqnum, NULL);

This is weird, why the manual disable_irq()?

--vxNpRqk6sR1V+qwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUnZTrAAoJECTWi3JdVIfQhmUH/jAKoDUgn1Hhprb4T2fxI5OU
zKtSh4BuJgiURIkaImmPGErh0r05XfOIP+bvVYnLSykV4lI9rmFSu//CdMFjtB2g
v72mp0ct9JhOuC/z8HdoiZDpz+dJGLw2OzS59v3KOBv1YTByoYXCisnYM2Z5kHyK
ZCY90sMvBzwGDP1QRzkgYHfwWDZGGPccTa25rmpq7qUSQmER8+3lFlmX8rrwTZHP
rNHQxSJqe+tzTb11wACBaVnddmcHmY7pxgquQv9ctsyfGYUjeRxuOgrPi6eJ4rL7
Z2D69i49XbcO7y4D/HeQ749lf4TUc2bvhbNUtrqo9svgY+sSZUCFghXEWuJrRzA=
=WBVZ
-----END PGP SIGNATURE-----

--vxNpRqk6sR1V+qwt--
