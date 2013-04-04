From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/2] ALSA: hda - Add fixed codec delay to
	runtime delay.
Date: Thu, 4 Apr 2013 09:21:34 -0700
Message-ID: <CAEUnVG5Wkk4hMnxkyVnd+eExR5+0NAcV5tXf9-D2ms-m4bgZpw@mail.gmail.com>
References: <1365003004-7680-1-git-send-email-dgreid@chromium.org>
 <s5h8v4yrcsk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E573265ED6
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 18:21:55 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so1605910bkc.34
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 09:21:54 -0700 (PDT)
In-Reply-To: <s5h8v4yrcsk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 4, 2013 at 12:10 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed,  3 Apr 2013 08:30:03 -0700,
> Dylan Reid wrote:
>>
>> Allow a codec to specify a delay in addition to the delay before
>> samples are passed through DMA.  Some codecs have large processing
>> delays because of built-in DSPs that require codec-side buffers of
>> many milliseconds.  Default to zero delay if the codec doesn't specify
>> a callback to get the processing delay.
>>
>> Signed-off-by: Dylan Reid <dgreid@chromium.org>
>> ---
>>  sound/pci/hda/hda_codec.c | 17 +++++++++++++++++
>>  sound/pci/hda/hda_codec.h |  4 ++++
>>  sound/pci/hda/hda_intel.c |  2 ++
>>  3 files changed, 23 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index 17286b3..1d792dd 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -3724,6 +3724,23 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
>>  }
>>  EXPORT_SYMBOL_HDA(snd_hda_codec_set_power_to_all);
>>
>> +/**
>> + * snd_hda_codec_processing_delay - get the fixed delay through the codec
>> + * @codec: HD-audio codec
>> + * @stream: playback or capture
>> + *
>> + * This is needed for codecs that contain DSPs that cause long delays.
>> + */
>> +unsigned int snd_hda_codec_processing_delay(struct hda_codec *codec,
>> +                                         unsigned int stream)
>> +{
>> +     if (codec->patch_ops.get_processing_delay)
>> +             return codec->patch_ops.get_processing_delay(codec, stream);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_HDA(snd_hda_codec_processing_delay);
>
> In the second thought, it would fit more better to pcm_ops than codec
> patch_ops.  That is, the change would be like below.

Yes this looks better.  I'll modify the subsequent patch and run our
latency tests on it to make sure it works then resend based on this.

Thanks!

-dg

>
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> index 23ca172..c93f902 100644
> --- a/sound/pci/hda/hda_codec.h
> +++ b/sound/pci/hda/hda_codec.h
> @@ -757,6 +757,9 @@ struct hda_pcm_ops {
>                        struct snd_pcm_substream *substream);
>         int (*cleanup)(struct hda_pcm_stream *info, struct hda_codec *codec,
>                        struct snd_pcm_substream *substream);
> +       unsigned int (*get_delay)(struct hda_pcm_stream *info,
> +                                 struct hda_codec *codec,
> +                                 struct snd_pcm_substream *substream);
>  };
>
>  /* PCM information for each substream */
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 418bfc0..a88f016 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2349,8 +2349,11 @@ static unsigned int azx_get_position(struct azx *chip,
>                                      struct azx_dev *azx_dev,
>                                      bool with_check)
>  {
> +       struct snd_pcm_substream *substream = azx_dev->substream;
> +       struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
>         unsigned int pos;
> -       int stream = azx_dev->substream->stream;
> +       int stream = substream->stream;
> +       struct hda_pcm_stream *hinfo = apcm->hinfo[stream];
>         int delay = 0;
>
>         switch (chip->position_fix[stream]) {
> @@ -2399,9 +2402,13 @@ static unsigned int azx_get_position(struct azx *chip,
>                         delay = 0;
>                         chip->driver_caps &= ~AZX_DCAPS_COUNT_LPIB_DELAY;
>                 }
> -               azx_dev->substream->runtime->delay =
> -                       bytes_to_frames(azx_dev->substream->runtime, delay);
> +               delay = bytes_to_frames(azx_dev->substream->runtime, delay);
>         }
> +
> +       if (hinfo->ops.get_delay)
> +               delay += hinfo->ops.get_delay(hinfo, apcm->codec, substream);
> +       azx_dev->substream->runtime->delay = delay;
> +
>         trace_azx_get_position(chip, azx_dev, pos, delay);
>         return pos;
>  }
>
>
