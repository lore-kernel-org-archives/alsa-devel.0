From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH 2/3 v2] ALSA: usb-audio: avoid setting of sample rate
 multiple times on bus
Date: Sun, 4 Dec 2016 23:32:51 -0800
Message-ID: <58451823.8040207@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com> <20161130075923.15205-3-jiada_wang@mentor.com> <c4579c3f-4798-7096-2c05-b0670ccbad08@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4579c3f-4798-7096-2c05-b0670ccbad08@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com
List-Id: alsa-devel@alsa-project.org

Hi Sakamoto

On 11/30/2016 02:45 AM, Takashi Sakamoto wrote:
> Hi Jiada,
>
> I don't oppose this patch. Nevertheless, your description is not 
> necessarily correct.
>
> On Nov 30 2016 16:59, Jiada Wang wrote:
>> From: Daniel Girnus <dgirnus@de.adit-jv.com>
>>
>> ALSA usually calls the prepare function twice before starting the 
>> playback:
>> 1. On hw_params call from userland and
>> 2. internally when starting the stream.
>
> ALSA PCM core in kernel land doesn't perform like this.
>
> In alsa-lib, 'snd_pcm_hw_params()' calls 
> 'snd_pcm_hw_params_internal()' and 'snd_pcm_prepare()' sequentially.
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm.c;h=cd87bc759ded95953e332b7e8d56b0f2d5b4185d;hb=HEAD#l853 
>
>
> In system call level (e.g. see by strace(1)), this looks like two 
> ioctl(2)s with 'SNDRV_PCM_IOCTL_HW_PARAMS' and 'SNDRV_PCM_IOCTL_PREPARE'.
>
> Well, when applications are written to execute 'snd_pcm_hw_params()' 
> and 'snd_pcm_hw_prepare()' sequentially, additional ioctl(2) with 
> 'SNDRV_PCM_IOCTL_PREPARE' appears. PulseAudio is this kind of 
> application. I indicated the useless in 2014, but it still remains:
> https://lists.freedesktop.org/archives/pulseaudio-discuss/2014-January/019773.html 
>
>
> You have the misunderstanding due to a nature of alsa-lib and tendency 
> of major applications, from my point of view.
>
Thanks for your indication, so because some of userland applications 
call 'snd_pcm_hw_params()' and
'snd_pcm_hw_prepare()' sequentially, means the second 
'SNDRV_PCM_IOCTL_PREPARE' be called in 'SNDRV_PCM_STATE_PREPARED' state, 
some devices are unable to manage this and stop working.

I will update Changelog in v2 Patchset.

Thanks,
Jiada

>> Some device are not able to manage this and they will stop playback
>> if the sample rate will be configured several times over USB protocol.
>>
>> Signed-off-by: Jens Lorenz <jlorenz@de.adit-jv.com>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>  sound/usb/pcm.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
>> index 44d178e..a522c9a 100644
>> --- a/sound/usb/pcm.c
>> +++ b/sound/usb/pcm.c
>> @@ -806,17 +806,18 @@ static int snd_usb_pcm_prepare(struct 
>> snd_pcm_substream *substream)
>>      if (ret < 0)
>>          goto unlock;
>>
>> -    iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
>> -    alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
>> -    ret = snd_usb_init_sample_rate(subs->stream->chip,
>> -                       subs->cur_audiofmt->iface,
>> -                       alts,
>> -                       subs->cur_audiofmt,
>> -                       subs->cur_rate);
>> -    if (ret < 0)
>> -        goto unlock;
>> -
>>      if (subs->need_setup_ep) {
>> +
>> +        iface = usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
>> +        alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
>> +        ret = snd_usb_init_sample_rate(subs->stream->chip,
>> +                           subs->cur_audiofmt->iface,
>> +                           alts,
>> +                           subs->cur_audiofmt,
>> +                           subs->cur_rate);
>> +        if (ret < 0)
>> +            goto unlock;
>> +
>>          ret = configure_endpoint(subs);
>>          if (ret < 0)
>>              goto unlock;
>
>
> Regards
>
> Takashi Sakamoto
