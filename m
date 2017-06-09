From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire: process packets in
 'struct snd_pcm_ops.ack' callback
Date: Fri, 9 Jun 2017 16:01:56 +0900
Message-ID: <0daee982-a2b5-08c2-a029-f4b6de8bbf38@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
 <20170607003806.27196-2-o-takashi@sakamocchi.jp>
 <s5hd1ag5oef.wl-tiwai@suse.de> <s5hvao7337g.wl-tiwai@suse.de>
 <20170609034231.GS2885@localhost> <s5hmv9h1wk9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 298CF267563
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:02:01 +0200 (CEST)
In-Reply-To: <s5hmv9h1wk9.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org, clemens@ladisch.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jun 9 2017 15:53, Takashi Iwai wrote:
>>> From: Takashi Iwai <tiwai@suse.de>
>>> Subject: [PATCH] ALSA: pcm: Suppress status/control mmap when ack ops is
>>>   present
>>>
>>> The drivers using PCM ack ops require the notification whenever
>>> appl_ptr is updated in general.  But when the PCM status/control page
>>> is mmapped, this notification doesn't happen, per design, thus it's
>>> not guaranteed to receive the fine-grained updates.
>>>
>>> For improving the situation, this patch simply suppresses the PCM
>>> status/control mmap when ack ops is defined.  At least, for all
>>> existing drivers with ack, this should give more benefit.
>>>
>>> Once when we really need the full optimization with status/control
>>> mmap even using ack ops, we may reconsider the check, e.g. introducing
>>> a new flag.  But, so far, this should be good enough.
>>
>> Yes this makes sense and we tested it for us, looks good
>>
>> Reveiwed-by: Vinod Koul <vinod.koul@intel.com>
>> Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> 
> OK, thanks.
> 
> If Sakamato-san is happy with this change, I'm going to merge it for
> 4.13.

I'm writing a long long message about my concern for this patch. I'm 
happy if you postpone application to your for-next branch, till next week.


Thanks

Takashi Sakamoto
