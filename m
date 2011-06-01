From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/10] sound/soc/nuc900/nuc900-ac97.c: add
	missing clk_put
Date: Wed, 1 Jun 2011 18:12:46 +0100
Message-ID: <4DE6730E.7040403@ti.com>
References: <1306948213-20767-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F63C103858
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:12:50 +0200 (CEST)
In-Reply-To: <1306948213-20767-2-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wan ZongShun <mcuos.com@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Axel Lin <axel.lin@gmail.com>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 01/06/11 18:10, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> This goto is after the call to clk_get, so it should go to the label that
> includes a call to clk_put.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r exists@
> expression e1,e2;
> statement S;
> @@
> 
> e1 = clk_get@p1(...);
> ... when != e1 = e2
>     when != clk_put(e1)
>     when any
> if (...) { ... when != clk_put(e1)
>                when != if (...) { ... clk_put(e1) ... }
> * return@p3 ...;
>  } else S
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  sound/soc/nuc900/nuc900-ac97.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
> index dac6732..9c0edad 100644
> --- a/sound/soc/nuc900/nuc900-ac97.c
> +++ b/sound/soc/nuc900/nuc900-ac97.c
> @@ -356,7 +356,7 @@ static int __devinit nuc900_ac97_drvprobe(struct platform_device *pdev)
>  	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
>  	if (!nuc900_audio->irq_num) {
>  		ret = -EBUSY;
> -		goto out2;
> +		goto out3;
>  	}
>  
>  	nuc900_ac97_data = nuc900_audio;
> 

Acked-by: Liam Girdwood <lrg@ti.com>
