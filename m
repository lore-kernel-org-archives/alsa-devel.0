From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: atom: Add sysfs entry in
 order to store FW version
Date: Tue, 8 Nov 2016 02:32:42 +0530
Message-ID: <20161107210241.GP3000@localhost>
References: <20161104080411.12410-1-sebastien.guiriec@intel.com>
 <20161104080411.12410-3-sebastien.guiriec@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 69487266E61
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2016 21:53:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161104080411.12410-3-sebastien.guiriec@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vind.koul@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 04, 2016 at 09:04:11AM +0100, Sebastien Guiriec wrote:
> This patch is adding a sysfs entry in order to be able to get
> access to SST FW version.
> 
> Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
> ---
>  sound/soc/intel/atom/sst/sst.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
> index a4b458e..dabbd06 100644
> --- a/sound/soc/intel/atom/sst/sst.c
> +++ b/sound/soc/intel/atom/sst/sst.c
> @@ -27,6 +27,7 @@
>  #include <linux/pm_qos.h>
>  #include <linux/async.h>
>  #include <linux/acpi.h>
> +#include <linux/sysfs.h>
>  #include <sound/core.h>
>  #include <sound/soc.h>
>  #include <asm/platform_sst_audio.h>
> @@ -241,6 +242,28 @@ int sst_alloc_drv_context(struct intel_sst_drv **ctx,
>  }
>  EXPORT_SYMBOL_GPL(sst_alloc_drv_context);
>  
> +static ssize_t firmware_version_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "v%02x.%02x.%02x.%02x\n",
> +			ctx->fw_version.type, ctx->fw_version.major,
> +			ctx->fw_version.minor, ctx->fw_version.build);

we should do this only after FW load, can you add that bit please. ALso
check we dont leak kernel memory when this is not set

-- 
~Vinod
