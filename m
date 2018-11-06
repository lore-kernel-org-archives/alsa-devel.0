From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the
 dev memory API
Date: Tue, 6 Nov 2018 08:39:46 -0600
Message-ID: <c57e4dcf-7117-72f4-0e07-350a20120742@linux.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
 <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
 <CD6925E8781EFD4D8E11882D20FC406D529FE5A9@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D529FE5A9@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "He, Bo" <bo.he@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>, "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Prakash, Divya1" <divya1.prakash@intel.com>, "Diwakar, Praveen" <praveen.diwakar@intel.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
List-Id: alsa-devel@alsa-project.org

On 11/5/18 6:58 PM, He, Bo wrote:
> Hi,
> 	I submit the patch based on tag v4.19.

Please don't post on mailing lists.

> 
> -----Original Message-----
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Sent: Tuesday, November 6, 2018 1:02 AM
> To: He, Bo <bo.he@intel.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Cc: liam.r.girdwood@linux.intel.com; perex@perex.cz; tiwai@suse.com; Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Periyasamy, SriramX <sriramx.periyasamy@intel.com>; Kale, Sanyog R <sanyog.r.kale@intel.com>; Kesapragada, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>; kuninori.morimoto.gx@renesas.com; guruprasadx.pawse@intel.com; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; Prakash, Divya1 <divya1.prakash@intel.com>; Diwakar, Praveen <praveen.diwakar@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
> Subject: Re: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the dev memory API
> 
> 
> On 11/5/18 2:29 AM, He, Bo wrote:
>> skl->dais is allocated with devm_kcalloc, can't free with
>> the krealloc. Memory allocated with devm API is automatically freed on
>> driver detach, Like all other devres resources.
>>
>> Refer to drivers/base/devres.c devm_kmalloc for more details.
> 
> What code are you looking at?
> 
> I see this in the Mark's tree
> 
> int skl_platform_register(struct device *dev) {
>       int ret;
>       struct snd_soc_dai_driver *dais;
>       int num_dais = ARRAY_SIZE(skl_platform_dai);
>       struct hdac_bus *bus = dev_get_drvdata(dev);
>       struct skl *skl = bus_to_skl(bus);
> 
>       INIT_LIST_HEAD(&skl->ppl_list);
>       INIT_LIST_HEAD(&skl->bind_list);
> 
>       skl->dais = kmemdup(skl_platform_dai, sizeof(skl_platform_dai),
>                   GFP_KERNEL);
>       if (!skl->dais) {
>           ret = -ENOMEM;
>           goto err;
>       }
> 
>       if (!skl->use_tplg_pcm) {
>           dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
>                   sizeof(skl_platform_dai), GFP_KERNEL);
> 
> 
> No trace of devm as you mention it? I checked the Chrome tree as well and it's not there.
> 
> What am I missing?

The code is completely identical in v4.19. skl->dais is allocated with 
kmemdup, which is a kmalloc+memcpy, i just don't understand what you are 
trying to fix.

> 
> 
>>
>> Signed-off-by: he, bo <bo.he@intel.com>
>> ---
>>    sound/soc/intel/skylake/skl-pcm.c | 5 ++---
>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl-pcm.c
>> b/sound/soc/intel/skylake/skl-pcm.c
>> index 823e391..928d314 100644
>> --- a/sound/soc/intel/skylake/skl-pcm.c
>> +++ b/sound/soc/intel/skylake/skl-pcm.c
>> @@ -1438,7 +1438,8 @@ int skl_platform_register(struct device *dev)
>>    	}
>>    
>>    	if (!skl->use_tplg_pcm) {
>> -		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
>> +		devm_kfree(dev, skl->dais);
>> +		dais = devm_kcalloc(dev, skl->dais, sizeof(skl_fe_dai) +
>>    				sizeof(skl_platform_dai), GFP_KERNEL);
>>    		if (!dais) {
>>    			ret = -ENOMEM;
>> @@ -1472,7 +1473,5 @@ int skl_platform_unregister(struct device *dev)
>>    		}
>>    	}
>>    
>> -	kfree(skl->dais);
>> -
>>    	return 0;
>>    }
