From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: fix 0-day warnings with
 snd_soc_new_compress()
Date: Wed, 30 May 2018 07:48:50 -0500
Message-ID: <480f50bc-3b77-534e-28f6-1da9c61aa711@linux.intel.com>
References: <20180529233002.23656-1-pierre-louis.bossart@linux.intel.com>
 <20180530031656.GL5666@vkoul-mobl>
 <4e691d48-6d09-cf2c-39f4-d3352bcf6d10@linux.intel.com>
 <s5hwovlmiy1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id D53DB26770B
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 14:48:44 +0200 (CEST)
In-Reply-To: <s5hwovlmiy1.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, Vinod <vkoul@kernel.org>, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/30/18 7:22 AM, Takashi Iwai wrote:
> On Wed, 30 May 2018 14:12:00 +0200,
> Pierre-Louis Bossart wrote:
>>
>> On 5/29/18 10:16 PM, Vinod wrote:
>>> On 29-05-18, 18:30, Pierre-Louis Bossart wrote:
>>>> All conditionally-defined routines in include/sound/soc.h expose a
>>>> static inline fallback to avoid 0-day warnings and compilation issues,
>>>> except snd_soc_new_compress().
>>>
>>> Hey Pierre,
>>>
>>> Thanks for the fix, but typically the title should not mention things like
>>> reporter. It should describe the change, so something like "Add
>>> snd_soc_new_compress() wrapper when CONFIG_SND_SOC_COMPRESS is not defined"
>>>
>>> Right now patch title is not describing the change
>>
>> I follow the guidelines in [1] of describing the problem statement,
>> provide details and then how the problem is addressed in the message.
>>
>> It's not clear to me that you need to describe the solution in the title.
>>
>> [1] https://www.kernel.org/doc/html/v4.16/process/submitting-patches.html
> 
> Well, a good patch describes itself concisely but clearly in the
> subject line in general.  And, in this regard, whether it's reported
> by 0-day bot or not is pretty much useless.  We'd merge a fix not
> because 0-day bot complains; instead, we merge it because it addresses
> some real bug.  In this particular case, a build error with
> CONFIG_SND_SOC_COMPRESS=n.  So this should have been mentioned in the
> subject line.

Got it, thanks!

> 
> 
> Takashi
> 
>>>
>>>> Fixes: 5db6aab6f36f ('ASoC: topology: Add support for compressed PCMs')
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    include/sound/soc.h | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>>>> index 600a7ebd10c0..1378dcd2128a 100644
>>>> --- a/include/sound/soc.h
>>>> +++ b/include/sound/soc.h
>>>> @@ -462,6 +462,11 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
>>>>    int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
>>>>    #ifdef CONFIG_SND_SOC_COMPRESS
>>>>    int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
>>>> +#else
>>>> +static inline int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>>    #endif
>>>>      void snd_soc_disconnect_sync(struct device *dev);
>>>> -- 
>>>> 2.14.1
>>>
>>
