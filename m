From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Wed, 3 Aug 2016 21:32:51 +0200
Message-ID: <49dd216c-d63c-693e-92ed-6abf1865eeb0@metafoo.de>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
 <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
 <20160729144145.GF10376@sirena.org.uk>
 <87popt9n1w.wl%kuninori.morimoto.gx@renesas.com>
 <87y44fhdxt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87y44fhdxt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/02/2016 08:47 AM, Kuninori Morimoto wrote:
> 
> Hi Lars, Mark
> 
> My previous mail was missing point...
> 
>>>> In my opinion the flags are just as much a hack as the pointer. In an ideal
>>>> setup the component does not need to know what type it is. The reason why we
>>>> need this in ASoC is because the framework has grown over time and we need
>>>> to support legacy code.
>>>
>>> Yes, the pointer is essentially already a flag - having a separate flag
>>> really doesn't add a huge amount here.  What we need to do is get rid of
>>> the need for the flag entirely.
>>
>> I can agree to remove flag entirely, and actually it is my final target.
>> But we need many steps for it IMO.
>>
>> I would like to cleanup (= remove random pointer) as 1st step.
>> My 1st concern is that each struct which want to have codec pointer has
>> codec pointer randomly.
>> And it makes component cleanup difficult IMO.
>>
>> 2nd concern is rtd has *codec, *platform, and *dai (for cpu/codec).
>> These are different type of pointer.
>> If platform can have dummy *dai, we can do like below ?
>>
>> 	struct snd_soc_pcm_runtime {
>> 		...
>> 		struct snd_soc_dai *cpu;
>> 		struct snd_soc_dai *codec;
>> 		struct snd_soc_dai *platform;
>> 		...
>> 	}
>>
>> Here, we can get original *codec or *platform by
>> using component_to_xxx, because dai already have *component;
>> It can be more cleanup ?
> 
> I mean current ALSA SoC has duplicate pointer,
> and using different type of pointer for CPU/Codec/Platform/Card.
> I agree that we would like to have flag-less style.
> 
> If my understanding was correct, we can more cleanup struct
> relationship if we can exchange pointer style.
> I think this is related to flag-less style.
> 
> For example, current rtd <-> CPU/Codec/Platform relationship
> is using different type of pointer.
> It makes flag-less style difficult.
> But we can use same type of pointer if we can have dummy dai on platform,
> like above idea. Similar idea is for component.
> 
> I think this kind of cleanup is needed, and it makes hotplug support easier.
> Otherwise, hotplug support will add more random pointer on each struct,
> and it makes cleanup more difficult.
> 
> # Here, I said "flag-less" style, but maybe we need flag somehow to keep
> # current style ? For example I don't think we can have flag-less cristal-clear
> # style for CODEC-CODEC support or DPCM etc ...

I think moving forward we should get rid of the whole CPU/CODEC/platform
concept. This is an outdated view of how the hardware looks like. When ASoC
was initially introduce all hardware basically had a CPU side DAI, a CODEC
side DAI and a DMA. The DMA was connected to the CPU DAI and the CPU DAI was
connected to the CODEC DAI and that was it. The CPU side was also really
simple, no signal processing, no signal routing, just the raw audio data
directly transferred via DMA (or PIO sometimes) to the CPU DAI controller.
And all digital audio was assumed to be in a single digital domain running
at them same clock rate.

This no longer reflects todays typical systems. Sometimes you have more than
those three components (e.g. additional amplifier IC, BT chip ...),
sometimes you less (just a DAC or ADC directly connected to a DMA in the
SoC). You often have complex routing and processing capabilities on the host
side. Also you have often multiple digital domains with sample-rate
converters between them.

Yet still at the core ASoC keeps the CPU/CODEC/platform concept. DPCM e.g.
tries to work with these concepts by introducing frontend and backend DAIs
and use dummy components to compensate for when the software model does not
match the hardware model. This makes it code more complicated than it has to
be and less efficient than it can be.
