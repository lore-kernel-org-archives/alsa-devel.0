From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH] ASoC: Remove unused variable 'card' in
	imx_pcm_fiq_new
Date: Wed, 31 Aug 2011 07:37:50 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77222BE87@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314769825.28750.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id C7C8C103827
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 09:38:01 +0200 (CEST)
In-Reply-To: <1314769825.28750.1.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Axel Lin
> Sent: Wednesday, August 31, 2011 1:50 PM
> To: linux-kernel@vger.kernel.org
> Cc: Sascha Hauer; Liam Girdwood; Mark Brown; alsa-devel@alsa-project.org
> Subject: [PATCH] ASoC: Remove unused variable 'card' in imx_pcm_fiq_new
> 
> Fix below build warning:

It seems Fabio already sent this out a few days ago.
Please refer to:
http://comments.gmane.org/gmane.linux.alsa.devel/88686

>   CC      sound/soc/imx/imx-pcm-fiq.o
> sound/soc/imx/imx-pcm-fiq.c: In function 'imx_pcm_fiq_new':
> sound/soc/imx/imx-pcm-fiq.c:243: warning: unused variable 'card'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/imx/imx-pcm-fiq.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
> index 309c59e..7945625 100644
> --- a/sound/soc/imx/imx-pcm-fiq.c
> +++ b/sound/soc/imx/imx-pcm-fiq.c
> @@ -240,7 +240,6 @@ static int ssi_irq = 0;
> 
>  static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)  {
> -	struct snd_card *card = rtd->card->snd_card;
>  	struct snd_soc_dai *dai = rtd->cpu_dai;
>  	struct snd_pcm *pcm = rtd->pcm;
>  	int ret;
> --
> 1.7.4.1
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
