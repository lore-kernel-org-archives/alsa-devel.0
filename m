From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 04/11] ASoC: codec: Add Maxim codec driver
Date: Tue, 9 Dec 2014 15:53:16 +0000
Message-ID: <20141209155316.GC1934@sirena.org.uk>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
 <1418076073-12623-5-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-5-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:01:06PM -0800, Kenneth Westfield wrote:

> +enum pinctrl_pin_state {
> +	STATE_DISABLED = 0,
> +	STATE_ENABLED = 1
> +};
> +static const char * const pin_states[] = {"Disabled", "Enabled"};

This looks like you are trying to reimplement some of the generic
support provided by the pinctrl framework - please don't do that.  It
looks like you should be using the standard idle and default states.

However I'm also questioning why this device is using pinctrl at all.
As far as I can see from the code it's a dumb external device with just
an enable control and hence no pin control support so it's not a device
I'd expect to have any pinmux to control.  Why is it doing this?  There
are also substantial problems throughout the relevant code but probably
the best thing is just to remove it all.

> +static int max98357a_codec_set_pinctrl(struct max98357a_codec_pinctrl *mi2s)
> +{
> +	int ret;
> +
> +	pr_debug("%s: curr_state = %s\n", __func__,
> +			pin_states[mi2s->curr_state]);

To repeat my previous review comments: use dev_ prints.

> +static struct snd_soc_dai_driver max98357a_codec_dai_driver = {
> +	.name = "max98357a-codec-dai",
> +	.playback = {
> +		.stream_name	= "max98357a-codec-playback",
> +		.formats	= SNDRV_PCM_FMTBIT_S16 |
> +					SNDRV_PCM_FMTBIT_S24 |
> +					SNDRV_PCM_FMTBIT_S32,
> +		.rates		= SNDRV_PCM_RATE_8000 |
> +					SNDRV_PCM_RATE_16000 |
> +					SNDRV_PCM_RATE_48000 |
> +					SNDRV_PCM_RATE_96000,
> +		.rate_min	= 8000,
> +		.rate_max	= 96000,
> +		.channels_min	= 1,
> +		.channels_max	= 2,
> +	},
> +	.probe = &max98357a_codec_dai_probe,
> +	.ops = &max98357a_codec_dai_ops,
> +};

This CODEC driver has no DAPM support.  I'm surprised this works at all,
it's certainly not OK for upstream - you need to implement at least stub
DAPM support.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhxrsAAoJECTWi3JdVIfQ8X4H/i4fSGBvm9fGNjym3uH2IHMK
KSWc3olcgViAL9Ku0wYttDkYswRTsUTes5LHnlyXo4mC6qN+KnWOADNWAYfK9xNm
IYfGimsHjJfUOAYqm49z+dzgHOQfGx31BQC8yOO6+VIuI0Dl0KbmtD5Lq8lPwY8D
D+iUJklKKHlgiVHGqFCrQjv6/xAtxAy230HwVO5wqbYGLbMtJFZPtfXH8EHXKdxy
6fzk4ogvFXqAQ5enwVCIk/y/kSMKgZpRGqeBTuDaY8Q0llq4PvaBJY6K7gQ8tjfg
ciz2rmXIpxoD4bpPmwDlZDFBxvVqb3CagHPprakL7fY9HLploGoJ5JWLlgE/1D0=
=KFBo
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
