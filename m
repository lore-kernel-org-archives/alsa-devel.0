From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Questions about ASoC driver implementation
Date: Wed, 12 Aug 2015 17:14:57 +0200
Message-ID: <55CB62F1.3010805@metafoo.de>
References: <CAMDowVVj26LdUz5hgp6J9kfB=g5gEfq1L_ycGbHymEYJ-_k+MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-194.synserver.de
 [212.40.185.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DBFD260438
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 17:14:59 +0200 (CEST)
In-Reply-To: <CAMDowVVj26LdUz5hgp6J9kfB=g5gEfq1L_ycGbHymEYJ-_k+MQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Campbell <mcampbell@izotope.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,


On 08/12/2015 04:01 PM, Matt Campbell wrote:
> Hi All,
> 
> I'm diving into adding support for a new codec (AK4621) targeting IMX6 SoC
> and as this is my first dive into ALSA driver code (and first deep dive in
> to Linux driver development) I've come up with a few questions. I've done a
> lot of digging in available documentation as well as reading a lot of code,
> but some things remain unclear.
> 
> First, I'm a little confused with what appears to be inconsistent
> terminology. The SoC overview.txt lists three types of component drivers:
> codec, platform and machine. However, in the code there are four types of
> snd_soc_register_* functions: card, platform, codec and component. From
> looking at the underlying structs and how these are used in existing code
> this is my best guess but please correct me if I'm wrong:
> 
> codec -> snd_soc_register_codec
> machine -> snd_soc_register_card
> platform -> snd_soc_register_component and snd_soc_register_platform? (not
> sure about this, from what I can gather at some point there was an API
> switch to using component rather than platforms for the DAIs)

There used to be a lot of similarity between platforms and CODECs and some
code duplication. snd_soc_component was introduced is a new common base
class for both CODEC and platform. It can also be used standalone if none of
the platform or CODEC specific functionality is need.

> 
> My second question is around adding support for an amplifier external to
> the codec. The amplifier is a PGA controlled over SPI. One possible way I
> can see to adding this is to create a SPI based codec driver for the PGA
> that exposes an ALSA control for the gain level and give it a dummy DAI
> then add it to the card as an aux_dev. This feels a little kludgy as the
> PGA isn't a perfect fit for the codec class.

You don't need to register a DAI with your CODEC it will work just fine
without. Although in this case you don't need any CODEC specific features so
the best is to just go with snd_soc_component. There are a few examples of
snd_soc_component based drivers for external analog amplifiers, e.g. max9768
or lm4857.

- Lars
