From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 01/10] ASoC: upd9976: Add Renesas
 uPD9976 codec driver
Date: Fri, 6 May 2011 11:17:27 +0100
Message-ID: <20110506101726.GF23729@opensource.wolfsonmicro.com>
References: <20110506053852.26312.79083.stgit@localhost>
	<20110506054603.26312.42120.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7CCD2437B
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 12:17:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110506054603.26312.42120.stgit@localhost>
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
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 01:46:03PM +0800, Lu Guanqun wrote:

> +static inline unsigned int upd9976_read(struct snd_soc_codec *codec,
> +					unsigned int reg)
> +{
> +	u8 value = 0;
> +	int ret;
> +
> +	ret = intel_scu_ipc_ioread8(reg, &value);
> +	if (ret)
> +		dev_err(codec->dev,
> +			"upd9976 read of 0x%x failed, error: %d\n", reg, ret);
> +	return value;
> +}

Please factor this stuff out.

> +/*
> + * Mixing Volume: from -25 dB to 6 dB in 1 dB steps.
> + */
> +static DECLARE_TLV_DB_SCALE(mixer_tlv, -2500, 100, 0);
> +
> +/*
> + * Audio DAC Volume: From -84 dB to 10.5 dB in 0.75 steps.
> + */
> +static DECLARE_TLV_DB_SCALE(adac_tlv, -8400, 75, 0);
> +static const struct snd_kcontrol_new upd9976_snd_controls[] = {

Use of blank lines here is really odd.

> +	SOC_DOUBLE_R_TLV("Master Volume",
> +			 UPD9976_AUDIOLVOL, UPD9976_AUDIORVOL,
> +			 0, 0x7f, 1, adac_tlv),
> +	SOC_DOUBLE_R_TLV("PCM Volume",
> +			 UPD9976_HPSPRLVOL, UPD9976_HPSPRRVOL,
> +			 0, 0x1f, 1, mixer_tlv),

PCM would usually be a digital audio stream but this is a control for a
mixer.

> +static struct snd_soc_dai_driver upd9976_dais[] = {
> +{
> +	.name = "upd9976-audio",

Previous issue with naming still applies.

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

This is all very magic and lots of what's going on (especially with
VAUDIOCNT) looks like it's actually trying to fiddle with bitmasks.
