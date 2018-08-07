From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel: Remove duplicate
 assignment
Date: Tue, 7 Aug 2018 09:22:52 -0500
Message-ID: <56673978-fb59-ab89-c5b0-16454d6ad5c4@linux.intel.com>
References: <20180807115837.8172-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C1C267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 16:22:54 +0200 (CEST)
In-Reply-To: <20180807115837.8172-1-vkoul@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
Cc: Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On 8/7/18 6:58 AM, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/soundwire/intel.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index da7f91f1a588..c5ee97ee7886 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -845,9 +845,6 @@ static int intel_probe(struct platform_device *pdev)
>   	sdw_intel_ops.read_prop = intel_prop_read;
>   	sdw->cdns.bus.ops = &sdw_intel_ops;
>   
> -	sdw_intel_ops.read_prop = intel_prop_read;
> -	sdw->cdns.bus.ops = &sdw_intel_ops;
> -
>   	platform_set_drvdata(pdev, sdw);
>   
>   	ret = sdw_add_bus_master(&sdw->cdns.bus);
> 
