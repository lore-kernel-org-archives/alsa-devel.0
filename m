From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
	Logic CS53L30
Date: Mon, 28 Mar 2016 10:51:50 +0100
Message-ID: <20160328095150.GB2350@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7051562874515862244=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C8AE265703
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:46:21 +0200 (CEST)
In-Reply-To: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tim.howe@cirrus.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============7051562874515862244==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 05:47:46PM -0500, tim.howe@cirrus.com wrote:

> +/* ADC Preamp gain select */
> +static const char * const cs53l30_preamp_gain_sel_text[] = {
> +	"0dB", "10dB", "20dB"};
> +
> +static const struct soc_enum adc1a_preamp_gain_enum =
> +	SOC_ENUM_SINGLE(CS53L30_ADC1A_AFE_CTL, 6,
> +		ARRAY_SIZE(cs53l30_preamp_gain_sel_text),
> +		cs53l30_preamp_gain_sel_text);

Why are you writing volume controls as enums?  Please use normal volume
controls with TLV information.

> +/* Set MIC Bias Voltage Control */
> +static const char * const cs53l30_micbias_text[] = {
> +	"HiZ", "1.8V", "2.75V"};

Why is this exposed to userspace and not platform data like other bias
controls?  The voltage to use will normally be determined by the
hardware design and the enable/disable should be managed via DAPM.

> +	case SND_SOC_DAPM_PRE_PMU:
> +		regmap_update_bits(priv->regmap, CS53L30_ASP1_CTL,
> +				   CS53L30_ASP1_3ST, 0);
> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		regmap_update_bits(priv->regmap, CS53L30_ASP1_CTL,
> +				   CS53L30_ASP1_3ST, 1);
> +		break;

Could this be a supply widget?

> +	regmap_read(priv->regmap, CS53L30_MCLKCTL, &mclk_ctl);
> +	mclk_ctl &= ~CS53L30_MCLK_DIV;
> +	mclk_ctl |= cs53l30_mclkx_coeffs[mclkx_coeff].mclkdiv;
> +
> +	regmap_update_bits(priv->regmap, CS53L30_MCLKCTL, CS53L30_MCLK_DIV,
> +			   mclk_ctl << CS53L30_MCLK_DIV);

You're using regmap_update_bits() but still implementing a manual
read/modify write cycle.  Just use regmap_update_bits.

> +	regmap_read(priv->regmap, CS53L30_ASPCFG_CTL, &asp_config_ctl);
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		asp_config_ctl |= CS53L30_ASP_MS;

> +	priv->asp_config_ctl = asp_config_ctl;

The driver appears to be mixing use of priv->asp_config_ctl and the
physical value, that seems likely to go wrong somewhere along the line.
Either the variable is authorative and we should always work from that
then write it to the device when needed or the device is authorative but
currently we're mixing both.

> +	regmap_update_bits(priv->regmap, CS53L30_ASPCFG_CTL,
> +			   CS53L30_ASP_RATE_MASK, priv->asp_config_ctl);

We also write out via update_bits but don't specify all the bits
sometimes...

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+P60AAoJECTWi3JdVIfQ4gQIAIVgvMgTXUESq9tUngo1MzuG
9rTzjoEOxaUymvyS4yxlQ531C9+NPzS5pq00Wyd/gLKxIDlYw6NHfgmOp1u1AW0/
gSeXfwUBTKrnX3FCOs2dHmcYMDjcvhBtTcFRDrCR7pgpoXFxgvcTD0nldlSbh0d9
hdwtTyPpibm4wcten3arK6tfdwSgKqRfLENgcAbJTOIXs08CMLigCFZfzN+CYPDs
L2jDsjD1izE87dU8SrklOnBUnoaYcPkmWR+ZEuhJeggcHPm8k4/W5hGNYCsHQ2mA
mZpqUqsedrzU164d+L5OPTpdWBQ5R0M44sfUSwl32bG3wZQNIRIwSbFk0gEp8G4=
=2PbY
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

--===============7051562874515862244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7051562874515862244==--
