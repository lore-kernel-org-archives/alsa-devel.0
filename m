From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V4 07/10] ASoC: ipq806x: Add LPASS platform driver
Date: Sat, 7 Feb 2015 06:55:19 +0800
Message-ID: <20150206225519.GI31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-8-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xGGVyNQdqA79rdfn"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-8-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--xGGVyNQdqA79rdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:43PM -0800, Kenneth Westfield wrote:

> +	irqreturn_t ret = IRQ_NONE;
> +
> +	interrupts = ioread32(drvdata->lpaif + status_offset) & chan_bitmask;

Elsewhere we're using regmap...  why not here and how does this play
with regmap?

> +	if (likely(interrupts & period_bitmask)) {

In general it's better not to use likely() and unlikely() annotations
unless you've got some evidence that they actually improve things (which
should be explained somewhere).  They make the code that bit noisier and
there's some potential for them to cause the compiler to do unhelpful
things.

> +static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
> +		struct snd_soc_pcm_runtime *soc_runtime)
> +{
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	struct lpass_data *drvdata =
> +		snd_soc_platform_get_drvdata(soc_runtime->platform);
> +
> +	if (atomic_cmpxchg(&drvdata->lpm_lock, 0, 1)) {

cmpxchg() and atomics are both among the more error prone
synchronization primitives the kernel has.  In cases where it is
appropriate to use them it is very important that the code be entirely
clear about what is going on so that not only are we clear that the
concurrency handling is safe but we can also modify the code safely in
the future.

This driver has no documentation at all for this variable so we've at
least got a problem with the clarity side here.  Looking at the code
it's not entirely clear to me wat exactly is being protected or why
we're not using a simpler mechanism like variable protected by a mutex.

> +	return devm_snd_soc_register_platform(&pdev->dev,
> +			&lpass_platform_driver);
> +}
> +EXPORT_SYMBOL(asoc_qcom_lpass_platform_register);

ASoC APIs are all exported EXPORT_SYMBOL_GPL, their users should be too.

--xGGVyNQdqA79rdfn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1UZWAAoJECTWi3JdVIfQrgEIAIZkyBwhMfEkVqj+Rg2CuiJl
Qye/aQW5+D8UQC+jGP7o8sv3OV7pWnDu0qooW3FKCL5HNcUoOGnJWn2j6ILK0alk
UsHZOYcMySQ3tCtBXhWunXZT4OCGLB0klA01+ZeLJN7meU82qibA7gq6lst+anXK
1KNTwGjt150OkBzUfeSfI4O+fN8rH2o3unGykHwOUmze+S4kFiV7QucbLOphVzw4
3Q2c+72f7MjpYtqfepF1R2OQJyStXjtKnl5M1e8TtUSSm4yXP6qikbtGlQSnCI2t
DIZnhl7mauqErgQ9nx6Sc7UuebiPn577WM6HxRf4zIcp7qat4+PMG6S0Tv/45fo=
=m3gC
-----END PGP SIGNATURE-----

--xGGVyNQdqA79rdfn--
