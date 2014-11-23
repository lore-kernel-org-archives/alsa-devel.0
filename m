From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 6/9] sound/pci/ctxfi/ctatc.c: fix error
	return code
Date: Sun, 23 Nov 2014 22:45:05 +0530
Message-ID: <20141123171505.GA8265@sudip-PC>
References: <1416746890-22719-1-git-send-email-Julia.Lawall@lip6.fr>
 <1416746890-22719-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D2E32604BC
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 18:15:19 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id et14so8083400pad.31
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 09:15:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416746890-22719-6-git-send-email-Julia.Lawall@lip6.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 23, 2014 at 01:48:06PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Initialize err before returning on failure, as done elsewhere in the
> function.
<snip>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  sound/pci/ctxfi/ctatc.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
> index 58b235c..a2f997a 100644
> --- a/sound/pci/ctxfi/ctatc.c
> +++ b/sound/pci/ctxfi/ctatc.c
> @@ -1725,8 +1725,10 @@ int __devinit ct_atc_create(struct snd_card *card, struct pci_dev *pci,
>  	atc_connect_resources(atc);
>  
>  	atc->timer = ct_timer_new(atc);
> -	if (!atc->timer)
> +	if (!atc->timer) {
> +		err = -ENOMEM;
>  		goto error1;
> +	}
>  
>  	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, atc, &ops);
>  	if (err < 0)
> 
just a small doubt..
looks like this patch you have already sent on 19 Aug 2012 and has been already applied via 4d8ce1c9966663bad69e738952179f3cc52710bf

or am i missing something?

sudip


> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
