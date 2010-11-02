From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] add API to allow disabling period
	interrupt
Date: Tue, 02 Nov 2010 10:04:15 +0100
Message-ID: <4CCFD40F.1010407@ladisch.de>
References: <1288649614-31581-1-git-send-email-pierre-louis.bossart@intel.com>
	<1288649614-31581-2-git-send-email-pierre-louis.bossart@intel.com>
	<4CCFCA6A.8010803@ladisch.de>
	<alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 286F01038E3
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 10:02:24 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1011020935550.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <bossart.nospam@gmail.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 2 Nov 2010, Clemens Ladisch wrote:
>>> + * It is not allowed to call this function when given configuration is not exactly one.
>>> ...
>>> +int snd_pcm_hw_params_can_disable_period_irq(const snd_pcm_hw_params_t *params)
>>
>> This function is useless because it cannot be called before
>> snd_pcm_hw_params_set_period_irq().
> 
> I don't think so. The info bits from the driver are used in this check 
> which are read-only.

All the snd_pcm_hw_params_can_* functions that read the info bits
are documented to require a completed configuration.  So they actually
don't, and there will never be a flag that depends on the configuration?


Regards,
Clemens
