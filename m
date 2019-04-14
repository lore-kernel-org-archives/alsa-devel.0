From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on arm64
Date: Sun, 14 Apr 2019 15:14:08 +0530
Message-ID: <20190414094408.GF28103@vkoul-mobl>
References: <20190404081221.341-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kotas <jank@cadence.com>
Cc: sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04-04-19, 09:12, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
> 
> readl and writel are undefined.
> This patch fixes that by including io.h.

And I cant verify that without hacking kconfig to force compile the lib.

> 
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---
>  drivers/soundwire/cadence_master.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index cb6a331f4..0b5bcc209 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>

Why not add asm/io.h which is the header that actually defines
readl/writel?

>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/soundwire/sdw_registers.h>
> -- 
> 2.15.0

-- 
~Vinod
