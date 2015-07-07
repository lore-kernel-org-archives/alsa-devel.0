From: Chih-Chiang Chang <ccchang12@nuvoton.com>
Subject: Re: [PATCH v2] ASoC: Add support for NAU8825 codec to ASoC
Date: Tue, 7 Jul 2015 16:22:32 +0800
Message-ID: <559B8C48.9090501@nuvoton.com>
References: <552F874A.7090409@nuvoton.com> <20150424182812.GI22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150424182812.GI22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AP MS30 Linux Kernel community <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 2015/4/25 =E4=B8=8A=E5=8D=88 02:28, Mark Brown wrote:
> On Thu, Apr 16, 2015 at 05:56:26PM +0800, Chih-Chiang Chang wrote:
>=20
>> +static const struct snd_kcontrol_new nau8825_hpo_mix[] =3D {
>> +
>> +	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
>> +	NAU8825_L_MUTE_SFT, 1, 1),
>> +	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
>> +	NAU8825_R_MUTE_SFT, 1, 1),
>=20
> Indentation - the continuation lines should be lined up with the (.
>=20
Modified code as below.

static const struct snd_kcontrol_new nau8825_hpo_mix[] =3D {
	SOC_DAPM_SINGLE("HP L Switch", NAU8825_HSVOL_CTRL,
				NAU8825_L_MUTE_SFT, 1, 1),
	SOC_DAPM_SINGLE("HP R Switch", NAU8825_HSVOL_CTRL,
				NAU8825_R_MUTE_SFT, 1, 1),
};

>> +static void set_sys_clk(struct snd_soc_codec *codec, int sys_clk)
>> +{
>=20
> This is only used in set_sysclk(), just merge it into there.
>=20
it is also used in the set_bias_level().

	case SND_SOC_BIAS_OFF:
		dev_dbg(codec->dev, "###nau8825_set_bias_level OFF\n");
		set_sys_clk(codec, NAU8825_INTERNALCLOCK);
		regmap_update_bits(nau8825->regmap, NAU8825_BIAS_ADJ,
				NAU8825_VMID_MASK, NAU8825_VMID_DIS);

>> +static const struct reg_default nau8825_reg[] =3D {
>> +	/* enable clock source */
>> +	{0x0001, 0x07FF},
>> +	/* enable VMID and Bias */
>> +	{0x0076, 0x3140},
>> +	/* setup clock divider */
>> +	{0x0003, 0x0050},
>> +	/* jack detection configuration */
>> +	{0x000C, 0x0004},
>> +	{0x000D, 0x00E0},
>> +	{0x000F, 0x0801},
>> +	{0x0012, 0x0010},
>> +	/* keypad detection configuration */
>> +	{0x0013, 0x0280},
>> +	{0x0014, 0x7310},
>> +	{0x0015, 0x050E},
>> +	{0x0016, 0x1B2A},
>> +	/* audio format configuration */
>> +	{0x001A, 0x0800},
>> +	{0x001C, 0x000E},
>> +	{0x001D, 0x0010},
>=20
> This all looks like normal configuration of the device done through a
> fixed magic number table which isn't what patches are for at all - th=
ey
> are for erratum fixes and similar.  Most if not all of this should be
> configured either from userspace or by the machine driver.
>=20
In original code, the reg_default hold the registers of initialization
sequence. Modified code to make reg_default hold the register values in
the power-on reset state. And remove the code of writing initial
register values in i2c_probe() function.

static const struct reg_default nau8825_reg[] =3D {
	{0x000, 0x0000},
	{0x001, 0x00ff},
	{0x003, 0x0050},
	{0x004, 0x0000},
	{0x005, 0x3126},
	{0x006, 0x0008},
	{0x007, 0x0010},
	{0x008, 0x0000},
	{0x009, 0x6000},
	{0x00a, 0xf13c},
	{0x00c, 0x000c},
	{0x00d, 0x0000},
	{0x00f, 0x0800},
	{0x010, 0x0000},
	{0x011, 0x0000},
	{0x012, 0x0010},
	{0x013, 0x0015},
	{0x014, 0x0110},
	{0x015, 0x0000},
	...

>> +static bool nau8825_volatile_register(struct device *dev, unsigned =
int reg)
>> +{
>> +	switch (reg) {
>> +	case NAU8825_RESET:
>> +	case NAU8825_ENA_CTRL:
>> +	case NAU8825_CLK_EN:
>> +	case NAU8825_CLK_DIVIDER:
>> +	case NAU8825_FLL_1:
>> +	case NAU8825_FLL_2:
>> +	case NAU8825_FLL_3:
>> +	case NAU8825_FLL_4:
>> +	case NAU8825_FLL_5:
>> +	case NAU8825_FLL_6:
>> +	case NAU8825_HEADSET_CTRL:
>> +	case NAU8825_JACK_DET_CTRL:
>> +	case NAU8825_IRQ_MASK:
>> +	case NAU8825_IRQ_CLEAR:
>> +	case NAU8825_IRQ_CTRL:
>=20
> Are you *sure* all these registers are volatile?  It isn't impossible=
 of
> course but it seems like it'd be some very special hardware design.  =
It
> looks like all the registers are being marked as volatile.
>
Remove some unnecessary registers.

static bool nau8825_volatile_register(struct device *dev, unsigned int =
reg)
{
	switch (reg) {
	case NAU8825_RESET:
	case NAU8825_CLK_DIVIDER:
	case NAU8825_FLL_1:
	case NAU8825_FLL_2:
	case NAU8825_FLL_3:
	case NAU8825_FLL_4:
	case NAU8825_FLL_5:
	case NAU8825_FLL_6:
	case NAU8825_ANALOG_CTRL_2:
	case NAU8825_ANALOG_ADC_1:
	case NAU8825_ANALOG_ADC_2:
	case NAU8825_DAC_CTRL:
	case NAU8825_MIC_BIAS:
	case NAU8825_BOOST:
	case NAU8825_CLASSG_CTRL:
	case NAU8825_I2C_DEVICE_ID:
	case NAU8825_BIAS_ADJ:
	case NAU8825_POWER_UP_CTRL:
	case NAU8825_CHARGE_BUMP_CTRL:
	case NAU8825_GENERAL_STATUS:
		return true;
	default:
		return false;
	}
}

>> +	/* software reset */
>> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x01);
>> +	regmap_write(nau8825->regmap, NAU8825_RESET, 0x02);
>=20
> We did the reset differently in the removal path...
>=20
=46or software reset, our codec must write twice in any value. Sync the
code as below in both of i2c_probe() and codec_remove().

	regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);
	regmap_write(nau8825->regmap, NAU8825_RESET, 0x00);

>> +	/*writing initial register values to the codec*/
>> +	for (i =3D 0; i < ARRAY_SIZE(nau8825_reg); i++)
>> +		regmap_write(nau8825->regmap, nau8825_reg[i].reg,
>> +		nau8825_reg[i].def);
>=20
> We should use the reset values the CODEC has.
>=20
Yes, removed the code.
