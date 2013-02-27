From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5 v7][RFC] ASoC: simple-card: add Device
	Tree support
Date: Wed, 27 Feb 2013 16:17:21 -0700
Message-ID: <512E9401.8050202@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
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
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
 <87621gg4az.wl%kuninori.morimoto.gx@renes as.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 45AD2265CBC
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 00:17:31 +0100 (CET)
In-Reply-To: <87621gg4az.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/25/2013 01:56 AM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec information,
> and .of_xlate_dai_name support on each driver for probing.

> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt


> +Optional properties:
...
> +- simple-audio,bitclock-inversion	: bit clock inversion for both CPU/CODEC
> +- simple-audio,frame-inversion		: frame inversion for both CPU/CODEC

I think that Mark pointed out those would be best stored in the CPU and
CODEC child nodes, since random buffering/inverting on the board might
make the values at the two DAIs the opposite of each-other.


> +Required cpu/codec subnode properties:
> +
> +- sound-dai				: phandle and port for CPU/CODEC

I would be inclined to rename that simply "dai". "sound" is implicit
since the property is part of a sound-related node. Still, this isn't a
big deal.

> +- #sound-dai-cells			: sound-dai phandle's node

That property isn't part of the sound card's CPU/CODEC subnode, but
rather part of the CPU or CODEC that's referred to by the phandle.

This document needs to describe 3 sets of nodes:

1) The sound node itself.

2) The CPU and CODEC child nodes of the sound node.

3) The nodes representing the CPU and CODEC HW devices. It is these that
will contain #sound-dai-cells.

See for example how Documentation/devicetree/bindings/gpio/gpio.txt
describes each of these 3 cases separately.

Note that I think #sound-dai-cells is the correct name for this property
(and not #dai-cells), since the nodes they will appear in are more
generic HW device nodes, and not a dedicated sound-card node.

> +simple-audio,format
> +	"i2s"
> +	"right_j"
> +	"left_j"
> +	"dsp_a"
> +	"dsp_b"
> +	"ac97"
> +	"pdm"
> +	"msb"
> +	"lsb"

Now that we have a C pre-processor for device tree, I would be inclined
to use an integer for that property, rather than strings.

> +Example:

Overall, the example looks very much like what I hoped.

> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c

> +static int
> +__asoc_simple_card_parse_of(struct device_node *np,

__ is a bit odd. Rename the function to asoc_simple_card_parse_of_dai()
to avoid it having the same name as asoc_simple_card_parse_of() below,
once you remove the __.

> +	/* get "simple-audio,dev = <&phandle port>" */
> +	*node = of_parse_phandle(np, "sound-dai", 0);
> +	if (!*node)
> +		return -ENODEV;

I definitely think snd_soc_of_get_*_dai_name() should return this.
Otherwise, you're just duplicating work that happens inside there.

> +	of_node_put(*node);
> +
> +	/* get dai-name  */
> +	if (for_cpu)
> +		ret = snd_soc_of_get_cpu_dai_name(np, &dai->name);
> +	else
> +		ret = snd_soc_of_get_codec_dai_name(np, &dai->name);

Why can't there be a single function that returns both the target DT
node and the DAI name. It should simply search both the list of CPUs and
list of CODECs until a match is found. That way, machine drivers won't
need this "for_cpu" condition.

> +static int asoc_simple_card_parse_of(struct device_node *node,
> +				     struct asoc_simple_card_info *info,
> +				     struct device *dev,
> +				     struct device_node **of_cpu,
> +				     struct device_node **of_codec,
> +				     struct device_node **of_platform)
> +{
> +	struct device_node *np;
> +	u32 sysclk = 0;
> +	int ret = 0;
> +
> +	of_property_read_string(node, "simple-audio,card-name", &info->card);
> +	info->name = info->card;
> +
> +	/* cpu/codec common daifmt */
> +	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio,") &
> +		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> +
> +	/* cpu/codec common clock */
> +	of_property_read_u32(node,
> +			"simple-audio,system-clock-frequency", &sysclk);
> +	info->cpu_dai.sysclk = sysclk;
> +	info->codec_dai.sysclk = sysclk;
> +
> +	/* cpu/codec sub-node */
> +	for_each_child_of_node(node, np) {

What if there are 3 nodes because the DT author put random cruft in there.

I think you want to use of_find_node_by_name() instead, to look up a
specific node name.

> +		if (0 == strcmp("simple-audio,cpu", np->name))

s/0 ==/!/. (and I'm sure others disagree, but I rather dislike comparing
a constant to see if it has a particular value, rather than comparing a
value to the constant that you care if it matches or not).

>  static int asoc_simple_card_probe(struct platform_device *pdev)
...
> +	struct asoc_simple_card_info *cinfo;
...
> +	if (np && of_device_is_available(np)) {
> +		cinfo = devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
> +		if (cinfo) {
> +			int ret;
> +			ret = asoc_simple_card_parse_of(np, cinfo, dev,
> +							&of_cpu,
> +							&of_codec,
> +							&of_platform);
...
> +	cinfo->snd_link.cpu_of_node	= of_cpu;
> +	cinfo->snd_link.codec_of_node	= of_codec;
> +	cinfo->snd_link.platform_of_node = of_platform;

Why not just have asoc_simple_card_parse_of() directly fill in those
values, rather than writing them to temporary variables only to copy
them in here anyway. You pass cinfo to the function, so it could easily
do this.
