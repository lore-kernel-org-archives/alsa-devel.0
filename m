From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Fri, 29 Jul 2016 11:01:27 +0200
Message-ID: <4ad31e53-188a-8a40-cea9-b89df5f3535e@metafoo.de>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <579A69EC.9060205@metafoo.de>
 <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87popx2nbb.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/29/2016 04:24 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
> Thank you for your feedback
> 
>>> int snd_soc_runtime_set_dai_fmt(xxx)
>>> {
>>> 	...
>>> 	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
>>> 	if (cpu_dai->codec) {
>>> 		...
>>> 	}
>>> 	...
>>> }
> (snip)
>> This is for CODEC<->CODEC links where no CPU DAI is involved and the
>> "CPU" side of the DAI link is actually a CODEC.
> 
> Wow !!
> 
>> Ideally we'd make the DAI links agnostic to what is connected, e.g. it
>> shouldn't matter what type is connected to what side. But that does not
>> work since things are anti-symmetric between CPU and CODEC DAIs. On
>> CODEC DAIs the capture stream is output, on CPU DAIs the capture stream
>> is input, similar thing for playback. So we need to know whether the DAI
>> is a CPU DAI or a CODEC DAI.
>>
>> Fixing this at this point is near to impossible since it requires
>> invasive changes to all existing drivers. So we need this code and can't
>> drop it.
>>
>> The best we can do is try to come up with a generic interface that is
>> DAI type independent and recommend this interface for new drivers.
> 
> Hmm...
> OK, now, I'm investigating ALSA SoC struct connection.
> And yes, existing code has deep relationship each other.
> Thus, fixing/droping seems very dificult...
> I think each struct has random pointer connection which doesn't care
> about ALSA SoC's hierarchy.
> 
> I would like to indicate my opinion here.
> My strange point are...
> 
> 1. snd_soc_pcm_runtime has pointer to Card/Codec/Platform, but no CPU
> 2. snd_soc_dai has pointer to [component] and [Codec]
>    [component] is its parent, [Codec] is maybe Hack

dai->codec is something we could get rid of since it is the same as
dai->component->codec. And for drivers were we know that it is a CODEC
driver you can use snd_soc_component_to_codec(dai->component). For those
drivers we know that this returns a valid pointer.

But there are a lot of users which all need to be updated. If you want to do
it go ahead. If you do the conversion this should be done by the use of
helper functions, so we can change the implementation if necessary.

> 3. [component] has pointer to [card] and [Codec]
>    [card] is understandable, [Codec] is maybe Hack
> 
> It seems many struct would like to access to [Codec], thus, each struct has
> codec pointer (as hack ?), but it is ignoring ALSA SoC hierarchy.
> 

This is a leftover of the old hierarchy where snd_soc_codec was not a
sub-struct of snd_soc_component.

> It will be more clear if...
> 
> IDEA 1
> 
>    Each component (= CPU/Codec/Platform) has pointer to Card now.
>    How about Card has pointer to each component ?
>    if so, we can access to every struct.
>    Card -> CPU/Codec/Platform, CPU/Codec/Platform -> Card
>    Then, we want to have component related macro/flag
> 
> 	#define component_is_cpu(component) (component->flag & COMPONENT_CPU)
> 	#define component_is_codec(component) (component->flag & COMPONENT_CODEC)
> 	#define component_is_platform(component) (component->flag & COMPONENT_PLATFORM)
> 
> 	#define component_to_cpu() container_of(xxx)
> 	#define component_to_codec() container_of(xxx)
> 	#define component_to_platorm() container_of(xxx)

I though about this when doing the refactoring of the ASoC core. But in the
end it does not make too much of a difference whether we have a flag field
or a CODEC pointer field. The former would have just caused more code churn
so I went with the later.

You wouldn't be able to simplify the code by this. You need to replace all
component->codec checks by component_is_codec(component). So the overall
code complexity stays the same.

The helper macros might still make sense to hide the actual implementation.

> 
> IDEA 2
> 
>    if IDEA1 was OK, snd_soc_pcm_runtime already has card pointer.
>    This means snd_soc_pcm_runtime can access to every component struct.
> 
>    snd_soc_dai has its parent component.
>    This means snd_soc_dai can access to Card, and Card can access to every component.
>    And then, cpu_dai->codec has no issue if we can use component_is_xxx() macro ?
> 
>     - if (cpu_dai->codec)
>     + if (component_is_codec(cpu_dai->component))
> 
> If IDEA1 / IDEA2 are OK, we can cleanup each struct,
> especially hack-able random pointer ?

In my opinion the flags are just as much a hack as the pointer. In an ideal
setup the component does not need to know what type it is. The reason why we
need this in ASoC is because the framework has grown over time and we need
to support legacy code.
