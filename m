From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: i.MX SSI: Fix DSP_A format.
Date: Thu, 23 Feb 2012 19:30:36 +0100
Message-ID: <20120223183036.GO3852@pengutronix.de>
References: <1330008198-31142-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 727AB24347
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 19:30:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1330008198-31142-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: lrg@ti.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, axel.lin@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 23, 2012 at 03:43:18PM +0100, Javier Martin wrote:
> According to i.MX27 Reference Manual (p 1593) TXBIT0 bit selects
> whether the most significant or the less significant part of the
> data word written to the FIFO is transmitted.
> 
> As DSP_A is the same as DSP_B with a data offset of 1 bit, it
> doesn't make any sense to remove TXBIT0 bit here.

I have the very same patch locally but wasn't confident enough to send
it.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  sound/soc/imx/imx-ssi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index 01d1f74..b6adbed 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -112,7 +112,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* data on rising edge of bclk, frame high 1clk before data */
> -		strcr |= SSI_STCR_TFSL | SSI_STCR_TEFS;
> +		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
>  		break;
>  	}
>  
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
