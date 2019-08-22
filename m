From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel: remove unused variables
Date: Thu, 22 Aug 2019 08:38:57 -0500
Message-ID: <05406f83-a799-2110-cf51-c289ae838065@linux.intel.com>
References: <20190822062555.30216-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6638AF80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 15:39:01 +0200 (CEST)
In-Reply-To: <20190822062555.30216-1-vkoul@kernel.org>
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
To: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On 8/22/19 1:25 AM, Vinod Koul wrote:
> Variables 'nval' and 'i' are no longer used sdw_master_read_intel_prop()
> so remove them.
> 
> drivers/soundwire/intel.c: In function 'sdw_master_read_intel_prop':
> drivers/soundwire/intel.c:829:12: warning: unused variable 'i' [-Wunused-variable]
>    int nval, i;
>              ^
> drivers/soundwire/intel.c:829:6: warning: unused variable 'nval' [-Wunused-variable]
>    int nval, i;
>        ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 085f4ace103d ("soundwire: intel: read mclk_freq property from firmware")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

This was fixed in the followup patch to disable hw links:

-	int nval, i;
+	u32 quirk_mask;

which wasn't applied because debugsfs didn't apply, and debugfs didn't 
apply because of discrepancies between soundwire/fixes and soundwire/next...
I realize these variables were removed in the wrong patch but I would 
appreciate it if we could just avoid creating more conflicts for minor 
changes. Thank you.

> ---
>   drivers/soundwire/intel.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 459cc1e6355d..cad378f741c0 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -826,7 +826,6 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>   	struct sdw_master_prop *prop = &bus->prop;
>   	struct fwnode_handle *link;
>   	char name[32];
> -	int nval, i;
>   
>   	/* Find master handle */
>   	snprintf(name, sizeof(name),
> 
