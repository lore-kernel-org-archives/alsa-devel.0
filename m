From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] ASoC: simple-card: add Device Tree
	support
Date: Thu, 24 Oct 2013 18:17:59 +0100
Message-ID: <20131024171758.GA2461@kartoffel>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A9D26261A81
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 19:18:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Oct 04, 2013 at 01:04:41AM +0100, Kuninori Morimoto wrote:
> Support for loading the simple-card module via DeviceTree.
> It requests CPU/CODEC information,
> and .of_xlate_dai_name support on each component driver.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - add common clock support, system-clock-frequency can over-write it
>  - add some comment on code
> 
> v2 -> v3
> 
>  - add devicetree ML address
> 
>  .../devicetree/bindings/sound/simple-card.txt      |   85 ++++++++++++
>  sound/soc/generic/simple-card.c                    |  146 +++++++++++++++++++-
>  2 files changed, 226 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
> new file mode 100644
> index 0000000..75bbc5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
> @@ -0,0 +1,85 @@
> +Simple-Card:

It's really difficult to review this without a description. Please explain what
this binding represents.

What hardware is this applicable to?

Does this inherit from some class of binding?

> +
> +Required properties:
> +
> +- compatible				: "simple-audio"
> +- simple-audio,card-name		: simple-audio card name

What's this used for?

> +- simple-audio,cpu			: CPU sub-node, see below
> +- simple-audio,codec			: CODEC sub-node, see below

Describe these as required subnodes. Nodes are not properties.

> +
> +Optional properties:
> +
> +- simple-audio,format			: CPU/CODEC common format, see below
> +
> +Required cpu/codec subnode properties:
> +
> +- sound-dai				: phandle and port for CPU/CODEC
> +- #sound-dai-cells			: sound-dai phandle's node

This description makes no sense, the organisation seems structurally wrong.

What does this mean? What does it affect?

> +
> +Optional subnode properties:
> +
> +- format				: specific format if needed, see below
> +- frame-master				: frame master
> +- bitclock-master			: bitclock master
> +- bitclock-inversion			: clock inversion
> +- frame-inversion			: frame inversion

What do these mean? Repeating the name without a dash is completely unhelpful.
Describe what these imply.

What type are they?

Which subnode(s) do they apply to?

> +- clocks				: phandle for system clock rate

Just one clock?

Nit: clocks are specified with a phandle + clock-specifier pair, not just a phandle.

> +- system-clock-frequency		: system clock rate
> +					  it will overwrite clocks's rate

This seems very odd.

Why do you want to overwrite a clock's rate?

> +
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

What do these mean? Why are they not described when the property was defined above?

Does this also apply for the "format" property?

> +
> +Example:
> +
> +clock {
> +	osc: oscillator {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <11289600>;
> +	};
> +};
> +
> +sound {
> +	compatible = "simple-audio";
> +
> +	simple-audio,card-name = "FSI2A-AK4648";
> +	simple-audio,format = "left_j";
> +
> +	simple-audio,cpu {
> +		sound-dai = <&sh_fsi2 0>;
> +	};
> +
> +	simple-audio,codec {
> +		sound-dai = <&ak4648>;
> +		bitclock-master;
> +		frame-master;
> +		clocks = <&osc>;
> +		/* it can use this instead of clocks
> +		 * system-clock-frequency = <11289600>; */

This just confuses matters. If ou want to show this off, have two examples.

> +	};
> +};
> +
> +&i2c0 {
> +	ak4648: ak4648@0x12 {

Nit: remove the 0x on the unit-address

> +		#sound-dai-cells = <0>;
> +		compatible = "asahi-kasei,ak4648";
> +		reg = <0x12>;
> +	};
> +};
> +
> +sh_fsi2: sh_fsi2@0xec230000 {

Again, fix the unit-address please.

> +	#sound-dai-cells = <1>;
> +	compatible = "renesas,sh_fsi2";
> +	reg = <0xec230000 0x400>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 146 0x4>;
> +};
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index 8c49147..62befbd 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -9,6 +9,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/clk.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <sound/simple_card.h>
> @@ -52,11 +54,135 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
>  
> +static int
> +__asoc_simple_card_parse_of(struct device_node *np,
> +			    struct asoc_simple_dai *dai,
> +			    struct device_node **node)
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
> +	of_node_put(*node);

Why?

You're refrering to it, so why do you not want to have it refcounted?

It could disappear under your feet.

> +
> +	/* get dai->name */
> +	ret = snd_soc_of_get_dai_name(np, &dai->name);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * bitclock-inversion, frame-inversion
> +	 * bitclock-master,    frame-master
> +	 * and specific "format" if it has
> +	 */
> +	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
> +
> +	/* dai->sysclk via "clolks = <xxx>" */
> +	clk = of_clk_get(np, 0);
> +	if (IS_ERR(clk))
> +		dai->sysclk = 0;
> +	else
> +		dai->sysclk = clk_get_rate(clk);

This seems like an odd assumption to make. Why not error?

> +
> +	/*
> +	 * overwrite dai->sysclk if it has
> +	 * "system-clock-frequency = <xxx>"
> +	 */
> +	of_property_read_u32(np,
> +			     "system-clock-frequency",
> +			     &dai->sysclk);

Is dai->sysclk defined as a u32?

> +
> +	return 0;
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
> +	int ret = 0;
> +
> +	/* get card name */
> +	of_property_read_string(node, "simple-audio,card-name", &info->card);
> +	info->name = info->card;

What if the string is not in the DT?

Does the core code handle these being NULL?

> +
> +	/* get CPU/CODEC common format via simple-audio,format */
> +	info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio,") &
> +		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> +
> +	/* CPU/CODEC sub-node */
> +	for_each_child_of_node(node, np) {
> +		if (0 == strcmp("simple-audio,cpu", np->name))
> +			ret = __asoc_simple_card_parse_of(np,
> +							  &info->cpu_dai,
> +							  of_cpu);
> +		if (0 == strcmp("simple-audio,codec", np->name))
> +			ret = __asoc_simple_card_parse_of(np,
> +							  &info->codec_dai,
> +							  of_codec);

of_get_child_by_name?

> +		if (ret < 0)
> +			return ret;
> +	}

What if there were no children?

> +
> +	/* simple-card assumes platform == cpu */
> +	*of_platform = *of_cpu;
> +
> +	dev_dbg(dev, "card-name : %s\n", info->card);
> +	dev_dbg(dev, "platform : %04x / %p\n",
> +		info->daifmt,
> +		*of_platform);

Why is the pointer helpful, rather than the info it points to?

Thanks,
Mark.
