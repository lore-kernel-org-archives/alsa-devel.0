From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5] ASoC/ARM: Davinci: McASP: split asp header into
	platform and audio specific
Date: Fri, 17 Aug 2012 23:43:44 +0530
Message-ID: <502E89D8.2090304@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
	<1344948125-5649-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1344948125-5649-2-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Gururaja,

On 8/14/2012 6:12 PM, Hebbar, Gururaja wrote:
> Davinci McASP header & driver are shared by few OMAP platforms (like
> TI81xx, AM335x). Splitting asp header into Davinci platform specific
> header and Audio specific header helps to share them across platforms.
> 
> Audio specific defines is moved to to common
> <linux/platform_data/davinci_asp.h> so that the header can be
> accessed by all related platforms.
> 
> While here, correct the header usage (remove multiple header
> re-definitions and unused headers) and remove platform names from
> structures comments and enum
> 
> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> Acked-by: Vaibhav Bedia <vaibhav.bedia-l0cyMroinI0@public.gmane.org>

This patch looks good to me. See a minor nit below.

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

> diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
> new file mode 100644
> index 0000000..8fd5238
> --- /dev/null
> +++ b/arch/arm/mach-davinci/asp.h
> @@ -0,0 +1,49 @@
> +/*
> + * TI DaVinci Audio definitions
> + */
> +#ifndef __ASM_ARCH_DAVINCI_ASP_H
> +#define __ASM_ARCH_DAVINCI_ASP_H
> +
> +/* Bases of dm644x and dm355 register banks */
> +#define DAVINCI_ASP0_BASE	0x01E02000
> +#define DAVINCI_ASP1_BASE	0x01E04000
> +
> +/* Bases of dm365 register banks */
> +#define DAVINCI_DM365_ASP0_BASE	0x01D02000
> +
> +/* Bases of dm646x register banks */
> +#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
> +#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800

Can you remove usage of tabs after 'define'. I understand this is coming
from existing code.

Thanks,
Sekhar
