From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Staticise asoc_idma_platform
Date: Wed, 14 Dec 2011 09:56:48 +0900
Message-ID: <03c701ccb9fb$4202a060$c607e120$@com>
References: <1323701282-9478-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A8DAD243E9
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 01:56:52 +0100 (CET)
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LW600FEN5AMCBJ0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 14 Dec 2011 09:56:48 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.120.118])
	by mmp2.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0LW6009L35AOZM20@mmp2.samsung.com>
	for alsa-devel@alsa-project.org; Wed, 14 Dec 2011 09:56:48 +0900 (KST)
In-reply-to: <1323701282-9478-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 12, 2011 at 11:48 PM, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/idma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
> index baf97eb..2bcf758 100644
> --- a/sound/soc/samsung/idma.c
> +++ b/sound/soc/samsung/idma.c
> @@ -410,7 +410,7 @@ void idma_reg_addr_init(void __iomem *regs, dma_addr_t
> addr)
>  	idma.lp_tx_addr = addr;
>  }
> 
> -struct snd_soc_platform_driver asoc_idma_platform = {
> +static struct snd_soc_platform_driver asoc_idma_platform = {
>  	.ops = &idma_ops,
>  	.pcm_new = idma_new,
>  	.pcm_free = idma_free,

Acked-by: Sangbeom Kim <sbkim73@samsung.com>

Thanks,
Sangbeom,
