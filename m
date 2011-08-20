From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH 2/4] sound/soc/ep93xx/ep93xx-i2s.c: add
	missing kfree
Date: Sat, 20 Aug 2011 09:31:55 +0200
Message-ID: <1313825516.15081.1.camel@r60e>
References: <1313820761-12042-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward16.mail.yandex.net (forward16.mail.yandex.net
	[95.108.253.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 73AAF2477C
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:31:59 +0200 (CEST)
In-Reply-To: <1313820761-12042-2-git-send-email-julia@diku.dk>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Takashi Iwai <tiwai@suse.de>, H@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Sweeten <hsweeten@visionengravers.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello!

I believe, fix is correct.
Acked-by: Alexander Sverdlin <subaparts@yandex.ru>

On Sat, 2011-08-20 at 08:12 +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Introduce a new label that includes kfree and jump to that one.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> expression E1!=0,E2,E3,E4;
> statement S;
> iterator I;
> @@
> 
> (
> if (...) { ... when != kfree(x)
>                when != x = E3
>                when != E3 = x
> *  return ...;
>  }
> ... when != x = E2
>     when != I(...,x,...) S
> if (...) { ... when != x = E4
>  kfree(x); ... return ...; }
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
>  sound/soc/ep93xx/ep93xx-i2s.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
> index 56efa0c..099614e 100644
> --- a/sound/soc/ep93xx/ep93xx-i2s.c
> +++ b/sound/soc/ep93xx/ep93xx-i2s.c
> @@ -385,14 +385,14 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		err = -ENODEV;
> -		goto fail;
> +		goto fail_free_info;
>  	}
>  
>  	info->mem = request_mem_region(res->start, resource_size(res),
>  				       pdev->name);
>  	if (!info->mem) {
>  		err = -EBUSY;
> -		goto fail;
> +		goto fail_free_info;
>  	}
>  
>  	info->regs = ioremap(info->mem->start, resource_size(info->mem));
> @@ -435,6 +435,7 @@ fail_unmap_mem:
>  	iounmap(info->regs);
>  fail_release_mem:
>  	release_mem_region(info->mem->start, resource_size(info->mem));
> +fail_free_info:
>  	kfree(info);
>  fail:
>  	return err;
> 
> 
