From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 114/146] ASoC: soc-topology: use modern
 dai_link style
Date: Thu, 6 Jun 2019 09:03:59 -0500
Message-ID: <10285830-e164-13b6-05c7-966806f45c18@linux.intel.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87v9xjfjgo.wl-kuninori.morimoto.gx@renesas.com>
 <20190606151747.343ddd4c@xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1785F80768
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 16:03:59 +0200 (CEST)
In-Reply-To: <20190606151747.343ddd4c@xxx>
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
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= <amadeuszx.slawinski@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
>> index 3299ebb..f485f7f 100644
>> --- a/sound/soc/soc-topology.c
>> +++ b/sound/soc/soc-topology.c
>> @@ -560,7 +560,7 @@ static void remove_link(struct snd_soc_component
>> *comp,
>>   	kfree(link->name);
>>   	kfree(link->stream_name);
>> -	kfree(link->cpu_dai_name);
>> +	kfree(link->cpus->dai_name);
>>   
>>   	list_del(&dobj->list);
>>   	snd_soc_remove_dai_link(comp->card, link);
>> @@ -1879,12 +1879,22 @@ static int soc_tplg_fe_link_create(struct
>> soc_tplg *tplg, struct snd_soc_tplg_pcm *pcm)
>>   {
>>   	struct snd_soc_dai_link *link;
>> +	struct snd_soc_dai_link_component *dlc;
>>   	int ret;
>>   
>> -	link = kzalloc(sizeof(struct snd_soc_dai_link), GFP_KERNEL);
>> +	/* link + cpu + codec */
>> +	link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)),
>> GFP_KERNEL); if (link == NULL)
>>   		return -ENOMEM;
>>   
>> +	dlc = (struct snd_soc_dai_link_component *)(link + 1);
>> +
>> +	link->cpus	= &dlc[0];
>> +	link->codecs	= &dlc[1];
> 
> While I understand what is going on here, I find this bit ugly.

It's not so bad and it avoid multiple tests and tags that are just as 
ugly IMHO.

> Can it perhaps be changed to something like:
> 
> 	link = kzalloc(sizeof(*link), GFP_KERNEL);
> 	if (link == NULL)
> 		return -ENOMEM;
> 	link->cpus = kzalloc(sizeof(*dlc), GFP_KERNEL);
> 	if (link->cpus == NULL) {
> 		ret = -ENOMEM;
> 		goto err;
> 	}
> 	link->codecs = kzalloc(sizeof(*dlc), GFP_KERNEL);
> 	if (link->cpus == NULL) {
> 		ret = -ENOMEM;
> 		goto err;
> 	}
> 
> (...)
> err:
> 	kfree(link->cpus);
> 	kfree(link);
> 	return ret;
> 
> While it has a bit more of boiler plate it's easier to follow.
> 
> And while I look at soc_tplg_fe_link_create() it could use some
> more memory checks, but it's a topic for separate patch.
