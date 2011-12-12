From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] ASoC: Add missed MODULE_LICENSE("GPL") for
	imx-pcm-fiq
Date: Mon, 12 Dec 2011 09:40:00 +0100
Message-ID: <20111212084000.GM27267@pengutronix.de>
References: <1323676875.8204.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EEEC024451
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 09:40:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323676875.8204.4.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 04:01:15PM +0800, Axel Lin wrote:
> This driver can be built as module and the file header indicates that
> the driver is published under the GPL.
> Thus add MODULE_LICENSE("GPL") for it.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  sound/soc/imx/imx-pcm-fiq.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
> index d7ea0b3..456b7d7 100644
> --- a/sound/soc/imx/imx-pcm-fiq.c
> +++ b/sound/soc/imx/imx-pcm-fiq.c
> @@ -332,3 +332,5 @@ static struct platform_driver imx_pcm_driver = {
>  };
>  
>  module_platform_driver(imx_pcm_driver);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.4
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
