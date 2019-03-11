From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: test memory
 allocation
Date: Mon, 11 Mar 2019 15:07:53 +0100
Message-ID: <831fdf7a-0239-9d6b-f8b8-21ca077c9009@linux.intel.com>
References: <20190309020252.27860-1-pierre-louis.bossart@linux.intel.com>
 <20190309020252.27860-2-pierre-louis.bossart@linux.intel.com>
 <87pnqyuvcl.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45CDAF807B5
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2019 15:07:57 +0100 (CET)
In-Reply-To: <87pnqyuvcl.wl-kuninori.morimoto.gx@renesas.com>
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

On 3/10/19 7:20 PM, Kuninori Morimoto wrote:
> 
> Hi Pierre-Louis
> 
> Thank you for your patch.
> 
>> devm_kcalloc() return value needs to be tested
>>
>> Fixes: 17029e494edc6 ('ASoC: simple-card: add link_info')
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/generic/simple-card.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
>> index 08df261024cf..bed4fe5721a2 100644
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -715,7 +715,7 @@ static int simple_probe(struct platform_device *pdev)
>>   	dai_link  = devm_kcalloc(dev, li.link, sizeof(*dai_link),  GFP_KERNEL);
>>   	dais      = devm_kcalloc(dev, li.dais, sizeof(*dais),      GFP_KERNEL);
>>   	cconf     = devm_kcalloc(dev, li.conf, sizeof(*cconf),     GFP_KERNEL);
>> -	if (!dai_props || !dai_link || !dais)
>> +	if (!dai_props || !dai_link || !dais || !cconf)
>>   		return -ENOMEM;
> 
> It isn't mentioned on code, but, "li.conf" will be 0 if it was not DPCM case.
> This means cconf NULL might be happen.


Humm, then don't call devm_kcalloc with a zero argument...
And if you keep this code, if li.conf is not zero you still have a risk 
of memory allocation failure. the test should be

+	if (!dai_props || !dai_link || !dais || (!cconf && li.conf))
