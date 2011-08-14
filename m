From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Please review rt5631 driver on alsa 1.0.24.
Date: Sun, 14 Aug 2011 23:12:59 +0900
Message-ID: <20110814141256.GA8482@opensource.wolfsonmicro.com>
References: <D645C35CCC6E49B38F7BCBD483C1F861@realtek.com.tw>
	<20110809161456.GO15861@opensource.wolfsonmicro.com>
	<5E892B2A410A4335AC76A944B7A742F8@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2F99248E8
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 16:13:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5E892B2A410A4335AC76A944B7A742F8@realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: johnnyhsu <johnnyhsu@realtek.com>
Cc: alsa-devel@alsa-project.org, 'Flove' <flove@realtek.com>, 'Liam Girdwood' <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 12, 2011 at 05:31:40PM +0800, johnnyhsu wrote:
> Dear Mr. Brown and Mr. Girdwood,
> 
> This patch is made against sound-2.6.git for-next.
> Because the git send-email can't work in my PC, I send the patch by Outlook.
> Hope it won't make error.

No, this doesn't work at all - Outlook mangles your patch so it can't be
applied and text like this at the top of the mail means it's not in the
format the tools expect.

There's quite a few problems, overall my main comment is the same as the
last time - please look at how other drivers do things and try to fit in
with the general style.  There's a lot of code in here which doesn't
look like normal ASoC code with no hint as to why.

> +#define RT5631_VERSION "0.01 alsa 1.0.24"

The kernel has a perfectly good versioning system, remove this.

> +static const u16 rt5631_reg[0x80];
> +static int timesofbclk = 32;

No global variables.

> +static void snd_soc_write_index(struct snd_soc_codec *codec,
> +		unsigned int reg, unsigned int value)

All your snd_soc_ functions should have some driver specific name,
unless they really are generic in which case they should be added to the
subsystem code rather than kept in your driver.  This one doesn't appear
to be generic.

> +{
> +	snd_soc_write(codec, RT5631_INDEX_ADD, reg);
> +	snd_soc_write(codec, RT5631_INDEX_DATA, value);
> +
> +	return;
> +}

The return statement is pointless here.

> +static void snd_soc_update_bits_index(struct snd_soc_codec *codec,
> +	unsigned int reg, unsigned int mask, unsigned int value)
> +{
> +	unsigned int reg_val;
> +
> +	if (!mask)
> +		return;
> +
> +	if (mask != 0xffff) {
> +		reg_val = snd_soc_read_index(codec, reg);
> +		reg_val &= ~mask;
> +		reg_val |= (value & mask);
> +		snd_soc_write_index(codec, reg, reg_val);
> +	} else {
> +		snd_soc_write_index(codec, reg, value);
> +	}
> +
> +	return;
> +}

Looking at this I'd expect regular snd_soc_update_bits() would work just
fine for you.

> +/*
> + * speaker channel volume 0dB by default
> + * Headphone channel volume 0dB by default
> + * AXO1/AXO2 channel volume 0dB by default
> + * Mic1/Mic2 boost 40dB by default
> + * Speaker AMP ratio gain is 1.44X
> + * enable HP zero cross
> + * change Mic1 & mic2 to differential mode
> + */

As I said in reply to your original mail:

| This sort of stuff is not suitable for mainline either, the driver
| should just use chip defaults for audio paths and leave the use case up
| to the application layer.

| Please compare your driver with the other CODEC drivers and make sure it
| is following a simmilar style to them.

> +static const char *rt5631_mic_boost[] = {"Bypass", "+20db", "+24db",
> "+30db",
> +			"+35db", "+40db", "+44db", "+50db", "+52db"};

This should be TLV dB information.

> +static const char *rt5631_hpl_source_sel[] = {"LEFT HPVOL", "LEFT DAC"};
> +static const char *rt5631_hpr_source_sel[] = {"RIGHT HPVOL", "RIGHT DAC"};
> +static const char *rt5631_eq_sel[] = {"NORMAL", "CLUB", "DANCE", "LIVE",
> "POP",
> +				"ROCK", "OPPO", "TREBLE", "BASS"};

The general style is not all caps.

> +static const struct soc_enum rt5631_enum[] = {

Don't use arrays of enums, they're hard to read and error prone.

> +static int spk_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	static int spkl_out_enable, spkr_out_enable;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		if (!spkl_out_enable && !strcmp(w->name, "SPKL Amp")) {

DAPM will take care of tracking if the widget is already enabled or
disabled.

> +			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD1,
> +					PWR_CLASS_D, PWR_CLASS_D);

I suspect you want a supply widget.

> +static void hp_depop_mode2_onebit(struct snd_soc_codec *codec, int enable)
> +{
> +	unsigned int soft_vol, hp_zc;

This function is rather abstruse in name and code terms, it should be
clarified.

> +static void hp_mute_unmute_depop_onebit(struct snd_soc_codec *codec, int

Similarly here and with the other depop functions, they could all could
use rather more blank lines and comments.

> +	if (enable) {
> +		snd_soc_write_index(codec, RT5631_SPK_INTL_CTRL, 0x303e);
> +		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
> +			PWR_CHARGE_PUMP | PWR_HP_L_AMP | PWR_HP_R_AMP,
> +			PWR_CHARGE_PUMP | PWR_HP_L_AMP | PWR_HP_R_AMP);

I rather suspect there should be some supply widgets in here.

> +	case SND_SOC_DAPM_POST_PMU:
> +		/*
> +		 * If microphone is stereo, need not copy ADC channel
> +		 * If mic1 is used, copy ADC left to right
> +		 * If mic2 is used, copy ADC right to left
> +		 */

Expose the routes via DAPM and leave the control up to the user.

> +static int auxo1_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	static bool aux1_en;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMD:
> +		if (aux1_en) {
> +			snd_soc_update_bits(codec, RT5631_MONO_AXO_1_2_VOL,
> +						RT_L_MUTE, RT_L_MUTE);
> +			aux1_en = false;

Again, DAPM will keep track of power for you.  I'm not clear why you're
managing mutes here rather than letting the user control them.

> +/**
> + * config_common_power - control all common power of codec system
> + * @pmu: power up or not
> + */
> +static int config_common_power(struct snd_soc_codec *codec, bool pmu)

This should just be inline in set_bias_level().  Though...

> +	if (pmu) {
> +		snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD1,
> +			PWR_MAIN_I2S_EN | PWR_DAC_REF,
> +			PWR_MAIN_I2S_EN | PWR_DAC_REF);
> +		mux_val = snd_soc_read(codec, RT5631_SPK_MONO_HP_OUT_CTRL);
> +		if (!(mux_val & HP_L_MUX_SEL_DAC_L))
> +			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD1,
> +				PWR_DAC_L_TO_MIXER, PWR_DAC_L_TO_MIXER);
> +		if (!(mux_val & HP_R_MUX_SEL_DAC_R))
> +			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD1,
> +				PWR_DAC_R_TO_MIXER, PWR_DAC_R_TO_MIXER);
> +		if (rt5631->pll_used_flag)
> +			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD2,
> +						PWR_PLL, PWR_PLL);

..this all looks rather like it should be managed via DAPM.  

> +static int adc_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	static bool pmu;

This isn't going to work if you've got more than one device in the
system.

> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMD:
> +		if (pmu) {
> +			config_common_power(codec, false);
> +			pmu = false;
> +		}

Again, everything is refcounted for you.  Though I'm not entirely clear
what this is supposed to do it looks rather like you may want to use a
supply widget.

In general please try to work with the subsystem rather than layering
stuff on top of it - it makes the code more complicated and harder to
follow.

> +static int rt5631_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_new_controls(dapm, rt5631_dapm_widgets,
> +			ARRAY_SIZE(rt5631_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));

Just point to the tables from the driver, no need to do this manually.

> +static const struct pll_div codec_slave_pll_div[] = {
> +	{256000,  2048000,  0x46f0},
> +	{256000,  4096000,  0x3ea0},
> +	{352800,	 5644800,  0x3ea0},
> +	{512000,	 8192000,  0x3ea0},

Try to keep the indentation consistent within the table.

> +static ssize_t rt5631_index_reg_show(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	#define IDX_REG_FMT "%02x: %04x\n"
> +	#define IDX_REG_LEN 9

Ick, don't indent #defines and don't put them in the middle of
functions.

> +	cnt += sprintf(buf, "RT5631 index register\n");
> +	for (i = 0; i < 0x55; i++) {
> +		if (cnt + IDX_REG_LEN >= PAGE_SIZE - 1)
> +			break;
> +		val = snd_soc_read_index(codec, i);
> +		if (!val)
> +			continue;
> +		cnt += sprintf(buf + cnt, IDX_REG_FMT, i, val);
> +	}

Use the subsystem, please.

> +EXPORT_SYMBOL_GPL(rt5631_dai);

No, don't do this.  There's no need for anyone to reference the DAI.

> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_update_bits(codec, RT5631_SPK_OUT_VOL,
> +			RT_L_MUTE | RT_R_MUTE, RT_L_MUTE | RT_R_MUTE);
> +		snd_soc_update_bits(codec, RT5631_HP_OUT_VOL,
> +			RT_L_MUTE | RT_R_MUTE, RT_L_MUTE | RT_R_MUTE);

This looks very suspicous, it'll mess with whatever the user has
configured for the mutes.  This applies to quite a few places in the
driver

> +	snd_soc_add_controls(codec, rt5631_snd_controls,
> +		ARRAY_SIZE(rt5631_snd_controls));

Again, use the tables.

> +	pr_info("RT5631 initial ok!\n");

The subsystem does a perfectly good job of announcing things, and if you
do need to do prints they should use dev_ prints.

> +static int rt5631_resume(struct snd_soc_codec *codec)
> +{
> +	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
> +
> +	snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
> +		PWR_VREF | PWR_MAIN_BIAS, PWR_VREF | PWR_MAIN_BIAS);
> +	schedule_timeout_uninterruptible(msecs_to_jiffies(110));
> +	snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
> +		PWR_FAST_VREF_CTRL, PWR_FAST_VREF_CTRL);
> +	rt5631_reg_init(codec);
> +
> +	/* power off ClassD auto Recovery */
> +	if (rt5631->codec_version)
> +		snd_soc_update_bits(codec, RT5631_INT_ST_IRQ_CTRL_2,
> +					0x2000, 0x2000);
> +	else
> +		snd_soc_update_bits(codec, RT5631_INT_ST_IRQ_CTRL_2,
> +					0x2000, 0);

This looks like it should share code with the probe.

> +/*
> + * detect short current for mic1
> + */
> +int rt5631_ext_mic_detect(struct snd_soc_codec *codec)
> +{
> +	int det;
> +
> +	snd_soc_update_bits(codec, RT5631_MIC_CTRL_2,
> +		MICBIAS1_S_C_DET_MASK, MICBIAS1_S_C_DET_ENA);
> +	det = snd_soc_read(codec, RT5631_INT_ST_IRQ_CTRL_2) & 0x0001;
> +	snd_soc_update_bits(codec, RT5631_INT_ST_IRQ_CTRL_2, 0x0001,
> 0x00001);
> +
> +	return det;
> +}
> +EXPORT_SYMBOL_GPL(rt5631_ext_mic_detect);

It looks like you want to write something that slots into soc-jack.

> +	pr_info("RT5631 Audio Codec %s\n", RT5631_VERSION);

This is needlessly chatty.

> +struct i2c_driver rt5631_i2c_driver = {
> +	.driver = {
> +		.name = "rt5631-codec",
> +		.owner = THIS_MODULE,

No need for a -codec, the device only does one thing.

> +/* global definition */
> +#define RT_L_MUTE				(0x1 << 15)
> +#define RT_R_MUTE				(0x1 << 7)

Most of the constants need namespacing.
