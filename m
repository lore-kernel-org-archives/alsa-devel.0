From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-core: WARN() is not related
 to component->driver->probe
Date: Mon, 20 May 2019 15:06:15 -0500
Message-ID: <513fa7aa-60ca-dea2-1888-1d9df531f478@linux.intel.com>
References: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
 <0ba565ea-2f61-015d-f6e3-63124f94e78a@linux.intel.com>
 <87pnoeyo9f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86954F8065E
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 22:06:17 +0200 (CEST)
In-Reply-To: <87pnoeyo9f.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

>>> 	if (component->driver->probe) {
>>> 		ret = component->driver->probe(component);
>>> 		...
>>> (A)		WARN(...)
>>> 	}
>>> (B)	WARN(...)
> (snip)
>> This WARN() was added in 2012 by ff541f4b2a75 ('ASoC: core: giving
>> WARN when device starting from non-off bias with idle_bias_off')
>>
>> The commit message hints at an intentional check
>>
>> "
>> Just found some cases that some codec drivers set the bias to _STANDBY
>> and set idle_bias_off to 1 during probing.
>> It will cause unpaired runtime_get_sync/put() issue. Also as Mark
>> suggested, there is no reason to start from _STANDBY bias with
>> idle_bias_off == 1.
>>
>> So here giving one warning when detected (dapm.idle_bias_off == 1) and
>>      (dapm.bias_level != SND_SOC_BIAS_OFF) just after driver->probe().
>> "
>>
>> My take is that unless we can prove this is incorrect we leave it as is.
> 
> I think this commit is correct, thanks.
> But, then, it sounds we need to check it even though without .prove ?

Sorry, I am not getting your question.
I don't have a trace of which codecs need this check, and I don't know 
either if this check needs to be done in other cases than the .probe(). 
Given all this, why would we try to move this WARN statement outside of 
the .probe case? It seems like asking for trouble.
