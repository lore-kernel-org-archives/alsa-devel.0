From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 116/146] ASoC: sof: use modern dai_link
 style
Date: Fri, 28 Jun 2019 07:56:06 +0200
Message-ID: <288441e7-eaa7-8005-4026-97c31125375b@linux.intel.com>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
 <8761d853-2b3f-7b26-0073-05d0c3ce1362@linux.intel.com>
 <87d0iytqi8.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA697F80768
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 07:56:11 +0200 (CEST)
In-Reply-To: <87d0iytqi8.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.olaru@nxp.com, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 6/28/19 4:06 AM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
>>> @@ -1883,7 +1883,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>>>           int ret;
>>>
>>>           /* link + cpu + codec */
>>> -       link = kzalloc(sizeof(*link) + (2 * sizeof(*dlc)), GFP_KERNEL);
>>> +       link = kzalloc(sizeof(*link) + (3 * sizeof(*dlc)), GFP_KERNEL);
>>>           if (link == NULL)
>>>                   return -ENOMEM;
>>>
>>> @@ -1891,9 +1891,11 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
>>>
>>>           link->cpus      = &dlc[0];
>>>           link->codecs    = &dlc[1];
>>> +       link->platforms = &dlc[2];
>>>
>>>           link->num_cpus   = 1;
>>>           link->num_codecs = 1;
>>> +       link->num_platforms = 1;
>>>
>>> Can you please help me figure this out?
>>
>> Isn't this fixed by my patch "ASoC: soc-topology: fix modern dai link
>> style" applied on 6/13? Looks like the same issue to me.
> 
> This is very impertinent comment, but it is possible to allow NULL platform
> instead of dummy platform by this or similar code ?
> I guess it is nice for SOF future.
> I can't test and not familiar with SOF thought...
> 
> 	if (link->platforms)
> 		link->platforms->name = dev_name(sdev->dev);

It's a good question. To be honest I don't fully understand what this 
'platform' field is needed for... I was just trying to maintain 'as-is' 
functionality. If anyone has a good explanation on when this field might 
be required and for what purpose, and when it can be made optional, I am 
all ears.
