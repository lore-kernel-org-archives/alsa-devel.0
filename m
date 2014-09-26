From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: codec->card removed
Date: Fri, 26 Sep 2014 21:25:10 +0200
Message-ID: <5425BD96.30609@metafoo.de>
References: <CAKON4OyqRaUxKPc0C2ALwOwvqeToMeSM25CJj9p00ndovh1ZSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-128.synserver.de (smtp-out-128.synserver.de
 [212.40.185.128])
 by alsa0.perex.cz (Postfix) with ESMTP id F07072604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 21:25:01 +0200 (CEST)
In-Reply-To: <CAKON4OyqRaUxKPc0C2ALwOwvqeToMeSM25CJj9p00ndovh1ZSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/26/2014 09:19 PM, jonsmirl@gmail.com wrote:
> How should I rewrite this to reflect that codec->card has been removed?

> This is codec is on the SOC chip, not an external one.
>
> static int sunxi_codec_trigger(struct snd_pcm_substream *substream, int
> cmd, struct snd_soc_dai *dai) {
> struct snd_soc_pcm_runtime *rtd = substream->private_data;
> struct snd_soc_dai *codec_dai = rtd->codec_dai;
> struct snd_soc_codec *codec = codec_dai->codec;
> struct snd_soc_card *card = codec->card;
> struct sunxi_priv *priv = snd_soc_card_get_drvdata(card);


It was moved to the component sub-structure in the CODEC struct. So

codec->component.card

But you really shouldn't access the card from the CODEC driver, that is a 
layering violation.

Similarly accessing rtd->codec_dai from the CODEC driver is not correct, 
since codec_dai may not necessarily point to the CODEC DAI of your CODEC. 
(E.g. for multi-codec links or codec-to-codec links).

- Lars
