From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/8] soundwire: mipi_disco: expose sdw_slave_read_dpn as
 symbol
Date: Tue, 7 May 2019 18:00:11 +0530
Message-ID: <20190507123011.GP16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
> sdw_slave_read_dpn was so far a static function, which prevented
> codec drivers from using it. Expose as non-static function and add symbol
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/mipi_disco.c | 7 ++++---
>  include/linux/soundwire/sdw.h  | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index 6df68584c963..4995554bd6b6 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -161,9 +161,9 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
>  	return 0;
>  }
>  
> -static int sdw_slave_read_dpn(struct sdw_slave *slave,
> -			      struct sdw_dpn_prop *dpn, int count, int ports,
> -			      char *type)
> +int sdw_slave_read_dpn(struct sdw_slave *slave,
> +		       struct sdw_dpn_prop *dpn, int count, int ports,
> +		       char *type)
>  {
>  	struct fwnode_handle *node;
>  	u32 bit, i = 0;
> @@ -283,6 +283,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(sdw_slave_read_dpn);

Fine to export but would be great to accompany user with it. In
general do not add a API without user.

-- 
~Vinod
