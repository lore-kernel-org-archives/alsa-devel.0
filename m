From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: codec->card removed
Date: Fri, 26 Sep 2014 16:42:15 -0400
Message-ID: <CAKON4Oy_8ncBWmSC+aGAmj34EH=5mcHOoP6EBsBgv9GsGVW8UQ@mail.gmail.com>
References: <CAKON4OyqRaUxKPc0C2ALwOwvqeToMeSM25CJj9p00ndovh1ZSg@mail.gmail.com>
 <5425BD96.30609@metafoo.de>
 <CAKON4OwJ43KKEOu-HmskXOFYp8+=g4721NeZsgj0GujU51xPfQ@mail.gmail.com>
 <5425C2AA.9080801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3272604EE
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 22:42:16 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id pv20so5679226lab.10
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 13:42:16 -0700 (PDT)
In-Reply-To: <5425C2AA.9080801@metafoo.de>
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

On Fri, Sep 26, 2014 at 3:46 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/26/2014 09:32 PM, jonsmirl@gmail.com wrote:
>
>>
>>
>> On Fri, Sep 26, 2014 at 3:25 PM, Lars-Peter Clausen <lars@metafoo.de
>> <mailto:lars@metafoo.de>> wrote:
>>
>>     On 09/26/2014 09:19 PM, jonsmirl@gmail.com <mailto:jonsmirl@gmail.com
>> >
>>     wrote:
>>
>>         How should I rewrite this to reflect that codec->card has been
>> removed?
>>
>>
>>         This is codec is on the SOC chip, not an external one.
>>
>>         static int sunxi_codec_trigger(struct snd_pcm_substream
>> *substream, int
>>         cmd, struct snd_soc_dai *dai) {
>>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>         struct snd_soc_dai *codec_dai = rtd->codec_dai;
>>         struct snd_soc_codec *codec = codec_dai->codec;
>>         struct snd_soc_card *card = codec->card;
>>         struct sunxi_priv *priv = snd_soc_card_get_drvdata(card)__;
>>
>>
>>
>>     It was moved to the component sub-structure in the CODEC struct. So
>>
>>     codec->component.card
>>
>>     But you really shouldn't access the card from the CODEC driver, that
>> is
>>     a layering violation.
>>
>>     Similarly accessing rtd->codec_dai from the CODEC driver is not
>> correct,
>>     since codec_dai may not necessarily point to the CODEC DAI of your
>>     CODEC. (E.g. for multi-codec links or codec-to-codec links).
>>
>>
>> In this case CPU DAI and CODEC DAI are integrated onto the CPU SOC. You
>> can't attach an external codec.
>> Check out sunxi_codec_probe()
>> Where should 'priv' have been stashed?
>>
>
> The way your driver looks right now you wouldn't need to make it a ASoC
> driver, since the whole audio card is defined in this one driver. But
> generally people still want to be able to for example hook up external
> amplifiers or similar.


People are already doing that. There are three known tablets with various
external amp chips that have some GPIO controls. The driver used the be
non-SOC, it was these amps that caused it to covert.

There is also a lot of variation with what jacks are installed. It supports
MIc 1 & 2, Vmic
Line In L/R
FM L/R
Phone Out L/R
Headphone L/R


> So even in the case that the SoC side is not componetized it still makes
> sense to have a ASoC driver. But you'd want to split the driver for your
> on-SoC component and the card driver, since the card driver will
> potentially contain other components as well.
>

The I2S support on the chip needs ASoC. There is also a SPDIF unit that
looks like the on-chip codec. It was too confusing to have some drivers
implemented as ASoC and others not.



>
> Since we now do have support for things like controls and DAPM widgets at
> the component level it makes sense to implement most of the drivers
> functionality as part of your snd_soc_component driver. For the moment
> you'll still need a dummy CODEC driver so ASoC will create a PCM device.
> But this is a requirement that might go away in the future.
>
> - Lars
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
