From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Thu, 07 May 2015 16:53:34 +0200
Message-ID: <554B7C6E.2030701@metafoo.de>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150507124811.GV15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id BF84626517F
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 16:53:33 +0200 (CEST)
In-Reply-To: <20150507124811.GV15510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/07/2015 02:48 PM, Mark Brown wrote:
[...]
>> +skip_search:
>> +	if (cache) {
>> +		cache->sink = wsink;
>> +		cache->source = wsource;
>> +	}
>> +
>
> Putting this into a store hit function would be good.
>
>>   	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
>>   	for (i = 0; i < num; i++) {
>> -		r = snd_soc_dapm_add_route(dapm, route);
>> +		r = snd_soc_dapm_add_route(dapm, route, &cache);
>
> Should we just have the cache in the dapm context or the card instead of
> locally?  It's only two pointers at the minute so there doesn't seem to
> be much cost from keeping it around and it might generate somme more
> hits for some use cases.  Or to put it another way why is the cache
> optional and created and re-created here like this?

I don't think the cache will produce hits anywhere else other then adding 
routes from the same route table. That's the only place were the same widget 
or widgets close to each other are accessed sequentially. I'd prefer to keep 
it locally.
