From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/3 v5] ASoC: simple-card: add Device Tree support
Date: Wed, 13 Feb 2013 16:30:33 -0700
Message-ID: <511C2219.7010002@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>	<87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>	<50E71618.8090302@wwwdotorg.org>	<20130104193712.GN4627@opensource.wolfsonmicro.com>	<87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>	<87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>	<20130127035943.GJ4650@opensource.wolfsonmicro.com>	<87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>	<20130129014808.GC4748@opensource.wolfsonmicro.com>	<87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>	<87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>	<5107FF97.1070601@wwwdotorg.org>	<87halz82bm.wl%kuninori.morimoto.gx@renesas.com>	<51097F0F.2030501@wwwdotorg.org>	<87halw7sij.wl%kuninori.morimoto.gx@renesas.com>	<5110349D.3050308@wwwdotorg.org>	<87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>	<87a9rjrrw
 t.wl%kuninori.morimoto.gx@renesas.com>	<87zjzhymbs.wl%kuninori.morimoto.gx@renesas.com>	<51196541.8010207@wwwdotorg.org>
 <87d2w6f88p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87d2w6f88p.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On 02/11/2013 09:48 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
>>> +sound {
>>> +	compatible = "simple-audio";
>> ...
>>> +	simple-audio,codec,dai = <&ak4648 0>;
>> ...
>>> +sh_fsi2: sh_fsi2@0xec230000 {
>>> +	compatible = "renesas,sh_fsi2";
>>> +	reg = <0xec230000 0x400>;
>>> +	interrupt-parent = <&gic>;
>>> +	interrupts = <0 146 0x4>;
>>> +};
>>
>> Note that the DT binding documentation for renesas,sh_fsi2 needs to define:
>>
>> a) The value of the #sound-dai-cells property that's missing from the
>> sh_fsi2 node.
>>
>> b) The legal values for the "0" in the "simple-audio,codec,dai" property
>> in the "sound" node above, and which DAI on the device each value
>> represents.
> 
> Sorry, I couldn't understand this.
> Do you mean like this ?
> 
> This example is assuming like this, and shows FSI-ak4642 sound
> 
> FSI port A -- ak4642
>     port B -- HDMI
> 
> sh_fsi2 has #sound-dai-cells, and ak4642 doesn't have it.
> Does this solved a) ?

There should be a file in Documentation/devicetree/bindings that
describes how to create a "renesas,sh_fsi2" node. The document should
specify what value that node's #sound-dai-cells property must contain.

> Do you mean sh_fsi2 needs something like "port-a = xxx" settings for b) ??

The binding documentation must specify what values go into the "DAI
specifier" DT cells. Something like:

Required properties:
- #sound-dai-cells Integer, must be 1.
  Valid values for the DAI specifier are:
  0: FSI port A
  1: FSI port B

> sound {
> 	compatible = "simple-audio";
> 
> 	simple-audio,card-name = "FSI2A-AK4648";
> 	simple-audio,format = "left_j";
> 	simple-audio,cpu,dai = <&sh_fsi2 0>;
> 	simple-audio,codec,dai = <&ak4648>;
> 	simple-audio,codec,bitclock-master;
> 	simple-audio,codec,frame-master;
> 	simple-audio,codec,system-clock-frequency = <11289600>;
> };
> 
> &i2c0 {
> 	ak4648: ak4648@0x12 {
> 		compatible = "asahi-kasei,ak4648";
> 		reg = <0x12>;

There should be a #sound-dai-cells property in this node too, since it
needs to be linked into the sound node.

Does this HW only have a single DAI? If so, the value of
#sound-dai-cells can be 0, since there's no need to distinguish between
different DAIs.

> 	};
> };
> 
> sh_fsi2: sh_fsi2@0xec230000 {
> 	#sound-dai-cells = <2>;

Shouldn't that be 1? This is specifying the number of cells that appear
after the phandle in the simple-audio,cpu,dai property above, not the
number of valid values that you could put into the cell.

> 	compatible = "renesas,sh_fsi2";
> 	reg = <0xec230000 0x400>;
> 	interrupt-parent = <&gic>;
> 	interrupts = <0 146 0x4>;
> };
