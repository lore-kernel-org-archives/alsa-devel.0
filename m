From: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 08:47:36 -0600
Message-ID: <E1J5MgT-0008HO-13@jdl.com>
References: <11981089894052-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: Your message of "Wed, 19 Dec 2007 18:03:09 CST."
	<11981089894052-git-send-email-timur@freescale.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So, like, the other day Timur Tabi mumbled:
> diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpc
> d.c
> index 6390895..6e1bde3 100644
> --- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -34,9 +34,27 @@
>  
>  #include <asm/mpic.h>
>  
> +#include <asm/of_platform.h>
>  #include <sysdev/fsl_pci.h>
>  #include <sysdev/fsl_soc.h>


Please dont' re-introduce these.  I just submitted patches to
move all of the PowerPC instances to using <linux/of_platform.h>



> diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
> new file mode 100644
> index 0000000..5421a5c
> --- /dev/null
> +++ b/sound/soc/fsl/mpc8610_hpcd.c
> @@ -0,0 +1,621 @@
> +/**
> + * Freescale MPC8610HPCD ALSA SoC Fabric driver
> + *
> + * Author: Timur Tabi <timur@freescale.com>
> + *
> + * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/version.h>
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>

Again, this should be moved up as <linux/of_platform.h>.


Thanks,
jdl
