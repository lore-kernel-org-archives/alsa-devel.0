From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 05/11] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Tue, 9 Dec 2014 16:01:25 +0000
Message-ID: <20141209160125.GD1934@sirena.org.uk>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
 <1418076073-12623-6-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-6-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:01:07PM -0800, Kenneth Westfield wrote:

Please stop CCing Rob Herring's Calxeda address, it bounces.

> +	default:
> +		pr_err("%s: invalid bitwidth given: %u\n", __func__, bitwidth);
> +		return -EINVAL;
> +	}

Repeating again: dev_err().

> +	ret = lpass_lpaif_mi2s_channels(prtd, channels, bit_act);

> +	ret = lpass_lpaif_mi2s_bitwidth(prtd, bitwidth);

Just inline these helper functions, they're basically just abstracting a
single switch statement each which adds little if anything.

> +static int lpass_cpu_mi2s_daiops_hw_free(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	struct lpass_cpu_mi2s_data *prtd = snd_soc_dai_get_drvdata(dai);
> +
> +	if (prtd->mi2s_clocks_enabled) {
> +		clk_disable_unprepare(prtd->mi2s_osr_clk);
> +		clk_disable_unprepare(prtd->mi2s_bit_clk);
> +	}

This seems problematic, why is the clock being disabled here rather than
in a place matching that where it was enabled so we don't need to do
this checking.  I suspect you should be using a DAPM widget to manage
the clocks.

> +	prtd->irq_acquired = 0;

What is this supposed to do?  It looks write only.

> +#ifndef _LPASS_CPU_MI2S_H
> +#define _LPASS_CPU_MI2S_H
> +
> +enum pinctrl_pin_state {
> +	STATE_DISABLED = 0,
> +	STATE_ENABLED = 1
> +};
> +static const char *const pin_states[] = {"Disabled", "Enabled"};

This apppears to be the same pinctrl stuff you had in the Maxim CODEC
driver.  Similar issues with reproducing core pinctrl functionality
apply here too, and the fact that the code has been cut'n'pasted between
different drivers isn't a good sign.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhxzUAAoJECTWi3JdVIfQmfsH/j7iV2Aoj2FZElrbHmf9I92n
9L2IN5oq5atzr01yRjmkIz6wPIoygx+i4HeOzTT6RZU0QO/czgBFaIrGpckvc4+C
9pMflLYCpcwHFNUvpbGUil3J73kfyattn5LrzlcJ1WFTgDL8in087OxrOoSrRKPn
7QLIcU84veQTs2lPTfNRFBt8FnDZ1Xb8q3W7n+kiQTRC/jcSUhMC0NlatK0SaXxp
rbrk8vPjkeU7oAiPOKBq+hkfczQPCBOpOkixYTfqB7NSaQWvIDz14TpYq2CaBtw8
hUrdtLrCjr0SuJKyI/xrfqsxfAAyjiaoIeW8Rx+3kFD4RaN3gkeoMBleb/WuDb8=
=rQ1z
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
