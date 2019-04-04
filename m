From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on
	arm64
Date: Thu, 4 Apr 2019 14:22:22 +0530
Message-ID: <ed49c2d9-dba1-1de6-0178-651f6567e3c3@codeaurora.org>
References: <20190404081221.341-1-jank@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38F92F8968A
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 10:52:32 +0200 (CEST)
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jan Kotas <jank@cadence.com>, vkoul@kernel.org, sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 4/4/2019 1:42 PM, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
>
> readl and writel are undefined.
> This patch fixes that by including io.h.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/soundwire/cadence_master.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index cb6a331f4..0b5bcc209 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -9,6 +9,7 @@
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
> +#include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/soundwire/sdw_registers.h>
