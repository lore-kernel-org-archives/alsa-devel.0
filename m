From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Mon, 24 Apr 2017 09:22:38 -0500
Message-ID: <d4e73746-40f7-8929-bdc4-5bf54aef982d@linux.intel.com>
References: <s5hpog5dgh8.wl-tiwai@suse.de> <20170424050144.GG6263@localhost>
 <s5ho9vmjmyv.wl-tiwai@suse.de> <s5hpog2b2o2.wl-tiwai@suse.de>
 <20170424091213.GO6263@localhost> <s5hh91eb0oc.wl-tiwai@suse.de>
 <20170424095244.GP6263@localhost> <s5hefwib075.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EC675266D58
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 16:22:40 +0200 (CEST)
In-Reply-To: <s5hefwib075.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/24/17 4:54 AM, Takashi Iwai wrote:
> On Mon, 24 Apr 2017 11:52:44 +0200,
> Vinod Koul wrote:
>>
>> On Mon, Apr 24, 2017 at 11:43:47AM +0200, Takashi Iwai wrote:
>>> On Mon, 24 Apr 2017 11:12:14 +0200,
>>> Vinod Koul wrote:
>>>>
>>>> On Mon, Apr 24, 2017 at 11:00:45AM +0200, Takashi Iwai wrote:
>>>>
>>>>> Removing ignore_suspend makes the PM succeeds.  But it hits some other
>>>>> ugly kernel bugs.
>>>>
>>>> Okay have you marked .nonatomic = true for the machine DAIs?
>>>
>>> Ah that's it.  The patch below seems fixing the PM and the nonatomic
>>> problems.  I'm not sure about the nonatomic flag for the compress
>>> stream, though.
>>
>> Well we dont have upstream decoders so it wont be used in this case.
>>
>>> Also I fiddled only with FE.  Do we need the same flags for BE?  The
>>> others don't look setting like that, so I left so.
>>
>> I dont remember if BE needs or not FE should suffice.
>
> OK then I leave it as is.
>
> When I submit the fix, I should put Cc to stable, and wonder which
> version we assure the nonatomic ops in SST driver.  Did the code base
> support nonatomic ops from the beginning?

can we take this opportunity to align all drivers?
The .nonatomic=true is set in all drivers for the BE, except for 
cht_bsw_max98090_ti.c
It's either needed for all or not needed for all...

>
>
> thanks,
>
> Takashi
>
>>
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>> ---
>>>  sound/soc/intel/boards/bytcr_rt5640.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> --- a/sound/soc/intel/boards/bytcr_rt5640.c
>>> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
>>> @@ -646,7 +646,7 @@ static struct snd_soc_dai_link byt_rt564
>>>  		.codec_dai_name = "snd-soc-dummy-dai",
>>>  		.codec_name = "snd-soc-dummy",
>>>  		.platform_name = "sst-mfld-platform",
>>> -		.ignore_suspend = 1,
>>> +		.nonatomic = true,
>>>  		.dynamic = 1,
>>>  		.dpcm_playback = 1,
>>>  		.dpcm_capture = 1,
>>> @@ -659,7 +659,6 @@ static struct snd_soc_dai_link byt_rt564
>>>  		.codec_dai_name = "snd-soc-dummy-dai",
>>>  		.codec_name = "snd-soc-dummy",
>>>  		.platform_name = "sst-mfld-platform",
>>> -		.ignore_suspend = 1,
>>>  		.nonatomic = true,
>>>  		.dynamic = 1,
>>>  		.dpcm_playback = 1,
>>> @@ -672,6 +671,7 @@ static struct snd_soc_dai_link byt_rt564
>>>  		.codec_dai_name = "snd-soc-dummy-dai",
>>>  		.codec_name = "snd-soc-dummy",
>>>  		.platform_name = "sst-mfld-platform",
>>> +		.nonatomic = true,
>>>  	},
>>>  		/* back ends */
>>>  	{
>>
>> --
>> ~Vinod
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
