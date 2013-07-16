From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx: Enable COMPILE_TEST builds
Date: Tue, 16 Jul 2013 08:23:22 +0800
Message-ID: <20130716002320.GF23589@S2101-09.ap.freescale.net>
References: <1373904242-30250-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D8870260323
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 02:23:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1373904242-30250-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2013 at 05:04:02PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Since DT based boards don't have any dependency on arch/arm enable them
> if COMPILE_TEST is enabled.
> 
I do not quite follow the commit log.  I think menuconfig SND_IMX_SOC
also covers a few non-DT boards.

With IMX/MXC moved over to multiplatform build, there shouldn't be any
<mach/*> includes anyway.  That may be the reason why COMPILE_TEST
should work.

Shawn

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/fsl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index aa43854..87e28bc 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -98,7 +98,7 @@ endif # SND_POWERPC_SOC
>  
>  menuconfig SND_IMX_SOC
>  	tristate "SoC Audio for Freescale i.MX CPUs"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || COMPILE_TEST
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the i.MX CPUs.
> -- 
> 1.8.3.2
> 
