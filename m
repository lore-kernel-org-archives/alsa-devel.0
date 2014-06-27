From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Fri, 27 Jun 2014 16:31:43 +0100
Message-ID: <20140627153143.GP23300@sirena.org.uk>
References: <1402028138-27444-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6897553198743385346=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 183B6265324
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 17:32:03 +0200 (CEST)
In-Reply-To: <1402028138-27444-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6897553198743385346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VsILLG6PYTzZlkGF"
Content-Disposition: inline


--VsILLG6PYTzZlkGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 12:15:38PM +0800, bardliao@realtek.com wrote:

> This patch adds a minimum support of Realtek ALC5670 codec.

This looks good overall, there are a few issues I've identified below
but they're relatively small.

> +	/* IN1/IN2 Control */
> +	SOC_SINGLE_TLV("IN1 Boost", RT5670_CJ_CTRL1,
> +		RT5670_BST_SFT1, 8, 0, bst_tlv),
> +	SOC_SINGLE_TLV("IN2 Boost", RT5670_IN2,
> +		RT5670_BST_SFT1, 8, 0, bst_tlv),

Boost Volume.

> +	/* ADC Boost Volume Control */
> +	SOC_DOUBLE_TLV("STO1 ADC Boost Gain", RT5670_ADC_BST_VOL1,
> +			RT5670_STO1_ADC_L_BST_SFT, RT5670_STO1_ADC_R_BST_SFT,
> +			3, 0, adc_bst_tlv),
> +	SOC_DOUBLE_TLV("STO2 ADC Boost Gain", RT5670_ADC_BST_VOL1,
> +			RT5670_STO2_ADC_L_BST_SFT, RT5670_STO2_ADC_R_BST_SFT,
> +			3, 0, adc_bst_tlv),

s/Gain/Volume/

> +static int check_dac_monor_asrc_source(struct snd_soc_dapm_widget *source,
> +			 struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_codec *codec = source->codec;
> +
> +	return is_using_asrc(codec, RT5670_ASRC_2, 4);
> +}

I have to say I'm not convinced all these wrapper functions are really
adding much - just making is_using_asrc() take a widget and passing the
arguments directly seems as simple.

> +	/* ASRC */
> +	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5670_ASRC_1,
> +			      11, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5670_ASRC_1,
> +			      12, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5670_ASRC_1,
> +			      10, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("DAC MONO L ASRC", 1, RT5670_ASRC_1,
> +			      9, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("DAC MONO R ASRC", 1, RT5670_ASRC_1,
> +			      8, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5670_ASRC_1,
> +			      3, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5670_ASRC_1,
> +			      2, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("ADC MONO L ASRC", 1, RT5670_ASRC_1,
> +			      1, 0, NULL, 0),
> +	SND_SOC_DAPM_SUPPLY_S("ADC MONO R ASRC", 1, RT5670_ASRC_1,
> +			      0, 0, NULL, 0),

These are all _S but they seem not to have different sequence numbers -
do they really need to be _S.

> +	/* Input Side */
> +	/* micbias */
> +	SND_SOC_DAPM_MICBIAS("MICBIAS1", RT5670_PWR_ANLG2,
> +			     RT5670_PWR_MB1_BIT, 0),

Modern drivers should use supply widgets for MICBIAS.

> +static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
> +	{ "adc stereo1 filter", NULL, "ADC STO1 ASRC",
> +					check_adc_sto1_asrc_source },
> +	{ "adc stereo2 filter", NULL, "ADC STO2 ASRC",
> +					check_adc_sto2_asrc_source },
> +	{ "adc mono left filter", NULL, "ADC MONO L ASRC",
> +					check_adc_monol_asrc_source },
> +	{ "adc mono right filter", NULL, "ADC MONO R ASRC",
> +					check_adc_monor_asrc_source },
> +	{ "dac mono left filter", NULL, "DAC MONO L ASRC",
> +					check_dac_monol_asrc_source },
> +	{ "dac mono right filter", NULL, "DAC MONO R ASRC",
> +					check_dac_monor_asrc_source },
> +	{ "dac stereo1 filter", NULL, "DAC STO ASRC",
> +					check_dac_sto_asrc_source },
> +
> +	{"I2S1", NULL, "I2S1 ASRC"},

Coding style here is a bit inconsistent, and normally widget names are
capitalised.

> +	switch (dai->id) {
> +	case RT5670_AIF1:
> +		snd_soc_update_bits(codec, RT5670_I2S1_SDP,
> +			RT5670_I2S_MS_MASK | RT5670_I2S_BP_MASK |
> +			RT5670_I2S_DF_MASK, reg_val);
> +		break;
> +	case  RT5670_AIF2:

Extra space.

> +	switch (slots) {
> +	case 4:
> +		val |= (1 << 12);
> +		break;
> +	case 6:
> +		val |= (2 << 12);
> +		break;
> +	case 8:
> +		val |= (3 << 12);
> +		break;
> +	case 2:
> +	default:
> +		break;
> +	}

This seems wrong - the code will map all unknown slot counts to stereo
which probably won't do what was expected.

> +	switch (slot_width) {
> +	case 20:
> +		val |= (1 << 10);
> +		break;
> +	case 24:
> +		val |= (2 << 10);
> +		break;
> +	case 32:
> +		val |= (3 << 10);
> +		break;
> +	case 16:
> +	default:
> +		break;
> +	}

Similarly here for 16 bits.

> +static int rt5670_probe(struct snd_soc_codec *codec)
> +{
> +	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
> +
> +	rt5670->codec = codec;
> +
> +	snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x4);
> +	rt5670_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}

I would expect this setup to be done in the bus level probe() rather
than at ASoC level.

--VsILLG6PYTzZlkGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrY5bAAoJELSic+t+oim9DRUP/3gQNCBy7oqrKF6zaFv9bpvv
6Ec3JAzBu0yhRpMbhiR4NL1+febi/J2P0xzi/yH99cxaFCLNla+fYRyb+WxfD+Ks
HGG+loF1W5OBH/kGGtgCCXBSLnIVTLV6Wdl2ueGKrRFx1FycihBPcDBuwWW7tRHh
HE4LBxpTm/S+CGp4eTVm8fMTtWzNyimMzrVU4Wr7ufBzk3RYHl1PVA4MIVb1MCtr
/AMFLbRGhQ/hmoDwLKscr0TY8n9PMZtMu3tgGhVenb8jc0+lKuiXBjOl14uMIqVs
mrUZ/zcxdLXKQobvnp5mJzXkSBZzpwAnmCOVUocANDbVct+5KaTYInVC/lbKxuXR
hizGD/8OIGdnjSer87khgfBHEtzw8EuuHIgABtisId90GLcp4lSRCpRs5piibyUW
66kSOrUyj6Dv8XIwVg1Br2FCqYQ6ljY3D1FCV7wrfHksd/9SCV+l7DlBVEPhRr8b
rqp4YyLYUdRFOcFsuKSVSEU/6EpEHyUgi5NXTbHvyb7jJkGrIi9CgLRgkiGkPhSd
4JU68GUXsJ8Fx6AIi6dfSb6+qKnATYWOEbzSc4q3XrSuc6CdK42bZMUE5VNtkGa/
Uv6eygsdGpb+BE6TT2nIu+FsRtYbZi0n/AGJBL1IUTKcjh8+q4W5DbuDzO88oQRb
5pqKI3C1wJ/GrmDdNGZx
=OuDE
-----END PGP SIGNATURE-----

--VsILLG6PYTzZlkGF--

--===============6897553198743385346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6897553198743385346==--
