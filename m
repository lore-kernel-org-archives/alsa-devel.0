From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC, master clock direction
Date: Fri, 18 Jul 2008 15:44:37 -0400
Message-ID: <9e4733910807181244k1ad1a2f8tecfd8d2baa463f57@mail.gmail.com>
References: <9e4733910807180954s47157b84m90eed202d4ab3dc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id EB6DD2458B
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:44:38 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so191540qwf.56
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 12:44:37 -0700 (PDT)
In-Reply-To: <9e4733910807180954s47157b84m90eed202d4ab3dc2@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/18/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> The MPC5200 has three clock configurations
>
>  1) Clock out, normal master mode
>  2) Clock in, normal slave mode
>  3) Something Freescale calls cellphone slave but it is more like clock
>  distribution.
>
>  In cellslave mode one i2s port is in normal slave mode. The clock from
>  this port is used to drive up to three other i2s ports in master mode.
>
>  I have two choices for set_sysclk:
>  #define SND_SOC_CLOCK_IN        0
>  #define SND_SOC_CLOCK_OUT       1
>
>  When the clock frequency changes I need to notify the i2s drivers for
>  the dependent channels. Do we need a third choice,
>  SND_SOC_CLOCK_SLAVE? Alternatively I can use another clock id value.

I can implement it like this, in cellslave mode I just record the
frequency, CLOCK_OUT not in cellslave mode needs to set up the
internal MPC clock generation (which can't make accurate audio
clocks).

static int psc_i2s_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
			      int clk_id, unsigned int freq, int dir)
{
	struct psc_i2s *psc_i2s = cpu_dai->private_data;
	dev_dbg(psc_i2s->dev, "psc_i2s_set_sysclk(cpu_dai=%p, freq=%ui, dir=%i)\n",
				cpu_dai, freq, dir);
	switch (dir) {
	case SND_SOC_CLOCK_IN:
		return 0;
	case SND_SOC_CLOCK_OUT:
	default:
		if (!(psc_i2s->sicr & MPC52xx_PSC_SICR_CELLSLAVE)) {
			/* implement me */
			/* compute and set the needed dividers for the internal clock */
			return -EINVAL;
		}
		psc_i2s->sysclk = freq;
		return -EINVAL;
	}
}


static int psc_i2s_hw_params(struct snd_pcm_substream *substream,
				 struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct psc_i2s *psc_i2s = rtd->dai->cpu_dai->private_data;
	u32 sicr, rate, bits, bitblk, err, wordclk;

	dev_dbg(psc_i2s->dev, "%s(substream=%p) p_size=%i p_bytes=%i"
		" periods=%i buffer_size=%i  buffer_bytes=%i\n",
		__FUNCTION__, substream, params_period_size(params),
		params_period_bytes(params), params_periods(params),
		params_buffer_size(params), params_buffer_bytes(params));

	sicr = psc_i2s->sicr;
	switch (params_format(params)) {
	 case SNDRV_PCM_FORMAT_S8:
		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_8;
		bits = 8;
		break;
	 case SNDRV_PCM_FORMAT_S16_BE:
		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_16;
		bits = 16;
		break;
	 case SNDRV_PCM_FORMAT_S24_BE:
		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_24;
		bits = 24;
		break;
	 case SNDRV_PCM_FORMAT_S32_BE:
		sicr |= MPC52xx_PSC_SICR_SIM_CODEC_32;
		bits = 32;
		break;
	 default:
		dev_dbg(psc_i2s->dev, "invalid format\n");
		return -EINVAL;
	}
	out_be32(&psc_i2s->psc_regs->sicr, sicr);
	
	if (psc_i2s->sysclk) {
		switch (params_rate(params)) {
		case SNDRV_PCM_RATE_5512: rate = 5512; break;
		case SNDRV_PCM_RATE_8000: rate = 8000; break;
		case SNDRV_PCM_RATE_11025: rate = 11025; break;
		case SNDRV_PCM_RATE_16000: rate = 16000; break;
		case SNDRV_PCM_RATE_22050: rate = 22050; break;
		case SNDRV_PCM_RATE_32000: rate = 32000; break;
		case SNDRV_PCM_RATE_44100: rate = 44100; break;
		case SNDRV_PCM_RATE_48000: rate = 48000; break;
		case SNDRV_PCM_RATE_64000: rate = 64000; break;
		case SNDRV_PCM_RATE_88200: rate = 88200; break;
		case SNDRV_PCM_RATE_96000: rate = 96000; break;
		case SNDRV_PCM_RATE_176400: rate = 176400; break;
		case SNDRV_PCM_RATE_192000: rate = 192000; break;
		 default:
			dev_dbg(psc_i2s->dev, "invalid format\n");
			return -EINVAL;
		}
		bitclk = psc_i2s->sysclk / rate;
		wordclk = bitclk / bits;
		out_be32(&psc_i2s->psc_regs->ccr, (bitclk - 1) << 24 | (wordclk << 16);
	}

	//rc = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
	//if (rc) {
	//	dev_err(psc_i2s->dev, "could not allocate dma buffer\n");
	//	return rc;
	//}

	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);

	return 0;
}



>
>
>  --
>  Jon Smirl
>  jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
