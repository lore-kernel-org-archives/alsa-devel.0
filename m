From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Atom: read timestamp moved to
 period_elapsed
Date: Wed, 17 Jul 2019 10:30:26 -0500
Message-ID: <029bc013-608b-031b-780e-c48486fd9c15@linux.intel.com>
References: <20190709040147.111927-1-levinale@chromium.org>
 <20190709114519.GW9224@smile.fi.intel.com>
 <CAOReqxirZdKJQ59Z4789wT5Cxh2fyQrUcuB1pm9AidYLiPEs1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOReqxirZdKJQ59Z4789wT5Cxh2fyQrUcuB1pm9AidYLiPEs1A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Curtis Malainey <cujomalainey@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@chromium.org>, Alex Levin <levinale@chromium.org>
List-Id: alsa-devel@alsa-project.org



On 7/10/19 6:15 PM, Curtis Malainey wrote:
> On Tue, Jul 9, 2019 at 4:45 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Mon, Jul 08, 2019 at 09:01:47PM -0700, Alex Levin wrote:
>>> sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
>>> from snd_pcm_ioctl. Calling read timestamp results in recalculating
>>> pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
>>> faster rate than intended.
>>> In a tested BSW system with chtrt5650, for a rate of 48000, the
>>> measured rate was sometimes 10 times more than that.
>>> After moving the timestamp read to period elapsed, buffer consumption is
>>> as expected.
>>
>>  From code prospective it looks good. You may take mine
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Though I'm not an expert in the area, Pierre and / or Liam should give
>> their blessing.
>>
> Agreed, Liam or Pierre should also give their ok since this is one of
> the closed source firmware drivers.
> 
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>

Humm, this first review after my Summer break isn't straightforward.

By moving the timestamp update to the period elapsed event, don't you 
prevent the use of this driver in no-interrupt mode - which I understood 
as the baseline for Chrome?

And I also don't get how this timestamp might lead to 10x speed issues, 
this driver has been around for a number of years and that specific 
error was never seen. What is different in this platform and can this be 
seen e.g. on a Cyan device?


>>>
>>> Signed-off-by: Alex Levin <levinale@chromium.org>
>>> ---
>>>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
>>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> index 0e8b1c5eec88..196af0b30b41 100644
>>> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> @@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
>>>   {
>>>        struct snd_pcm_substream *substream = arg;
>>>        struct sst_runtime_stream *stream;
>>> -     int status;
>>> +     struct snd_soc_pcm_runtime *rtd;
>>> +     int status, ret_val;
>>>
>>>        if (!substream || !substream->runtime)
>>>                return;
>>>        stream = substream->runtime->private_data;
>>>        if (!stream)
>>>                return;
>>> +
>>> +     rtd = substream->private_data;
>>> +     if (!rtd)
>>> +             return;
>>> +
>>>        status = sst_get_stream_status(stream);
>>>        if (status != SST_PLATFORM_RUNNING)
>>>                return;
>>> +
>>> +     ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
>>> +     if (ret_val) {
>>> +             dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
>>> +             return;
>>> +     }
>>>        snd_pcm_period_elapsed(substream);
>>>   }
>>>
>>> @@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
>>>                        (struct snd_pcm_substream *substream)
>>>   {
>>>        struct sst_runtime_stream *stream;
>>> -     int ret_val, status;
>>> +     int status;
>>>        struct pcm_stream_info *str_info;
>>> -     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>
>>>        stream = substream->runtime->private_data;
>>>        status = sst_get_stream_status(stream);
>>>        if (status == SST_PLATFORM_INIT)
>>>                return 0;
>>> +
>>>        str_info = &stream->stream_info;
>>> -     ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
>>> -     if (ret_val) {
>>> -             dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
>>> -             return ret_val;
>>> -     }
>>>        substream->runtime->delay = str_info->pcm_delay;
>>>        return str_info->buffer_ptr;
>>>   }
>>> --
>>> 2.22.0.410.gd8fdbe21b5-goog
>>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
