From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: cht_bsw_max98090_ti: Remove unused
 function cht_get_codec_dai()
Date: Tue, 23 May 2017 12:49:03 -0700
Message-ID: <0070e2cf-3b8b-9440-06c0-3eb284c517a3@linux.intel.com>
References: <20170523190509.59212-1-mka@chromium.org>
 <6f941eb4-04b9-89ea-a791-c65c939581cf@linux.intel.com>
 <20170523193239.GP141096@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BE56267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 21:49:06 +0200 (CEST)
In-Reply-To: <20170523193239.GP141096@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, Yang A Fang <yang.a.fang@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 5/23/17 12:32 PM, Matthias Kaehlcke wrote:
> Hi Pierre-Louis,
>
> El Tue, May 23, 2017 at 12:25:17PM -0700 Pierre-Louis Bossart ha dit:
>
>> On 5/23/17 12:05 PM, Matthias Kaehlcke wrote:
>>> Looks like the function has never been used since it was added by commit
>>> 17119a465706 ("ASoC: Intel: Add Cherrytrail & Braswell machine driver
>>> cht_bsw_max98090_ti"). Removing it fixes the following warning when
>>> building with clang:
>>>
>>> sound/soc/intel/boards/cht_bsw_max98090_ti.c:42:35: error: unused
>>>    function 'cht_get_codec_dai' [-Werror,-Wunused-function]
>>
>> Fine but it'll have to be re-added when I finally find the time to
>> support Baytrail with this driver.
>
> If you have plans to add the code in a nearish future it is probably
> not worth to do the removal, unless the maintainers think otherwise.

I have patches for this on github, but I've been unable to force the 
Rambi system I have into submission to boot my image from USB.

https://github.com/plbossart/sound/commit/756c912a3da1c7e40bb98ea726a1508c5e0191e2

Like I said, it's fine if you want to get rid of the warning for now, I 
am not going to be able to work on this before August.

>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>> sound/soc/intel/boards/cht_bsw_max98090_ti.c | 12 ------------
>>> 1 file changed, 12 deletions(-)
>>>
>>> diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> index 742bc0d4e681..20755ecc7f9e 100644
>>> --- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> +++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
>>> @@ -39,18 +39,6 @@ struct cht_mc_private {
>>> 	bool ts3a227e_present;
>>> };
>>>
>>> -static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
>>> -{
>>> -	struct snd_soc_pcm_runtime *rtd;
>>> -
>>> -	list_for_each_entry(rtd, &card->rtd_list, list) {
>>> -		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
>>> -			     strlen(CHT_CODEC_DAI)))
>>> -			return rtd->codec_dai;
>>> -	}
>>> -	return NULL;
>>> -}
>>> -
>>> static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
>>> 	SND_SOC_DAPM_HP("Headphone", NULL),
>>> 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>
>>
