From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] ASoC: Intel: Haswell: Adjust machine
 device private context
Date: Thu, 22 Aug 2019 10:58:29 -0500
Message-ID: <76464d4e-a129-99b8-05ab-eff755cc5a1e@linux.intel.com>
References: <20190822113616.22702-1-cezary.rojewski@intel.com>
 <20190822113616.22702-2-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9D49F800BF
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 17:58:32 +0200 (CEST)
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
> 
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

I now agree that the code I added is incorrect and probably accesses 
memory offsets that aren't right. I have absolutely no idea why I added 
this comment that 'legacy does not pass parameters' when it most 
definitively does. Good catch on your side.

That said, doesn't the proposed fix introduce another issue?

In the machine drivers, you still get pdata directly, so aren't you 
missing an indirection to get back to pdata from mach?

static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
{
	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
	struct sst_pdata *pdata = dev_get_platdata(component->dev);
	struct sst_hsw *broadwell = pdata->dsp;

<<< so here you took the wrong pointer, no?
