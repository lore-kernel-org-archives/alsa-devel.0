From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: bclk should never greater
 than 1/5 IPG clock rate
Date: Fri, 11 Dec 2015 22:05:43 -0800
Message-ID: <20151212060542.GA38351@Asurada-CZ80>
References: <1449745370-18960-1-git-send-email-zidan.wang@freescale.com>
 <1449745370-18960-3-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1167D2654BE
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 07:05:50 +0100 (CET)
Received: by obber4 with SMTP id er4so15349941obb.3
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 22:05:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449745370-18960-3-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 10, 2015 at 07:02:50PM +0800, Zidan Wang wrote:
> According to the referance menual, the bclk rate must be never greater
> than 1/5 IPG clock rate. But clkrate is the system clock, afreq is the
> bit clock.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

There's already a similar fix under review.

Thanks
Nicolin

> ---
>  sound/soc/fsl/fsl_ssi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index e3abad5..4466bcb 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -677,16 +677,16 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  		else
>  			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
>  
> +		clkrate /= factor;
> +		afreq = clkrate / (i + 1);
> +
>  		/*
>  		 * Hardware limitation: The bclk rate must be
>  		 * never greater than 1/5 IPG clock rate
>  		 */
> -		if (clkrate * 5 > clk_get_rate(ssi_private->clk))
> +		if (afreq * 5 > clk_get_rate(ssi_private->clk))
>  			continue;
>  
> -		clkrate /= factor;
> -		afreq = clkrate / (i + 1);
> -
>  		if (freq == afreq)
>  			sub = 0;
>  		else if (freq / afreq == 1)
> -- 
> 1.9.1
> 
