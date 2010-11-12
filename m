From: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] sound/mixart: avoid redefining {readl,write}_{le,be} accessors
Date: Fri, 12 Nov 2010 18:29:11 +0100
Message-ID: <201011121829.11914.florian@openwrt.org>
References: <201011091829.08664.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201011091829.08664.florian@openwrt.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 09 November 2010 18:29:08 Florian Fainelli wrote:
> From: Florian Fainelli <florian@openwrt.org>

Takashi, do you have any comments on this patch?

Thanks!

> 
> If the platform already provides a definition for these accessors
> do not redefine them. The warning was caught on MIPS.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/sound/pci/mixart/mixart_hwdep.h
> b/sound/pci/mixart/mixart_hwdep.h index a46f508..812e288 100644
> --- a/sound/pci/mixart/mixart_hwdep.h
> +++ b/sound/pci/mixart/mixart_hwdep.h
> @@ -25,11 +25,21 @@
> 
>  #include <sound/hwdep.h>
> 
> +#ifndef readl_be
>  #define readl_be(x) be32_to_cpu(__raw_readl(x))
> +#endif
> +
> +#ifndef writel_be
>  #define writel_be(data,addr) __raw_writel(cpu_to_be32(data),addr)
> +#endif
> 
> +#ifndef readl_le
>  #define readl_le(x) le32_to_cpu(__raw_readl(x))
> +#endif
> +
> +#ifndef writel_le
>  #define writel_le(data,addr) __raw_writel(cpu_to_le32(data),addr)
> +#endif
> 
>  #define MIXART_MEM(mgr,x)	((mgr)->mem[0].virt + (x))
>  #define MIXART_REG(mgr,x)	((mgr)->mem[1].virt + (x))
