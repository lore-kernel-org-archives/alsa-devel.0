From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 2/4] sound/soc/ep93xx/ep93xx-i2s.c: add missing kfree
Date: Mon, 22 Aug 2011 11:25:32 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F38857523F@AUSP01VMBX24.collaborationhost.net>
References: <1313820761-12042-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313820761-12042-2-git-send-email-julia@diku.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>, Liam Girdwood <lrg@ti.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Alexander Sverdlin <subaparts@yandex.ru>, Ryan Mallon <rmallon@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Friday, August 19, 2011 11:13 PM, Julia Lawall wrote:
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

Looks correct to me...

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
