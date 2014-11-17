From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: add missing ACPI device table
Date: Mon, 17 Nov 2014 14:24:31 +0530
Message-ID: <20141117085431.GA1983@intel.com>
References: <1416206200-26703-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CD44261522
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:53:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1416206200-26703-1-git-send-email-mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 17, 2014 at 02:36:40PM +0800, mengdong.lin@intel.com wrote:
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> The ACPI device table will generate the driver module alias for
> Intel audio devices enumerated from ACPI.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

> 
> diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
> index 2b1c5d9..b261821 100644
> --- a/sound/soc/intel/sst/sst_acpi.c
> +++ b/sound/soc/intel/sst/sst_acpi.c
> @@ -342,6 +342,8 @@ static const struct acpi_device_id sst_acpi_ids[] = {
>  	{ },
>  };
>  
> +MODULE_DEVICE_TABLE(acpi, sst_acpi_ids);
> +
>  static struct platform_driver sst_acpi_driver = {
>  	.driver = {
>  		.name			= "intel_sst_acpi",
> -- 
> 1.9.1
> 

-- 
