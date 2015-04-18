From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] ASoc: Codec: add sti platform codec
Date: Sat, 18 Apr 2015 14:09:14 +0100
Message-ID: <20150418130914.GT26185@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-8-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1285067345634234983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C1032619BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 15:09:22 +0200 (CEST)
In-Reply-To: <1429018531-29025-8-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1285067345634234983==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u+FGODhbLwgAeSOU"
Content-Disposition: inline


--u+FGODhbLwgAeSOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 03:35:31PM +0200, Arnaud Pouliquen wrote:

> +struct codec_regfield {
> +	struct regmap_field  *field;
> +	const struct reg_field regfield;
> +};

The fact that you're defining this structure should be settinng off
alarm bells.  You shouldn't be storing the per device dynamically
allocated regmap_feild in global static data, you should be storing it
in the driver data for your device.

> +/* specify ops depends on codec version */
> +struct sti_codec_ops {
> +	int (*dai_dac_probe)(struct snd_soc_dai *dai);
> +	int (*mute)(struct snd_soc_dai *dai, int mute);
> +	int (*startup)(struct snd_soc_dai *);
> +	void (*shutdown)(struct snd_soc_dai *);
> +};

Don't define an abstraction layer within your driver wrapping the core
abstraction layer, this is just making things harder to follow.  Just
register different ops with the core if you need to.

> +	/* init DAC configuration */
> +	if (data->chipid == CHIPID_STIH407) {
> +		/* init configuration */
> +		ret = regmap_field_write(
> +			dac->regfield[STIH407_DAC_STANDBY].field, 1);
> +		ret |= regmap_field_write(
> +			dac->regfield[STIH407_DAC_STANDBY_ANA].field, 1);
> +		ret |= regmap_field_write(
> +			dac->regfield[STIH407_DAC_SOFTMUTE].field, 1);

Don't or multiple return values together, check and return errors
properly.  That way the error value isn't corrupted if you get different
errors.

> +	} else if (data->chipid == CHIPID_STIH416) {

Use switch statements to select among multiple values.

> +	dac->rst = devm_reset_control_get(codec->dev, "dac_rst");
> +	if (IS_ERR(dac->rst)) {
> +		dev_err(dai->codec->dev,
> +			"%s: ERROR: DAC reset not declared in DT (%d)!\n",
> +			__func__, (int)dac->rst);

That error message might be wrong, it could be some other error.

> +		return -EFAULT;

Don't ignore the error that was returned, use PTR_ERR() - this is broken
for probe deferral.

> +int stih407_sas_dac_startup(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct sti_sas_codec_data *drvdata = dev_get_drvdata(codec->dev);
> +	struct sti_dac_audio *dac = &drvdata->dac;
> +	int ret;
> +
> +	/* mute */
> +	ret = regmap_field_write(
> +		dac->regfield[STIH407_DAC_SOFTMUTE].field, 1);
> +
> +	/* Enable analog */
> +	ret |= regmap_field_write(
> +		dac->regfield[STIH407_DAC_STANDBY_ANA].field, 0);
> +
> +	/* Disable standby */
> +	ret |= regmap_field_write(
> +		dac->regfield[STIH407_DAC_STANDBY].field, 0);

This looks like at least standby and analogue should be moved to DAPM,
I'm not clear why the mute is being controlled here...

> +static int sti_sas_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int ret, div;
> +
> +	div = sti_sas_dai_clk_div[dai->id];
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, SND_SOC_CLOCK_OUT, div);
> +	if (ret)

set_clkdiv() is an external API, you shouldn't be calling it within the
driver - probably you should just not implement it and inline the
functionality here.

> +static int sti_sas_codec_suspend(struct snd_soc_codec *codec)
> +{
> +	/* Nothing done but need to be declared for PM management*/
> +	return 0;
> +}

Remove empty functions, the comment is not accurate.

> +	/* Allocate device structure */
> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct sti_sas_codec_data),
> +			       GFP_KERNEL);
> +
> +	if (!drvdata) {
> +		dev_err(&pdev->dev, "Failed to allocate device structure");

The memory allocators are already very noisy if they fail.

--u+FGODhbLwgAeSOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMld5AAoJECTWi3JdVIfQ9LQH/jYEABDafXSPlcpdek6n/rjq
48YpSMXz2o+3lmSqXaRJTIMzGSy11Op5QKo4CBuw5BDkTN6Qs4AJgspimgpPiigZ
0wpYem/u1pHoq4uIsnOQBbJmWR0dhikRX977xbldoYhfMaPyjRJlbJkNqj1Vyuf7
gDCVib1neK/+7q1qrVNNBMWjB6LYaZEsyxsK81RKMfECfCX9bQb0MBrGK5aKnKJa
5k1dAAMX/bYa9qx0EoDsxguti+cw3+HtAdEMe+iN07yblrq/CMJBNlIJY63a5e/o
AlUWp/XDnmFcUcH52hI30uJ/AztfO7RTHphs1eGbIAlF6vp5WuN0il2lmVcy4z4=
=1H3j
-----END PGP SIGNATURE-----

--u+FGODhbLwgAeSOU--

--===============1285067345634234983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1285067345634234983==--
