From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: atmel-classd: add the Audio Class D Amplifier
 code
Date: Thu, 3 Sep 2015 12:37:16 +0100
Message-ID: <20150903113716.GU12027@sirena.org.uk>
References: <1441086101-15303-1-git-send-email-songjun.wu@atmel.com>
 <1441086101-15303-2-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FStV/iabqQx856sH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441086101-15303-2-git-send-email-songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Songjun Wu <songjun.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--FStV/iabqQx856sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 01, 2015 at 01:41:40PM +0800, Songjun Wu wrote:

> +static const char * const mono_text[] = {
> +	"stereo", "mono"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(classd_mono_enum,
> +			CLASSD_INTPMR, CLASSD_INTPMR_MONO_SHIFT,
> +			mono_text);

This looks like it should be a simple Switch control called something
like "Stereo Switch" or "Mono Switch".

> +static const char * const deemp_text[] = {
> +	"disabled", "enabled"
> +};
> +
> +static SOC_ENUM_SINGLE_DECL(classd_deemp_enum,
> +			CLASSD_INTPMR, CLASSD_INTPMR_DEEMP_SHIFT,
> +			deemp_text);

Similarly this looks like it should be "Deemph Switch".

> +static const char * const eqcfg_bass_text[] = {
> +	"-12 dB", "-6 dB", "0 dB", "+6 dB", "+12 dB"
> +};

> +static const unsigned int eqcfg_bass_value[] = {
> +	CLASSD_INTPMR_EQCFG_B_CUT_12,
> +	CLASSD_INTPMR_EQCFG_B_CUT_6, CLASSD_INTPMR_EQCFG_FLAT,
> +	CLASSD_INTPMR_EQCFG_B_BOOST_6, CLASSD_INTPMR_EQCFG_B_BOOST_12
> +};

This should be a Volume control with TLV information, as should the
following few controls.

> +static const struct snd_kcontrol_new atmel_classd_snd_controls[] = {
> +SOC_SINGLE_TLV("Left Volume", CLASSD_INTPMR,
> +		CLASSD_INTPMR_ATTL_SHIFT, 78, 1, classd_digital_tlv),
> +
> +SOC_SINGLE_TLV("Right Volume", CLASSD_INTPMR,
> +		CLASSD_INTPMR_ATTR_SHIFT, 78, 1, classd_digital_tlv),

This should be a single stereo control rather than separate left and
right controls.

> +static const char * const pwm_type[] = {
> +	"single-ended", "differential"
> +};

The normal style for ALSA controls is to capitalise strings so
"Single ended" and "Differential".

> +	if (pdata->non_overlap_enable) {
> +		val |= (CLASSD_MR_NON_OVERLAP_EN
> +			<< CLASSD_MR_NON_OVERLAP_SHIFT);
> +
> +		mask |= CLASSD_MR_NOVR_VAL_MASK;
> +		switch (pdata->non_overlap_time) {
> +		case 5:
> +			val |= (CLASSD_MR_NOVR_VAL_5NS
> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
> +			break;
> +		case 10:
> +			val |= (CLASSD_MR_NOVR_VAL_10NS
> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
> +			break;
> +		case 15:
> +			val |= (CLASSD_MR_NOVR_VAL_15NS
> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
> +			break;
> +		case 20:
> +			val |= (CLASSD_MR_NOVR_VAL_20NS
> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
> +			break;
> +		default:
> +			val |= (CLASSD_MR_NOVR_VAL_10NS
> +				<< CLASSD_MR_NOVR_VAL_SHIFT);
> +			break;
> +		}

I'd expect at least a warning if the user trys to specify an invalid
value (if they didn't specify any value then I'd expect the DT parsing
function to assign the default value).

> +static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
> +{
> +	struct atmel_classd *dd = dev_get_drvdata(dev);
> +
> +	return dd->regmap;
> +}

Can you just use dev_get_regmap()?

> +static int atmel_classd_codec_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *codec_dai)
> +{
> +	struct atmel_classd *dd = snd_soc_dai_get_drvdata(codec_dai);
> +
> +	clk_prepare_enable(dd->aclk);
> +	clk_prepare_enable(dd->gclk);

Should check for errors here.

> +	dev_info(dev,
> +		"Atmel Class D Amplifier (CLASSD) device at 0x%p (irq %d)\n",
> +		io_base, dd->irq);

This is a bit noisy and not really based on interaction with the
hardware...  dev_dbg() seems better.

--FStV/iabqQx856sH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV6DDoAAoJECTWi3JdVIfQp4UH/R13DZen1lTRfy7fR6vz5XWn
C/Y+r/QulvRpfNf4pzZNDEMKJ6cdKbzOMyvPvA6FfasMVwm9wjPfgb00DbKTJ9NS
FFGbLBNrboqX9XydhDB2eenxBFqaUJwnyZdPAnZU1xj1WaCv2KhUoLRMIidm9g/v
kmrK1JV9GHVkjZfjYIsUP9OkYgB5ckQqm3fMvVi64m/fXMT1xSOJYX++MfIlRK/x
R3VTRTxVSTbRoCJF2GvD4xljsNf5jia94mX3A2QSAkCktLfIgg2HRHkVG7XDUTar
0/vO7wdC1bMLDWs3cnmUpXlRfz+ohGX4eq2xVZXZ3AGJqILp+xFxHvIMnB6IHvg=
=vkfw
-----END PGP SIGNATURE-----

--FStV/iabqQx856sH--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
