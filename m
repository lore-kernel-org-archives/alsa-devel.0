From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver
	as	using symmetric rates
Date: Mon, 11 Jan 2010 12:20:47 +0100
Message-ID: <20100111112047.GT6923@pengutronix.de>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 8DBBC24566
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:20:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Javier Martin <javier.martin@vista-silicon.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Fri, Jan 08, 2010 at 04:19:58PM +0000, Mark Brown wrote:
> While the hardware is fully asymmetric the driver currently forces
> a symmetric configuration so flag that up in the capabilities to
> avoid breakage - when the driver is able to do symmetry the flag
> can be dropped.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/imx/imx-ssi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
> index ccb7ec9..cfaf715 100644
> --- a/sound/soc/imx/imx-ssi.c
> +++ b/sound/soc/imx/imx-ssi.c
> @@ -357,6 +357,8 @@ static struct snd_soc_dai imx_ssi_dai = {
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE,
>  	},
>  	.ops = &imx_ssi_pcm_dai_ops,
> +	/* Hardware is asymmetric but the driver isn't yet */
> +	.symmetric_rates = 1,

Why this limitation? I can successfully record with 16000Hz while
playing at 48000Hz on my PCM037 board. What is missing in the driver to
'officially' support asymmetric rates?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
