From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 02/10] ASoC: Intel: Skylake: Add entry in
 sst_acpi_mach for HDA codecs
Date: Fri, 1 Dec 2017 12:15:44 -0600
Message-ID: <ac3f61b8-f9ef-91f3-1e4d-36d88d14d6a0@linux.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-3-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id F1B45267044
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 19:15:49 +0100 (CET)
In-Reply-To: <1512119648-2700-3-git-send-email-rakesh.a.ughreja@intel.com>
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
To: Rakesh Ughreja <rakesh.a.ughreja@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
> When no I2S based codecs are detected in the BIOS, check if there are
> any HDA codecs present. If yes, load the corresponding machine driver.

Is this completely correct?
I may be splitting hair but I believe it's possible to have an HDAudio 
codec connected to some pins and an I2S/PDM device on non-conflicting 
pins. The PDM case is very real and isn't related to I2S

You may also want to explain that you *have* to look for non-HDaudio 
stuff first, because otherwise the iDisp codec will be detected but that 
is not sufficient to load the HDaudio machine driver (could be 
iDisp+I2S+PDM)

> 
> TODO:
> support for detecting the presence of HDA codec is not implemented.
> it will be implemented in the next revision.
> 
> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> ---
>   sound/soc/intel/skylake/skl.c | 46 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 27462c0..568a285 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -424,6 +424,26 @@ static int skl_free(struct hdac_bus *bus)
>   	return 0;
>   }
>   
> +static struct snd_soc_acpi_mach *skl_probe_hda_machine(
> +					struct snd_soc_acpi_mach *machines)
> +{
> +
> +	struct snd_soc_acpi_mach *mach;
> +
> +	/*
> +	 * FIXME:
> +	 * First check if there are any HDA codecs present on the system
> +	 * then search the match table.
> +	 * For now this function is not detecting the presence of any
> +	 * HDA codecs.

D'oh. so how was this patchset tested then?

> +	 */
> +	for (mach = machines; mach->id[0]; mach++) {
> +		if (!strcmp(mach->id, "HDA_GEN"))

Do you mean to say this was a temporary hack assuming a modified DSDT to 
force the detection of the codec?

And while I am at it in the hair-splitting department, in theory HDAudio 
can work with multiple codecs (each using its own SDI line), did you 
think of this case and how would it impact the machine driver selection?

> +			return mach;
> +	}
> +	return NULL;
> +}
> +
>   static int skl_machine_device_register(struct skl *skl, void *driver_data)
>   {
>   	struct hdac_bus *bus = skl_to_bus(skl);
> @@ -433,9 +453,14 @@ static int skl_machine_device_register(struct skl *skl, void *driver_data)
>   
>   	mach = snd_soc_acpi_find_machine(mach);
>   	if (mach == NULL) {
> -		dev_err(bus->dev, "No matching machine driver found\n");
> -		return -ENODEV;
> +		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
> +		mach = skl_probe_hda_machine(driver_data);
> +		if (mach == NULL) {
> +			dev_err(bus->dev, "No matching machine driver found\n");
> +			return -ENODEV;
> +		}
>   	}
> +
>   	skl->fw_name = mach->fw_filename;
>   
>   	pdev = platform_device_alloc(mach->drv_name, -1);
> @@ -911,6 +936,14 @@ static struct snd_soc_acpi_mach sst_skl_devdata[] = {
>   		.quirk_data = &skl_codecs,
>   		.pdata = &skl_dmic_data
>   	},
> +	{
> +		.id = "HDA_GEN",
> +		.drv_name = "skl_hda_generic",
> +		.fw_filename = "intel/dsp_fw_release.bin",
> +		.machine_quirk = NULL,
> +		.quirk_data = NULL,
> +		.pdata = NULL
> +	},
>   	{}
>   };
>   
> @@ -973,7 +1006,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
>   		.drv_name = "kbl_rt5663",
>   		.fw_filename = "intel/dsp_fw_kbl.bin",
>   	},
> -
> +	{
> +		.id = "HDA_GEN",
> +		.drv_name = "skl_hda_generic",
> +		.fw_filename = "intel/dsp_fw_kbl.bin",
> +		.machine_quirk = NULL,
> +		.quirk_data = NULL,
> +		.pdata = NULL
> +	},
>   	{}
>   };
>   
> 
