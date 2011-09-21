From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_hw_rule_noresample
Date: Wed, 21 Sep 2011 09:09:25 +0200
Message-ID: <4E798DA5.1000607@ladisch.de>
References: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
	<4E785362.2090808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E24C1103A68
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 09:08:55 +0200 (CEST)
In-Reply-To: <4E785362.2090808@ladisch.de>
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

Clemens Ladisch wrote:
> Raymond Yau wrote:
> > but snd_pcm_hw_params_get_rate_min() is still 8000Hz
> 
> This should not happen.  I'd guess the rules engine hasn't noticed
> that some parameters affected by the new rule need to change.
> 
> Please try the patch below.  But there might be drivers where other
> parameters are affected by SND_PCM_HW_PARAMS_NORESAMPLE, so I guess
> all parameter bits need to be set.

updated and applied:
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=6dab1a91cbbd

> > This patch won't affect the accuracy of the playback position of the ymfpci

When resampling is used, the interval between period interrupts is not
strictly constant, but with the noresample flag set, I guess it might
make sense to restrict the period size to a multiple of the hardware
period size.  This would at least remove the jitter from the ALSA period
interrupt timing.


The ymfpci hardware has a global sample counter, but AFAICS it is not
possible to reliably get its value at the time of a period boundary.


Regards,
Clemens
