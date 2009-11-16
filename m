From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 4/7] S3C64XX PCM: Added PCLK clock source
	for the PCM	controllers
Date: Mon, 16 Nov 2009 10:48:15 +0000
Message-ID: <20091116104814.GV23772@trinity.fluff.org>
References: <1257914715-4477-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FB341038A1
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 11:48:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257914715-4477-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 11, 2009 at 01:45:15PM +0900, Jassi Brar wrote:
> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

again, this should have gone to the linux-arm-kernel list.

will merge to my tree.

> ---
>  arch/arm/plat-s3c64xx/clock.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
> index 7a36e89..3ab564e 100644
> --- a/arch/arm/plat-s3c64xx/clock.c
> +++ b/arch/arm/plat-s3c64xx/clock.c
> @@ -129,6 +129,18 @@ static struct clk init_clocks_disable[] = {
>  		.enable		= s3c64xx_pclk_ctrl,
>  		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
>  	}, {
> +		.name		= "pcm",
> +		.id		= 0,
> +		.parent		= &clk_p,
> +		.enable		= s3c64xx_pclk_ctrl,
> +		.ctrlbit	= S3C_CLKCON_PCLK_PCM0,
> +	}, {
> +		.name		= "pcm",
> +		.id		= 1,
> +		.parent		= &clk_p,
> +		.enable		= s3c64xx_pclk_ctrl,
> +		.ctrlbit	= S3C_CLKCON_PCLK_PCM1,
> +	}, {
>  		.name		= "spi",
>  		.id		= 0,
>  		.parent		= &clk_p,
> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
