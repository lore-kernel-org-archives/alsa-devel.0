From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device Tree support
Date: Mon, 04 Feb 2013 15:22:21 -0700
Message-ID: <5110349D.3050308@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87halw7sij.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On 01/31/2013 06:05 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen, Mark
> 
>>> +- simple-audio,dai-name			: simple-audio CPU/CODEC DAI name
>>
>> OK, I see those two are CPU-/CODEC-specific. However, you could easily
>> just have different property names for the two.
>>
>> I assume you didn't like my idea of not putting the DAI names into the
>> DT, but using extra arguments after the phandles instead? Doing so would
>> be more alike most existing DT bindings.
> 
> The reason why I need "dai-name" is that phandle can select "cpu/codec device"
> itself, but, it can't select "port".
> This port is called/controlled as "xxx_dai_name" on ASoC I think.
> 
> like this
> 
> +-------------+
> | FSI  port A |--> ak4642
> |      port B |--> HDMI
> +-------------+
> 
> Then, I would like to ask Stephen, Mark

Yes it can.

In most DT bindings where phandles are used, you specify both a phandle
and some arguments related to that phandle. The arguments could easily
encode the port ID. In other words, instead of:

simple-audio,codec = <&phandle>;

you could write:

simple-audio,codec = <&phandle PORT_NUMBER>;

where PORT_NUMBER could be 0, 1, 2, or any other integer value or
sequence of integer values, which the driver for the CODEC would
interpret itself, and return an ASoC-internal port name.
