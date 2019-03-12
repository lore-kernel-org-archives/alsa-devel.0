From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: test memory
 allocation
Date: Tue, 12 Mar 2019 22:08:19 +0100
Message-ID: <6be2cdb4-1891-2e4d-9b3b-d88a323c8347@linux.intel.com>
References: <20190309020252.27860-1-pierre-louis.bossart@linux.intel.com>
 <20190309020252.27860-2-pierre-louis.bossart@linux.intel.com>
 <87pnqyuvcl.wl-kuninori.morimoto.gx@renesas.com>
 <831fdf7a-0239-9d6b-f8b8-21ca077c9009@linux.intel.com>
 <87sgvs9821.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCDB7F8961E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 05:38:04 +0100 (CET)
In-Reply-To: <87sgvs9821.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>>>    	cconf     = devm_kcalloc(dev, li.conf, sizeof(*cconf),     GFP_KERNEL);
>>>> -	if (!dai_props || !dai_link || !dais)
>>>> +	if (!dai_props || !dai_link || !dais || !cconf)
>>>>    		return -ENOMEM;
>>>
>>> It isn't mentioned on code, but, "li.conf" will be 0 if it was not DPCM case.
>>> This means cconf NULL might be happen.
>>
>>
>> Humm, then don't call devm_kcalloc with a zero argument...
>> And if you keep this code, if li.conf is not zero you still have a
>> risk of memory allocation failure. the test should be
>>
>> +	if (!dai_props || !dai_link || !dais || (!cconf && li.conf))
> 
> Yes, indeed.
> Thank you for your feedback
> 
> Actually, I have few cleanup patches for simple-card/audio-graph
> for v5.2, then, your patch and it will be conflict.
> If you are OK, I can merge your patch on my patch-set with your
> Signed-off-by (or Reported-by).
> Is OK for you ? I will post it when -rc1 was released from Linus.

yes, that's fine. Thanks!
