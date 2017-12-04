From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 03/10] ASoC: Intel: Skylake: add HDA BE DAIs
Date: Mon, 4 Dec 2017 16:14:15 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC602C@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-4-git-send-email-rakesh.a.ughreja@intel.com>
 <092167b4-2659-cc58-4e7a-00bb3d28068b@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D314266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 17:14:20 +0100 (CET)
In-Reply-To: <092167b4-2659-cc58-4e7a-00bb3d28068b@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Friday, December 1, 2017 11:50 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC 03/10] ASoC: Intel: Skylake: add HDA BE DAIs
>
>On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
>> Add support for HDA BE DAIs in SKL platform driver.
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>   sound/soc/intel/skylake/skl-pcm.c | 32 +++++++++++++++++++++++++------
>-
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-
>pcm.c
>> index e6fee7a..3dcb241 100644
>> --- a/sound/soc/intel/skylake/skl-pcm.c
>> +++ b/sound/soc/intel/skylake/skl-pcm.c
>> @@ -956,21 +956,39 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
>>   	},
>>   },
>>   {
>> -	.name = "HD-Codec Pin",
>> +	.name = "Analog CPU DAI",
>>   	.ops = &skl_link_dai_ops,
>>   	.playback = {
>> -		.stream_name = "HD-Codec Tx",
>> -		.channels_min = HDA_STEREO,
>> +		.stream_name = "Analog CPU Playback",
>> +		.channels_min = HDA_MONO,
>>   		.channels_max = HDA_STEREO,
>>   		.rates = SNDRV_PCM_RATE_48000,
>> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>SNDRV_PCM_FMTBIT_S24_LE,
>>   	},
>>   	.capture = {
>> -		.stream_name = "HD-Codec Rx",
>> -		.channels_min = HDA_STEREO,
>> +		.stream_name = "Analog CPU Capture",
>> +		.channels_min = HDA_MONO,
>>   		.channels_max = HDA_STEREO,
>>   		.rates = SNDRV_PCM_RATE_48000,
>> -		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>SNDRV_PCM_FMTBIT_S24_LE,
>> +	},
>> +},
>> +{
>> +	.name = "Digital CPU DAI",
>
>I am not sure I get the meaning of analog/digital.
>
>Did you mean external codec vs. iDisp codec?
>
>Or did you really mean analog? I don't think you can control this front
>the CPU side, e.g. if the codec has an S/PDIF output it remains digital.

I was trying to map the BE CPU DAIs to hda_pcm_stream. 
The way it is defined here.
https://elixir.free-electrons.com/linux/v4.15-rc2/source/sound/pci/hda/hda_generic.c#L5374

>
>> +	.ops = &skl_link_dai_ops,
>> +	.playback = {
>> +		.stream_name = "Digital CPU Playback",
>> +		.channels_min = HDA_MONO,
>> +		.channels_max = HDA_STEREO,
>> +		.rates = SNDRV_PCM_RATE_48000,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>SNDRV_PCM_FMTBIT_S24_LE,
>> +	},
>> +	.capture = {
>> +		.stream_name = "Digital CPU Capture",
>> +		.channels_min = HDA_MONO,
>> +		.channels_max = HDA_STEREO,
>> +		.rates = SNDRV_PCM_RATE_48000,
>> +		.formats = SNDRV_PCM_FMTBIT_S16_LE |
>SNDRV_PCM_FMTBIT_S24_LE,
>>   	},
>>   },
>>   };
>>
