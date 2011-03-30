From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA hw sample rate conversion support
Date: Wed, 30 Mar 2011 20:09:53 +0100
Message-ID: <1301512193.3375.31.camel@odin>
References: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
	<438BB0150E931F4B9CE701519A44630108516FF552@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B77641037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 21:09:57 +0200 (CEST)
Received: by wyg36 with SMTP id 36so1488651wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2011 12:09:57 -0700 (PDT)
In-Reply-To: <438BB0150E931F4B9CE701519A44630108516FF552@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark <broonie@opensource.wolfsonmicro.com>, Aisheng Dong <dongas86@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-30 at 21:02 +0530, Koul, Vinod wrote:
> Aisheng Dong wrote:
> > Hi ALL,
> > 
> > Does ALSA core support hw sample rate conversion now?
> > Our soc has a HW sample rate converter module inside,
> > I wonder if current ALSA core provide interface to support hw sample
> > rate conversion?
> > 
> Assuming the SRC is inside SoC and you are converting sampling rate of stream
> and sending at different rate, then I have a patch for you.
> Basically the soc side hw_params should call a new API which call
> codec_set_params() and sets the matching rate.
> 
> Something like this in soc-core
> 
> +int snd_soc_codec_set_params(struct snd_soc_codec *codec, unsigned int param)
> +{
> +       if (codec->driver->set_params)
> +               return codec->driver->set_params(codec, param);
> +       else
> +               return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_codec_set_params);
> 
> Mark,
> Would you okay with such a patch where DSP is doing some conversion and codec
> will get different params from what stream is set up? And we make sure 
> conversion is synced

Fwiw, I've already implemented a hw_params() fixup between the DSP and
CODEC drivers. This is in my dsp branch atm here :-

http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-2.6.git;a=shortlog;h=refs/heads/topic/dsp-upstream

This allows us to rewrite channels, rates, formats etc. depending on the
use case and can be part of the machine driver e.g. (from sdp4430.c)

static int mcbsp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
			struct snd_pcm_hw_params *params)
{
	struct snd_interval *channels = hw_param_interval(params,
                                       SNDRV_PCM_HW_PARAM_CHANNELS);
	unsigned int be_id = rtd->dai_link->be_id;

	if (be_id == OMAP_ABE_DAI_MM_FM)
		channels->min = 2;
	else if (be_id == OMAP_ABE_DAI_BT_VX)
		channels->min = 1;
	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
	                            SNDRV_PCM_HW_PARAM_FIRST_MASK],
	                            SNDRV_PCM_FORMAT_S16_LE);
	return 0;
}

static int dmic_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
			struct snd_pcm_hw_params *params)
{
	struct snd_interval *rate = hw_param_interval(params,
			SNDRV_PCM_HW_PARAM_RATE);

	/* The ABE will covert the FE rate to 96k */
	rate->min = rate->max = 96000;

	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
	                            SNDRV_PCM_HW_PARAM_FIRST_MASK],
	                            SNDRV_PCM_FORMAT_S32_LE);
	return 0;
}

I intend to start upstreaming all this stuff when I return from holiday
on the 11th April (in time for 2.6.40).

Liam
