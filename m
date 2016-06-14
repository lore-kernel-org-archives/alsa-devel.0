From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: msm8916: Add msm8916-wcd codec driver
Date: Tue, 14 Jun 2016 16:59:38 +0100
Message-ID: <20160614155938.GS2282@sirena.org.uk>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="en9/O5YN3eJ0yPaf"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--en9/O5YN3eJ0yPaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2016 at 07:18:45PM +0100, Srinivas Kandagatla wrote:

> +config SND_SOC_MSM8916_WCD
> +	tristate "Qualcomm MSM8916 WCD"
> +	depends on SPMI && MFD_SYSCON
> +

Normally users select MFD_SYSCON.

> @@ -208,7 +209,6 @@ snd-soc-wm9705-objs := wm9705.o
>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> -
>  # Amp
>  snd-soc-max9877-objs := max9877.o
>  snd-soc-tpa6130a2-objs := tpa6130a2.o

Spurious whitespace change.

> +#include "msm8916-wcd-registers.h"
> +#include "msm8916-wcd.h"
> +#include "dt-bindings/sound/msm8916-wcd.h"

What's in here?  There weren't any constants in the bindings.

> +struct msm8916_wcd_chip {
> +	struct regmap *analog_map;
> +	struct regmap *digital_map;
> +	unsigned int analog_offset;
> +	u16 pmic_rev;
> +	u16 codec_version;

Why is this one device and not two devices?  The description indicated
that this was two separate bits of silicon.

> +static int msm8916_wcd_write(struct snd_soc_codec *codec, unsigned int reg,
> +			     unsigned int val)
> +{
> +	int ret = -EINVAL;
> +	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
> +	u8 *cache = codec->reg_cache;
> +
> +	if (!msm8916_wcd_reg_readonly[reg])
> +		cache[reg] = val;

Why is the driver open coding a cache?  Don't do that!

> +	case SND_SOC_DAPM_POST_PMU:
> +		if (w->shift == 5)
> +			snd_soc_update_bits(codec, LPASS_CDC_RX1_B6_CTL,
> +					    RXn_B6_CTL_MUTE_MASK, 0);
> +		else if (w->shift == 4)
> +			snd_soc_update_bits(codec, LPASS_CDC_RX2_B6_CTL,
> +					    RXn_B6_CTL_MUTE_MASK, 0);

Switch statement.

> +	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
> +	if (!widget_name)
> +		return -ENOMEM;
> +	temp = widget_name;
> +
> +	dec_name = strsep(&widget_name, " ");
> +	widget_name = temp;
> +	if (!dec_name) {
> +		dev_err(codec->dev, "Invalid decimator = %s\n", w->name);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	dec_num = strpbrk(dec_name, "12");
> +	if (dec_num == NULL) {
> +		dev_err(codec->dev, "Invalid Decimator\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = kstrtouint(dec_num, 10, &decimator);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Invalid decimator = %s\n", dec_name);
> +		ret = -EINVAL;
> +		goto out;
> +	}

I'm not terribly clear what this is doing, it probably needs some
comments explaining what's going on at the very least.

> +	/*RX stuff */
> +	SND_SOC_DAPM_AIF_IN("I2S RX1", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("I2S RX2", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("I2S RX3", "AIF1 Playback", 0, SND_SOC_NOPM, 0, 0),

Use DAPM routes to connect the widgets in, don't name the DAI in the
widget.

> +		mclk_rate = clk_get_rate(msm8916_wcd->mclk);
> +
> +		if (mclk_rate == 12288000)
> +			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
> +					    TOP_CTL_DIG_MCLK_FREQ_MASK,
> +					    TOP_CTL_DIG_MCLK_FREQ_F_12_288MHZ);
> +
> +		else if (mclk_rate == 9600000)
> +			snd_soc_update_bits(codec, LPASS_CDC_TOP_CTL,
> +					    TOP_CTL_DIG_MCLK_FREQ_MASK,
> +					    TOP_CTL_DIG_MCLK_FREQ_F_9_6MHZ);

Switch statement, and this should also handle unexpected rates.

> +static int msm8916_wcd_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct msm8916_wcd_chip *chip = dev_get_drvdata(codec->dev);
> +	int err, reg;
> +
> +	err = regulator_enable(chip->vddio);
> +	if (err < 0) {
> +		dev_err(codec->dev,
> +			"failed to enable VDDIO regulator (%d)\n", err);
> +		return err;
> +	}
> +
> +	err = regulator_enable(chip->vdd_tx_rx);
> +	if (err < 0) {
> +		dev_err(codec->dev,
> +			"failed to enable VDD_TX_RX regulator (%d)\n", err);
> +		regulator_disable(chip->vddio);
> +		return err;
> +	}

Why is this not using regulator_bulk_enable()?  I'd also expect to see
most if not all of this initial setup stuff in the main device probe.

> +	if (TOMBAK_IS_1_0(chip->pmic_rev)) {
> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults); reg++)
> +			snd_soc_write(codec, wcd_reg_defaults[reg].reg,
> +				      wcd_reg_defaults[reg].val);
> +	} else {
> +		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
> +			snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
> +				      wcd_reg_defaults_2_0[reg].val);
> +	}

Please reset the chip properly.

> +	ret = clk_prepare_enable(chip->mclk);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable mclk %d\n", ret);
> +		return ret;
> +	}

Runtime PM?

> +static const struct of_device_id msm8916_wcd_match_table[] = {
> +	{.compatible = "qcom,msm8916-pmic-wcd-codec"},
> +	{}
> +};

We were peering inside the parent for the register map, why does this
appear in the device tree as a separate device?  Both the patch
description and that code suggest that it doesn't really have a separate
existence independent of the broader IP.

--en9/O5YN3eJ0yPaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYCnpAAoJECTWi3JdVIfQxqEH/3yWp8YCZbf6h/7YY1R0gr0e
DNtI6guoUhDlwOytJLd4pGeHyvT/KkMQauFVhY8SsdhYlCL7fhexhsW419h4fZnx
1BYmmMSw4cqpl9voGqWq6Qr7znDf1W6d4y11RCFTX+3o6jpq4qhiLkKCmvdym3T5
6wew13Wb87MN1GeWDvD2kL/M1GBAZTBX1VQ//yXsdXbkC+l8rG9qHPQGGWJruv/4
B5HEltKBiPN35ACVCUgb+ciLml1ZYApzclNixMq27QSx/bbZhIZRZNAoZ2wzxx7L
MqPcSpWQd1mf7R1CI5NFw06nagwIgo+IUmMU/5Ce+rtNYfRZXjHbk3aX0Htj2Lo=
=Ra9W
-----END PGP SIGNATURE-----

--en9/O5YN3eJ0yPaf--
