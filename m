From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v2] ASoC: simple-card: add Device Tree support
Date: Tue, 29 Jan 2013 09:57:59 -0700
Message-ID: <5107FF97.1070601@wwwdotorg.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87obg8z4u4.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On 01/29/2013 03:00 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, Stephen
> 
>>> 	simple-audio,codec {
>>> 		simple-audio,dev = &phandle;
>>> 		simple-audio,system-clock-frequency = 122880000;
>>> 	};
> 
> I would like to ask you before creating v3 patch.
> I got some opinions from you.
>  - cpu/codec style (above)
>  - "controller" naming
>  - it is using "name" property (it is must item for matching)
> 
> Then, what do you think about this style ?
> 
> fai_ak4642 {

The node would usually be named after the type of object, not the
identity of the object, so more like "sound".

>         compatible = "simple-audio";
> 
>         simple-audio,card-name = "FSI2A-AK4648";

OK.

>         /* platform */
>         simple-audio,platform {

I still don't understand why you need to even represent the platform in DT.

Introducing sub-nodes seems to just add to the complexity without much gain.

>              compatible = "ak4642-hifi";  /* platform name (if needed) */

The "compatible" property has a very specific meaning in DT already. I
don't think we should re-use that property name for other purposes.

>              simple-audio,dev = <&sh_fsi2>;


>              /* format and inversion are here */
>              simple-audio,format = "left_j";
>              simple-audio,bitclock-inversion;

Those properties appear more relevant to the I2S link than the ASoC
platform object.

>         }
> 
>         /* codec and cpu are same style */
> 
>         /* codec */
>         simple-audio,codec {
>              compatible = "ak4642-hifi";  /* codec dai name (this is must item on ASoC) */

If you absolutely must use named-based binding here rather than the
standard phandle+args style, rename that property to something more like
simple-audio,dai-name.

>              simple-audio,dev = <&ak4648>;
>              simple-audio,bitclock-master;
>  
>              /* clock gating is here */
>             simple-audio,clock-gating = "continuous";

I think this should be a Boolean property; present means yes, missing
means no.

>         }
> 
>         /* cpu */
>         simple-audio,cpu {
>              compatible = "fsia-dai"; /* cpu dai name (if needed) */
>              simple-audio,dev = <&sh_fsi2>;
>              simple-audio,system-clock-frequency = <11289600>;
>         }
> }
