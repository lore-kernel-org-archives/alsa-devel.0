From: Keyon Jie <yang.jie@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: Intel: Reset hw_ptr on resume
 trigger
Date: Mon, 7 Aug 2017 14:36:04 +0800
Message-ID: <91a1fb3d-b2a3-e40e-8f87-08768b9da1bd@linux.intel.com>
References: <20170731104734.5776-1-cychiang@chromium.org>
 <20170801033006.GL3053@localhost>
 <60e20968-28b2-dd91-c30c-318aee9d298f@linux.intel.com>
 <CAFv8NwJ05HS10XN34-LUuhk744PxXZvGaW_bwbb_uFTf5f6Y-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFv8NwJ05HS10XN34-LUuhk744PxXZvGaW_bwbb_uFTf5f6Y-Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "U . Artie Eoff" <ullysses.a.eoff@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2017年08月03日 21:47, Cheng-yi Chiang wrote:
> +Jarkko Nikula
> 
> Hi Keyon,
>    Sorry for the late reply. I spent some time trying to figure out
> previous suspend resume patch in BYT.
> 
>    From the patch for restore_stream flag:
> https://patchwork.kernel.org/patch/4706611/,  the restore_stream flag
> means that ADSP was in power off state during system suspend/resume
> cycle. You are right that the resuming won't play from the pausing
> point of the last suspending. I am not sure whether it is intended in
> ADSP coming back from power off case. Jarkko and Ullysses might have
> better idea on this.
> 
> In my testing I have found that this patch sometimes causes playback
> failure upon resume. I have put the logs in
> https://bugs.chromium.org/p/chromium/issues/detail?id=752107. I think
> we should not merge this until it is resolved. I have cc'ed Intel
> folks on the issue.

Thanks for investigation on it, so looks it's better to root cause and 
fix this noise issue, other than workaround to reset pcm_data->hw_ptr 
which may introduce new issues.

Thanks,
~Keyon

> 
> Thanks!
> 
> On Tue, Aug 1, 2017 at 1:04 PM, Keyon Jie <yang.jie@linux.intel.com> wrote:
>>
>> On 2017年08月01日 11:30, Vinod Koul wrote:
>>>
>>> On Mon, Jul 31, 2017 at 06:47:34PM +0800, Cheng-Yi Chiang wrote:
>>>>
>>>> From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>
>>>>
>>>> Reset the hw_ptr before queuing the restore_stream_context
>>>> work to eradicate a nasty white audio noise on resume.
>>>
>>>
>>> Liam, Jie? This on legacy BYT driver..
>>>
>>>>
>>>> Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
>>>> Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
>>>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>>>> ---
>>>>    sound/soc/intel/baytrail/sst-baytrail-pcm.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
>>>> b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
>>>> index 4765ad474544..e0db7070cd42 100644
>>>> --- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
>>>> +++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
>>>> @@ -187,8 +187,10 @@ static int sst_byt_pcm_trigger(struct
>>>> snd_pcm_substream *substream, int cmd)
>>>>                  sst_byt_stream_start(byt, pcm_data->stream, 0);
>>>>                  break;
>>>>          case SNDRV_PCM_TRIGGER_RESUME:
>>>> -               if (pdata->restore_stream == true)
>>>> +               if (pdata->restore_stream == true) {
>>>> +                       pcm_data->hw_ptr = 0;
>>
>>
>> Won't this break the hw_ptr and make the resuming won't play from the
>> pausing point of the last suspending?
>>
>> Thanks,
>> ~Keyon
>>
>>
>>>>                          schedule_work(&pcm_data->work);
>>>> +               }
>>>>                  else
>>>>                          sst_byt_stream_resume(byt, pcm_data->stream);
>>>>                  break;
>>>> --
>>>> 2.12.2
>>>>
>>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
