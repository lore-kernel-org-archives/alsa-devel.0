From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4 v6] ASoC: simple-card: add Device Tree
 support
Date: Tue, 19 Feb 2013 16:57:41 +0100
Message-ID: <5123A0F5.2030001@metafoo.de>
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
 <87wqubtfi3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-117.synserver.de (smtp-out-117.synserver.de
 [212.40.185.117])
 by alsa0.perex.cz (Postfix) with ESMTP id E0CBE265232
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 16:56:09 +0100 (CET)
In-Reply-To: <87wqubtfi3.wl%kuninori.morimoto.gx@renesas.com>
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

On 02/14/2013 10:24 AM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec information,
> and .of_xlate_dai_name support on each driver for probing.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v5 -> v6
> 
>  - cpu/codec become sub-node
>  - it is using new .of_xlate_dai_name based
>    snd_soc_of_get_port_dai_name()
>  - update Documentation
> 
>  .../devicetree/bindings/sound/simple-card.txt      |   75 +++++++++++++
>  sound/soc/generic/simple-card.c                    |  118 +++++++++++++++++++-
>  2 files changed, 188 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> new file mode 100644
> index 0000000..86e0d9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -0,0 +1,75 @@
> +Simple-Card:
> +
> +Required properties:
> +
> +- compatible				: "simple-audio"
> +- simple-audio,card-name		: simple-audio card name
> +- simple-audio,format			: see below
> +- simple-audio,cpu			: CPU sub-node, see below
> +- simple-audio,codec			: CODEC sub-node, see below
> +
> +Optional properties:
> +
> +- simple-audio,system-clock-frequency	: system clock rate if it is connected to both CPU/CODEC
> +- simple-audio,bitclock-inversion	: bit clock inversion for both CPU/CODEC
> +- simple-audio,frame-inversion		: frame inversion for both CPU/CODEC
> +
> +Required cpu/codec subnode properties:
> +
> +- simple-audio,dev			: phandle and port for CPU/CODEC
> +- simple-audio,frame-master		: frame master
> +- simple-audio,bitclock-master		: bitclock master
> +#sound-dai-cells integer is required on simple-audio,dev phandle's node

Shouldn't the names of '#sound-dai-cells' and 'simple-audio,dev' kind of
match? E.g. '#sound-dai-cells' and 'sound-dai'. Maybe drop the sound, since
the a in dai kind of implies this.

[...]
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 6cf8355..e50e415 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -9,6 +9,7 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <sound/simple_card.h>
> @@ -52,11 +53,108 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> +static struct device_node*
> +__asoc_simple_card_parse_of(struct device_node *np,
> +			    struct asoc_simple_dai *dai)
> +{
> +	struct device_node *node;
> +	char prop[128];
> +
> +	/* get "simple-audio,dev = <&phandle port>" */
> +	snprintf(prop, sizeof(prop), "simple-audio,dev");

Why do you need the extra buffer? Can you just pass, "simple-audio,dev"
directly to of_parse_phandle?

> +	node = of_parse_phandle(np, prop, 0);
> +	if (!node)
> +		return NULL;
> +
> +	of_node_put(node);

You shouldn't drop the reference until you are done processing it. Which in
this case is only after the device has been unregistered, since you pass the
node on to the ASoC core.

> +
> +	/* get dai-name  */
> +	dai->name = snd_soc_of_get_port_dai_name(np, prop);
> +
> +	/* get dai specific format */
> +	dai->fmt = snd_soc_of_parse_daifmt(np, "simple-audio,");
> +
> +	/* get "simple-audio,system-clock-frequency = <xxx>" */
> +	snprintf(prop, sizeof(prop), "simple-audio,system-clock-frequency");
> +	of_property_read_u32(np, prop, &dai->sysclk);
> +
> +	return node;
> +}
