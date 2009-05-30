From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 1/6] ARM: DaVinci: ASoC: Adds McASP
	clock support for TI DM646X processor
Date: Fri, 29 May 2009 17:19:41 -0700
Message-ID: <87ljofsaqq.fsf@deeprootsystems.com>
References: <1243501761-28420-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DB8324716
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 02:19:45 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so2031581wfg.23
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2009 17:19:44 -0700 (PDT)
In-Reply-To: <1243501761-28420-1-git-send-email-chaithrika@ti.com> (Chaithrika
	U. S.'s message of "Thu\, 28 May 2009 05\:09\:21 -0400")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Chaithrika U S <chaithrika@ti.com> writes:

> Adds McASP clock support for the two instances of mcasp (mcasp0,mcasp1). This
> patch is part of the audio support for dm646x series.
>
> Signed-off-by: Naresh Medisetty <naresh@ti.com>
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
> This patch applies to the DaVinci git tree available at
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

Thanks, pushing to DaVinci git today.

Kevin

>  arch/arm/mach-davinci/dm646x.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
> index f95b5e9..07c8d88 100644
> --- a/arch/arm/mach-davinci/dm646x.c
> +++ b/arch/arm/mach-davinci/dm646x.c
> @@ -227,6 +227,18 @@ static struct clk gpio_clk = {
>  	.lpsc = DM646X_LPSC_GPIO,
>  };
>  
> +static struct clk mcasp0_clk = {
> +	.name = "mcasp0",
> +	.parent = &pll1_sysclk3,
> +	.lpsc = DM646X_LPSC_McASP0,
> +};
> +
> +static struct clk mcasp1_clk = {
> +	.name = "mcasp1",
> +	.parent = &pll1_sysclk3,
> +	.lpsc = DM646X_LPSC_McASP1,
> +};
> +
>  static struct clk aemif_clk = {
>  	.name = "aemif",
>  	.parent = &pll1_sysclk3,
> @@ -314,6 +326,8 @@ struct davinci_clk dm646x_clks[] = {
>  	CLK(NULL, "uart2", &uart2_clk),
>  	CLK("i2c_davinci.1", NULL, &i2c_clk),
>  	CLK(NULL, "gpio", &gpio_clk),
> +	CLK(NULL, "mcasp0", &mcasp0_clk),
> +	CLK(NULL, "mcasp1", &mcasp1_clk),
>  	CLK(NULL, "aemif", &aemif_clk),
>  	CLK("davinci_emac.1", NULL, &emac_clk),
>  	CLK(NULL, "pwm0", &pwm0_clk),
> -- 
> 1.5.6
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
