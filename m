From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
Date: Fri, 30 Aug 2019 11:56:21 -0700
Message-ID: <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
References: <20190830185212.25144-1-msuchanek@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830185212.25144-1-msuchanek@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Suchanek <msuchanek@suse.de>, alsa-devel@alsa-project.org
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 8/30/19 11:52 AM, Michal Suchanek wrote:
> Fixes the following warning on !ACPI systems:
> 
> drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> not used [-Wunused-function]
>  static int sdw_slave_add(struct sdw_bus *bus,
>             ^~~~~~~~~~~~~
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

I was about to send the same patch.
Thanks.

> ---
>  drivers/soundwire/slave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..34c7e65831d1 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -6,6 +6,7 @@
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
>  
> +#if IS_ENABLED(CONFIG_ACPI)
>  static void sdw_slave_release(struct device *dev)
>  {
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> @@ -60,7 +61,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	return ret;
>  }
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> 


-- 
~Randy
