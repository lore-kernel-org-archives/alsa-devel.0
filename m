From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: qcom: add apq8016 sound card support
Date: Tue, 2 Jun 2015 20:55:06 +0100
Message-ID: <20150602195506.GJ14071@sirena.org.uk>
References: <1432309956-5228-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432310047-5316-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3M7QbeJEF900HlmX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432310047-5316-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3M7QbeJEF900HlmX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 04:54:07PM +0100, Srinivas Kandagatla wrote:

> +	if (cpu_dai->id == MI2S_QUATERNARY) {
> +		/* Configure the Quat MI2S to TLMM */
> +		writel(readl(pdata->mic_iomux) |
> +			MIC_CTRL_QUA_WS_SLAVE_SEL_10 |
> +			MIC_CTRL_TLMM_SCLK_EN,
> +			pdata->mic_iomux);
> +
> +		return 0;
> +	} else if (cpu_dai->id == MI2S_PRIMARY) {

This looks like you're trying to write a switch statement.  It's also
somewhat unclear to me that this should be in a machine driver and not
in a CODEC/aux driver that gets pulled in by a machine driver, I can't
be entirely sure what this is controlling.

> +		if (of_property_read_bool(np, "external"))
> +			name = "HDMI";
> +
> +		else
> +			name = "Headset";

Coding style.  I'm also a bit concerned about the binding here -
headsets sound external too?

> +	card->dev = dev;
> +	data = apq8016_sbc_parse_of(card);

We parse the DT here and then...

> +	ret = snd_soc_of_parse_card_name(card, "qcom,model");
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error parsing card name: %d\n", ret);
> +		return ret;
> +	}

...this other bit of DT here.

> +	ret = devm_snd_soc_register_card(&pdev->dev, card);
> +	if (ret == -EPROBE_DEFER) {
> +		card->dev = NULL;
> +		return ret;
> +	} else if (ret) {
> +		dev_err(&pdev->dev, "Error registering soundcard: %d\n", ret);
> +		return ret;
> +	}

If setting card->dev does anything there something is broken, and in
general it's just better form to not special case probe deferral.

--3M7QbeJEF900HlmX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgoZAAoJECTWi3JdVIfQbt4H/Alva1Z2ZX9s7Qjg1LnWqift
3PGTRoao0q8yCRCSO9Uh2ROLTjZRQxf9Hfq1MGK6znbX8UVsy3SrQPhzIDB6DoDz
7tyJI7H6AhCz5AtilPKNzz7sb4fPWVpuPRxp+KKMNJseZqyQ5wTUckWw4jsQ2duk
zLB51a3qDcX2K58L8hiwhuiAg1PKMSfomROFMpyQnYpSXvmNAr67pt0LQbH2jTcs
smPQp6cnI1O9q6q6Su3L5TJUoxFDK5vZoMPMBwxv1jC+36jQGV2VbchDo/yTsfOR
Jgr6p5J5542WEVOSL/0ZeXU+d6VF4RgtGmx7r/CErWXxhTLStlwreBINxhhQci4=
=9/Fx
-----END PGP SIGNATURE-----

--3M7QbeJEF900HlmX--
