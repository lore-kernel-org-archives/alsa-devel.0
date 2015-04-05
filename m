From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 7/9] sound/pci/sis7019.c: fix error return code
Date: Sun, 5 Apr 2015 14:13:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1504051413140.2038@localhost6.localdomain6>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr> <1428233914-4503-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428233914-4503-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Please ignore. Wrong patch set.

On Sun, 5 Apr 2015, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize rc before returning on failure, as done elsewhere in the
> function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> 
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/pci/sis7019.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
> index 535efe2..51e4340 100644
> --- a/sound/pci/sis7019.c
> +++ b/sound/pci/sis7019.c
> @@ -1377,8 +1377,9 @@ static int __devinit sis_chip_create(struct snd_card *card,
>  	if (rc)
>  		goto error_out_cleanup;
>  
> -	if (request_irq(pci->irq, sis_interrupt, IRQF_SHARED, KBUILD_MODNAME,
> -			sis)) {
> +	rc = request_irq(pci->irq, sis_interrupt, IRQF_SHARED, KBUILD_MODNAME,
> +			 sis);
> +	if (rc) {
>  		dev_err(&pci->dev, "unable to allocate irq %d\n", sis->irq);
>  		goto error_out_cleanup;
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
