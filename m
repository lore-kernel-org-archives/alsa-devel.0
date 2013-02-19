From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/4 v6] ASoC: add .of_xlate_dai_name callback on struct
 snd_soc_dai_driver
Date: Tue, 19 Feb 2013 13:53:56 -0700
Message-ID: <5123E664.7090107@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
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
 <87bobzrry6.wl%kuninori.morimoto.gx@renesas.com>
 <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <871ucjuu7g.wl%kuninori.morimoto.gx@renes as.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <871ucjuu7g.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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

On 02/14/2013 02:21 AM, Kuninori Morimoto wrote:
> ASoC sound driver requires CPU/CODEC drivers for probing,
> and each CPU/CODEC has some DAI on it.
> Then, "dai name matching" have been used to identify
> CPU-CODEC DAI pair on ASoC.
> 
> But, the "dai port number matching" is now required from DeviceTree.
> The solution of this issue is to replace the dai port number into dai name,
> and it needs some kind of .of_xlate function on each driver.
> 
> This patch adds .of_xlate_dai_name callback interface
> on struct snd_soc_dai_driver,
> very basic/common snd_soc_common_of_xlate_dai_name()
> which replace the dai port number into dai name,
> and snd_soc_of_get_port_dai_name() which is using .of_xlate_dai_name.
> 
> Then, #sound-dai-cells which enables DAI specifier is required
> on CPU/CODEC device tree properties.

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c

> +const char *snd_soc_common_of_xlate_dai_name(struct snd_soc_dai *dai,
> +					const struct of_phandle_args *args)

I assume you expect this to be the standard implementation that many/all
CODECS will use as their of_xlate_dai_name function?

> +	if (dai->id != args->args[0])
> +		return NULL;

This rather assumes that drivers with multiple DAIs will order the list
of DAIs passed to snd_soc_register_dais() in the same order as the
numbering in their device tree binding document. That seems a little
optimistic.

The whole reason for adding an .of_xlate_dai_name function to the DAI
driver was to allow drivers to implement their own translation without
any dependency on ASoC internals, orders of lists of DAIs registered
with ASoC, etc.

As such, I'm not sure that having a standardized implementation of
.of_xlate_dai_name actually even makes sense.

> +	return dai->driver->name;

Surely this should return the DAI name not the DAI driver name?

> +const char *snd_soc_of_get_port_dai_name(struct device_node *of_node,
> +					 const char *prop)
> +{
> +	struct snd_soc_dai *dai;
> +	struct of_phandle_args args;
> +	const char *name;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_args(of_node, prop,
> +					 "#sound-dai-cells", 0, &args);
> +	if (ret)
> +		return NULL;

I suspect returning an int error code would be better. That would allow
you to "return ret" here, which would allow propagating details such as
-EPROBE_DEFERRED.

> +	of_node_put(args.np);
> +
> +	list_for_each_entry(dai, &dai_list, list) {

I think this should iterate over the list of CODEC drivers that are
registered, and then ask the driver to translate from the args to the
DAI name. Here, you're iterating over the list of registered DAIs, which
is something entirely different.

> +		if (dai->dev->of_node != args.np)
> +			continue;
> +
> +		if (dai->driver->of_xlate_dai_name) {
> +			name = dai->driver->of_xlate_dai_name(dai, &args);
> +			if (name)
> +				return name;

This probably also wants to return an integer to differentiate between
e.g. "invalid value" and "no driver found yet".

> +		}
> +	}
> +
> +	return NULL;

If no driver has been registered for the phandle yet, you probably want
to return -EPROBE_DEFERRED here too.

> +}
> +EXPORT_SYMBOL_GPL(snd_soc_of_get_port_dai_name);
