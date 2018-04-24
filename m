From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: improve support for ancient
	firmware for DICE
Date: Tue, 24 Apr 2018 21:57:25 +0900
Message-ID: <8c006d95-553e-be2f-ca54-b5663f0a0acc@sakamocchi.jp>
References: <20180422120759.15579-1-o-takashi@sakamocchi.jp>
 <201804230032.0xnJM97d%fengguang.wu@intel.com> <s5hlgdcrfic.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F408226722C
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 14:57:30 +0200 (CEST)
In-Reply-To: <s5hlgdcrfic.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 24 2018 20:49, Takashi Iwai wrote:
> On Sun, 22 Apr 2018 20:25:36 +0200,
> kbuild test robot wrote:
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> sound/firewire/dice/dice-transaction.c:334:21: sparse: restricted __be32 degrades to integer
>>     sound/firewire/dice/dice-transaction.c:336:21: sparse: restricted __be32 degrades to integer
>>
>> vim +334 sound/firewire/dice/dice-transaction.c
> (snip)
>>     333		/* Old firmware doesn't support these fields. */
>>   > 334		if (pointers[7] > 0)
>>     335			dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
>>     336		if (pointers[9] > 0)
>>     337			dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
> 
> The warning looks reasonable.

Yep. The integer value can be negative.

> Alternatively, you can rewrite it as a non-zero check:
> 	if (pointers[7])
> 		....
> Then it would be OK without endian conversion.

OK. I'll repost.


Thanks

Takashi Sakamoto
