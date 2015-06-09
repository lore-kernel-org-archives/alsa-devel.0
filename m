From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/2] ASoC: qcom: add apq8016 sound card support
Date: Tue, 9 Jun 2015 18:07:38 +0100
Message-ID: <20150609170738.GI14071@sirena.org.uk>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gtHcOevdugseuBBz"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--gtHcOevdugseuBBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 01:59:36PM +0100, Srinivas Kandagatla wrote:

> +	if (cpu_dai->id == MI2S_QUATERNARY) {
> +		/* Configure the Quat MI2S to TLMM */
> +		writel(readl(pdata->mic_iomux) |
> +			MIC_CTRL_QUA_WS_SLAVE_SEL_10 |
> +			MIC_CTRL_TLMM_SCLK_EN,
> +			pdata->mic_iomux);
> +
> +		return 0;
> +	} else if (cpu_dai->id == MI2S_PRIMARY) {
> +		writel(readl(pdata->spkr_iomux) |
> +			SPKR_CTL_PRI_WS_SLAVE_SEL_11,
> +			pdata->spkr_iomux);
> +
> +		return 0;
> +	}

Why not just do these one time at probe, we don't undo them when we shut
the DAI down?

> +
> +	dev_err(card->dev, "unsupported cpu dai configuration\n");
> +
> +	return -EINVAL;

It'd be clearer if this were part of the above code (which should still
be written as a switch statement) - I was just asking myself what
happens if we fall off the end of the if/else chain.

> +		/**
> +		 * External codec is ADV7533
> +		 * and internal codec digital part is inside apq8016
> +		 * and analog part is in PMIC PM8916
> +		 **/
> +		if (of_property_read_bool(np, "external"))
> +			name = "ADV7533";
> +		else
> +			name = "WCD";

If this is all the property is doing why not just put a link name
property in the DT rather than this?  That makes the driver a bit more
general and is more idiomatic.

> +		dai_link->name = dai_link->stream_name = name;

Write two assignment statements, it's clearer and more idiomatic.

--gtHcOevdugseuBBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdx1ZAAoJECTWi3JdVIfQxFgH/jzNcFHvXyGnxqHPImTkc0q2
/o2hYvRa049axJM0b/OYPL8lGfGM+Hlaf1J6lynKb012CZWyraAsj9rZkK+K0vSs
ruPFIdiiYHRhxcCSPbxh+oPIZA+BUrezGS6HnKnClIo5S0j37T7nxT0aSPhvet+k
/4ja1MpjppB+5xYtTr58eJKFi9R2AuvlR7QoKrxDVSvXrGOqqUT5DkyJilorSJFa
xRYJd4Rzq8zX8U08a16SsdOvrcXFCTQcUEmSIfApS/YqJd9yCsWbxA2G0OERxucR
M9hDaxRg3dBwnYO80NDvrCDLusDCx7eoAvdJkbtmpR/x1snn0TSHopgQpES0Ngo=
=WHZu
-----END PGP SIGNATURE-----

--gtHcOevdugseuBBz--
