From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 8/9] ASoC: Intel: Atom: work-around
 Coccinelle false-alarm
Date: Mon, 17 Dec 2018 08:55:29 -0600
Message-ID: <0795e668-f3ae-c47a-0021-6367c0e1ca2a@linux.intel.com>
References: <20181216224910.16198-1-pierre-louis.bossart@linux.intel.com>
 <20181216224910.16198-9-pierre-louis.bossart@linux.intel.com>
 <alpine.DEB.2.21.1812170703120.2539@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E343267AE6
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 15:55:32 +0100 (CET)
In-Reply-To: <alpine.DEB.2.21.1812170703120.2539@hadrien>
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
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/17/18 12:04 AM, Julia Lawall wrote:
>
> On Sun, 16 Dec 2018, Pierre-Louis Bossart wrote:
>
>> Coccinelle complains:
>> sst-atom-controls.c:1534:2-19: ERROR: Assignment of bool to non-0/1
>> constant
>>
>> false alarm: that constant is declared as
>>
>> Using a test that will be optimized away to work-around the issue
> I'll improve the rule.  It would be better to leave the code as it is.
Fine with me. I just wanted to go down to zero warnings left, if the 
tool is improved it achieves the same result. Thanks!
>
> julia
>
>> Cc: Julia Lawall <julia.lawall@lip6.fr>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/soc/intel/atom/sst-atom-controls.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
>> index d1207ea53523..d00990852fdf 100644
>> --- a/sound/soc/intel/atom/sst-atom-controls.c
>> +++ b/sound/soc/intel/atom/sst-atom-controls.c
>> @@ -1531,7 +1531,7 @@ int sst_dsp_init_v2_dpcm(struct snd_soc_component *component)
>>   	snd_soc_dapm_new_widgets(dapm->card);
>>
>>   	for (i = 0; i < gains; i++) {
>> -		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT;
>> +		sst_gains[i].mute = SST_GAIN_MUTE_DEFAULT ? true : false;
>>   		sst_gains[i].l_gain = SST_GAIN_VOLUME_DEFAULT;
>>   		sst_gains[i].r_gain = SST_GAIN_VOLUME_DEFAULT;
>>   		sst_gains[i].ramp_duration = SST_GAIN_RAMP_DURATION_DEFAULT;
>> --
>> 2.17.1
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
