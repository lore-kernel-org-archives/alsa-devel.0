From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: codec->card removed
Date: Fri, 26 Sep 2014 15:32:47 -0400
Message-ID: <CAKON4OwJ43KKEOu-HmskXOFYp8+=g4721NeZsgj0GujU51xPfQ@mail.gmail.com>
References: <CAKON4OyqRaUxKPc0C2ALwOwvqeToMeSM25CJj9p00ndovh1ZSg@mail.gmail.com>
 <5425BD96.30609@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D05D92604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 21:32:47 +0200 (CEST)
Received: by mail-la0-f43.google.com with SMTP id gb8so5572286lab.16
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 12:32:47 -0700 (PDT)
In-Reply-To: <5425BD96.30609@metafoo.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2014 at 3:25 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/26/2014 09:19 PM, jonsmirl@gmail.com wrote:
>
>> How should I rewrite this to reflect that codec->card has been removed?
>>
>
>  This is codec is on the SOC chip, not an external one.
>>
>> static int sunxi_codec_trigger(struct snd_pcm_substream *substream, int
>> cmd, struct snd_soc_dai *dai) {
>> struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> struct snd_soc_dai *codec_dai = rtd->codec_dai;
>> struct snd_soc_codec *codec = codec_dai->codec;
>> struct snd_soc_card *card = codec->card;
>> struct sunxi_priv *priv = snd_soc_card_get_drvdata(card);
>>
>
>
> It was moved to the component sub-structure in the CODEC struct. So
>
> codec->component.card
>
> But you really shouldn't access the card from the CODEC driver, that is a
> layering violation.
>
> Similarly accessing rtd->codec_dai from the CODEC driver is not correct,
> since codec_dai may not necessarily point to the CODEC DAI of your CODEC.
> (E.g. for multi-codec links or codec-to-codec links).


In this case CPU DAI and CODEC DAI are integrated onto the CPU SOC. You
can't attach an external codec.

Check out sunxi_codec_probe()
Where should 'priv' have been stashed?

https://bitbucket.org/emiliolopez/linux/src/fbfc3e9c092c90574aee454062fc465e8c71703c/sound/soc/sunxi/sunxi-codec.c?at=sunxi-codec-exp



>
> - Lars
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
