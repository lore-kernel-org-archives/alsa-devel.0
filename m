From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [SAMPLE-PATCH 0/x] ASoC: replace snd_soc_read/write
Date: Wed, 19 Oct 2016 10:39:56 +0200
Message-ID: <4bc24e6a-af85-863f-9051-00ab4a45df19@metafoo.de>
References: <87oa2g3nhl.wl%kuninori.morimoto.gx@renesas.com>
 <s5hh988g5ie.wl-tiwai@suse.de>
 <87d1iw3i9d.wl%kuninori.morimoto.gx@renesas.com>
 <2e008145-062d-948e-0839-0aef9acf11db@metafoo.de>
 <87bmyg3gk0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 33BFF2666D3
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 10:40:02 +0200 (CEST)
In-Reply-To: <87bmyg3gk0.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 10/19/2016 10:19 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
>> The problematic bits are in the ASoC core where we have code that needs to
>> know whether a component is a CODEC or not. These are the issue we need to
>> resolve before we can think about converting more driver snd_soc_codec to
>> snd_soc_component.
> 
> Yeah, I agree about this, but
> 
>> I agree with Takashi, in my opinion this is not the right change at this
>> point in time. snd_soc_{write,read}() are not problematic they are simple
>> wrapper functions around snd_soc_component_{write,read}() that make it more
>> convenient to use them in a CODEC driver. Same for the CODEC specific
>> probe()/remove() callbacks.
>>
>> And while we are phasing out the concept of differentiating between
>> different types of components, since the hardware landscape has changed so
>> that there is no longer a really meaningful differentiating factor,
>> snd_soc_codec and snd_soc_codec drivers will still be around for a while.
> (snip)
>> Doing these partial conversions only leaves us with a lot of drivers that
>> are more convoluted than they need to be. In my opinion a driver should be
>> converted in one go, making it a complete component driver. But not leave it
>> partially component and partially CODEC. We've done this for the drivers
>> where it is possible, e.g. see [1].
> 
> Your "converted in one go" includes many conversion in 1 patch, right ?
> But it will be difficult to review, and is big risk.
> 
> I talked this topic with Mark in Berlin, and if my understand was correct,
> he agreed about step-by-step approach, because current driver is very complex.
> many conversion in 1 patch x 100 driver is very big risk IMO.

It does not have to be in one patch, but it should be in one series. A patch
series should result in a overall improvement of the code. Just changing
snd_soc_read() to snd_soc_component_read() does not improve the code, it
makes it slightly worse since as you can see from the diffstat of your
patches it requires more boilerplate code.

So such a change needs to be paired with other changes so that the overall
result of the patch series is a improvement.

You said in your earlier mail "and 3rd, 4th... I don't know how many steps
are exist.". We need to figure those steps out before we start converting a
driver, otherwise we'll be left with lots of frankenstein drivers that are
part snd_soc_component, part snd_soc_codec.
