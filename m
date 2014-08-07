From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] MAINTAINERS: Add i.MX maintainers and
 paths to Freescale ASoC entry
Date: Thu, 7 Aug 2014 18:45:34 +0800
Message-ID: <20140807104533.GA3295@MrMyself>
References: <1407404939-14950-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 by alsa0.perex.cz (Postfix) with ESMTP id BEF2C2650E1
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 13:02:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1407404939-14950-1-git-send-email-broonie@kernel.org>
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
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2014 at 10:48:59AM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> There's several new i.MX specific controllers, try to help make sure they
> get reviewed by the people working on them.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
> 
> Is this OK wiht everyone?
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e0d24dcb122..2078bd3232a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3835,10 +3835,13 @@ F:	drivers/tty/serial/ucc_uart.c
>  
>  FREESCALE SOC SOUND DRIVERS
>  M:	Timur Tabi <timur@tabi.org>
> +M:	Nicolin Chen <Guangyu.Chen@freescale.com>

Although this change hasn't been decided yet, may I ask for a mail address
update with my Gmail which I set for mail list usage only?

<nicoleotsuka@gmail.com>

Thank you
Nicolin

> +M:	Xiubo Li <Li.Xiubo@freescale.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Maintained
>  F:	sound/soc/fsl/fsl*
> +F:	sound/soc/fsl/imx*
>  F:	sound/soc/fsl/mpc8610_hpcd.c
>  
>  FREEVXFS FILESYSTEM
> -- 
> 2.0.1
> 
