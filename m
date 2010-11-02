From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] add API to allow disabling period
	interrupt
Date: Tue, 02 Nov 2010 09:23:06 +0100
Message-ID: <4CCFCA6A.8010803@ladisch.de>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B9BA424457
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 09:21:14 +0100 (CET)
In-Reply-To: <1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Sorry for not answering sooner.

Pierre-Louis Bossart wrote:
> (No filtering in pcm_multi and pcm_direct info fields)

I'm not sure whether filtering or not filtering would be a good idea for
yet unknown flags.

> + * It is not allowed to call this function when given configuration is not exactly one.
> ...
> +int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params)

This function is useless because it cannot be called before
snd_pcm_hw_params_set_period_irq().

> + * This function should be called only on devices where
> + * #snd_pcm_hw_params_can_disable_period_irq() returns true. (too late, FIXME)

Therefore, this paragraph needs to go away.

I think there should be a flag that can be added to snd_pcm_open, like
SND_PCM_NO_AUTO_RESAMPLE.

> + * Even with disabled period interrupts, the period size/time/count parameters
> + * are valid; it is suggested to use #snd_pcm_hw_params_set_period_size_last().
> + *
> + * When period interrupts are disabled, the application must not use poll() or
> + * any functions that could block on this device.

We should also mention that the application must call some update
function often enough.


Regards,
Clemens
