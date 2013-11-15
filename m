From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4] ASoC: simple-card: add Device Tree
	support
Date: Fri, 15 Nov 2013 15:50:28 +0000
Message-ID: <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id CF81A261AC1
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 16:50:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <Pawel.Moll@arm.com>, Simon <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Takashi Iwai <tiwai@suse.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 25, 2013 at 03:14:20AM +0100, Kuninori Morimoto wrote:
> Support for loading the simple-card module via DeviceTree.
> It requests CPU/CODEC information.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - explain detail of each properties on simple-card.txt
>  - fixup odd examples on simple-card.txt
>  - remove "simple-card,card-name". create it from cpu/codec name
>  - use of_get_child_by_name()
>  - remove odd pointer info from dev_dbg()
>  - remove subnode format which are no longer needed
> 
> This is based on asoc/topic/simple branch
> 
>  .../devicetree/bindings/sound/simple-card.txt      |   73 +++++++++
>  sound/soc/generic/simple-card.c                    |  156 +++++++++++++++++++-
>  2 files changed, 223 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> new file mode 100644
> index 0000000..4871e91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -0,0 +1,73 @@
> +Simple-Card:
> +
> +Simple-Card specifies audio DAI connection of SoC <-> codec.
> +
> +Required properties:
> +
> +- compatible				: "simple-audio"
> +
> +Optional properties:
> +
> +- simple-audio,format			: CPU/CODEC common audio format.
> +					"i2s", "right_j", "left_j" , "dsp_a"
> +					"dsp_b", "ac97", "pdm", "msb", "lsb"
> +Required subnodes:
> +
> +- simple-audio,cpu			: CPU   sub-node
> +- simple-audio,codec			: CODEC sub-node
> +
> +Required CPU/CODEC subnodes properties:
> +
> +- sound-dai				: phandle and port of CPU/CODEC

Is there a class binding for audio devices this derives from?

> +
> +Optional CPU/CODEC subnodes properties:

Do these all apply to both sub-nodes?

> +- frame-master				: bool property. add this if subnode was frame master
> +- bitclock-master			: bool property. add this if subnode was bitclock master

s/was/is/

> +- bitclock-inversion			: bool property. add this if subnode has clock inversion
> +- frame-inversion			: bool property. add this if subnode has frame inversion
> +- clocks / system-clock-frequency	: specify subnode's clock if needed.
> +					  it can be specified via "clocks" if system has clock node,
> +                                          or "system-clock-frequency" if system doesn't have it.

What does "if system doesn't have it" mean? If it doesn't have a clock,
how does said non-existent clock have a frequency?

It would be possible to use a fixed-clock in place of
system-clock-frequency, which would make the binding more consistent and
the driver simpler, at the cost of making the dt marginally more
complex.

> +
> +Example:
> +
> +clock {

Why is this container here? It's confusing and unnecessary.

> +	osc: oscillator {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <11289600>;
> +	};
> +};

[...]

> +static int
> +asoc_simple_card_sub_parse_of(struct device_node *np,
> +			      struct asoc_simple_dai *dai,
> +			      struct device_node **node)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	/*
> +	 * get node via "sound-dai = <&phandle port>"
> +	 * it will be used as xxx_of_node on soc_bind_dai_link()
> +	 */
> +	*node = of_parse_phandle(np, "sound-dai", 0);
> +	if (!*node)
> +		return -ENODEV;
> +
> +	/* get dai->name */
> +	ret = snd_soc_of_get_dai_name(np, &dai->name);
> +	if (ret < 0)
> +		goto parse_error;
> +
> +	/*
> +	 * bitclock-inversion, frame-inversion
> +	 * bitclock-master,    frame-master
> +	 * and specific "format" if it has
> +	 */

This comment looks confusing to me. I'm not sure it's all that helpful.

> +	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);

As a general note, I'm surprised there isn't a helper that does all of
the above, from of_parse_phandle to here.

> +
> +	/*
> +	 * dai->sysclk come from
> +	 *  "clolks = <&xxx>" or "system-clock-frequency = <xxx>"

s/clolks/clocks/

> +	 */
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk))
> +		of_property_read_u32(np,
> +				     "system-clock-frequency",
> +				     &dai->sysclk);

What it this isn't present?

> +	else
> +		dai->sysclk = clk_get_rate(clk);
> +
> +	ret = 0;
> +
> +parse_error:
> +	of_node_put(*node);
> +
> +	return ret;
> +}
> +
> +static int asoc_simple_card_parse_of(struct device_node *node,
> +				     struct asoc_simple_card_info *info,
> +				     struct device *dev,
> +				     struct device_node **of_cpu,
> +				     struct device_node **of_codec,
> +				     struct device_node **of_platform)
> +{
> +	struct device_node *np;
> +	char *name;
> +	int ret = 0;
> +
> +	/* get CPU/CODEC common format via simple-audio,format */
> +	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio,") &
> +		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> +
> +	/* CPU sub-node */
> +	ret = -EINVAL;
> +	np = of_get_child_by_name(node, "simple-audio,cpu");
> +	if (np)
> +		ret = asoc_simple_card_sub_parse_of(np,
> +						  &info->cpu_dai,
> +						  of_cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* CODEC sub-node */
> +	ret = -EINVAL;
> +	np = of_get_child_by_name(node, "simple-audio,codec");
> +	if (np)
> +		ret = asoc_simple_card_sub_parse_of(np,
> +						  &info->codec_dai,
> +						  of_codec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* card name is created from CPU/CODEC dai name */
> +	of_property_read_string(node, "simple-audio,card-name", &info->card);
> +	name = devm_kzalloc(dev,
> +			    strlen(info->cpu_dai.name)   +
> +			    strlen(info->codec_dai.name) + 2,
> +			    GFP_KERNEL);
> +	sprintf(name, "%s-%s", info->cpu_dai.name, info->codec_dai.name);
> +	info->name = info->card = name;
> +
> +	/* simple-card assumes platform == cpu */
> +	*of_platform = *of_cpu;

Why? What does this imply?

Thanks,
Mark.
