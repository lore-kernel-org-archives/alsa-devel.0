From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 3/4] ALSA: CA0132: Add latency monitoring
Date: Mon, 25 Mar 2013 10:47:31 -0700
Message-ID: <CAEUnVG5t5MHWbYRDnFW268cekt5bVGe6=-ba7uzW+5xn1h1uiA@mail.gmail.com>
References: <1360377105-2480-1-git-send-email-ian_minett@creativelabs.com>
 <1360377105-2480-4-git-send-email-ian_minett@creativelabs.com>
 <s5hehgozbl5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 53B402625DE
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 18:47:52 +0100 (CET)
Received: by mail-ee0-f46.google.com with SMTP id e49so3315993eek.5
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 10:47:52 -0700 (PDT)
In-Reply-To: <s5hehgozbl5.wl%tiwai@suse.de>
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

On Sun, Feb 10, 2013 at 2:51 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 8 Feb 2013 18:31:44 -0800,
> Ian Minett wrote:
>>
>> From: Ian Minett <ian_minett@creativelabs.com>
>>
>> Add latency monitoring for playback, capture and DSP effects.
>
> Please give a bit more descriptions.
> Looking at the patch, it doesn't implement only the latency monitoring
> but actually reflecting to the runtime->delay.
>
> Also..
>
>
>> Signed-off-by: Ian Minett <ian_minett@creativelabs.com>
>>
>> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
>> index b52f00c..c797f65 100644
>> --- a/sound/pci/hda/patch_ca0132.c
>> +++ b/sound/pci/hda/patch_ca0132.c
>> @@ -133,6 +133,12 @@ enum {
>>  /* Effects values size*/
>>  #define EFFECT_VALS_MAX_COUNT 12
>>
>> +#define DSP_CAPTURE_INIT_LATENCY        0
>> +#define DSP_CRYSTAL_VOICE_LATENCY       124
>> +#define DSP_PLAYBACK_INIT_LATENCY       13
>> +#define DSP_PLAY_ENHANCEMENT_LATENCY    30
>> +#define DSP_SPEAKER_OUT_LATENCY         7
>> +
>>  struct ct_effect {
>>       char name[44];
>>       hda_nid_t nid;
>> @@ -2761,8 +2767,27 @@ static void ca0132_cleanup_stream(struct hda_codec *codec, hda_nid_t nid)
>>  }
>>
>>  /*
>> - * PCM callbacks
>> + * PCM playbacks
>>   */
>> +static unsigned int ca0132_get_playback_latency(struct hda_codec *codec)
>> +{
>> +     struct ca0132_spec *spec = codec->spec;
>> +     unsigned int latency = DSP_PLAYBACK_INIT_LATENCY;
>> +
>> +     if (!dspload_is_loaded(codec))
>> +             return 0;
>> +
>> +     if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID]) {
>> +             if ((spec->effects_switch[SURROUND - EFFECT_START_NID]) ||
>> +                 (spec->effects_switch[DIALOG_PLUS - EFFECT_START_NID]))
>> +                     latency += DSP_PLAY_ENHANCEMENT_LATENCY;
>> +     }
>> +
>> +     if (spec->cur_out_type == SPEAKER_OUT)
>> +             latency += DSP_SPEAKER_OUT_LATENCY;
>> +     return latency;
>> +}
>> +
>>  static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>>                       struct hda_codec *codec,
>>                       unsigned int stream_tag,
>> @@ -2770,6 +2795,16 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
>>                       struct snd_pcm_substream *substream)
>>  {
>>       struct ca0132_spec *spec = codec->spec;
>> +     struct snd_pcm_runtime *runtime = substream->runtime;
>> +     unsigned int latency = ca0132_get_playback_latency(codec);
>> +
>> +     if (spec->dsp_state == DSP_DOWNLOADING) {
>> +             spec->dsp_stream_id = stream_tag;
>> +             return 0;
>> +     }
>> +
>> +     runtime->delay = bytes_to_frames(runtime, (latency * runtime->rate *
>> +                                     runtime->byte_align) / 1000);
>>
>>       ca0132_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
>>
>> @@ -2834,8 +2869,22 @@ static int ca0132_dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
>>  }
>>
>>  /*
>> - * Analog capture
>> + * PCM capture
>>   */
>> +
>> +static unsigned int ca0132_get_capture_latency(struct hda_codec *codec)
>> +{
>> +     struct ca0132_spec *spec = codec->spec;
>> +     unsigned int latency = DSP_CAPTURE_INIT_LATENCY;
>> +
>> +     if (!dspload_is_loaded(codec))
>> +             return 0;
>> +
>> +     if (spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID])
>> +             latency += DSP_CRYSTAL_VOICE_LATENCY;
>> +     return latency;
>> +}
>> +
>>  static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
>>                                       struct hda_codec *codec,
>>                                       unsigned int stream_tag,
>> @@ -2843,9 +2892,16 @@ static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
>>                                       struct snd_pcm_substream *substream)
>>  {
>>       struct ca0132_spec *spec = codec->spec;
>> +     struct snd_pcm_runtime *runtime = substream->runtime;
>> +     unsigned int latency = ca0132_get_capture_latency(codec);
>>
>> -     ca0132_setup_stream(codec, spec->adcs[substream->number],
>> -                         stream_tag, 0, format);
>> +     if (spec->dsp_state == DSP_DOWNLOADING)
>> +             return 0;
>> +
>> +     runtime->delay = bytes_to_frames(runtime, (latency * runtime->rate *
>> +                                     runtime->byte_align) / 1000);
>> +
>> +     ca0132_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
>>
>>       return 0;
>>  }
>> @@ -3429,6 +3485,33 @@ static int ca0132_voicefx_set(struct hda_codec *codec, int enable)
>>       return 1;
>>  }
>>
>> +static void ca0132_update_latency(struct hda_codec *codec,
>> +                               unsigned int direction)
>> +{
>> +     struct ca0132_spec *spec = codec->spec;
>> +     unsigned int latency;
>> +     struct snd_pcm_substream *substr;
>> +     struct snd_pcm_runtime *runtime;
>> +
>> +     if (spec->dsp_state == DSP_DOWNLOADING)
>> +             return;
>> +
>> +     latency = (direction == SNDRV_PCM_STREAM_PLAYBACK)
>> +                     ? ca0132_get_playback_latency(codec)
>> +                     : ca0132_get_capture_latency(codec);
>> +
>> +     substr = codec->pcm_info->pcm->streams[direction].substream;
>> +     while (substr) {
>> +             runtime = substr->runtime;
>> +             /* update latency only when frame_bits is set */
>> +             if (runtime && runtime->frame_bits)
>> +                     runtime->delay = bytes_to_frames(runtime,
>> +                                     (latency * runtime->rate *
>> +                                     runtime->byte_align) / 1000);
>> +             substr = substr->next;
>> +     }
>
> I guess this isn't needed.  Usually the pointer callback is performed
> always before the inquiry of runtime->delay.

Thanks for pointing that out Takashi.  This will have no effect, as
azx_get_position now recalculates the delay based on LPIB position.

What was trying to be solved was that there is a large delay in the
codec, and other codecs with integrated DSP.  In this case it is
greater than 100ms, depending on what effects are enabled.  Is there a
good was to add this delay to what is reported?  Maybe allow the codec
to specify a delay that is added to the calculation in
azx_get_position?

>
>
> Takashi
>
>
>> +}
>> +
>>  /*
>>   * Set the effects parameters
>>   */
>> @@ -3468,6 +3551,9 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
>>       err = dspio_set_uint_param(codec, ca0132_effects[idx].mid,
>>                                  ca0132_effects[idx].reqs[0], on);
>>
>> +     ca0132_update_latency(codec, SNDRV_PCM_STREAM_PLAYBACK);
>> +     ca0132_update_latency(codec, SNDRV_PCM_STREAM_CAPTURE);
>> +
>>       if (err < 0)
>>               return 0; /* no changed */
>>
>> --
>> 1.7.4.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
