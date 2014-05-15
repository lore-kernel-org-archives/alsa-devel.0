From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Thu, 15 May 2014 17:01:19 +0200
Message-ID: <5374D6BF.4060500@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
 [209.85.213.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CA86261ACD
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 17:01:25 +0200 (CEST)
Received: by mail-ig0-f176.google.com with SMTP id hl10so8011129igb.15
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 08:01:22 -0700 (PDT)
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

I'm struggling a little bit to understand one of your comment :-)

On 26/04/2014 14:51, Lars-Peter Clausen wrote:
> On 04/24/2014 02:01 PM, Benoit Cousson wrote:
>> @@ -870,6 +876,10 @@ struct snd_soc_dai_link {
>>       const struct device_node *codec_of_node;
>>       /* You MUST specify the DAI name within the codec */
>>       const char *codec_dai_name;
>> +
>> +    struct snd_soc_dai_link_component *codecs;
> =

> Should probably be const

In fact, I don't think this is not possible, since this struct will be init=
ialized at runtime in the legacy case when the regular codec struct is the =
one used by the driver.

[...]

>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct =

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
> =

> This will create a DAI link widget for each CODEC DAI. The DAI link =

> widget will configure the CPU and the CODEC DAI that are connected to =

> it. If there is one DAI link widget per CODEC DAI this means that the =

> CPU DAI will be connected to multiple DAI link widgets, which means it =

> will be configured once for each CODEC DAI (with possible conflicting =

> configurations).

I've got that point, but now I'm wondering what struct should be per codec_=
dai. Should we consider one source and several sinks to represent the multi=
ple codecs?

> So there should only be one DAI link widget per DAI link, with the CPU =

> DAI on one side and the CODEC DAIs on the other side. Note that you'll =

> also need to re-work snd_soc_dai_link_event() to handle multiple =

> inputs/outputs. I'd factor that part out into a separate patch.

Here, I'm lost :-)

What struct should be made multiple in that case?

Should we consider that the following list can handle multiple sink/source?

	/* We only support a single source and sink, pick the first */
	source_p =3D list_first_entry(&w->sources, struct snd_soc_dapm_path,
				    list_sink);
	sink_p =3D list_first_entry(&w->sinks, struct snd_soc_dapm_path,
				  list_source);

[...]

Thanks,
Benoit

-- =

Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
