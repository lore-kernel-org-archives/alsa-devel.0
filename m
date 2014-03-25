From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFT v2 6/6] ASoC: core: Add support for DAI
	multicodec
Date: Tue, 25 Mar 2014 18:01:43 +0100
Message-ID: <5331B677.9040405@metafoo.de>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
 <1395415650-20045-7-git-send-email-bcousson@baylibre.com>
 <532D4ADF.7030804@metafoo.de> <5331805F.1010309@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-085.synserver.de (smtp-out-210.synserver.de
 [212.40.185.210])
 by alsa0.perex.cz (Postfix) with ESMTP id D5526264F0D
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 18:00:59 +0100 (CET)
In-Reply-To: <5331805F.1010309@baylibre.com>
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
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/25/2014 02:10 PM, Benoit Cousson wrote:
[...]
>>> +struct snd_soc_dai_link_codec {
>>
>> For the sake of symmetry maybe name this snd_soc_dai_link_component and
>> drop the 'codec_' prefix in front of the struct fields. There is no
>> reason why this couldn't be used for CPU dais as well at some point.
>
> OK, good point.
>
>>> +    const char *codec_name;
>>> +    const struct device_node *codec_of_node;
>>> +    const char *codec_dai_name;
>>
>> I'd like to see this split up into the descriptive part that holds the
>> name, of_node etc, and the runtime data that holds the pointer to the
>> DAIs. The descriptive part goes in the dai_link struct the. The pointers
>> to the DAIs go into the snd_soc_pcm_runtime struct. This is how it is
>> used the only place where you need both is in soc_bind_dai_link.
>
> OK, let me try to clarify that. You suggest to create that struct:
>
> +struct snd_soc_dai_link_component {
> +    const char *name;
> +    const struct device_node *of_node;
> +    const char *dai_name;
> +}
>
> to be inside the snd_soc_dai_link.
>
> And inside the snd_soc_pcm_runtime, to replace these ones
> +    struct snd_soc_dai_link_codec *codecs;
> +    int num_codecs;
>
> with a direct pointers to codecs dais?
>
> +    struct snd_soc_dai **codecs_dai;
> +    int num_codecs;
>
> Is that correct ?

Yes. Should be unsigned int though ;)

- Lars
