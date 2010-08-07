From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/6] ASoC: add ADAU1361 codec driver
Date: Sat, 7 Aug 2010 23:06:29 +0100
Message-ID: <E27BA060-E4A2-4336-957A-4567769528B9@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212833_803471_D906791A)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0CF410380E
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:06:09 +0200 (CEST)
In-Reply-To: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212833_803471_D906791A)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 21:28, Mike Frysinger <vapier@gentoo.org> wrote:

> +#define AUDIO_NAME "adau1361"
> +#define ADAU1361_VERSION "0.1"

As ever, remove the version numbers and you need to convert to mullet-component.

> +#define CAP_MIC  1
> +#define CAP_LINE 2
> +#define CAPTURE_SOURCE_NUMBER 2

This looks rather like more machine driver stuff.

> +	/* dapm */
> +	u8 dapm_lineL;
> +	u8 dapm_lineR;
> +	u8 dapm_hpL;
> +	u8 dapm_hpR;

> +	addr[0] = (u8)(reg >> 8);

I suspect the casts are redundant.


> +	if (i2c_master_recv(codec->control_data, buf, len) != len)
> +		return -EIO;

Pass back the error code if you got one.

> +	if (codec->hw_write(codec->control_data, buf, count) == count)
> +		return 0;
> +	else {
> +		dev_err(codec->dev, "address block write failed.");
> +		return -EIO;

Likewise.

> +static int adau1361_mux_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct adau1361_priv *adau1361 = codec->private_data;
> +	int src = ucontrol->value.integer.value[0];
> +	u8 regvalue = 0;
> +
> +	if (src == 0) {/* Select Mic */
> +		adau1361->in_source = CAP_MIC;
> +#ifdef ADAU1361_DIG_MIC
> +		regvalue = (snd_soc_read(codec, ADAU_ADCCTL0) & 0xFB)|0x4;
> +		snd_soc_write(codec, ADAU_ADCCTL0, regvalue);
> +#else
> +		snd_soc_write(codec, ADAU_RECMBIA, RECMBIA_DISABLE);
> +		regvalue = (snd_soc_read(codec, ADAU_RECVLCL)
> +				| RECVLC_ENABLE_MASK);
> +		snd_soc_write(codec, ADAU_RECVLCL, regvalue);
> +		regvalue = (snd_soc_read(codec, ADAU_RECVLCR)
> +				| RECVLC_ENABLE_MASK);
> +		snd_soc_write(codec, ADAU_RECVLCR, regvalue);
> +		snd_soc_write(codec, ADAU_RECMLC1, RECMLC_MIC_0DB);
> +		snd_soc_write(codec, ADAU_RECMRC1, RECMLC_MIC_0DB);

As well as the issue with the configuration of the digital microphone with an ifdef rather than a runtime selection it looks rather like this register configuration is doing a bunch of stuff like configuring volume controls and power which I'd rather expect to be done elsewhere.

> +static int adau1361_mic_boost_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct adau1361_priv *adau1361 = codec->private_data;
> +	int val = ucontrol->value.integer.value[0];
> +	u8 regvalue = 0;
> +
> +	if (adau1361->in_source & CAP_MIC) {
> +		regvalue = (val) ? RECMLC_MIC_20DB : RECMLC_MIC_0DB;
> +		if (snd_soc_read(codec, ADAU_RECMLC1) != regvalue) {
> +			snd_soc_write(codec, ADAU_RECMLC1, regvalue);
> +			snd_soc_write(codec, ADAU_RECMRC1, regvalue);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}

I'm having a hard time seeing why you're not just using standard controls here. You've also got a mono control exposed to the user but apparently stereo control in the chip - that seems restrictive for machine drivers (for example, a system might have a mono microphone plus a line input).

> 
> +static int adau1361_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	u8 reg = 0;
> +
> +	if (mute) {
> +		/* mute inputs */
> +		reg = (snd_soc_read(codec, ADAU_RECMLC0) & 0xFE) | 0x0;
> +		snd_soc_write(codec, ADAU_RECMLC0, reg);
> +		reg = (snd_soc_read(codec, ADAU_RECMRC0) & 0xFE) | 0x0;
> +		snd_soc_write(codec, ADAU_RECMRC0, reg);
> +		/* mute outputs */
> +		reg = (snd_soc_read(codec, ADAU_PLBMLC0) & 0xFE) | 0x1;
> +		snd_soc_write(codec, ADAU_PLBMLC0, reg);
> +		reg = (snd_soc_read(codec, ADAU_PLBMRC0) & 0xFE) | 0x1;
> +		snd_soc_write(codec, ADAU_PLBMRC0, reg);

Ick, no. Your mute control should be muting and unmuting the DAC only. Quite apart from anything else this is going to leave the inputs muted unless there's an active playback which seems likely to cause problems during recordings.


> +static int adau1361_pll_enable(struct snd_soc_codec *codec, int enable)
> +{
> +	struct adau1361_priv *adau1361 = codec->private_data;
> +	u8 *pll_reg = adau1361->adau1361_pll_reg;
> +	int counter = 0;
> +
> +	if (enable) {
> +		pll_reg[5]  = PLLCTRL_ENABLE;
> +		adau1361_write_reg_block(codec, ADAU_PLLCTRL, 6, pll_reg);
> +
> +		/* wait for PLL lock*/
> +		do {
> +			++counter;
> +			schedule_timeout_interruptible(msecs_to_jiffies(1));
> +			adau1361_read_reg_block(codec, ADAU_PLLCTRL, 6);

Why interruptible?

> +		if (counter >= 20)
> +			return -1;

Return proper error codes.


> +	/* unmute outputs */
> +	snd_soc_write(codec, ADAU_PLBHPVL, DAPM_HP_DEF);
> +	snd_soc_write(codec, ADAU_PLBHPVR, DAPM_HP_DEF);
> +	snd_soc_write(codec, ADAU_PLBLOVL, DAPM_LINE_DEF);
> +	snd_soc_write(codec, ADAU_PLBLOVR, DAPM_LINE_DEF);

Use chip defaults (this also applies to the register setting above).

> +	/* initialize the PLL */
> +	if (adau1361_pll_init(codec) != 0)
> +		return -EINVAL;

Pass back the error code.

> +	reg = (snd_soc_read(codec, ADAU_SPRTCT0) & 0xFE);
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:  /*master*/
> +		reg |= 0x1;
> +		break;
> +	case SND_SOC_DAIFMT_CBS_CFS: /*slave*/
> +		reg &= ~0x1;
> +		break;
> +	default:
> +		return 0;
> +	}

Return an error if the mode is unsupported here and elsewhere.

> +static int adau1361_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +		int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct adau1361_priv *adau1361 = codec->private_data;
> +
> +	switch (freq) {
> +	case 12000000:
> +		adau1361->sysclk = freq;
> +		return 0;
> +	case 12288000:
> +		adau1361->sysclk = freq;
> +		return 0;
> +	}
> +
> +	/* supported 12MHz MCLK only for now */
> +	return -EINVAL;
> +

Similar comments to the previous driver here - use the default for the switch statement and your comment is bit. I've not made further comments on this but many of the issues in the driver I previously reviewed also apply here.
