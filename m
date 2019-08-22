From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC: Intel: Haswell: Adjust machine
 device private context
Date: Thu, 22 Aug 2019 09:07:36 -0500
Message-ID: <dbde72dc-9b41-f1a8-001a-5674f5af3b61@linux.intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
 <20190822113616.22702-2-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1EE77F80112
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 16:07:39 +0200 (CEST)
In-Reply-To: <20190822113616.22702-2-cezary.rojewski@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 8/22/19 6:36 AM, Cezary Rojewski wrote:
> Apart from Haswell machines, all other devices have their private data
> set to snd_soc_acpi_mach instance.
> 
> Changes for HSW/ BDW boards introduced with series:
> https://patchwork.kernel.org/cover/10782035/
> 
> added support for dai_link platform_name adjustments within card probe
> routines. These take for granted private_data points to
> snd_soc_acpi_mach whereas for Haswell, it's sst_pdata instead. Change
> private context of platform_device - representing machine board - to
> address this.

Cezary, see the comments of the initial series:

"Note that byt-max98080, byt-rt5640 were not modified since they are
deprecated. bytcht-nocodec and the Skylake/Kabylake machine drivers
changes were not changed since SOF does not support them. There may be
additional changes if and when Skylake/Kabylake are supported by SOF
(largely a firmware authentication issue, not technical difficulty)."

I intentionally did not touch the Haswell and Baytrail legacy since both 
drivers do not update the platform name, this is only done for cases 
where SOF is used.

So while I don't mind a change, it's got to come with tests for each 
variant, and if you do the changes for Haswell then you want to change 
Baytrail legacy machine drivers as well. And are we going to change the 
SKL/KBL machine drivers to allow for this platform name rewrite?

Also the information below is misleading: nothing is broken in the 
current solution and -stable kernels do not need to pick this patchset. 
This is a code alignment and the behavior is identical.

Or as an alternative we leave the code as is...

> Fixes: e87055d732e3 ("ASoC: Intel: haswell: platform name fixup support")
> Fixes: 7e40ddcf974a ("ASoC: Intel: bdw-rt5677: platform name fixup support")
> Fixes: 2d067b2807f9 ("ASoC: Intel: broadwell: platform name fixup support")
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
> ---
>   sound/soc/intel/common/sst-acpi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
> index 15f2b27e643f..c34f628c7987 100644
> --- a/sound/soc/intel/common/sst-acpi.c
> +++ b/sound/soc/intel/common/sst-acpi.c
> @@ -109,11 +109,12 @@ int sst_acpi_probe(struct platform_device *pdev)
>   	}
>   
>   	platform_set_drvdata(pdev, sst_acpi);
> +	mach->pdata = sst_pdata;
>   
>   	/* register machine driver */
>   	sst_acpi->pdev_mach =
>   		platform_device_register_data(dev, mach->drv_name, -1,
> -					      sst_pdata, sizeof(*sst_pdata));
> +					      mach, sizeof(*mach));
>   	if (IS_ERR(sst_acpi->pdev_mach))
>   		return PTR_ERR(sst_acpi->pdev_mach);
>   
> 
