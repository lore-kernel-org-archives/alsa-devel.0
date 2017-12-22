From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][next] soundwire: intel: fix missing assignment to ret
Date: Fri, 22 Dec 2017 18:12:40 +0530
Message-ID: <20171222124239.GX18649@localhost>
References: <20171221233210.8821-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171221233210.8821-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 21, 2017 at 11:32:10PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return status ret is being checked but it has not been
> updated since the previous check on ret. It appears that assignment of
> ret from return status of the call to sdw_cdns_enable_interrupt was
> accidentally ommited.  Fix this.

Applied, thanks

> 
> Detected by CoverityScan, CID#1463148 ("Logically dead code")
> 
> Fixes: 71bb8a1b059e ("soundwire: intel: Add Intel Master driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/soundwire/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 6a9177ea6eb9..86a7bd1fc912 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -295,7 +295,7 @@ static int intel_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> -	sdw_cdns_enable_interrupt(&sdw->cdns);
> +	ret = sdw_cdns_enable_interrupt(&sdw->cdns);
>  	if (ret)
>  		goto err_init;
>  
> -- 
> 2.14.1
> 

-- 
~Vinod
