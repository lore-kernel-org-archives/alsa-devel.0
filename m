From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Thu, 31 Jan 2013 10:15:55 -0700
Message-ID: <510AA6CB.3050809@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>	<87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>	<50E71618.8090302@wwwdotorg.org>	<20130104193712.GN4627@opensource.wolfsonmicro.com>	<87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>	<87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>	<20130127035943.GJ4650@opensource.wolfsonmicro.com>	<87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>	<20130129014808.GC4748@opensource.wolfsonmicro.com>	<87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>	<87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>	<5107FF97.1070601@wwwdotorg.org>	<87halz82bm.wl%kuninori.morimoto.gx@renesas.com>	<51097F0F.2030501@wwwdotorg.org>
 <877gmuqir2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <877gmuqir2.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/30/2013 05:49 PM, Kuninori Morimoto wrote:

>>> +- simple-audio,system-clock-frequency	: system clock rate
>>> +- simple-audio,frame-master
>>> +- simple-audio,bitclock-master
>>
>> Aren't those a property of the CPU<->CODEC link, hence the clock
>> frequency is identical,
> 
> This clock connection/frequency depends on SoC/board.
> There is a case where system clock is not connected to both cpu/codec.
> 
> system clock    bit/frame
> --------[codec]---------> [cpu]


In that diagram, it looks like the CPU-side simply doesn't receive a
system clock at all, so it's recovering any clock by multiplying up the
bit clock.

That seems like a different case to the two ends both receiving a system
clock but the frequency being different.

How does the CPU DAI driver know (based on the binding) whether it
receives a system clock or not, or whether it should extract a clock
from the bit clock? Perhaps the HW design of the CPU DAI determines
this, so the binding doesn't need to specify it?

>> and the two "master" properties are the inverse
>> of each-other in between CPU and CODEC. Specifying these right in the
>> top-level node seems simpler.
> 
> If I put these in top-level node, it needs
> 
>   simple-audio,xxx,frame-master;
>   simple-audio,xxx,bitclock-master;     xxx = cpu / codec
> 
> This is same things ?
> 
> Of course I can do like
> 
>   simple-audio,frame-master = "cpu";
>   simple-audio,bitclock-master = "cpu";
> 
> But, this style can't use snd_soc_of_parse_daifmt()

I think the usual style for this would be a Boolean property indicating
whether the CPU DAI is the master or slave, and same for bitclock.
That'd be something like:

simple-audio,cpu-frame-master;
simple-audio,cpu-bitclock-master;

and those two properties would be present (for true) or missing (for false).

>>> +Required subnode properties:
>>> +- simple-audio,dev		: phandle for CPU/CODEC
>>> +
>>> +Optional subnode properties:
>>> +
>>> +- simple-audio,dai-name			: simple-audio CPU/CODEC DAI name
>>
>> OK, I see those two are CPU-/CODEC-specific. However, you could easily
>> just have different property names for the two.
>>
>> I assume you didn't like my idea of not putting the DAI names into the
>> DT, but using extra arguments after the phandles instead? Doing so would
>> be more alike most existing DT bindings.
> 
> I'm confusing about this.
> What does this "different property name" mean ?

Instead of:

nodea {
    simple-audio,dev = ...;
}
nodeb {
    simple-audio,dev = ...;
}

You'd have:

simple-audio,cpu-dai = ...;
simple-audio,codec = ...;
