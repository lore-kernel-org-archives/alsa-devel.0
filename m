From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in
	pr_debug.
Date: Fri, 17 Oct 2014 09:18:00 +0800
Message-ID: <54406E48.3080006@atmel.com>
References: <6f13dfe392b146a4a8ea07115265d551@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0254126063A
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 03:18:08 +0200 (CEST)
In-Reply-To: <6f13dfe392b146a4a8ea07115265d551@EMAIL.axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Peter,
   Thanks.

   Add Mark Brown into list

On 10/16/2014 11:43 PM, Peter Rosin wrote:
>  From 64e0a6c2fe731eb24c81c7c56a3cacdda3d51610 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Date: Thu, 16 Oct 2014 17:22:05 +0200
> Subject: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in pr_debug.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Bo Shen <voice.shen@atmel.com>

> ---
>   sound/soc/atmel/atmel_ssc_dai.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index f403f39..775a2ba 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -267,7 +267,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>   	if (!ssc_p->dir_mask) {
>   		if (ssc_p->initialized) {
>   			/* Shutdown the SSC clock. */
> -			pr_debug("atmel_ssc_dau: Stopping clock\n");
> +			pr_debug("atmel_ssc_dai: Stopping clock\n");
>   			clk_disable(ssc_p->ssc->clk);
>
>   			free_irq(ssc_p->ssc->irq, ssc_p);
>

Best Regards,
Bo Shen
