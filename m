From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Question about your DSP topic branch - hw param
	fix up query
Date: Thu, 31 Mar 2011 22:35:31 +0100
Message-ID: <1301607331.3549.215.camel@odin>
References: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>
	<438BB0150E931F4B9CE701519A44630108516FF552@bgsmsx502.gar.corp.intel.com>
	<1301512193.3375.31.camel@odin>  <4D94BDB3.4050903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 657A91037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:35:34 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 26so2608847wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 14:35:34 -0700 (PDT)
In-Reply-To: <4D94BDB3.4050903@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-31 at 10:45 -0700, Patrick Lai wrote:
> Change subject
> 
> > static int dmic_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> > 			struct snd_pcm_hw_params *params)
> > {
> > 	struct snd_interval *rate = hw_param_interval(params,
> > 			SNDRV_PCM_HW_PARAM_RATE);
> >
> > 	/* The ABE will covert the FE rate to 96k */
> > 	rate->min = rate->max = 96000;
> >
> > 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
> > 	                            SNDRV_PCM_HW_PARAM_FIRST_MASK],
> > 	                            SNDRV_PCM_FORMAT_S32_LE);
> > 	return 0;
> > }
> Liam,
> 
> For sample rate conversion case, supplying back-end hw_params_fixup 
> function would work. However, I am looking for run-time configuration of 
> back-end channel mode. For scenario of multi-channel microphone input, I 
> need to have a mean to specify channel mode of back-end depending on 
> algorithm running on DSP while front-end channel mode is mono. Is there 
> a hook in the framework to do that?
> 

Not atm, but it does sound like we need to add such a hook.

I'll add this to the conference agenda.

Thanks

Liam
