From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add support for NAU8825 codec to ASoC
Date: Fri, 24 Apr 2015 19:28:12 +0100
Message-ID: <20150424182812.GI22845@sirena.org.uk>
References: <552F874A.7090409@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QKPhqaMSryCHBNcI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552F874A.7090409@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: tiwai@suse.de, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--QKPhqaMSryCHBNcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 05:56:26PM +0800, Chih-Chiang Chang wrote:

> +static const struct snd_kcontrol_new nau8825_hpo_mix[] = {
> +
> +	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
> +	NAU8825_L_MUTE_SFT, 1, 1),
> +	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
> +	NAU8825_R_MUTE_SFT, 1, 1),

Indentation - the continuation lines should be lined up with the (.

> +static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
> +{

This is only used in set_sysclk(), just merge it into there.

> +static const struct reg_default nau8825_reg[] = {
> +	/* enable clock source */
> +	{0x0001, 0x07FF},
> +	/* enable VMID and Bias */
> +	{0x0076, 0x3140},
> +	/* setup clock divider */
> +	{0x0003, 0x0050},
> +	/* jack detection configuration */
> +	{0x000C, 0x0004},
> +	{0x000D, 0x00E0},
> +	{0x000F, 0x0801},
> +	{0x0012, 0x0010},
> +	/* keypad detection configuration */
> +	{0x0013, 0x0280},
> +	{0x0014, 0x7310},
> +	{0x0015, 0x050E},
> +	{0x0016, 0x1B2A},
> +	/* audio format configuration */
> +	{0x001A, 0x0800},
> +	{0x001C, 0x000E},
> +	{0x001D, 0x0010},

This all looks like normal configuration of the device done through a
fixed magic number table which isn't what patches are for at all - they
are for erratum fixes and similar.  Most if not all of this should be
configured either from userspace or by the machine driver.

> +static bool nau8825_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case NAU8825_RESET:
> +	case NAU8825_ENA_CTRL:
> +	case NAU8825_CLK_EN:
> +	case NAU8825_CLK_DIVIDER:
> +	case NAU8825_FLL_1:
> +	case NAU8825_FLL_2:
> +	case NAU8825_FLL_3:
> +	case NAU8825_FLL_4:
> +	case NAU8825_FLL_5:
> +	case NAU8825_FLL_6:
> +	case NAU8825_HEADSET_CTRL:
> +	case NAU8825_JACK_DET_CTRL:
> +	case NAU8825_IRQ_MASK:
> +	case NAU8825_IRQ_CLEAR:
> +	case NAU8825_IRQ_CTRL:

Are you *sure* all these registers are volatile?  It isn't impossible of
course but it seems like it'd be some very special hardware design.  It
looks like all the registers are being marked as volatile.

> +	/* software reset */
> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x01);
> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x02);

We did the reset differently in the removal path...

> +	/*writing initial register values to the codec*/
> +	for (i = 0; i < ARRAY_SIZE(nau8825_reg); i++)
> +		regmap_write(nau8825->regmap, nau8825_reg[i].reg,
> +		nau8825_reg[i].def);

We should use the reset values the CODEC has.

--QKPhqaMSryCHBNcI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOos7AAoJECTWi3JdVIfQ20MH/0m7sUY+snJoYD2eNrEy/JOT
QaR72/qHQkfK+1dNgNhS3+/eiu0FiHKFzAq6Msjret3NJO7InUg6v4so062gYbEB
Mty1Ytpbqu2Woa4e07M7KDdHJqd3QztWzSnpgvydhtN1OSQ5SCYKgi0HaCCyEUqk
8LBm8F+Iz64UPnmPYiRYKjJ09S8/FzomuF8qxSPVvZtPA4Fbk273hWPo9XDvR2CI
yyOIxPSDkG5hQYkyqbKXQMee1+5CfKqr4HRDTsJQXGWGdLc47a7+GJvua/Jt/BCQ
PfR/KApFqavQxnLPKrB0URveZzx1dsAxfDU0BQOUc4aCVwkBfmLHQlf21Pob55c=
=yeAx
-----END PGP SIGNATURE-----

--QKPhqaMSryCHBNcI--
