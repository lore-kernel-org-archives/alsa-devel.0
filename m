From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for Cirrus Logic CS42L73
 Codec
Date: Fri, 16 Sep 2011 11:17:20 +0100
Message-ID: <20110916101720.GA25354@sirena.org.uk>
References: <1316097648-28066-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9FA243BE
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 12:17:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316097648-28066-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, joe@nucleusys.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 09:40:48AM -0500, Brian Austin wrote:
> ---

This patch can't be applied as you haven't signed it off.  Please follow
the process in Documentation/SubmittingPatches, including the bit about
always CCing maintainers on patches.

> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>

Platform device?

> +struct  cs42l73_private {
> +	enum snd_soc_control_type control_type;
> +	void *control_data;
> +	u8 reg_cache[CS42L73_CACHEREGNUM];

Use the standard cache infrastructure, don't open code it.

> +int cs42l73_write(struct snd_soc_codec *codec, unsigned reg, u_int val)
> +{
> +	u8 data[2];
> +
> +	if (reg > CS42L73_CACHEREGNUM)
> +		return -EINVAL;

Use the standard I/O infrastructure too.

> +int cs42l73_get_volsw(struct snd_kcontrol *kcontrol,
> +		      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct soc_mixer_control *mc =
> +	    (struct soc_mixer_control *)kcontrol->private_value;
> +
> +	unsigned int reg = mc->reg;
> +	unsigned int shift = mc->shift;
> +	unsigned int rshift = mc->rshift;
> +	int max = mc->max;
> +	int min = mc->min;
> +	int mmax = (max > min) ? max:min;
> +	unsigned int mask = (1 << fls(mmax)) - 1;
> +
> +	ucontrol->value.integer.value[0] =
> +	    ((cs42l73_read(codec, reg) >> shift) - min) & mask;
> +	if (shift != rshift)
> +		ucontrol->value.integer.value[1] =
> +		    ((cs42l73_read(codec, reg) >> rshift) - min) & mask;

Why is this open coded?  This doesn't look driver specific and...

> +#define SOC_SINGLE_S8_C_TLV(xname, xreg, xshift, xmax, xmin, tlv_array) \
> +{       .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \

...the names given are obviously not driver specific names.

> +/* ESL-ASP, ESL-XSP, SPK-ASP, SPK-XSP Mono Mixer Selects */
> +static const struct soc_enum mono_mixer_enum[] = 
> +{
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 6,
> +		ARRAY_SIZE (cs42l73_mono_mixer_text), cs42l73_mono_mixer_text),
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 4,
> +		ARRAY_SIZE (cs42l73_mono_mixer_text), cs42l73_mono_mixer_text),
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 2,
> +		ARRAY_SIZE (cs42l73_mono_mixer_text), cs42l73_mono_mixer_text),
> +	SOC_ENUM_SINGLE(CS42L73_MMIXCTL, 0,
> +		ARRAY_SIZE (cs42l73_mono_mixer_text), cs42l73_mono_mixer_text),
> +};

Don't use arrays of controls, use named variables.  Arrays are error
prone when referencing.

> +static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
> +/* 
> +    SOC_DOUBLE_R_S8_C (..., max, min)
> +    min - min from CS datasheet
> +    max - fls(max) - min + max from CS datasheet
> +*/

In general you've got rather a lot of comments pointing out very obvious
things.

> +/* Volume */

Indentation here and throughout the table.

> +	SND_SOC_DAPM_MICBIAS("MIC1 Bias", CS42L73_PWRCTL2, 6, 1),
> +	SND_SOC_DAPM_INPUT("MIC2"),
> +	SND_SOC_DAPM_MICBIAS("MIC2 Bias", CS42L73_PWRCTL2, 7, 1),

Just use supply widgets.

> +static int cs42l73_add_widgets(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_new_controls(dapm, cs42l73_dapm_widgets,
> +				  ARRAY_SIZE(cs42l73_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));

Just initialize these using the driver structure.

> +	/* MCLKX -> MCLK */
> +	mclkx_coeff = cs42l74_get_mclkx_coeff(priv->sysclk);
> +
> +	if (mclkx_coeff < 0) 
> +		return -EINVAL;

Better to pass through the error code you got.

> +static int cs42l73_set_sysclk(struct snd_soc_dai *dai,
> +			      int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	if (clk_id != CS42L73_CLKID_MCLK1 && clk_id != CS42L73_CLKID_MCLK2) {
> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
> +		return -EINVAL;
> +	}
> +
> +	if ((cs42l74_get_mclkx_coeff(freq) < 0)) {
> +		dev_err(codec->dev, "Invalid sysclk %u\n", freq);
> +		return -EINVAL;
> +	}
> +

This ought to be a switch statement I think.

> +	priv->sysclk = freq;
> +	priv->mclksel = clk_id;
> +
> +	return cs42l73_set_mclk(dai);

With this we could assign the variables and then fail.

> +/*
> +	cs42l73_set_dai_clkdiv()
> +		Setup MCLKx, MMCC dividers.
> +		The dividers are selected from the MCLKX and the 
> +		sample rate. 
> +*/

Coding style.

> +static int cs42l73_set_clkdiv(struct snd_soc_dai *codec_dai,
> +                int div_id, int div)
> +{
> +        struct snd_soc_codec *codec = codec_dai->codec;
> +	int id = codec_dai->id;
> +        u8 reg;

Indentation.

> +        switch (div_id) {
> +        case CS42L73_MCLKXDIV:
> +		/* MCLKDIV */
> +                reg = cs42l73_read(codec, CS42L73_DMMCC) & 0xf1;
> +		cs42l73_write(codec, CS42L73_DMMCC, 
> +					reg | ((div & 0x07) << 1));

Coding style and indentation are both bad here.  checkpatch should spot
some of this.  You should use snd_soc_update_bits() too (and throughout
the code), and the comment should be fairly obvious but actually doesn't
agree with the constant.

Also, why are users having to explicitly set this stuff, can't the
driver work this out?

> +static u32 cs42l73_asrc_rates[] = {
> +	8000, 11025, 12000, 16000, 22050,
> +	24000, 32000, 44100, 48000
> +};
> +
> +static unsigned int cs42l73_get_xspfs_coeff(u32 rate)
> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(cs42l73_asrc_rates); i++) {
> +		if (cs42l73_asrc_rates[i] == rate)
> +			return (i + 1);
> +	}
> +	return 0;		/* 0 = Don't know */
> +}

Shouldn't you return an error?

> +
> +static void cs42l73_update_asrc(struct snd_soc_codec *codec, int id, int srate)
> +{
> +	u8 spfs = 0;
> +	u8 reg;
> +	
> +	if (srate > 0)
> +	  spfs = cs42l73_get_xspfs_coeff(srate);
> +		  
> +	switch (id) {
> +	  case CS42L73_XSP:
> +	    reg = cs42l73_read(codec, CS42L73_VXSPFS);

Coding style.  There's a lot more issues than I've been pointing out, in
general if your code doesn't visually resemble other Linux code there's
an issue.

> +	case SND_SOC_BIAS_STANDBY:
> +	  /* Powerdown all ports, inputs and outputs */
> +	  cs42l73_write(codec, CS42L73_DMMCC, dmmcc & ~ MCLKDIS);
> +	  
> + 	  cs42l73_write(codec, CS42L73_PWRCTL3,
> +		      PDN_THMS | PDN_SPKLO | PDN_EAR |
> +		      PDN_SPK | PDN_LO | PDN_HP);
> +	  
> +	  cs42l73_write(codec, CS42L73_PWRCTL2,
> +		      PDN_MIC2_BIAS | PDN_MIC1_BIAS |
> +		      PDN_VSP | PDN_ASP_SDOUT | PDN_ASP_SDIN | 
> +		      PDN_XSP_SDOUT | PDN_XSP_SDIN);
> +	 
> +	  cs42l73_write(codec, CS42L73_PWRCTL1,
> +		      PDN_ADCB | PDN_ADCA | PDN_DMICB | 
> +		      PDN_DMICA | PDN);
> +	    break;

This looks like it should all be managed by DAPM.

> +static void cs42l73_shutdown(struct snd_pcm_substream *substream,
> +                            struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	int id = dai->id;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +	priv->config[id].srate = 0;
> +	cs42l73_update_asrc(codec,id,0);
> +}

What happens with simultaneous playback and record?

> +static int cs42l73_resume(struct snd_soc_codec *codec)
> +{
> +	int i;
> +	u8 *cache = codec->reg_cache;
> +	
> +	/* Sync reg_cache with the hardware */
> +	for (i = CS42L73_PWRCTL1; i < ARRAY_SIZE(cs42l73_reg); i++) {
> +		cs42l73_write(codec, i, cache[i]);
> +	}

There's standard infrastructure for this too.

> +/* CS42L73_PWRCTL1 */
> +#define PDN_ADCB	(1 << 7)
> +#define PDN_DMICB	(1 << 6) 
> +#define PDN_ADCA        (1 << 5)
> +#define PDN_DMICA       (1 << 4)
> +#define PDN_LDO         (1 << 2)
> +#define DISCHG_FILT     (1 << 1)
> +#define PDN             (1 << 0)

Namespacing here and elsewhere in the header.
