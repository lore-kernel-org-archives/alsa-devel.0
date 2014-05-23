From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
	multicodec
Date: Fri, 23 May 2014 14:42:26 +0200
Message-ID: <537F4232.4090801@metafoo.de>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <535BABCF.6080001@metafoo.de> <5374D6BF.4060500@baylibre.com>
 <5375EC1C.9020909@metafoo.de> <537DA0C6.7080502@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 89F73264FE3
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 14:42:31 +0200 (CEST)
In-Reply-To: <537DA0C6.7080502@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/22/2014 09:01 AM, Benoit Cousson wrote:
> Hi Lars,
>
> On 16/05/2014 12:44, Lars-Peter Clausen wrote:
>> On 05/15/2014 05:01 PM, Benoit Cousson wrote:
>
> [...]
>
>>>>> @@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct
>>>>> snd_soc_card *card, int num, int order)
>>>>>                             codec2codec_close_delayed_work);
>>>>>
>>>>>                 /* link the DAI widgets */
>>>>> -            ret = soc_link_dai_widgets(card, dai_link,
>>>>> -                    cpu_dai, codec_dai);
>>>>> -            if (ret)
>>>>> -                return ret;
>>>>> +            for (i = 0; i < rtd->num_codecs; i++) {
>>>>> +                ret = soc_link_dai_widgets(card, dai_link,
>>>>> +                        cpu_dai, rtd->codec_dais[i]);
>>>>
>>>> This will create a DAI link widget for each CODEC DAI. The DAI link
>>>> widget will configure the CPU and the CODEC DAI that are connected to
>>>> it. If there is one DAI link widget per CODEC DAI this means that the
>>>> CPU DAI will be connected to multiple DAI link widgets, which means it
>>>> will be configured once for each CODEC DAI (with possible conflicting
>>>> configurations).
>>>
>>> I've got that point, but now I'm wondering what struct should be per
>>> codec_dai. Should we consider one source and several sinks to
>>> represent the multiple codecs?
>>
>> The soc_link_dai_widgets function should take the rtd as a parameter
>> instead of the CODEC and CPU DAIs. Same goes for snd_soc_dapm_new_pcm()
>> then you create one dai_link widget per stream (i.e. one for capture of
>> there is capture support, one for playback if there is playback
>> support). And then create the paths between the dai_link widgets and the
>> DAI widgets accordingly.
>
> I'm still not 100% sure how it should work so here is a tentative patch to try to handle that part. Please note that in my setup none of that code is ever called :-( I'm not sure why!
>
> Please ignore the extra DEBUG code I added and there is probably some way to factorize some code, but I'd like to be sure that this is the proper way to handle the routes in the multicodec case before re-sending that series.

If we do not want to support CODEC<-->CODEC links with multiple CODECs you 
do not have to care about this for now. But I think the code looks good. The 
result should look something like this:

                     +----------+
                     | Playback | --> [ CODEC 1 DAI ]
         [ CPU ] --> | DAI LINK | --> [ CODEC 2 DAI ]
                     |          | --> [ CODEC 3 DAI ]
                     +----------+

                     +----------+
[ CODEC 1 DAI ]-- > | Capture  |
[ CODEC 2 DAI ] --> | DAI LINK | --> [ CPU DAI ]
[ CODEC 3 DAI ] --> |          |
                     +----------+

Also note that the code in upstream is now using snd_soc_dapm_add_path() 
rather than snd_soc_dapm_add_route()

- Lars
