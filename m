From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] ASoC: Remove a unused variables from
	i.MX FIQ	runtime data
Date: Thu, 25 Feb 2010 15:59:35 +0100
Message-ID: <20100225145935.GF25271@pengutronix.de>
References: <1267102330-13294-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 934FA103815
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 15:59:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267102330-13294-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 12:52:09PM +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

both

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  sound/soc/imx/imx-pcm-fiq.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
> index 5532579..a1c4ce6 100644
> --- a/sound/soc/imx/imx-pcm-fiq.c
> +++ b/sound/soc/imx/imx-pcm-fiq.c
> @@ -35,12 +35,8 @@
>  struct imx_pcm_runtime_data {
>  	int period;
>  	int periods;
> -	unsigned long dma_addr;
> -	int dma;
>  	unsigned long offset;
>  	unsigned long size;
> -	unsigned long period_cnt;
> -	void *buf;
>  	struct timer_list timer;
>  	int period_time;
>  };
> -- 
> 1.7.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
