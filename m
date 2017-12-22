From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH][next] soundwire: intel: fix missing
	assignment to ret
Date: Fri, 22 Dec 2017 09:01:49 +0530
Message-ID: <20171222033148.GN18649@localhost>
References: <20171221233210.8821-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B250A266D61
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 04:27:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171221233210.8821-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin King <colin.king@canonical.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 21, 2017 at 11:32:10PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return status ret is being checked but it has not been
> updated since the previous check on ret. It appears that assignment of
> ret from return status of the call to sdw_cdns_enable_interrupt was
> accidentally ommited.  Fix this.

Thanks Colin, this looks good to me.

Greg, we have this and another patch from Colin, both lgtm.

Would you like me to collect these and send to you before merge cycle or
apply directly?

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
