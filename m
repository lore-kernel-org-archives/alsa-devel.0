From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Tue, 29 Apr 2014 19:53:16 +0200
Message-ID: <535FE70C.3080706@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id A66DD2619E5
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 19:53:24 +0200 (CEST)
Received: by mail-ig0-f176.google.com with SMTP id r10so489876igi.9
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:53:19 -0700 (PDT)
In-Reply-To: <535BABCF.6080001@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 26/04/2014 14:51, Lars-Peter Clausen wrote:
> On 04/24/2014 02:01 PM, Benoit Cousson wrote:
>> DAI link assumes a one to one mapping between CPU DAI and CODEC. In
>> some cases, the same CPU DAI can be connected to several codecs.
>> This is the case for example, if you connect two mono codecs to the
>> same I2S link in order to have a stereo card.
>> The current ASoC implementation does not allow such setup.
>>
>> Add support for DAI links composed of a single CPU DAI and multiple
>> CODECs. Sound cards have to pass the CODECs array in the corresponding
>> DAI link through a new 'snd_soc_dai_link_component' struct. Each CODEC in
>> this array is described in the same manner single CODEC DAIs are
>> (either DT/OF node or codec_name).
>>
>> Fix a trailing space in the header as well.
>>
>> Based on an original code done by Misael.
>>
>> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Looks mostly good. A few bits and pieces here and there, comments inline.

Cool, it is getting closer :-)

>
> [...]
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index 0fadb3c..7933512 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -821,6 +821,12 @@ struct snd_soc_platform_driver {
>>       int (*bespoke_trigger)(struct snd_pcm_substream *, int);
>>   };
>>
>> +struct snd_soc_dai_link_component {
>> +    const char *name;
>> +    const struct device_node *of_node;
>> +    const char *dai_name;
>> +};
>> +
>>   struct snd_soc_platform {
>>       const char *name;
>>       int id;
>> @@ -870,6 +876,10 @@ struct snd_soc_dai_link {
>>       const struct device_node *codec_of_node;
>>       /* You MUST specify the DAI name within the codec */
>>       const char *codec_dai_name;
>> +
>> +    struct snd_soc_dai_link_component *codecs;
>
> Should probably be const

OK.

>
>> +    unsigned int num_codecs;
>> +
>>       /*
>>        * You MAY specify the link's platform/PCM/DMA driver, either by
>>        * device name, or by DT/OF node, but not both. Some forms of link
> [...]
>> @@ -620,23 +631,26 @@ int soc_new_compress(struct snd_soc_pcm_runtime
>> *rtd, int num)
>>   {
>>       struct snd_soc_codec *codec =3D rtd->codec;
>>       struct snd_soc_platform *platform =3D rtd->platform;
>> -    struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>>       struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>>       struct snd_compr *compr;
>>       struct snd_pcm *be_pcm;
>>       char new_name[64];
>> -    int ret =3D 0, direction =3D 0;
>> +    int i, ret =3D 0, direction =3D 0;
>>
>> -    /* check client and interface hw capabilities */
>> -    snprintf(new_name, sizeof(new_name), "%s %s-%d",
>> -            rtd->dai_link->stream_name, codec_dai->name, num);
>>
>> -    if (codec_dai->driver->playback.channels_min)
>> -        direction =3D SND_COMPRESS_PLAYBACK;
>> -    else if (codec_dai->driver->capture.channels_min)
>> -        direction =3D SND_COMPRESS_CAPTURE;
>> -    else
>> -        return -EINVAL;
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +        /* check client and interface hw capabilities */
>> +        snprintf(new_name, sizeof(new_name), "%s %s-%d",
>> +             rtd->dai_link->stream_name, codec_dai->name, num);
>> +
>> +        if (codec_dai->driver->playback.channels_min)
>> +            direction =3D SND_COMPRESS_PLAYBACK;
>> +        else if (codec_dai->driver->capture.channels_min)
>> +            direction =3D SND_COMPRESS_CAPTURE;
>> +        else
>> +            return -EINVAL;
>> +    }
>
> This loop makes no sense, you just end up overwriting new_name and
> direction with each loop iteration.

Mmm, indeed! I just did a dumb search and replace without understanding =

what that was doing :-)
In that case we could potentially check that everything codecs does have =

the same direction... hoping it will be the case.

>
>>
>>       compr =3D kzalloc(sizeof(*compr), GFP_KERNEL);
>>       if (compr =3D=3D NULL) {
>> @@ -690,8 +704,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime
>> *rtd, int num)
>>       rtd->compr =3D compr;
>>       compr->private_data =3D rtd;
>>
>> -    printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
>> codec_dai->name,
>> -        cpu_dai->name);
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +        printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
>> +               codec_dai->name, cpu_dai->name);
>> +    }
>>       return ret;
>>
>>   compr_err:
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index f18112a..7f68492 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
> [...]
>> @@ -1294,20 +1324,28 @@ static int soc_aux_dev_init(struct
>> snd_soc_card *card,
>>       return 0;
>>   }
>>
>> -static int soc_dai_link_init(struct snd_soc_card *card,
>> -                 struct snd_soc_codec *codec,
>> -                 int num)
>> +static int soc_dai_link_init(struct snd_soc_card *card, int num)
>>   {
>>       struct snd_soc_dai_link *dai_link =3D  &card->dai_link[num];
>>       struct snd_soc_pcm_runtime *rtd =3D &card->rtd[num];
>> -    const char *temp;
>> -    int ret;
>> +    const char **temp;
>> +    int i, ret;
>>
>>       rtd->card =3D card;
>>
>> -    /* machine controls, routes and widgets are not prefixed */
>> -    temp =3D codec->name_prefix;
>> -    codec->name_prefix =3D NULL;
>> +    temp =3D devm_kzalloc(card->dev, rtd->num_codecs * sizeof(char *),
>> +                GFP_KERNEL);
>> +    if (!temp)
>> +        return -ENOMEM;
>> +
>
> Setting name_prefix temporarily to NULL is no longer necessary, see the
> patch I just sent out.

Yep, I saw it. Sorry for pulling some code you've just removed.

>
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        /* Make sure all DAPM widgets are instantiated */
>> +        snd_soc_dapm_new_widgets(rtd->codec_dais[i]->codec->dapm.card);
>> +
>> +        /* machine controls, routes and widgets are not prefixed */
>> +        temp[i] =3D rtd->codec_dais[i]->codec->name_prefix;
>> +        rtd->codec_dais[i]->codec->name_prefix =3D NULL;
>> +    }
>>
>>       /* do machine specific initialization */
>>       if (dai_link->init) {
> [...]
>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct
>> snd_soc_card *card, int num, int order)
>>                           codec2codec_close_delayed_work);
>>
>>               /* link the DAI widgets */
>> -            ret =3D soc_link_dai_widgets(card, dai_link,
>> -                    cpu_dai, codec_dai);
>> -            if (ret)
>> -                return ret;
>> +            for (i =3D 0; i < rtd->num_codecs; i++) {
>> +                ret =3D soc_link_dai_widgets(card, dai_link,
>> +                        cpu_dai, rtd->codec_dais[i]);
>
> This will create a DAI link widget for each CODEC DAI. The DAI link
> widget will configure the CPU and the CODEC DAI that are connected to
> it. If there is one DAI link widget per CODEC DAI this means that the
> CPU DAI will be connected to multiple DAI link widgets, which means it
> will be configured once for each CODEC DAI (with possible conflicting
> configurations).
>
> So there should only be one DAI link widget per DAI link, with the CPU
> DAI on one side and the CODEC DAIs on the other side. Note that you'll
> also need to re-work snd_soc_dai_link_event() to handle multiple
> inputs/outputs. I'd factor that part out into a separate patch.

OK.

>
>> +                if (ret)
>> +                    return ret;
>> +            }
>>           }
>>       }
>>
>>       /* add platform data for AC97 devices */
>> -    if (rtd->codec_dai->driver->ac97_control)
>> -        snd_ac97_dev_add_pdata(codec->ac97, rtd->cpu_dai->ac97_pdata);
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        if (rtd->codec_dais[i]->driver->ac97_control)
>> +            snd_ac97_dev_add_pdata(rtd->codec_dais[i]->codec->ac97,
>> +                           rtd->cpu_dai->ac97_pdata);
>> +    }
>>
>>       return 0;
>>   }
>> @@ -1635,7 +1680,20 @@ static int soc_register_ac97_codec(struct
>> snd_soc_codec *codec,
>>
>>   static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
>>   {
>> -    return soc_register_ac97_codec(rtd->codec, rtd->codec_dai);
>> +    int i, ret;
>> +
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +
>> +        ret =3D soc_register_ac97_codec(codec_dai->codec, codec_dai);
>> +        if (ret) {
>> +            while (--i >=3D 0)
>> +                soc_unregister_ac97_codec(codec_dai->codec);
>
> You use soc_unregister_ac97_codec here ...
>
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>
>>   static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
>> @@ -1648,7 +1706,10 @@ static void soc_unregister_ac97_codec(struct
>> snd_soc_codec *codec)
>>
>>   static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime
>> *rtd)
>
> ... but only define it here. This causes a compile error. Just move
> soc_unregister_ac97_dai_link before soc_register_ac97_codec
>

Oops, I did not have the CONFIG_SND_SOC_AC97_BUS enabled and missed that =

issue.

>>   {
>> -    soc_unregister_ac97_codec(rtd->codec);
>> +    int i;
>> +
>> +    for (i =3D 0; i < rtd->num_codecs; i++)
>> +        soc_unregister_ac97_codec(rtd->codec_dais[i]->codec);
>>   }
>>   #endif
>>
> [...]
>> +static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
>> +                  struct snd_soc_dai *cpu_dai,
>> +                  struct snd_soc_dai *codec_dai,
>> +                  int stream, int event)
>> +{
>>       struct snd_soc_dapm_widget *w_cpu, *w_codec;
>> -    struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>> -    struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>
> The way this should be implemented is:
>      * Update CPU DAI (set active, mark widget dirty)
>      * Update all CODEC DAIs
>      * Run dapm_power_widgets()

OK.

>
>>
>>       if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
>>           w_cpu =3D cpu_dai->playback_widget;
> [...]
>> @@ -107,11 +115,15 @@ void snd_soc_runtime_deactivate(struct
>> snd_soc_pcm_runtime *rtd, int stream)
>>    */
>>   bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime
>> *rtd)
>>   {
>> +    int i, ignore =3D 0;
>> +
>>       if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
>>           return true;
>>
>> -    return rtd->cpu_dai->component->ignore_pmdown_time &&
>> -            rtd->codec_dai->component->ignore_pmdown_time;
>> +    for (i =3D 0; (i < rtd->num_codecs) && !ignore; i++)
>> +        ignore |=3D rtd->codec_dais[i]->component->ignore_pmdown_time;
>
> The power-down delay must only be ignored if all components connected to
> the DAI link agree that it can be ignored.

OK, so it should be an "&" then.

>
>> +
>> +    return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
>>   }
>>
>>   /**
>> @@ -222,8 +234,7 @@ static int soc_pcm_params_symmetry(struct
>> snd_pcm_substream *substream,
>>   {
>>       struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
>>       struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>> -    struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>> -    unsigned int rate, channels, sample_bits, symmetry;
>> +    unsigned int rate, channels, sample_bits, symmetry, i;
>>
>>       rate =3D params_rate(params);
>>       channels =3D params_channels(params);
>> @@ -231,8 +242,12 @@ static int soc_pcm_params_symmetry(struct
>> snd_pcm_substream *substream,
>>
>>       /* reject unmatched parameters when applying symmetry */
>>       symmetry =3D cpu_dai->driver->symmetric_rates ||
>> -        codec_dai->driver->symmetric_rates ||
>>           rtd->dai_link->symmetric_rates;
>> +
>> +    for (i =3D 0; i < rtd->num_codecs; i++)
>> +        symmetry =3D rtd->codec_dais[i]->driver->symmetric_rates ||
>> +                   symmetry;
>
> Just writing symmetery |=3D ... should be fine, that makes it a bit
> shorter. Same comment for the same pattern below.

OK.

>
>> +
>>       if (symmetry && cpu_dai->rate && cpu_dai->rate !=3D rate) {
>>           dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
>>                   cpu_dai->rate, rate);
>> @@ -240,8 +255,12 @@ static int soc_pcm_params_symmetry(struct
>> snd_pcm_substream *substream,
> [...]
>> @@ -418,22 +487,22 @@ static int soc_pcm_open(struct snd_pcm_substream
>> *substream)
>>       ret =3D -EINVAL;
>>       if (!runtime->hw.rates) {
>>           printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
>> -            codec_dai->name, cpu_dai->name);
>> +            codec_dai_name, cpu_dai->name);
>>           goto config_err;
>>       }
>>       if (!runtime->hw.formats) {
>>           printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
>> -            codec_dai->name, cpu_dai->name);
>> +            codec_dai_name, cpu_dai->name);
>>           goto config_err;
>>       }
>>       if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
>>           runtime->hw.channels_min > runtime->hw.channels_max) {
>>           printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
>> -                codec_dai->name, cpu_dai->name);
>> +                codec_dai_name, cpu_dai->name);
>>           goto config_err;
>>       }
>>
>> -    soc_pcm_apply_msb(substream, codec_dai);
>> +    soc_pcm_apply_msb(substream, rtd->codec_dais[0]);
>
> The msb constraint that gets applied for the CODEC side should be the
> maximum over all the CODECs sig_bits. If one of them is 0 there is no
> constraint from the CODEC side.

OK.

>
>>       soc_pcm_apply_msb(substream, cpu_dai);
>>
>>       /* Symmetry only applies if we've already got an active stream. */
> [...]
>> @@ -2181,22 +2364,28 @@ static int dpcm_fe_dai_close(struct
>> snd_pcm_substream *fe_substream)
>>   int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>>   {
>>       struct snd_soc_platform *platform =3D rtd->platform;
>> -    struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>> +    struct snd_soc_dai *codec_dai;
>>       struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
>>       struct snd_pcm *pcm;
>>       char new_name[64];
>>       int ret =3D 0, playback =3D 0, capture =3D 0;
>> +    int i;
>>
>>       if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
>>           playback =3D rtd->dai_link->dpcm_playback;
>>           capture =3D rtd->dai_link->dpcm_capture;
>>       } else {
>> -        if (codec_dai->driver->playback.channels_min &&
>> -            cpu_dai->driver->playback.channels_min)
>> -            playback =3D 1;
>> -        if (codec_dai->driver->capture.channels_min &&
>> -            cpu_dai->driver->capture.channels_min)
>> -            capture =3D 1;
>> +        for (i =3D 0; i < rtd->num_codecs; i++) {
>> +            codec_dai =3D rtd->codec_dais[i];
>> +            if (codec_dai->driver->playback.channels_min &&
>> +                cpu_dai->driver->playback.channels_min)
>> +                playback++;
>> +            if (codec_dai->driver->capture.channels_min &&
>> +                cpu_dai->driver->capture.channels_min)
>> +                capture++;
>> +        }
>> +        capture =3D (rtd->num_codecs =3D=3D capture);
>> +        playback =3D (rtd->num_codecs =3D=3D playback);
>
> I think it should be sufficent if at least one of them has a
> channels_min !=3D 0 to create the stream. Not all of the CODEC necesarrily
> do have to have data flowing in both directions. So thing like:
>
>          for (i =3D 0; i < rtd->num_codecs; i++) {
>              codec_dai =3D rtd->codec_dais[i];
>              if (codec_dai->driver->playback.channels_min)
>                  codec_playback =3D true;
>              if (codec_dai->driver->capture.channels_min)
>                  codec_capture =3D true;
>          }
>
>          if (cpu_dai->driver->playback.channels_min &&
>              codec_playback)
>              playback =3D true;
>          ...
>

OK.

>
>>       }
> [...]

Thanks for exhaustive review and comments.

I'll try to update faster than for the v3, but I'm stuck at ELC this week.

Regards,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
