From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if
 statement and removed buffer
Date: Mon, 6 May 2019 10:50:25 -0500
Message-ID: <d9cb3ce3-d97b-a8ce-252f-c7d8455f5ae1@linux.intel.com>
References: <20190504151652.5213-1-user@elitebook-localhost>
 <423c7b83-abd6-4f75-ad3a-7c650b76e8bb@linux.intel.com>
 <6b7111b1-2387-5366-3536-f369a9b0982a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b7111b1-2387-5366-3536-f369a9b0982a@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Nariman <narimantos@gmail.com>, linux-kernel@vger.kernel.org
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, yang.jie@linux.intel.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 5/6/19 10:43 AM, Hans de Goede wrote:
> Hi Pierre-Louis,
> 
> Nariman and the author authors of these patches are a group of students 
> doing
> some kernel work for me and this is a warm-up assignment for them to get 
> used
> to the kernel development process.
> 
> On 06-05-19 17:21, Pierre-Louis Bossart wrote:
>>
>>>   static int byt_rt5640_suspend(struct snd_soc_card *card)
>>> @@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct 
>>> platform_device *pdev)
>>>       log_quirks(&pdev->dev);
>>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>>> -
>>> -        /* fixup codec aif name */
>>> -        snprintf(byt_rt5640_codec_aif_name,
>>> -            sizeof(byt_rt5640_codec_aif_name),
>>> -            "%s", "rt5640-aif2");
>>> -
>>> -        byt_rt5640_dais[dai_index].codec_dai_name =
>>> -            byt_rt5640_codec_aif_name;
>>> -    }
>>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>>> +        byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
>>
>> This is not equivalent, you don't deal with the (byt_rt5640_quirk & 
>> BYT_RT5640_SSP2_AIF2) case. The default is SSP_AIF1
> 
> I might be mistaken here, but look closer, the original:
>      if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
> 
> Line is kept, so the new code block is:
> 
>      if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
>          (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>          byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
> 
> Which does take the BYT_RT5640_SSP2_AIF2 into account.

Ah yes, my mistake. Looks good then.

> 
>>>       if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
>>> -        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
>>> -
>>> -        /* fixup cpu dai name name */
>>> -        snprintf(byt_rt5640_cpu_dai_name,
>>> -            sizeof(byt_rt5640_cpu_dai_name),
>>> -            "%s", "ssp0-port");
>>> -
>>> -        byt_rt5640_dais[dai_index].cpu_dai_name =
>>> -            byt_rt5640_cpu_dai_name;
>>> -    }
>>> +        (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
>>> +        byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
>>
>> Same here, this is not equivalent. the SSP0_AIF1 case is not handled.
>> it's fine to remove the intermediate buffers, but you can't remove 
>> support for 2 out of the 4 combinations supported.
> 
> Same remark here from me too :)
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
