From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 1/4] ASoC: Intel: common: Replace custom
 implementation of readq / writeq
Date: Mon, 6 Feb 2017 22:33:54 +0530
Message-ID: <20170206170353.GE19244@localhost>
References: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id CE79B2654AD
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 18:03:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170131141425.35482-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 31, 2017 at 04:14:22PM +0200, Andy Shevchenko wrote:
> The readq() and writeq() helpers are available in the
> linux/io-64-nonatomic-hi-lo.h and linux/io-64-nonatomic-lo-hi.h headers.
> 
> Replace custom implementation by the generic helpers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/common/sst-dsp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
> index 11c0805393ff..748f1f5c02df 100644
> --- a/sound/soc/intel/common/sst-dsp.c
> +++ b/sound/soc/intel/common/sst-dsp.c
> @@ -22,6 +22,8 @@
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +
>  #include "sst-dsp.h"
>  #include "sst-dsp-priv.h"
>  
> @@ -43,16 +45,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);
>  
>  void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
>  {
> -	memcpy_toio(addr + offset, &value, sizeof(value));
> +	lo_hi_writeq(value, addr + offset);

why not use writeq here and for 32bit this becomes lo_hi_writeq(), or did I
miss something here..

>  }
>  EXPORT_SYMBOL_GPL(sst_shim32_write64);
>  
>  u64 sst_shim32_read64(void __iomem *addr, u32 offset)
>  {
> -	u64 val;
> -
> -	memcpy_fromio(&val, addr + offset, sizeof(val));
> -	return val;
> +	return lo_hi_readq(addr + offset);
>  }
>  EXPORT_SYMBOL_GPL(sst_shim32_read64);
>  
> -- 
> 2.11.0
> 

-- 
~Vinod
