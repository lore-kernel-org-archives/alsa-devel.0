From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
 codec driver
Date: Wed, 4 May 2011 23:12:50 +0800
Message-ID: <20110504151250.GC1671@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504144600.GA7366@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id EF78810394F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 17:13:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504144600.GA7366@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Wang,
	Xingchao" <xingchao.wang@intel.com>, "Koul,
	Vinod" <vinod.koul@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 10:46:00PM +0800, Dimitris Papastamos wrote:
> On Wed, May 04, 2011 at 09:44:58PM +0800, Lu Guanqun wrote:
> > +	if (ret)
> > +		pr_err("upd9976 read of 0x%x failed, error: %d\n", reg, ret);
> > +	return value;
> > +}
> 
> dev_err() would be more preferable.

OK.

> > +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> > +	case SND_SOC_DAIFMT_CBM_CFM:
> > +	case SND_SOC_DAIFMT_CBM_CFS:
> > +		mode |= BIT(7) | BIT(3);
> > +		break;
> > +	}
> > +
> > +	return snd_soc_update_bits(codec, UPD9976_AUDIOPORT1, mask, mode);
> > +}
> 
> I am not sure whether the BIT() macro is more confusing than helpful.

I was trying to be helpful. :) but if that confuses you.,I'm OK to use hex
number.

> > +	switch (params_rate(params)) {
> > +	case 8000:
> > +		tmp = 0x00;
> > +		break;
> > +	case 11025:
> > +		tmp = 0x01;
> > +		break;
> > +	case 12000:
> > +		tmp = 0x02;
> > +		break;
> > +	case 16000:
> > +		tmp = 0x03;
> > +		break;
> > +	case 22050:
> > +		tmp = 0x04;
> > +		break;
> > +	case 24000:
> > +		tmp = 0x05;
> > +		break;
> > +	case 32000:
> > +		tmp = 0x07;
> > +		break;
> > +	case 44100:
> > +		tmp = 0x08;
> > +		break;
> > +	case 48000:
> > +		tmp = 0x09;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> Looks fine, I'd rather use an array though.

OK. Array makes it less code.

> 
> > +static int upd9976_set_bias_level(struct snd_soc_codec *codec,
> > +				  enum snd_soc_bias_level level)
> > +{
> > +	switch (level) {
> > +	case SND_SOC_BIAS_ON:
> > +		break;
> > +
> > +	case SND_SOC_BIAS_PREPARE:
> > +		if (codec->dapm.bias_level == SND_SOC_BIAS_STANDBY) {
> > +			snd_soc_update_bits(codec, UPD9976_VAUDIOCNT,
> > +					    0x27, 0x27);
> > +			snd_soc_update_bits(codec, UPD9976_VREFPLL,
> > +					    0x35, 0x35);
> > +		}
> > +		break;
> > +
> > +	case SND_SOC_BIAS_STANDBY:
> > +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x25);
> > +		snd_soc_write(codec, UPD9976_VREFPLL, 0x10);
> > +		break;
> > +
> > +	case SND_SOC_BIAS_OFF:
> > +		snd_soc_write(codec, UPD9976_VREFPLL, 0);
> > +		snd_soc_write(codec, UPD9976_VAUDIOCNT, 0x24);
> > +		break;
> > +	}
> 
> Why not snd_soc_update_bits()?  These should normally be DAPM widgets.

There's no DAPM widgets bound to these two registers. So I'm afraid it's
OK to use snd_soc_write when it's been powered off totally.

> 
> > +static int upd9976_codec_probe(struct snd_soc_codec *codec)
> > +{
> > +	upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > +
> > +	return 0;
> > +}
> 
> Why SND_SOC_BIAS_OFF and not SND_SOC_BIAS_STANDBY?

Try to use as little power as possible.

> 
> > +static int upd9976_codec_remove(struct snd_soc_codec *codec)
> > +{
> > +	return 0;
> > +}
> 
> You can call upd9976_set_bias_level(codec, SND_SOC_BIAS_OFF) here.

Thanks for reminding this.

-- 
guanqun
