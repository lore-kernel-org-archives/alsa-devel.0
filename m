From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in
 pr_debug.
Date: Fri, 17 Oct 2014 10:22:57 +0200
Message-ID: <20141017082257.GB32723@piout.net>
References: <6f13dfe392b146a4a8ea07115265d551@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id E31A52614D4
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 10:22:59 +0200 (CEST)
Content-Disposition: inline
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
To: Peter Rosin <peda@axentia.se>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 16/10/2014 at 15:43:40 +0000, Peter Rosin wrote :
> From 64e0a6c2fe731eb24c81c7c56a3cacdda3d51610 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> Date: Thu, 16 Oct 2014 17:22:05 +0200
> Subject: [PATCH] ASoC: atmel_ssc_dai: Fix spelling in pr_debug.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index f403f39..775a2ba 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -267,7 +267,7 @@ static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>  	if (!ssc_p->dir_mask) {
>  		if (ssc_p->initialized) {
>  			/* Shutdown the SSC clock. */
> -			pr_debug("atmel_ssc_dau: Stopping clock\n");
> +			pr_debug("atmel_ssc_dai: Stopping clock\n");

Maybe you could switch the whole file to pr_fmt or use __func__.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
