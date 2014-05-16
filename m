From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Fri, 16 May 2014 13:31:27 +0200
Message-ID: <5375F70F.6050000@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de> <5374D6BF.4060500@baylibre.com>
 <5375EC1C.9020909@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id DD273261A12
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 13:31:30 +0200 (CEST)
Received: by mail-ig0-f170.google.com with SMTP id r10so1524131igi.5
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 04:31:30 -0700 (PDT)
In-Reply-To: <5375EC1C.9020909@metafoo.de>
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

On 16/05/2014 12:44, Lars-Peter Clausen wrote:
> On 05/15/2014 05:01 PM, Benoit Cousson wrote:
>> Hi Lars,
>>
>> I'm struggling a little bit to understand one of your comment :-)
>>
>> On 26/04/2014 14:51, Lars-Peter Clausen wrote:
>>> On 04/24/2014 02:01 PM, Benoit Cousson wrote:
>>>> @@ -870,6 +876,10 @@ struct snd_soc_dai_link {
>>>>        const struct device_node *codec_of_node;
>>>>        /* You MUST specify the DAI name within the codec */
>>>>        const char *codec_dai_name;
>>>> +
>>>> +    struct snd_soc_dai_link_component *codecs;
>>>
>>> Should probably be const
>>
>> In fact, I don't think this is not possible, since this struct will be
>> initialized at runtime in the legacy case when the regular codec
>> struct is the one used by the driver.
>
> That shouldn't be a problem. The const applies to the data the pointer
> points to, not the pointer itself.

Yeah, I know. But in that case, we populate the data based on the ones =

in the codec struct. We do not just assign the pointer. The fact is the =

compiler is complaining about that anyway :-)

>> [...]
>>
>>>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct
>>>> snd_soc_card *card, int num, int order)
>>>>                            codec2codec_close_delayed_work);
>>>>
>>>>                /* link the DAI widgets */
>>>> -            ret =3D soc_link_dai_widgets(card, dai_link,
>>>> -                    cpu_dai, codec_dai);
>>>> -            if (ret)
>>>> -                return ret;
>>>> +            for (i =3D 0; i < rtd->num_codecs; i++) {
>>>> +                ret =3D soc_link_dai_widgets(card, dai_link,
>>>> +                        cpu_dai, rtd->codec_dais[i]);
>>>
>>> This will create a DAI link widget for each CODEC DAI. The DAI link
>>> widget will configure the CPU and the CODEC DAI that are connected to
>>> it. If there is one DAI link widget per CODEC DAI this means that the
>>> CPU DAI will be connected to multiple DAI link widgets, which means it
>>> will be configured once for each CODEC DAI (with possible conflicting
>>> configurations).
>>
>> I've got that point, but now I'm wondering what struct should be per
>> codec_dai. Should we consider one source and several sinks to
>> represent the multiple codecs?
>
> The soc_link_dai_widgets function should take the rtd as a parameter
> instead of the CODEC and CPU DAIs. Same goes for snd_soc_dapm_new_pcm()
> then you create one dai_link widget per stream (i.e. one for capture of
> there is capture support, one for playback if there is playback
> support). And then create the paths between the dai_link widgets and the
> DAI widgets accordingly.

Yep, I've done that part already, but this is widget -> dai relation =

that was not clear to me.

>>> So there should only be one DAI link widget per DAI link, with the CPU
>>> DAI on one side and the CODEC DAIs on the other side. Note that you'll
>>> also need to re-work snd_soc_dai_link_event() to handle multiple
>>> inputs/outputs. I'd factor that part out into a separate patch.
>>
>> Here, I'm lost :-)
>>
>> What struct should be made multiple in that case?
>>
>> Should we consider that the following list can handle multiple
>> sink/source?
>>
>>     /* We only support a single source and sink, pick the first */
>>     source_p =3D list_first_entry(&w->sources, struct snd_soc_dapm_path,
>>                     list_sink);
>>     sink_p =3D list_first_entry(&w->sinks, struct snd_soc_dapm_path,But

>>                   list_source);
>>
>> [...]
>
> See the attached patch.

Cool, thanks for that.

> If you don't want to worry about these things for now it should be fine
> to add a check in soc_probe_link_dais() and make sure that num_codecs =3D=
=3D
> 1 for the CODEC to CODEC case. This means we'll not support multi-codec
> links for CODEC to CODEC links, which should in my opinion be fine for no=
w.

That sounds like a good plan to me. The patch is already pretty big, and =

assumning it will not generate regression in the regular case (single =

codec), it might be good to start merging the current work in progress =

and add the full multi codec support later.

I'll repost to fix the current comments and let you decide what you'll =

do with that code :-)

Thanks for the help,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
