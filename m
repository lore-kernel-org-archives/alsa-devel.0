From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: fix error handling for
 gpio detection
Date: Wed, 1 Feb 2017 23:41:38 -0600
Message-ID: <484655e6-a394-7701-cd70-2b7023e79499@linux.intel.com>
References: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <c41f5795-4b53-48d5-5a46-b2a579f3b931@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CEEB626750E
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 06:41:41 +0100 (CET)
In-Reply-To: <c41f5795-4b53-48d5-5a46-b2a579f3b931@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>      if (IS_ERR(rt5645->gpiod_hp_det)) {
>> -        dev_err(&i2c->dev, "failed to initialize gpiod\n");
>> -        return PTR_ERR(rt5645->gpiod_hp_det);
>> +        dev_info(&i2c->dev, "failed to initialize gpiod\n");
>> +        ret = PTR_ERR(rt5645->gpiod_hp_det);
>> +        /*
>> +         * Continue if optional gpiod is missing, bail for all other
>> +         * errors, including -EPROBE_DEFER
>> +         */
>> +        if (ret != -ENOENT)
>> +            return ret;
>>      }
>>
>>      for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
>
> (sound/soc/codecs/rt5645.c)
> rt5645_i2c_probe()
>  (drivers/gpio/devres.c)
>  ->devm_gpiod_get_optional()
>    ->devm_gpiod_get_index_optional()
>
> As long as seeing current implementation of 
> 'devm_gpiod_get_index_optional()', this function never returns ENOENT. 
> In this case, it returns NULL.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/devres.c#n185 
>
Thanks for pointing this out, I didn't see it and naively thought that 
everyone followed the same conventions. Oh well. I'll respin a v2.
