From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v2] ASoC: simple-card: add Device Tree support
Date: Mon, 28 Jan 2013 14:11:38 -0700
Message-ID: <5106E98A.6070103@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87vcazyxr1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/14/2013 07:40 PM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec/platform information for probing.

> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt

> +Required properties:
> +
> +- compatible					: "simple-audio"
> +- simple-audio,card-name			: simple-audio card name
> +
> +- simple-audio,platform,controller		: phandle for platform

Rename that simple-audio,dma-controller perhaps? "platform" is a word
specific to ASoC, and the bindings really should be generic across OSs.

But I wonder why you'd even need the ASoC platform to be specified in
DT; instead, the following seem better:

a) Have the CPU DAI's driver register the platform itself. Tegra does this.

b) Assume the ASoC "platform" device simply does DMA via a standard
dmaengine driber, and instead refer to the DMA controller using DMA
engine DT bindings.

> +- simple-audio,platform,name			: simple-audio platform name

Can you explain why you'd need the platform name in the DT? Doesn't the
phandle always uniquely identify it? The example doesn't use this property.

> +- simple-audio,cpu,controller			: phandle for CPU DAI
> +- simple-audio,cpu,dai,name			: simple-audio CPU DAI name

It'd be a bit more typical of device-tree to have a single property that
defines both the controller and any properties of the controller at
once, e.g. something like:

simple-audio,cpu-interface = <&codec_phandle AK4648_I2S_ITF_A>;

where we assume something like:

#define AK4648_I2S_ITF_A 0 // Interface A's ID

That would remove the need to put string names into the DT.

> +simple-audio,xxx,dai,clock-gating
> +	"continuous"
> +	"gated"

Don't you need to use the common clock bindings to define which clock to
gate? Or, is the I2S/... node's binding supposed to provide that
information?
