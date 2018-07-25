From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/6] ASoC: Intel: boards: cleanup
 snd_mask_set usage
Date: Wed, 25 Jul 2018 08:54:54 -0500
Message-ID: <1429709c-2ac3-be3a-c3da-b02a9b2c856c@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
 <20180724211248.29427-2-pierre-louis.bossart@linux.intel.com>
 <s5h7eljyj2a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8954D2675D4
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 15:57:06 +0200 (CEST)
In-Reply-To: <s5h7eljyj2a.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 7/25/18 12:34 AM, Takashi Iwai wrote:
> On Tue, 24 Jul 2018 23:12:43 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Sparse reports a ton of warnings when snd_mask_set is used (see
>> e.g. below). Fix by adding the right typecast with the __force
>> attribute. The code is less readable but with fewer warnings it's
>> easier to track the real issues and improve the rest of the code.
>>
>>   CHECK   sound/soc/intel/boards/skl_nau88l25_max98357a.c
>> sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27: warning: incorrect type in argument 2 (different base types)
>> sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27:    expected unsigned int [unsigned] val
>> sound/soc/intel/boards/skl_nau88l25_max98357a.c:160:27:    got restricted snd_pcm_format_t [usertype] <noident>
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/boards/bdw-rt5677.c                 | 2 +-
>>   sound/soc/intel/boards/bxt_da7219_max98357a.c       | 2 +-
>>   sound/soc/intel/boards/bxt_rt298.c                  | 2 +-
>>   sound/soc/intel/boards/glk_rt5682_max98357a.c       | 2 +-
>>   sound/soc/intel/boards/kbl_da7219_max98357a.c       | 2 +-
>>   sound/soc/intel/boards/kbl_rt5663_max98927.c        | 6 ++++--
>>   sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 6 ++++--
>>   sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 2 +-
>>   sound/soc/intel/boards/skl_nau88l25_ssm4567.c       | 2 +-
>>   sound/soc/intel/boards/skl_rt286.c                  | 2 +-
>>   10 files changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
>> index 6ea360f33575..17037892c16b 100644
>> --- a/sound/soc/intel/boards/bdw-rt5677.c
>> +++ b/sound/soc/intel/boards/bdw-rt5677.c
>> @@ -156,7 +156,7 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
>>   	/* set SSP0 to 16 bit */
>>   	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
>>   				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
>> -				    SNDRV_PCM_FORMAT_S16_LE);
>> +				(__force unsigned int)SNDRV_PCM_FORMAT_S16_LE);
> 
> I believe we should provide a specific type of snd_mask_set(), e.g.
> snd_mask_set_format(), snd_mask_set_access(), etc, which receives the
> right type as the argument, instead of this kind of ugly cast.

I agree it's ugly, I was indeed hoping we'd fix this in a nicer way.

> 
> Will cook up the patch later.
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
