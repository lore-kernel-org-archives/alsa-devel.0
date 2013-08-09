From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v4 1/1] ASoc: kirkwood: add DT support to
 the mvebu audio subsystem
Date: Fri, 09 Aug 2013 10:23:50 +0200
Message-ID: <5204A716.6070507@gmail.com>
References: <20130808132201.2610aef3@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
 [209.85.215.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 07453261A42
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 10:24:02 +0200 (CEST)
Received: by mail-ea0-f177.google.com with SMTP id f15so1891419eak.22
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 01:24:02 -0700 (PDT)
In-Reply-To: <20130808132201.2610aef3@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/08/2013 01:22 PM, Jean-Francois Moine wrote:
> This patch adds DT support to the audio subsystem of the mvebu family
> (Kirkwood, Dove, Armada 370).
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>   .../devicetree/bindings/sound/mvebu-audio.txt      | 29 ++++++++++++++++++++++
>   sound/soc/kirkwood/kirkwood-i2s.c                  | 26 +++++++++++++++++-----
>   2 files changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> new file mode 100644
> index 0000000..7e5fd37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> @@ -0,0 +1,29 @@
> +* mvebu (Kirkwood, Dove, Armada 370) audio controller
> +
> +Required properties:
> +
> +- compatible: "mrvl,mvebu-audio"

Jean-Francois,

we need at least two more compatibles for the audio controller found on
Dove and Kirkwood respectively. This is how we are going to distinguish
those two, e.g. Kirkwood has SPDIF in which Dove hasn't.

Also, we have used "marvell" as prefix for a long time. I know there has
been discussion about the stock ticker appreviation, has there been any
decision on that already?

> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +- interrupts: list of two irq numbers.
> +  The first irq is used for data flow and the second one is used for errors.
> +
> +- clocks: one or two phandles.
> +  The first one is mandatory and defines the internal clock.
> +  The second one is optional and defines an external clock.
> +
> +- clock-names: names associated to the clocks:
> +	"internal" for the internal clock

s/internal/dcoclk/

> +	"extclk" for the external clock
> +
> +Example:
> +
> +i2s1: audio-controller@b4000 {
> +	compatible = "mrvl,mvebu-audio";
> +	reg = <0xb4000 0x2210>;
> +	interrupts = <21>, <22>;
> +	clocks = <&gate_clk 13>;
> +	clock-names = "internal";
> +};

Also we will need some phandle reference to the audio codec here. As
this property is ongoing work in ASoC core, I suggest we wait for it
and propose a binding afterwards.

Sebastian

> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c.next b/sound/soc/kirkwood/kirkwood-i2s.c
> index e5f3f7a..a4170b4 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c.next
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -22,6 +22,8 @@
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
>   #include <linux/platform_data/asoc-kirkwood.h>
> +#include <linux/of.h>
> +
>   #include "kirkwood.h"
>
>   #define DRV_NAME	"mvebu-audio"
> @@ -453,6 +455,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	struct snd_soc_dai_driver *soc_dai = &kirkwood_i2s_dai;
>   	struct kirkwood_dma_data *priv;
>   	struct resource *mem;
> +	struct device_node *np = pdev->dev.of_node;
>   	int err;
>
>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> @@ -473,14 +476,16 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   		return -ENXIO;
>   	}
>
> -	if (!data) {
> -		dev_err(&pdev->dev, "no platform data ?!\n");
> +	if (np) {
> +		priv->burst = 128;		/* might be 32 or 128 */
> +	} else if (data) {
> +		priv->burst = data->burst;
> +	} else {
> +		dev_err(&pdev->dev, "no DT nor platform data ?!\n");
>   		return -EINVAL;
>   	}
>
> -	priv->burst = data->burst;
> -
> -	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	priv->clk = devm_clk_get(&pdev->dev, np ? "internal" : NULL);
>   	if (IS_ERR(priv->clk)) {
>   		dev_err(&pdev->dev, "no clock\n");
>   		return PTR_ERR(priv->clk);
> @@ -507,7 +512,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
>   	priv->ctl_rec = KIRKWOOD_RECCTL_SIZE_24;
>
>   	/* Select the burst size */
> -	if (data->burst == 32) {
> +	if (priv->burst == 32) {
>   		priv->ctl_play |= KIRKWOOD_PLAYCTL_BURST_32;
>   		priv->ctl_rec |= KIRKWOOD_RECCTL_BURST_32;
>   	} else {
> @@ -552,12 +557,21 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static struct of_device_id kirkwood_i2s_of_match[] = {
> +	{ .compatible = "mrvl,mvebu-audio" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kirkwood_i2s_of_match);
> +#endif
> +
>   static struct platform_driver kirkwood_i2s_driver = {
>   	.probe  = kirkwood_i2s_dev_probe,
>   	.remove = kirkwood_i2s_dev_remove,
>   	.driver = {
>   		.name = DRV_NAME,
>   		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(kirkwood_i2s_of_match),
>   	},
>   };
>
>
