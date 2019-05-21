From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][RFC] ASoC: soc-core: WARN() is not related
 to component->driver->probe
Date: Tue, 21 May 2019 09:22:47 -0500
Message-ID: <5d16b18e-fd21-931a-ced6-f682afffc5b8@linux.intel.com>
References: <87imu939x3.wl-kuninori.morimoto.gx@renesas.com>
 <0ba565ea-2f61-015d-f6e3-63124f94e78a@linux.intel.com>
 <87pnoeyo9f.wl-kuninori.morimoto.gx@renesas.com>
 <513fa7aa-60ca-dea2-1888-1d9df531f478@linux.intel.com>
 <87d0kctzwb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6B07F806E7
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 16:23:05 +0200 (CEST)
In-Reply-To: <87d0kctzwb.wl-kuninori.morimoto.gx@renesas.com>
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

On 5/20/19 7:42 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>>>> 	if (component->driver->probe) {
>>>>> 		ret = component->driver->probe(component);
>>>>> 		...
>>>>> (A)		WARN(...)
>>>>> 	}
>>>>> (B)	WARN(...)
> (snip)
>>>> My take is that unless we can prove this is incorrect we leave it as is.
>>>
>>> I think this commit is correct, thanks.
>>> But, then, it sounds we need to check it even though without .prove ?
>>
>> Sorry, I am not getting your question.
>> I don't have a trace of which codecs need this check, and I don't know
>> either if this check needs to be done in other cases than the
>> .probe(). Given all this, why would we try to move this WARN statement
>> outside of the .probe case? It seems like asking for trouble.
> 
> Sorry for bother you.
> Actually, I'm planning to post soc-pcm.c / soc-core.c cleanup patch
> because, it is not readable/understandable/balanceable,
> thus, it is difficult to support multi CPU / multi Platform, etc, etc, etc...
> 
> Then, I can see below cade too many places.
> 
> 		if (component->driver->xxx)
> 			ret = component->driver->xxx()
> 
> this kind of code is very verbose for me.
> As one of this cleanup, I want to create very simple new_func like below.
> Then, this WARN() here is not good match for this purpose.
> In my understanding, this WARN() is effective
> even though it doesn't have .probe
> If so, code will be more simple.
> 
> 	int xxx_probe(component) {
> 		if (component->driver->probe)
> 			return component->driver->probe()
> 		return 0;
> 	}
> 
> 	...
> 	ret = xxx_probe(component);
> =>	WARN();
> 	...

I don't know how to help further. Doing this change will result in the 
warning being thrown in cases where it wasn't before. and since no one 
knows what this warning means in the first place, either we leave it or 
we remove it, changing its location would be very odd.
