From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Sat, 28 Jul 2018 09:58:00 +0530
Message-ID: <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A8A362675D4
 for <alsa-devel@alsa-project.org>; Sat, 28 Jul 2018 06:28:25 +0200 (CEST)
In-Reply-To: <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org



On 7/27/2018 8:39 PM, Pierre-Louis Bossart wrote:
> On 7/27/18 5:13 AM, Akshu Agrawal wrote:
>> There are cases where a pointer function populates
>> runtime->delay, such as:
>> ./sound/pci/hda/hda_controller.c
>> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>
>> Also, in some cases cpu dai used is generic and the pcm
>> driver needs to set delay.
>>
>> This delay was getting lost and was overwritten by delays
>> from codec or cpu dai delay function if exposed.
> 
> Humm, yes the runtime->delay set in the .pointer function would be lost 
> without this change, but the delay would still be provided in the 
> followup call to .delay.
> With your change, the same delay will be accounted for twice?
> 

It will not be accounted twice because no driver which is setting
runtime->delay is defining .delay op for cpu_dai. Vice versa is also
true, the drivers which define .delay for cpu_dai don't set
runtime->delay. And I think this is expected from drivers else it would
be a bug from their side.

.delay for codec_dai anyway is different and has to be accounted for.

Thanks,
Akshu
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>>   sound/soc/soc-pcm.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 98be04b..b1a2bc2 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>   	snd_pcm_sframes_t codec_delay = 0;
>>   	int i;
>>   
>> +	/* clearing the previous delay */
>> +	runtime->delay = 0;
>> +
>>   	for_each_rtdcom(rtd, rtdcom) {
>>   		component = rtdcom->component;
>>   
>> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>   	}
>>   	delay += codec_delay;
>>   
>> -	runtime->delay = delay;
>> +	runtime->delay += delay;
>>   
>>   	return offset;
>>   }
>>
> 
