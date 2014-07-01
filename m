From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v4 3/8] ASoC: core: Add initial support for
 DAI multicodec
Date: Tue, 01 Jul 2014 19:27:53 +0200
Message-ID: <53B2EF99.5030006@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-4-git-send-email-bcousson@baylibre.com>
 <53B2B565.9080808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ECA02650CA
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:27:55 +0200 (CEST)
Received: by mail-wg0-f46.google.com with SMTP id y10so10019006wgg.17
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 10:27:55 -0700 (PDT)
In-Reply-To: <53B2B565.9080808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, broonie@kernel.org, lgirdwood@gmail.com
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 01/07/2014 15:19, Lars-Peter Clausen wrote:
> On 07/01/2014 09:47 AM, Benoit Cousson wrote:
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
>> Based on an original code done by Misael.
>>
>> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Almost. There are two more serious issues, the rest is trivial.

Gosh... Another new update to do :-)
I'll try to be faster this time...

>> ---
> [...]
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index 37a965c..3764150 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -554,7 +554,7 @@ int snd_soc_suspend(struct device *dev)
>>   {
>>       struct snd_soc_card *card =3D dev_get_drvdata(dev);
>>       struct snd_soc_codec *codec;
>> -    int i;
>> +    int i, j;
>>
>>       /* If the initialization of this soc device failed, there is no
>> codec
>>        * associated with it. Just bail out in this case.
>> @@ -574,14 +574,16 @@ int snd_soc_suspend(struct device *dev)
>>
>>       /* mute any active DACs */
>>       for (i =3D 0; i < card->num_rtd; i++) {
>> -        struct snd_soc_dai *dai =3D card->rtd[i].codec_dai;
>> -        struct snd_soc_dai_driver *drv =3D dai->driver;
>> +        for (j =3D 0; j < card->rtd[i].num_codecs; j++) {
>> +            struct snd_soc_dai *dai =3D card->rtd[i].codec_dais[j];
>> +            struct snd_soc_dai_driver *drv =3D dai->driver;
>>
>> -        if (card->rtd[i].dai_link->ignore_suspend)
>> -            continue;
>> +            if (card->rtd[i].dai_link->ignore_suspend)
>> +                continue;
>
> This check can actually stay outside the inner loop. We either want to
> mute all or none.

Indeed.

>
>>
>> -        if (drv->ops->digital_mute && dai->playback_active)
>> -            drv->ops->digital_mute(dai, 1);
>> +            if (drv->ops->digital_mute && dai->playback_active)
>> +                drv->ops->digital_mute(dai, 1);
>> +        }
>>       }
>>
>>       /* suspend all pcms */
> [...]
>> @@ -697,7 +703,7 @@ static void soc_resume_deferred(struct work_struct
>> *work)
>>       struct snd_soc_card *card =3D
>>               container_of(work, struct snd_soc_card,
>> deferred_resume_work);
>>       struct snd_soc_codec *codec;
>> -    int i;
>> +    int i, j;
>>
>>       /* our power state is still SNDRV_CTL_POWER_D3hot from suspend
>> time,
>>        * so userspace apps are blocked from touching us
>> @@ -758,14 +764,17 @@ static void soc_resume_deferred(struct
>> work_struct *work)
>>
>>       /* unmute any active DACs */
>>       for (i =3D 0; i < card->num_rtd; i++) {
>> -        struct snd_soc_dai *dai =3D card->rtd[i].codec_dai;
>> -        struct snd_soc_dai_driver *drv =3D dai->driver;
>>
>> -        if (card->rtd[i].dai_link->ignore_suspend)
>> -            continue;
>> +        for (j =3D 0; j < card->rtd[i].num_codecs; j++) {
>> +            struct snd_soc_dai *dai =3D card->rtd[i].codec_dais[j];
>> +            struct snd_soc_dai_driver *drv =3D dai->driver;
>> +
>> +            if (card->rtd[i].dai_link->ignore_suspend)
>> +                continue;
>
> Same as with the mute loop.

OK

>
>>
>> -        if (drv->ops->digital_mute && dai->playback_active)
>> -            drv->ops->digital_mute(dai, 0);
>> +            if (drv->ops->digital_mute && dai->playback_active)
>> +                drv->ops->digital_mute(dai, 0);
>> +        }
>>       }
>>
>>       for (i =3D 0; i < card->num_rtd; i++) {
> [...]                int num)
>> +static int soc_aux_dev_init(struct snd_soc_card *card, int num)
>>   {
>>       struct snd_soc_aux_dev *aux_dev =3D &card->aux_dev[num];
>>       struct snd_soc_pcm_runtime *rtd =3D &card->rtd_aux[num];
>> +    struct snd_soc_codec *codec;
>>       int ret;
>>
>>       rtd->card =3D card;
>>
>> +    codec =3D soc_find_codec(NULL, aux_dev->codec_name);
>
> We actually have support for binding the aux dev by DT node now. But I
> have a patch in my componentization branch that cleans all this up. Let
> me send it to you and then you can rebase on-top of that.

OK, I guess you are talking about soc_find_matching_codec API introduced =

by Sebatian. Are you gonna merge it with the soc_find_codec API?

>
>> +    if (!codec)
>> +        return -EPROBE_DEFER;
>> +
>>       /* do machine specific initialization */
>>       if (aux_dev->init) {
>>           ret =3D aux_dev->init(&codec->dapm);
>> @@ -1286,16 +1316,19 @@ static int soc_aux_dev_init(struct
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
>> -    int ret;
>> +    int i, ret;
>>
>>       rtd->card =3D card;
>>
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        /* Make sure all DAPM widgets are instantiated */
>> +        snd_soc_dapm_new_widgets(rtd->codec_dais[i]->codec->dapm.card);
>> +    }
>
> This is still a left over from a very early revision of this patch. We
> removed this in upstream a while ago.

Oops, sorry about that :-(

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
