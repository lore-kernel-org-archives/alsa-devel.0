From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4 v6] ASoC: add .of_xlate_dai_name
 callback on struct snd_soc_dai_driver
Date: Tue, 19 Feb 2013 16:50:39 +0100
Message-ID: <51239F4F.4040605@metafoo.de>
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
 <871ucjuu7g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-117.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DD4265232
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 16:49:12 +0100 (CET)
In-Reply-To: <871ucjuu7g.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/14/2013 10:21 AM, Kuninori Morimoto wrote:
[...]
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
> +
> +	of_node_put(args.np);

You should keep the reference until after the link.

> +
> +	list_for_each_entry(dai, &dai_list, list) {
> +		if (dai->dev->of_node != args.np)
> +			continue;
> +
> +		if (dai->driver->of_xlate_dai_name) {
> +			name = dai->driver->of_xlate_dai_name(dai, &args);
> +			if (name)
> +				return name;
> +		}

Hm, this is not really a translate function, but rather a match function. It
iterates over all dais of the device and returns the name of the first one
which matches. But there is no translation going on. If the dai matches the
callback will always want to return dai->driver->name. Anything else doesn't
make much sense.

> +	}
> +
> +	return NULL;
> +}
