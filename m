From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_hw_rule_noresample
Date: Tue, 20 Sep 2011 10:48:34 +0200
Message-ID: <4E785362.2090808@ladisch.de>
References: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8098624470
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 10:48:03 +0200 (CEST)
In-Reply-To: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> ALSA: pcm: add snd_pcm_hw_rule_noresample()
> ...
> 
> ymfpci and emu10k1 have SNDRV_PCM_RATE_CONTINUOUS and support 8000Hz to 48000Hz
> 
> after this patch and if application using
> snd_pcm_hw_params_set_rate_resample(,pcm , params ,0)
> 
> why the supported rate is only 48000Hz ?

Because these cards run at 48 kHz and resample anything else.  That
the resampler is implemented in hardware does not make a conceptual
difference, and just means that the resampler has low quality.

> but snd_pcm_hw_params_get_rate_min() is still 8000Hz

This should not happen.  I'd guess the rules engine hasn't noticed
that some parameters affected by the new rule need to change.

Please try the patch below.  But there might be drivers where other
parameters are affected by SND_PCM_HW_PARAMS_NORESAMPLE, so I guess
all parameter bits need to be set.

> This patch won't affect the accuracy of the playback position of the ymfpci

Why should it?


Regards,
Clemens


--- alsa-lib/src/pcm/pcm.c
+++ alsa-lib/src/pcm/pcm.c
@@ -4176,6 +4176,7 @@ int snd_pcm_hw_params_set_rate_resample(snd_pcm_t *pcm, snd_pcm_hw_params_t *par
 		params->flags |= SND_PCM_HW_PARAMS_NORESAMPLE;
 	else
 		params->flags &= ~SND_PCM_HW_PARAMS_NORESAMPLE;
+	params->rmask |= 1 << SNDRV_PCM_HW_PARAM_RATE;
 	return snd_pcm_hw_refine(pcm, params);
 }
 
