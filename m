From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 4 Aug 2016 10:21:10 +0200
Message-ID: <2c894b35-9c57-6212-c8c5-f97ec1e1d263@metafoo.de>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
 <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
 <20160729144145.GF10376@sirena.org.uk>
 <87popt9n1w.wl%kuninori.morimoto.gx@renesas.com>
 <87y44fhdxt.wl%kuninori.morimoto.gx@renesas.com>
 <49dd216c-d63c-693e-92ed-6abf1865eeb0@metafoo.de>
 <87r3a5mfjd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DC0A2657B1
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 10:21:21 +0200 (CEST)
In-Reply-To: <87r3a5mfjd.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/04/2016 04:38 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
>> I think moving forward we should get rid of the whole CPU/CODEC/platform
>> concept. This is an outdated view of how the hardware looks like. When ASoC
>> was initially introduce all hardware basically had a CPU side DAI, a CODEC
>> side DAI and a DMA. The DMA was connected to the CPU DAI and the CPU DAI was
>> connected to the CODEC DAI and that was it. The CPU side was also really
>> simple, no signal processing, no signal routing, just the raw audio data
>> directly transferred via DMA (or PIO sometimes) to the CPU DAI controller.
>> And all digital audio was assumed to be in a single digital domain running
>> at them same clock rate.
>>
>> This no longer reflects todays typical systems. Sometimes you have more than
>> those three components (e.g. additional amplifier IC, BT chip ...),
>> sometimes you less (just a DAC or ADC directly connected to a DMA in the
>> SoC). You often have complex routing and processing capabilities on the host
>> side. Also you have often multiple digital domains with sample-rate
>> converters between them.
>>
>> Yet still at the core ASoC keeps the CPU/CODEC/platform concept. DPCM e.g.
>> tries to work with these concepts by introducing frontend and backend DAIs
>> and use dummy components to compensate for when the software model does not
>> match the hardware model. This makes it code more complicated than it has to
>> be and less efficient than it can be.
> 
> I agree to your opinion.
> OTOH, we would like to use/keep existing current all drivers.
> Thus, I think we need super many small and slow steps.
> Or, we need new ASoC2 ?
> 
> I can agree that we should get rid of current CPU/Codec/Platform,
> but, removing all of them is a little bit over-kill for me.
> I think ALSA SoC "framework" should care "component" only,
> and it doesn't care what it was.
> OTOH "driver" side can use existing CPU/Codec/Platform and/or AUX/compr
> etc as helper ? (I'm not sure detail of AUX/compr actually...)
> And each "component" has "dai".
> 
> My image is like this.
> This allows many / few components, and many / few DAIs.
> Current DPCM style is automatically supported,
> and it is easy to add new style device.
> What do you think ?

To be honest I'd also get rid of DAIs has a top level concept. This image
(http://metafoo.de/the_new_asoc.svg) is something I've put together awhile
ago how I think we should lay things out if we do a major refactoring of the
ASoC core.

The big green and blue boxes are components. Green are On-SoC components,
blue are external components.

The light grey boxes are domains. Domains have certain properties, like e.g.
samplerates. There are different types of domains and different types have
different kinds of properties. E.g. in the PCM domain we care about the
memory layout of the samples in addition to the samplerate and the number of
channels, while in the digital domain however we do no longer care about the
memory layout since here data is processed one sample at a time. In the I2S
link domain we care about which I2S mode is used (I2S, LJ, ...), while in a
SPDIF link domain we don't care about such properties.

The dark grey boxes are bridges between domains and they translate
properties from one domain to another. This can either be straight forward
propagation like a PCM device where the samplerate in the source and target
domain are the same, or it can modify the properties, e.g. a samplerate
converter between two digital domains will change the samplerate according
to the interpolation/decimation factor of the SRC.

In addition to just translating the properties a bridge can also translate
the constraints on properties from one domain to another or even add its own
constraints. E.g. if a CODEC has a constraint that it can run either with
48kHz or 96kHz this constraint is propagated through the bridges to the PCM
devices so that the userspace application using the PCM is aware of this.
Bridges can also add their own constraints e.g. a SRC might have multiple
interpolation/decimation rates available, so it might say the samplerate in
the target domain must be 1x or 2x that of the source domain. Going back to
the example that means for a CODEC that supports either 48kHz or 96kHz and
there is a SRC with interpolation factors of 1 or 2 then the PCM device will
present the list of either 24kHz, 48kHz or 96kHz to the userspace application.

A bridge is also not limited to one source and one sink. It can have
multiple sources and multiple sinks e.g. for a crossbar with a complex
routing matrix.

Obviously we can't convert everything at the same time and it will take a
lot of time and effort to update all drivers to this new model. This is
where the legacy bridge kicks in which still keeps the concept of 1 CPU, 1
CODEC, 1 platform. If you want to use the advanced features of the new
framework you have to update your driver, if you are OK with the current set
of features just keep the drivers the way they are and use the legacy bridge
that is automatically managed by the ASoC core.
