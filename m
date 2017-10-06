From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 6/6] ASoC: Intel: boards: use strcmp with
 constant literals
Date: Fri, 6 Oct 2017 09:28:50 -0500
Message-ID: <ad4cce2f-2af0-64bb-99c8-4b4a9e430143@linux.intel.com>
References: <20171005185243.4174-1-pierre-louis.bossart@linux.intel.com>
 <20171005185243.4174-7-pierre-louis.bossart@linux.intel.com>
 <s5hfuaw7j0a.wl-tiwai@suse.de> <1507290634.16112.280.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F81F266991
 for <alsa-devel@alsa-project.org>; Fri,  6 Oct 2017 16:28:53 +0200 (CEST)
In-Reply-To: <1507290634.16112.280.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/6/17 6:50 AM, Andy Shevchenko wrote:
> On Fri, 2017-10-06 at 10:55 +0200, Takashi Iwai wrote:
>> On Thu, 05 Oct 2017 20:52:43 +0200,
>> Pierre-Louis Bossart wrote:
>>>
>>> we used strncmp in all audio machine drivers, this is not needed
>>> when comparing against constant literals.
>>> General replace of strncmp(a, b, strlen(b)) to strcmp(a,b)
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.inte
>>> l.com>
>>> ---
>>>   sound/soc/intel/boards/bxt_da7219_max98357a.c   | 3 +--
>>>   sound/soc/intel/boards/bytcht_es8316.c          | 3 +--
>>>   sound/soc/intel/boards/bytcr_rt5640.c           | 6 ++----
>>>   sound/soc/intel/boards/bytcr_rt5651.c           | 3 +--
>>>   sound/soc/intel/boards/cht_bsw_max98090_ti.c    | 3 +--
>>>   sound/soc/intel/boards/cht_bsw_rt5645.c         | 6 ++----
>>>   sound/soc/intel/boards/cht_bsw_rt5672.c         | 3 +--
>>>   sound/soc/intel/boards/skl_nau88l25_max98357a.c | 3 +--
>>>   sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 3 +--
>>>   9 files changed, 11 insertions(+), 22 deletions(-)
>>
>> While we're at it: since all these do mostly same: wouldn't it make
>> more sense to create a helper to scan over the rtd_list?
>>
>> static inline snd_soc_intel_get_codec_dai(struct snd_soc_card *card,
>> 					  const char *dai_name)
>> {
>> 	struct snd_soc_pcm_runtime *rtd;
>>
>> 	list_for_each_entry(rtd, &card->rtd_list, list) {
>> 		if (!strcmp(rtd->codec_dai->name, dai_name))
>> 			return rtd->codec_dai;
>> 	}
>> 	
>> 	return NULL;
>> }
> 
> I like this!
> 
>> Some drivers require to check two names, but it can call this function
>> twice.
> 
> It looks like not hot path, so, 2 passes instead of one might be not a
> big deal.

Yes, that'd be a good way to simplify further. I'll resend the series, 
thanks for the suggestion Takashi.
