From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH] *** ASoC: core: refine of node id parse of
 cpu/codec dai ***
Date: Fri, 20 Jun 2014 10:32:30 +0800
Message-ID: <53A39D3E.9030101@marvell.com>
References: <1403089319-2555-1-git-send-email-zhouqiao@marvell.com>
 <53A18273.7090203@metafoo.de> <53A2389B.3000102@marvell.com>
 <53A27545.7040304@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 631002610D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 04:32:33 +0200 (CEST)
In-Reply-To: <53A27545.7040304@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/19/2014 01:29 PM, Lars-Peter Clausen wrote:
> On 06/19/2014 03:10 AM, Qiao Zhou wrote:
>> On 06/18/2014 08:13 PM, Lars-Peter Clausen wrote:
>>> On 06/18/2014 01:01 PM, Qiao Zhou wrote:
>>>> Hi Mark, Liam
>>>>
>>>> This patch is to add another check besides cpu_dai/codec_dai name during
>>>> dai_link bind. currently if the cpu_dai/codec_dai name match corresponding
>>>> dai_link cpu/codec name, then a match is found. in this patch, it also
>>>> checks
>>>> whether cpu/codec dai id match dailink cpu_dai_id/codec_dai_id. Still check
>>>> name first.
>>>> 1. if it doesn't match, it will keep checking whether cpu_id/codec_id match
>>>> corresponding dai_link cpu_dai_id/codec_dai_id. if the ids are equal, then
>>>> a match is found.
>>>> 2. if it does match, then a match is already found. no need to further
>>>> check.
>>>>
>>> [...]
>>>> Could you help share your opinions? Thanks in advance.
>>>
>>> Hi,
>>>
>>> There is already snd_soc_of_get_dai_name() which will translate a phandle +
>>> specifier to a DAI name. By default it will use the DAI id for the
>>> specifier. Alternatively the driver can implement a of_xlate_dai_name
>>> callback that does the translation from specifier to name. The advantage of
>>> this approach is that the board driver does not need to know about the
>>> specific format of the DAI specifier.
>>>
>>> - Lars
>>>
>> Hi Lars,
>>
>> This API is powerful and meets my requirement. Thanks a lot.
>>
>> I still have a small question. why don't we consider to also use DAI id to
>> match DAIs & dai_link? It seems to be a more direct alternative. Please
>> correct/instruct me if anything is wrong.
>
> Matching by id would also work, I guess. But it doesn't really matter if
> name or id is used since both should be unique per CODEC. But what you
> shouldn't do is manually parse the id from the devicetree property in the
> machine driver since the specifier layout is CODEC specific and hence has to
> be parsed by the CODEC.
For DPCM, CPU dai of BE also needs to handle id matching specifically 
just as codec dai does. In this case, we need to also consider cpu dai 
id parsing, right?
>
> I think ideally the machine driver would pass the devicetree node and the
> name of the property that specifies the DAI to the core and the core would
> take care of everything else. As it is right now we first lookup the DAI by
Totally agree. A device node & a specifier together should be enough.
> the of node and return the name of the DAI, then later on we use that name
> to lookup the DAI again. The second lookup is kind of superfluous since we
> already had a pointer to the DAI during the first lookup, so this is
> something that could be optimized if somebody was interested in optimizing this.
>
> - Lars
>


-- 

Best Regards
Qiao
