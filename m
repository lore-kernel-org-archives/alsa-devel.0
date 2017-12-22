From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][next] soundwire: fix sign extension when shifting buf[2]
 24 places
Date: Fri, 22 Dec 2017 18:12:26 +0530
Message-ID: <20171222124226.GW18649@localhost>
References: <20171221235113.9274-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171221235113.9274-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 21, 2017 at 11:51:13PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The buf[2] left shift by 24 bits is promoted to int (32 bit signed)
> and then signed-extended to unsigned long long. Hence if the upper
> bit to buf[2] is set then all the upper bits of addr end up as 1.
> Fix this by casting it to u64 before shifting it. Also replace the
> unsigned long long casts to u64 casts to match the same type of
> addr.

Applied, thanks

> 
> Detected by CoverityScan, CID#1463147 ("Unintended sign extension")
> 
> Fixes: d52d7a1be02c ("soundwire: Add Slave status handling helpers")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/soundwire/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 4c345197eb55..7211ecc62015 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -522,8 +522,8 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  		 * bits to avoid truncation due to size limit.
>  		 */
>  		addr = buf[5] | (buf[4] << 8) | (buf[3] << 16) |
> -			(buf[2] << 24) | ((unsigned long long)buf[1] << 32) |
> -			((unsigned long long)buf[0] << 40);
> +			((u64)buf[2] << 24) | ((u64)buf[1] << 32) |
> +			((u64)buf[0] << 40);
>  
>  		sdw_extract_slave_id(bus, addr, &id);
>  
> -- 
> 2.14.1
> 

-- 
~Vinod
