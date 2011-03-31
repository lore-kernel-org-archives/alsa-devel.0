From: Patrick Lai <plai@codeaurora.org>
Subject: Question about your DSP topic branch - hw param fix up
	query
Date: Thu, 31 Mar 2011 10:45:23 -0700
Message-ID: <4D94BDB3.4050903@codeaurora.org>
References: <AANLkTikT+O+D1wQCVa0vsOQyMJcEHP9+9JEfCm=q+bho@mail.gmail.com>	<438BB0150E931F4B9CE701519A44630108516FF552@bgsmsx502.gar.corp.intel.com>
	<1301512193.3375.31.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FF5E244AD
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 19:45:42 +0200 (CEST)
In-Reply-To: <1301512193.3375.31.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Change subject

> static int dmic_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
> 			struct snd_pcm_hw_params *params)
> {
> 	struct snd_interval *rate = hw_param_interval(params,
> 			SNDRV_PCM_HW_PARAM_RATE);
>
> 	/* The ABE will covert the FE rate to 96k */
> 	rate->min = rate->max = 96000;
>
> 	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
> 	                            SNDRV_PCM_HW_PARAM_FIRST_MASK],
> 	                            SNDRV_PCM_FORMAT_S32_LE);
> 	return 0;
> }
Liam,

For sample rate conversion case, supplying back-end hw_params_fixup 
function would work. However, I am looking for run-time configuration of 
back-end channel mode. For scenario of multi-channel microphone input, I 
need to have a mean to specify channel mode of back-end depending on 
algorithm running on DSP while front-end channel mode is mono. Is there 
a hook in the framework to do that?

Thanks
Patrick

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
