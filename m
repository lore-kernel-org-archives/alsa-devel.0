From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 5/6] ASoC: rsnd: care DMA slave channel
 name for DT
Date: Mon, 02 Jun 2014 22:33:45 +0100
Message-ID: <538CEDB9.3020506@codethink.co.uk>
References: <87r43lc8w5.wl%kuninori.morimoto.gx@gmail.com>
 <87iooxc8pg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (unknown [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 0643D265450
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 23:34:37 +0200 (CEST)
In-Reply-To: <87iooxc8pg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 23/05/14 07:25, Kuninori Morimoto wrote:
> Renesas sound driver is supporting to use DMAEngine.
> But, DMA slave channel name "tx", "rx" is not enough
> in DT case.
> Becuase, it has many ports and path combination.
> 
> This patch adds rsnd_dma_of_name() to find
> DMA channel name, for example
> memory to SSI0 is "mem_ssi0",
> SSI0 to memory is "ssi0_mem",
> SSI0 to SRC0   is "ssi0_src0",
> SRC0 to SSI0   is "src0_ssi0",
> SRC0 to DVC0   is "src0_dvc0"...

I commented on another patch where the ssiX nodes are not being
used, this would be so much nicer if we removed the ssiX from the
name and used the of-pointer for the ssiX node to lookup the DMA...

This is going to produce a hugh list of DMA entries that are going
to be difficult to manage.

> Renesas sound want to use PIO transfer mode for some reasons.
> It will be PIO tranfer mode if device node doesn't have
> DMA settings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/renesas,rsnd.txt     |    1 +
>  sound/soc/sh/rcar/core.c                           |   80 +++++++++++++++++++-
>  sound/soc/sh/rcar/ssi.c                            |    6 ++
>  3 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index a44e917..8346cab 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -20,6 +20,7 @@ Required properties:
>  SSI subnode properties:
>  - interrupts			: Should contain SSI interrupt for PIO transfer
>  - shared-pin			: if shared clock pin
> +- pio-transfer			: use PIO transfer mode
>  
>  SRC subnode properties:
>  no properties at this poin

> diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
> index 2d94a62..e0a4ba7 100644
> --- a/sound/soc/sh/rcar/ssi.c
> +++ b/sound/soc/sh/rcar/ssi.c
> @@ -589,6 +589,12 @@ static void rsnd_of_parse_ssi(struct platform_device *pdev,
>  		 * irq
>  		 */
>  		ssi_info->pio_irq = irq_of_parse_and_map(np, 0);
> +
> +		/*
> +		 * DMA
> +		 */
> +		ssi_info->dma_id = of_get_property(np, "pio-transfer", NULL) ?
> +			0 : 1;

How about checking for the dma node, and if no present?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
