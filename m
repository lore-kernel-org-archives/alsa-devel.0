From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Date: Tue, 3 Apr 2018 15:45:40 +0200
Message-ID: <20180403134540.GA29017@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 346482670D5
 for <alsa-devel@alsa-project.org>; Tue,  3 Apr 2018 15:45:41 +0200 (CEST)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993603AbeDCNplRm40Y (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Tue, 3 Apr 2018 15:45:41 +0200
Content-Disposition: inline
In-Reply-To: <20180330154420.6903-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>

Hello Colin,

> Trivial fix to spelling mistake in pr_debug message text

would you mind making this patch a bit less non-trivial and
change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?

Thank you.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..1c7af0ca98ec 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  		if (ret < 0) {
>  			printk(KERN_WARNING
>  					"atmel_ssc_dai: request_irq failure\n");
> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
> +			pr_debug("Atmel_ssc_dai: Stopping clock\n");
>  			clk_disable(ssc_p->ssc->clk);
>  			return ret;
>  		}
> -- 
> 2.15.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
