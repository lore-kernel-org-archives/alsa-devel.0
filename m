From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Question about Component and Card
Date: Mon, 03 Aug 2015 13:51:48 +0200
Message-ID: <55BF55D4.5010007@metafoo.de>
References: <87zj29uei7.wl%kuninori.morimoto.gx@renesas.com>	<55BF09CB.6060307@metafoo.de>
 <87wpxcvl5n.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-139.synserver.de (smtp-out-139.synserver.de
 [212.40.185.139])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0C7260612
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 13:51:49 +0200 (CEST)
In-Reply-To: <87wpxcvl5n.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 08/03/2015 10:23 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
>>> I noticed my sound card (which is not upstreamed) can't probe in next branch.
>>> I think it is because this patch
>>> 1b7c12316982f74a5b8e7704c24cf5524d0723a3
>>> (ASoC: Prevent components from being bound to multiple cards)
>>>
>>> In my case, my sound device (= CPU) has some DAIs,
>>> and these are connected to some codecs.
>>> It is shown as below. And I would like to use these as 2 sound cards.
>>>  ex)	aplay -D hw:0 xxx
>>> 	aplay -D hw:1 xxx
>>> But, 2nd sound card can't probe because of above patch now.
>>> (component->card indicates 1st card)
>>> It can be probeed if I used DPCM card (= 1 CPU + 2 Codec), but...
>>> But, is my understanding wrong ?
>>
>> ASoC always had the restriction that you can only bind a component to a
>> single card. Otherwise the internal data structures will get corrupted,
>> which may result in undefined behavior at a later point. The patch made this
>> restriction explicit to make sure that issue is caught when it happens and
>> you don't have dig through crashes from random memory corruption.
> 
> Hmm...
> Current my CPU driver is probing all channels in 1 driver.
> Then, I can use multi sound card if CPU driver probes limited channels.
> (ex driver0 probes ch0, ch1
>     driver1 probes ch2, ch3, or something like this)
> 
> This means I need to re-consider / change my CPU driver for it.
> Do you think this is good idea ? or do I have other solution ?

Yeah, it's difficult. I guess this is a case where the control path (e.g.
memory mapped register region, irq, etc.) is shared, but the data paths are
independent. In theory this means you can use each DAI in a different sound
card. But in practice they still share the same DAPM context, even though
there are no connections in the DAPM graph between them. I don't know how to
solve this issue. The easiest way out would be to register a different
component for each DAI. But that might not be possible depending on how the
system is structured.
