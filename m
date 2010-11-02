From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/2] add API to allow disabling period
 interrupt
Date: Tue, 2 Nov 2010 09:38:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7214324460
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 09:38:11 +0100 (CET)
In-Reply-To: <4CCFCA6A.8010803@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Pierre-Louis Bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Nov 2010, Clemens Ladisch wrote:

>> + * It is not allowed to call this function when given configuration is not exactly one.
>> ...
>> +int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params)
>
> This function is useless because it cannot be called before
> snd_pcm_hw_params_set_period_irq().

I don't think so. The info bits from the driver are used in this check 
which are read-only.

>> + * This function should be called only on devices where
>> + * #snd_pcm_hw_params_can_disable_period_irq() returns true. (too late, FIXME)
>
> Therefore, this paragraph needs to go away.
>
> I think there should be a flag that can be added to snd_pcm_open, like
> SND_PCM_NO_AUTO_RESAMPLE.

It's not required. It's better to allow checking if no period update 
feature is available after snd_pcm_open().

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
