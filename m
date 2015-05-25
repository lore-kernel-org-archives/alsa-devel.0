From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 7/9] ASoC: Codec: Add sti platform codec
Date: Mon, 25 May 2015 14:01:24 +0100
Message-ID: <20150525130124.GS21391@sirena.org.uk>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-8-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2194737726399105336=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BFC02260686
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 15:01:40 +0200 (CEST)
In-Reply-To: <1431951176-24670-8-git-send-email-arnaud.pouliquen@st.com>
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


--===============2194737726399105336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KS5V1uDxmEcBh2BA"
Content-Disposition: inline


--KS5V1uDxmEcBh2BA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2015 at 02:12:54PM +0200, Arnaud Pouliquen wrote:

> +	if (data->dev_data->chipid == CHIPID_STIH407)
> +		max_rf = STIH407_DAC_MAX_RF;
> +	else
> +		max_rf = STIH416_DAC_MAX_RF;

switch statements for selecting chip versions here and elsewhere please,
that way new variants are easier to handle.

> +	dac->field = devm_kzalloc(data->dev,
> +				  sizeof(struct regmap_field *) * max_rf,
> +				  GFP_KERNEL);

devm_kcalloc().

> +static int  stih407_sas_dac_supply(struct snd_soc_dapm_widget *w,
> +				   struct snd_kcontrol *kcontrol, int event) {
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
> +	struct sti_dac_audio *dac = &drvdata->dac;
> +	int ret = 0;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		/* Enable analog */
> +		ret = regmap_field_write(dac->field[STIH407_DAC_STANDBY_ANA],
> +					 0);
> +		/* Disable standby */
> +		if (!ret)
> +			ret = regmap_field_write(
> +				dac->field[STIH407_DAC_STANDBY], 0);
> +		break;

These event functions all look very similar and I can't help but think
that they look awfully like the sort of register write sequences that
DAPM normally generates anyway.  Is there any great reason for not doing
these by registering multiple widgets with routes between them rather
than with custom code?

> +static int sti_sas_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *params,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	int div;
> +
> +	div = sti_sas_dai_clk_div[dai->id];
> +	if (cpu_dai->driver->ops->set_clkdiv)
> +		return cpu_dai->driver->ops->set_clkdiv(cpu_dai,
> +							SND_SOC_CLOCK_OUT, div);
> +	dev_warn(codec->dev, "WARN: CPU DAI not support sysclk div");

This is worrying, we shouldn't be peering inside the CPU DAI like this.
I'd expect this to either be done autonomously by the CPU DAI or handled
in a machine driver.

> +config SND_SOC_STI_SAS
> +	tristate "codec Audio support for STI SAS codec"
> +	depends on SND_SOC_STI
> +	help
> +		Say Y if you want to include STI SAS audio codec support

This appears to duplicate the CODEC Kconfig in the CODECs directory -
I'd expect it to be there rather than in the STI directory given that
that is where the code is.

--KS5V1uDxmEcBh2BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYx0jAAoJECTWi3JdVIfQ81QH/2dHHUi5Vj/eoRr/xRKlkAOT
mRf2gPmUgamekzMi++CTsypGvwTdhsOS9H377GAuR/b8WBFPqSGUmwjguc4Y8VL2
2oIZOSxEYw8AzBQliXkfC7H816NDPaHP0e/QpsPTPSWpDKTSVjI3Q61oAomPCczQ
oJGgAzs55lt3mNh2F/kuIkyzXUDltW7Qh1gukMbCK5bKWJJd3oZYuKiBLM7LiW3/
XeVZpLhPQH6UFqDTG9IdTshndltZbu9Rr5tQUduZHpospo2dJv1jQ/+LGgObdRQe
pNp3XuWS5n4mi/32KnjJhS83kOL4K85aVHjnj6uoulhbdeUtS+jqU/Oxkv2Li74=
=7Ds4
-----END PGP SIGNATURE-----

--KS5V1uDxmEcBh2BA--

--===============2194737726399105336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2194737726399105336==--
