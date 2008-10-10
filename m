From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Fri, 10 Oct 2008 19:53:13 +0100
Message-ID: <20081010185312.GA10766@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 464F924348
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 20:53:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 10, 2008 at 06:15:17PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> However, there seems to be some problem with PM, occasionally ASoC is
> stuck with Standby mode (looking at dapm_widgets) when I start the
> playback. Restarting the player brings the sound back. I'll carry out
> some further investigation and get back to this.

How does this compare with the behaviour of the original at32 machine
support - did that have similar issues?

> The SSC peripheral clock was disabled more often than it was enabled,
> and that catched the bug trap in arch/arm/mach-at91/clock.c. I'm not
> sure if this was the real problem, but it's the way I managed to solve
> it.

Looks reasonable to me.

> diff -uprN a/sound/soc/atmel/atmel_ssc_dai.c
> b/sound/soc/atmel/atmel_ssc_dai.c
> --- a/sound/soc/atmel/atmel_ssc_dai.c   2008-10-10 17:23:46.000000000
> +0300
> +++ b/sound/soc/atmel/atmel_ssc_dai.c   2008-10-10 17:26:06.000000000
> +0300
> @@ -261,11 +261,11 @@ static void atmel_ssc_shutdown(struct sn
>         spin_lock_irq(&ssc_p->lock);
>         ssc_p->dir_mask &= ~dir_mask;
>         if (!ssc_p->dir_mask) {
> -               /* Shutdown the SSC clock. */
> -               pr_debug("atmel_ssc_dau: Stopping clock\n");
> -               clk_disable(ssc_p->ssc->clk);
> -
>                 if (ssc_p->initialized) {
> +                       /* Shutdown the SSC clock. */
> +                       pr_debug("atmel_ssc_dai: Stopping clock\n");
> +                       clk_disable(ssc_p->ssc->clk);
> +
>                         free_irq(ssc_p->ssc->irq, ssc_p);
>                         ssc_p->initialized = 0;
>                 }
