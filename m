From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas
	uPD9976	codec driver
Date: Wed, 4 May 2011 15:46:00 +0100
Message-ID: <20110504144600.GA7366@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F281F103937
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 16:46:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504134458.32443.45825.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wang Xingchao <xingchao.wang@intel.com>, Koul Vinod <vinod.koul@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> uPD9976 is a complex codec, however this patch only provides basic playback
> functionality for headphone. More functionality will be added bit by bit in the
> following patches.
> 
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>

> +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> +					unsigned int reg)
> +{
> +	u8 value = 0;
> +	int ret;
> +
> +	ret = intel_scu_ipc_ioread8(reg, &value);
> +	if (ret)
> +		pr_err("upd9976 read of 0x%x failed, error: %d\n", reg, ret);
> +	return value;
> +}

dev_err() would be more preferable.

> +static int upd9976_audio_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int mode, mask;
> +
> +	mask = BIT(5) | BIT(4);
> +	mode = 0;
> +
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		mode |= BIT(4);
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		mode |= BIT(5);
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		mode |= BIT(5) | BIT(4);
> +		break;
> +	}
> +
> +	mask |= BIT(7) | BIT(3);
> +
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		mode |= BIT(7) | BIT(3);
> +		break;
> +	}
> +
> +	return snd_soc_update_bits(codec, UPD9976_AUDIOPORT1, mask, mode);
> +}

I am not sure whether the BIT() macro is more confusing than helpful.

> +static int upd9976_audio_hw_params(struct snd_pcm_substream *substream,
> +				   struct snd_pcm_hw_params *params,
> +				   struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	unsigned int tmp;
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		tmp = 0x00;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		tmp = 0x03;
> +		break;
> +	case SNDRV_PCM_FORMAT_S18_3LE:
> +		tmp = 0x01;
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		tmp = 0x02;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	snd_soc_update_bits(codec, UPD9976_AUDIOPORT1,
> +			    BIT(2)|BIT(1)|BIT(0), tmp);
> +
> +	switch (params_rate(params)) {
> +	case 8000:
> +		tmp = 0x00;
> +		break;
> +	case 11025:
> +		tmp = 0x01;
> +		break;
> +	case 12000:
> +		tmp = 0x02;
> +		break;
> +	case 16000:
> +		tmp = 0x03;
> +		break;
> +	case 22050:
> +		tmp = 0x04;
> +		break;
> +	case 24000:
> +		tmp = 0x05;
> +		break;
> +	case 32000:
> +		tmp = 0x07;
> +		break;
> +	case 44100:
> +		tmp = 0x08;
> +		break;
> +	case 48000:
> +		tmp = 0x09;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Looks fine, I'd rather use an array though.

> +static int upd9976_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +
> +	case SND_SOC_BIAS_PREPARE:
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
> +			snd_soc_update_bits(codec, UPD9976_VAUDIOCNT,
> +					    0x27, 0x27);
> +			snd_soc_update_bits(codec, UPD9976_VREFPLL,
> +					    0x35, 0x35);
> +		}
> +		break;
> +
> +	case SND_SOC_BIAS_STANDBY:
> +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x25);
> +		snd_soc_write(codec, UPD9976_VREFPLL, 0x10);
> +		break;
> +
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, UPD9976_VREFPLL, 0);
> +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x24);
> +		break;
> +	}

Why not snd_soc_update_bits()?  These should normally be DAPM widgets.

> +static int upd9976_codec_probe(struct snd_soc_codec *codec)
> +{
> +	upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +
> +	return 0;
> +}

Why SND_SOC_BIAS_OFF and not SND_SOC_BIAS_STANDBY?

> +static int upd9976_codec_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

You can call upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF) here.

Thanks,
Dimitris
