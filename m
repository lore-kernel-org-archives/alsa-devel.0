From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/3 v5] ASoC: simple-card: add Device Tree support
Date: Mon, 11 Feb 2013 14:40:17 -0700
Message-ID: <51196541.8010207@wwwdotorg.org>
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
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87a9rjrrwt.wl%kuninori.morimoto.gx@renesas.com>
 <87zjzhymbs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87zjzhymbs.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On 02/06/2013 05:55 PM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec information for probing.


> +Simple-Card:
> +
> +Required properties:
> +
> + [prefix] means cpu/codec here
> +
> +- compatible					: "simple-audio"
> +- simple-audio,card-name			: simple-audio card name
> +- simple-audio,format				: see below

> +- simple-audio,[prefix],dai			: phandle and port for CPU/CODEC
> +- simple-audio,[prefix],frame-master		: frame master
> +- simple-audio,[prefix],bitclock-master		: bitclock master
> +
> +Optional properties:
> +
> +- simple-audio,system-clock-frequency		: system clock rate if it is connected to both CPU/CODEC
> +- simple-audio,bitclock-inversion		: bit clock inversion for both CPU/CODEC
> +- simple-audio,frame-inversion			: frame inversion for both CPU/CODEC
> +
> +- simple-audio,[prefix],bitclock-inversion	: if CPU/CODEC needs clock inversion
> +- simple-audio,[prefix],frame-inversion		: if CPU/CODEC needs frame inversion
> +- simple-audio,[prefix],system-clock-frequency	: system clock rate for each CPU/CODEC

I know Mark had a preference to store DAI-specific data in sub-nodes
rather than using this "[prefix]" thing... If that doesn't end up
happening though, rather than "[prefix],", I think it'd be more typical
to use "[prefix]-" since I've never seen a DT property name with two
","; "-" is typically used as the word separator in DT property names.

> +sound {
> +	compatible = "simple-audio";
...
> +	simple-audio,codec,dai = <&ak4648 0>;
...
> +sh_fsi2: sh_fsi2@0xec230000 {
> +	compatible = "renesas,sh_fsi2";
> +	reg = <0xec230000 0x400>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 146 0x4>;
> +};

Note that the DT binding documentation for renesas,sh_fsi2 needs to define:

a) The value of the #sound-dai-cells property that's missing from the
sh_fsi2 node.

b) The legal values for the "0" in the "simple-audio,codec,dai" property
in the "sound" node above, and which DAI on the device each value
represents.
