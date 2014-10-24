From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Fri, 24 Oct 2014 17:24:04 +0100
Message-ID: <20141024162404.GJ3729@sirena.org.uk>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5680984865202952705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 116212604AF
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 18:24:15 +0200 (CEST)
In-Reply-To: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5680984865202952705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Content-Disposition: inline


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 07:14:07PM +0800, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
>=20
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail =
and
> Braswell, with RT5672 codec.

This doesn't seem to have any ACPI stuff - how does the driver get
loaded?

> +static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> +	int ret;
> +	unsigned int fmt;
> +
> +	if (strncmp(codec_dai->name, "rt5670-aif1", 11))
> +		return 0;
> +
> +	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
> +	ret =3D snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4,
> +				       SNDRV_PCM_FORMAT_GSM);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec TDM slot %d\n", ret);
> +		return ret;
> +	}
> +

This doesn't depend on the parameters so should be set on init and your
use of SNDRV_PCM_FORMAT_GSM doesn't seem to make much sense here -
what's going on?

> +	/* TDM slave Mode */
> +	fmt =3D   SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
> +		| SND_SOC_DAIFMT_CBS_CFS;
> +	ret =3D snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0) {
> +		dev_err(rtd->dev, "can't set codec DAI fmt %d\n", ret);
> +		return ret;
> +	}

Likewise, set on init (in the dai_link)

> +static int cht_set_bias_level(struct snd_soc_card *card,
> +				struct snd_soc_dapm_context *dapm,
> +				enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		break;
> +	default:
> +		dev_err(card->dev, "Invalid bias level=3D%d\n", level);
> +		return -EINVAL;
> +	}
> +	card->dapm.bias_level =3D level;
> +	return 0;
> +}

This does nothing and can be removed.

> +static int cht_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +	int ret;
> +	struct snd_soc_card *card =3D runtime->card;
> +
> +	/* Set card bias level */
> +	cht_set_bias_level(card, &card->dapm, SND_SOC_BIAS_OFF);
> +	card->dapm.idle_bias_off =3D true;
> +
> +	ret =3D snd_soc_dapm_sync(&card->dapm);
> +	if (ret) {
> +		dev_err(card->dev, "unable to sync dapm\n");
> +		return ret;
> +	}
> +	return ret;
> +}

This also does nothing and can be removed.

> +static struct snd_pcm_hw_constraint_list constraints_48000 =3D {
> +	.count =3D ARRAY_SIZE(rates_48000),
> +	.list  =3D rates_48000,
> +};
> +
> +static int cht_aif1_startup(struct snd_pcm_substream *substream)
> +{
> +	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> +			SNDRV_PCM_HW_PARAM_RATE,
> +			&constraints_48000);
> +}

If the rates are restricted to 48kHz then is there any need for rate
dependent code in hw_params() at all?

> +static int snd_cht_mc_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card =3D platform_get_drvdata(pdev);
> +
> +	snd_soc_card_set_drvdata(soc_card, NULL);
> +	snd_soc_unregister_card(soc_card);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}

No need to set the driver data to NULL, the driver core will do it
anyway and it's buggy to look at the driver data for unbound devices.

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUSn0kAAoJECTWi3JdVIfQotgH/3cezs/gZOR3GLvtpzLwIeZX
KskQzWfJ80x3Rm6i8AqKt/GlklvrdGUyYkNTWjrpKGMZ6O5OKduSB6jAbtJacyxv
SMTib3NKgjE7vsVejcXbdLoCjy7dNK52mIL+/vqVMcuTO2rvK1dLFpDSx6Bkrv04
1VyMYuvDcrLaeL4LT2h9tKPRzQaSzQ3cAc3ksnZ8csZmLspASGGZsVT+hIlZUZs6
9hrc0H8NVNlIBX5x8DYWnA6nZZL2LDV+KiwNMWIFyQ5mtsSDWCoSzQm/T9E+C5ks
SiiDG8YOaGFDZzZxqE43JzlielIAWLMv83qfj8r7g9PjGlgsfyNORWFSGoPhxIQ=
=mPge
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--

--===============5680984865202952705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5680984865202952705==--
