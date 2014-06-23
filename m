From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Mon, 23 Jun 2014 16:26:17 +0200
Message-ID: <53A83909.2060002@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <5368C67D.4080506@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 by alsa0.perex.cz (Postfix) with ESMTP id DCEAD2610A1
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 16:26:19 +0200 (CEST)
Received: by mail-we0-f178.google.com with SMTP id x48so7219402wes.9
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 07:26:19 -0700 (PDT)
In-Reply-To: <5368C67D.4080506@metafoo.de>
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

I finally got some BW to address your second email :-)

On 06/05/2014 13:24, Lars-Peter Clausen wrote:
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
> Some thoughts on the parameter fixup.
>
>> ---
>>   include/sound/soc-dai.h  |   5 +
>>   include/sound/soc.h      |  13 ++
>>   sound/soc/soc-compress.c |  83 +++++---
>>   sound/soc/soc-core.c     | 364 ++++++++++++++++++++++-----------
>>   sound/soc/soc-dapm.c     |  71 ++++---
>>   sound/soc/soc-pcm.c      | 512
>> ++++++++++++++++++++++++++++++++---------------
>>   6 files changed, 715 insertions(+), 333 deletions(-)
>>
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index fad7676..6985851 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -274,6 +274,11 @@ struct snd_soc_dai {
>>       struct snd_soc_codec *codec;
>>       struct snd_soc_component *component;
>>
>> +    /* CODEC TDM slot masks and params (for fixup) */
>> +    unsigned int tx_mask;
>> +    unsigned int rx_mask;
>> +    struct snd_pcm_hw_params params[2];
>
> snd_pcm_hw_params is rather large, given that for a lot of setups we
> don't need it it might be better to make this a pointer and only
> allocate the params struct when needed.

OK.

>
> [...]
>> @@ -3624,17 +3697,26 @@ static int
>> snd_soc_xlate_tdm_slot_mask(unsigned int slots,
>>   int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
>>       unsigned int tx_mask, unsigned int rx_mask, int slots, int
>> slot_width)
>>   {
>> +    int ret =3D 0;
>> +
>>       if (dai->driver && dai->driver->ops->xlate_tdm_slot_mask)
>>           dai->driver->ops->xlate_tdm_slot_mask(slots,
>>                           &tx_mask, &rx_mask);
>>       else
>>           snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
>>
>> +    if (dai->codec) {
>> +        dai->tx_mask =3D tx_mask;
>> +        dai->rx_mask =3D rx_mask;
>> +    }
>
> I don't think it makes sense to artificially limit this to just CODECs.
> While we do not support multiple CPU DAIs (yet?) adding the check for
> CODECs just makes the code more complex, but doesn't gain us anything.

OK, makes sense.

>
>
> [...]
>> +    for (i =3D 0; i < rtd->num_codecs; i++) {
>> +        struct snd_soc_dai *codec_dai =3D rtd->codec_dais[i];
>> +        struct snd_pcm_hw_params *codec_params;
>> +
>> +        codec_params =3D &codec_dai->params[substream->stream];
>
> The fixed up params are only ever used in here. Do we really need to
> keep two copies per CODEC DAI around?

Well, we can indeed, create a local copy that will be used for the =

fixup. Moreover, it will avoid allocating the data dynamically.

>> +
>> +        /* copy params for each codec */
>> +        memcpy(codec_params, params, sizeof(struct snd_pcm_hw_params));
>> +
>> +        /* fixup params based on TDM slot masks */
>> +        if (codec_dai->tx_mask)
>> +            soc_pcm_codec_params_fixup(codec_params,
>> +                           codec_dai->tx_mask);
>> +        if (codec_dai->rx_mask)
>> +            soc_pcm_codec_params_fixup(codec_params,
>> +                           codec_dai->rx_mask);
>> +
>
> If we fix-up the number of channels to be always the number of slots
> should we also setup a constraint for userspace that the number of
> channels must match the number of channels specified in the CPU DAI
> mask? Or should we check how many of the channels in the CODEC mask are
> actually active and fix-up the the number of channels according to that?

That's a pretty good question.

I've tried to check the current users of the snd_soc_dai_set_tdm_slot to =

understand how it is used in cpu/codec dais.

There are only ~10 users, and it seems that the definition of the mask =

is dependent of the user. I don't know if we can really enforce anything =

because of that :-(

>> +        if (codec_dai->driver->ops &&
>> +            codec_dai->driver->ops->hw_params) {
>> +            ret =3D codec_dai->driver->ops->hw_params(substream,
>> +                        codec_params, codec_dai);
>> +            if (ret < 0) {
>> +                dev_err(codec_dai->dev,
>> +                    "ASoC: can't set %s hw params: %d\n",
>> +                    codec_dai->name, ret);
>> +                goto codec_err;
>> +            }
>>           }
>
> I think it makes sense to factor this whole block out into a helper
> function. E.g. soc_dai_hw_params(struct snd_soc_dai* dai, struct
> hw_params *params);. This will make it possible to also use it in other
> places like the dapm_dai_link_event() function.

OK, good point.

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
