From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
	support
Date: Wed, 16 Feb 2011 19:01:47 +0100
Message-ID: <87k4gzq2no.fsf@lechat.rtp-net.org>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 77378103848
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 19:01:35 +0100 (CET)
In-Reply-To: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	(zhaoming zeng's message of "Wed, 16 Feb 2011 06:56:16 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

<zhaoming.zeng@freescale.com> writes:

Hi,

> From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
>
> Add Freescale SGTL5000 codec support
>
> Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> ---
> changes since v2:
> 1. clean up register default values
> 2. rewrite codec power up code, add sgtl5000_set_power_regs()
> 3. rewrite codec clock configure code sgtl5000_set_clock()
> 4. reimplement PM hooks, restore register by particular order.
> 5. clean up dapm code, remove dac and adc event hooks.
> 6. clean up codec private structure, remove unnecessary fields.
> 7. add comments for uncommon code.
>
> Thanks for Mark's review.
> ---
>  sound/soc/codecs/Kconfig    |    4 +
>  sound/soc/codecs/Makefile   |    1 +
>  sound/soc/codecs/sgtl5000.c | 1229 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/sgtl5000.h |  403 ++++++++++++++
>  4 files changed, 1637 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c48b23c..57b909a 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -32,6 +32,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_MAX98088 if I2C
>  	select SND_SOC_MAX9877 if I2C
>  	select SND_SOC_PCM3008
> +	select SND_SOC_SGTL5000 if I2C
>  	select SND_SOC_SPDIF
>  	select SND_SOC_SSM2602 if I2C
>  	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
> @@ -176,6 +177,9 @@ config SND_SOC_MAX98088
>  config SND_SOC_PCM3008
>         tristate
>  
> +config SND_SOC_SGTL5000
> +	tristate
> +
>  config SND_SOC_SPDIF
>  	tristate
>  
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 579af9c..78e36cc 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -18,6 +18,7 @@ snd-soc-dmic-objs := dmic.o
>  snd-soc-l3-objs := l3.o
>  snd-soc-max98088-objs := max98088.o
>  snd-soc-pcm3008-objs := pcm3008.o
> +snd-soc-sgtl5000-objs := sgtl5000.o
>  snd-soc-alc5623-objs := alc5623.o
>  snd-soc-spdif-objs := spdif_transciever.o
>  snd-soc-ssm2602-objs := ssm2602.o

you're actually missing something like :
obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o


> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> new file mode 100644
> index 0000000..2646ecb
> --- /dev/null
> +++ b/sound/soc/codecs/sgtl5000.c

[...]

> +static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
> +				   enum snd_soc_bias_level level)
> +{
> +	int i;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->bias_level == SND_SOC_BIAS_OFF) {

I don't see a member 'bias_level' in snd_soc_codec in the trees I have
on my drive. Which tree did you use ?

> +			for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +				if (!sgtl5000->supplies[i])
> +					continue;
> +				regulator_enable(sgtl5000->supplies[i]);
> +			}
> +		}
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +			if (!sgtl5000->supplies[i])
> +				continue;
> +			regulator_disable(sgtl5000->supplies[i]);
> +		}
> +		break;
> +	}
> +
> +	codec->bias_level = level;
> +	return 0;
> +}
> +
> +#define SGTL5000_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			SNDRV_PCM_FMTBIT_S20_3LE |\
> +			SNDRV_PCM_FMTBIT_S24_LE |\
> +			SNDRV_PCM_FMTBIT_S32_LE)
> +
> +struct snd_soc_dai_ops sgtl5000_ops = {
> +	.hw_params = sgtl5000_pcm_hw_params,
> +	.digital_mute = sgtl5000_digital_mute,
> +	.set_fmt = sgtl5000_set_dai_fmt,
> +	.set_sysclk = sgtl5000_set_dai_sysclk,
> +};
> +
> +static struct snd_soc_dai_driver sgtl5000_dai = {
> +	.name = "sgtl5000",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		/*
> +		 * only support 8~48K + 96K,
> +		 * TODO modify hw_param to support more
> +		 */
> +		.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_96000,
> +		.formats = SGTL5000_FORMATS,
> +	},
> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_96000,
> +		.formats = SGTL5000_FORMATS,
> +	},
> +	.ops = &sgtl5000_ops,
> +	.symmetric_rates = 1,
> +};
> +
> +static int sgtl5000_volatile_register(unsigned int reg)
> +{
> +	switch (reg) {
> +	case SGTL5000_CHIP_ID:
> +	case SGTL5000_CHIP_ADCDAC_CTRL:
> +	case SGTL5000_CHIP_ANA_STATUS:
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
> +{
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}
> +
> +/*
> + * restore all sgtl5000 registers,
> + * since a big hole between dap and regular registers,
> + * we will restore them respectively.
> + */
> +static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
> +{
> +	u16 *cache = codec->reg_cache;
> +	int i;
> +	int regular_regs = SGTL5000_CHIP_SHORT_CTRL >> 1;
> +
> +	/* restore regular registers */
> +	for (i = 0; i < regular_regs; i++) {
> +		int reg = i << 1;
> +
> +		/* this regs depends on the others */
> +		if (reg == SGTL5000_CHIP_ANA_POWER ||
> +			reg == SGTL5000_CHIP_CLK_CTRL ||
> +			reg == SGTL5000_CHIP_LINREG_CTRL ||
> +			reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
> +			reg == SGTL5000_CHIP_CLK_CTRL)
> +			continue;
> +
> +		snd_soc_write(codec, reg, cache[i]);
> +	}
> +
> +	/* restore dap registers */
> +	for (i = SGTL5000_DAP_REG_OFFSET >> 1;
> +			i < SGTL5000_MAX_REG_OFFSET >> 1; i++) {
> +		int reg = i << 1;
> +
> +		snd_soc_write(codec, reg, cache[i]);
> +	}
> +
> +	/*
> +	 * restore power and other regs accroding
> +	 * to set_power() and set_clock()
> +	 */
> +	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
> +			cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
> +			cache[SGTL5000_CHIP_ANA_POWER >> 1]);
> +	mdelay(1);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
> +			cache[SGTL5000_CHIP_CLK_CTRL >> 1]);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
> +			cache[SGTL5000_CHIP_REF_CTRL >> 1]);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
> +			cache[SGTL5000_CHIP_LINE_OUT_CTRL >> 1]);
> +	return 0;
> +}
> +
> +static int sgtl5000_resume(struct snd_soc_codec *codec)
> +{
> +	/* Bring the codec back up to standby to enable regulators */
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +
> +	/* Restore registers by cached in memory */
> +	sgtl5000_restore_regs(codec);
> +	return 0;
> +}
> +
> +/*
> + * sgtl5000 has 3 internal power supplies:
> + * 1. VAG, normally set to vdda/2
> + * 2. chargepump, set to different value
> + *	according to voltage of vdda and vddio
> + * 3. line out VAG, normally set to vddio/2
> + *
> + * and should be set accroding to:
> + * 1. vddd provided by external or not
> + * 2. vdda and vddio voltage value. > 3.1v or not
> + * 3. chip revision >=0x11 or not. If >=0x11, not use external vddd.
> + */
> +static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
> +{
> +	int vddd, vdda, vddio;
> +	u16 ana_pwr, lreg_ctrl;
> +	int vag;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA]) / 1000;
> +	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO]) / 1000;
> +
> +	if (sgtl5000->supplies[VDDD])
> +		vddd = regulator_get_voltage(sgtl5000->supplies[VDDD]) / 1000;
> +	else
> +		vddd = 0;
> +
> +	/* reset value */
> +	ana_pwr = SGTL5000_DAC_STEREO |
> +			SGTL5000_ADC_STEREO |
> +			SGTL5000_REFTOP_POWERUP;
> +	lreg_ctrl = 0;
> +
> +	/* if no external vddd, use internal vddd */
> +	if (!vddd) {
> +		/* set VDDD to 1.2v */
> +		lreg_ctrl |= 0x8 << SGTL5000_LINREG_VDDD_SHIFT;
> +		/* power up internal linear regulator */
> +		ana_pwr |= SGTL5000_LINEREG_D_POWERUP |
> +				SGTL5000_LINREG_SIMPLE_POWERUP |
> +				SGTL5000_STARTUP_POWERUP;
> +	}
> +
> +	if (vddio < 3100 && vdda < 3100) {
> +		/* enable internal oscillator used for charge pump */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_CLK_TOP_CTRL,
> +					SGTL5000_INT_OSC_EN,
> +					SGTL5000_INT_OSC_EN);
> +		/* Enable VDDC charge pump */
> +		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
> +	} else if (vddio >= 3100 && vdda >= 3100) {
> +		/*
> +		 * if vddio and vddd > 3.1v,
> +		 * charge pump should be clean before set ana_pwr
> +		 */
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +				SGTL5000_VDDC_CHRGPMP_POWERUP, 0);
> +
> +		/* VDDC use VDDIO rail */
> +		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
> +		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
> +			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
> +	}
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, ana_pwr);
> +	mdelay(1);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
> +
> +	/*
> +	 * if vddd linear reg has been enabled,
> +	 * simple digital supply should be clear to get
> +	 * proper VDDD voltage.
> +	 */
> +	if (ana_pwr & SGTL5000_LINEREG_D_POWERUP) {
> +		ana_pwr &= ~SGTL5000_LINREG_SIMPLE_POWERUP;
> +		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +				SGTL5000_LINREG_SIMPLE_POWERUP |
> +				SGTL5000_STARTUP_POWERUP,
> +				0);
> +		mdelay(1);
> +	}
> +
> +	/*
> +	 * set ADC/DAC VAG to vdda / 2,
> +	 * should stay in range (0.8v, 1.575v)
> +	 */
> +	vag = vdda / 2;
> +	if (vag <= SGTL5000_ANA_GND_BASE)
> +		vag = 0;
> +	else if (vag >= SGTL5000_ANA_GND_BASE + SGTL5000_ANA_GND_STP *
> +		 (SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT))
> +		vag = SGTL5000_ANA_GND_MASK >> SGTL5000_ANA_GND_SHIFT;
> +	else
> +		vag = (vag - SGTL5000_ANA_GND_BASE) / SGTL5000_ANA_GND_STP;
> +
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
> +			vag << SGTL5000_ANA_GND_SHIFT,
> +			vag << SGTL5000_ANA_GND_SHIFT);
> +
> +	/* set line out VAG to vddio / 2, in range (0.8v, 1.675v) */
> +	vag = vddio / 2;
> +	if (vag <= SGTL5000_LINE_OUT_GND_BASE)
> +		vag = 0;
> +	else if (vag >= SGTL5000_LINE_OUT_GND_BASE +
> +		SGTL5000_LINE_OUT_GND_STP * SGTL5000_LINE_OUT_GND_MAX)
> +		vag = SGTL5000_LINE_OUT_GND_MAX;
> +	else
> +		vag = (vag - SGTL5000_LINE_OUT_GND_BASE) /
> +		    SGTL5000_LINE_OUT_GND_STP;
> +
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
> +			vag << SGTL5000_LINE_OUT_GND_SHIFT |
> +			SGTL5000_LINE_OUT_CURRENT_360u <<
> +				SGTL5000_LINE_OUT_CURRENT_SHIFT,
> +			vag << SGTL5000_LINE_OUT_GND_SHIFT |
> +			SGTL5000_LINE_OUT_CURRENT_360u <<
> +				SGTL5000_LINE_OUT_CURRENT_SHIFT);
> +
> +	return 0;
> +}
> +
> +static int sgtl5000_probe(struct snd_soc_codec *codec)
> +{
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	u16 reg;
> +	int ret;
> +	int rev;
> +	int i;
> +
> +	/* setup i2c data ops */
> +	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* read chip information */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
> +	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
> +	    SGTL5000_PARTID_PART_ID) {
> +		dev_err(codec->dev,
> +			"Device with ID register %x is not a sgtl5000\n", reg);
> +		ret = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
> +	dev_info(codec->dev, "sgtl5000 revision %d\n", rev);
> +
> +	/* get and enable all regulators */
> +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		struct regulator *reg;
> +
> +		/* workaround for revision 0x11, using internal LDO */
> +		if (i == VDDD && rev == 0x11)
> +			continue;
> +
> +		reg = regulator_get(codec->dev, supply_names[i]);
> +
> +		if (IS_ERR(reg))
> +			continue;
> +
> +		regulator_enable(reg);
> +		sgtl5000->supplies[i] = reg;
> +	}
> +
> +	/*
> +	 * vdda and vddio regulator must configured,
> +	 * vddd is an optional regulator, if vddd not supply externally,
> +	 * internal vddd will be enabled in sgtl5000_set_power_regs()
> +	 */
> +	if (!sgtl5000->supplies[VDDA] || !sgtl5000->supplies[VDDIO]) {
> +		dev_err(codec->dev,
> +			"Not set vdda or vddio regulator correctly\n");
> +
> +		/* platform regulator not configured correctly */
> +		ret = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	/* power up sgtl5000 */
> +	ret = sgtl5000_set_power_regs(codec);
> +	if (ret)
> +		goto err_out;
> +
> +	/* enable small pop, introduce 400ms delay in turning off */
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
> +				SGTL5000_SMALL_POP,
> +				SGTL5000_SMALL_POP);
> +
> +	/* enable short cut detect */
> +	snd_soc_write(codec, SGTL5000_CHIP_SHORT_CTRL, 0);
> +
> +	/*
> +	 * set i2s as default input of sound switch
> +	 * TODO: add sound switch to control and dapm widge.
> +	 */
> +	snd_soc_write(codec, SGTL5000_CHIP_SSS_CTRL,
> +			SGTL5000_DAC_SEL_I2S_IN << SGTL5000_DAC_SEL_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_DIG_POWER,
> +			SGTL5000_ADC_EN | SGTL5000_DAC_EN);
> +
> +	/* enable dac vol ramp by default */
> +	snd_soc_write(codec, SGTL5000_CHIP_ADCDAC_CTRL,
> +			SGTL5000_DAC_VOL_RAMP_EN |
> +			SGTL5000_DAC_MUTE_RIGHT |
> +			SGTL5000_DAC_MUTE_LEFT);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
> +
> +	/* set default volume of adc */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_ADC_CTRL);
> +	reg &= ~SGTL5000_ADC_VOL_M6DB;
> +	reg &= ~(SGTL5000_ADC_VOL_LEFT_MASK | SGTL5000_ADC_VOL_RIGHT_MASK);
> +	reg |= (0xf << SGTL5000_ADC_VOL_LEFT_SHIFT)
> +	    | (0xf << SGTL5000_ADC_VOL_RIGHT_SHIFT);
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_ADC_CTRL, reg);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
> +			SGTL5000_HP_ZCD_EN |
> +			SGTL5000_ADC_ZCD_EN);
> +
> +	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
> +
> +	/*
> +	 * disable DAP
> +	 * TODO:
> +	 * Enable DAP in control and dapm.
> +	 */
> +	snd_soc_write(codec, SGTL5000_DAP_CTRL, 0);
> +
> +	/* leading to standby state */
> +	ret = sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	if (ret)
> +		goto err_out;
> +
> +	snd_soc_add_controls(codec, sgtl5000_snd_controls,
> +			     ARRAY_SIZE(sgtl5000_snd_controls));
> +
> +	snd_soc_dapm_new_controls(codec, sgtl5000_dapm_widgets,
> +				  ARRAY_SIZE(sgtl5000_dapm_widgets));

same kind of probleme here. on my drive, it's :
int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
        const struct snd_soc_dapm_widget *widget,
        int num);


> +
> +	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
> +
> +	snd_soc_dapm_new_widgets(codec);

same here.


> +
> +	return 0;
> +
> +err_out:
> +	for (i = 0; i < SGTL5000_SUPPLY_NUM; i++) {
> +		if (!sgtl5000->supplies[i])
> +			continue;
> +
> +		regulator_disable(sgtl5000->supplies[i]);
> +		regulator_put(sgtl5000->supplies[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sgtl5000_remove(struct snd_soc_codec *codec)
> +{
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +	int i;
> +
> +	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	snd_soc_dapm_free(codec);

same here.

[...]

Arnaud
