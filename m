From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 5/6] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Fri, 28 Jul 2017 14:51:56 +0100
Message-ID: <20170728135156.ifdo2ev44eldrw4r@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zua3d3ddyezpwrpm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726003512.18965-6-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zua3d3ddyezpwrpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2017 at 02:35:11AM +0200, srinivas.kandagatla@linaro.org wrote:

> +	if (wcd->hphl_jack_type_normally_open)
> +		plug_type = CDC_A_HPHL_PLUG_TYPE_NO;
> +
> +	if (wcd->gnd_jack_type_normally_open)
> +		plug_type |= CDC_A_GND_PLUG_TYPE_NO;

It'd be clearer to use |= consistently, this is just confusing as it
makes it look like there's a path where things aren't initialized.

> +	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
> +				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
> +
> +	if (!btn_result)
> +		priv->mbhc_btn0_pressed = false;
> +
> +	snd_jack_report(priv->jack->jack, 0);

This checks to see if the read worked, uses it to decide if it should
clear the button pressed flag but unconditionally reports that the
button is not pressed.  It also discards the read error if there was one
without reporting that.  This needs cleanup.

> +	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
> +				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
> +
> +	switch (btn_result) {
> +	case 0xf:
> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_4);
> +		break;
> +	case 0x7:
> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_3);
> +		break;
> +	case 0x3:
> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_2);
> +		break;
> +	case 0x1:
> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_1);
> +		break;
> +	case 0:
> +		priv->mbhc_btn0_pressed = true;
> +		snd_jack_report(priv->jack->jack, SND_JACK_BTN_0);
> +		break;
> +	}

Here we silently ignore any value we get back from the chip that we
didn't expect and all read errors.

> +struct msm8916_wcd_mbhc_data {
> +	/* Voltage threshold when internal current source of 100uA is used */
> +	int vref_btn_cs[MBHC_MAX_BUTTONS];
> +	/* Voltage threshold when microphone bias is ON */
> +	int vref_btn_micb[MBHC_MAX_BUTTONS];
> +};

I'd expect to see some mechanism for configuring the threasholds via DT,
not all vendors use the same specs for resistive buttons.

--zua3d3ddyezpwrpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7QXsACgkQJNaLcl1U
h9BsqQf+NtJ0i6gpHcm7nRGMwVhegb4Zj5s5T/r7mDiNymNmRu1mpvMIjSXqELLH
WwAzz9VPhzCjcTZ6zmYC+2i5xFQZOu4QYy/8QU58DwyPH0ianX9ARxf87wIb8Wje
m7/+6U1mTACITOjcuSLUjGrDknqZUiiFlJcN0zYnZY1TOBG7C6O/cbaZByjQvDFD
PEd7OQ4t7o1G23ztjuGqgwpo7l0VgBVydr+jpcbJmc8qvCeII2c4Ye+q0NB6SLR2
gnNViBPmfIvl2pQWCwbbY4MIfd0zvLtJfEshmr9IoQSMrP+mLUhLMNAN4XgeAd4Z
WofJR6KWfEEuIIZ2+PrcrHDDfNLrHA==
=rCt+
-----END PGP SIGNATURE-----

--zua3d3ddyezpwrpm--
