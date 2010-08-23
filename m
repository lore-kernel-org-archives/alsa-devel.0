From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC i.MX ssi: use SSI_STCCR in synchronous mode
Date: Mon, 23 Aug 2010 11:38:23 +0100
Message-ID: <1282559903.3053.26.camel@odin>
References: <20100823065402.GR27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 75AC310384E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 12:38:26 +0200 (CEST)
Received: by wyb42 with SMTP id 42so6522693wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2010 03:38:26 -0700 (PDT)
In-Reply-To: <20100823065402.GR27749@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-08-23 at 08:54 +0200, Sascha Hauer wrote:
> Hi,
> 
> This time with cc list.
> 
> Please consider applying for -rc.
> 
> Sascha
> 
> 
> In synchronous mode the SSI_SRCCR values are ignored. Instead
> SSI_STCCR must be used for both receiving and transmitting.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  sound/soc/imx/imx-ssi.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index a11daa1..c81da05 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -254,6 +254,9 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
>  		dma_data = &ssi->dma_params_rx;
>  	}
>  
> +	if (ssi->flags & IMX_SSI_SYN)
> +		reg = SSI_STCCR;
> +
>  	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
>  
>  	sccr = readl(ssi->base + reg) & ~SSI_STCCR_WL_MASK;
> -- 
> 1.7.1
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
