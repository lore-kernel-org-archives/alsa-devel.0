From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v1 2/9] ASoC: Intel: Skylake: Add entry in
 sst_acpi_mach for HDA codecs
Date: Fri, 23 Feb 2018 10:42:33 -0600
Message-ID: <9f6781f5-d581-3ee9-c89c-c695e28bb4fb@linux.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-3-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id C1728267902
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 17:42:36 +0100 (CET)
In-Reply-To: <1519373550-2545-3-git-send-email-rakesh.a.ughreja@intel.com>
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

On 2/23/18 2:12 AM, Rakesh Ughreja wrote:
> When no I2S based codec entries are found in the BIOS, check if there are
> any HDA codecs detected on the bus. If there are two (i.e. iDisp + HDA)
> HDA codecs found on the bus, load the HDA machine driver.

What if you have a headless device with no codec, that means no HDMI 
support? Why is this restriction necessary?

> 
> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
> ---
>   sound/soc/intel/skylake/skl.c | 59 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index f948f29..ac64416 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -442,6 +442,24 @@ static struct skl_ssp_clk skl_ssp_clks[] = {
>   						{.name = "ssp5_sclkfs"},
>   };
>   
> +static struct snd_soc_acpi_mach *skl_find_hda_machine(struct skl *skl,
> +					struct snd_soc_acpi_mach *machines)
> +{
> +
> +	struct snd_soc_acpi_mach *mach;
> +	struct hdac_bus *bus = skl_to_bus(skl);
> +
> +	/* check if we have two HDA codecs */
> +	if (hweight_long(bus->codec_mask) != 2)
> +		return NULL;
> +
> +	for (mach = machines; mach->id[0]; mach++) {
> +		if (!strcmp(mach->id, "HDA_GEN"))
> +			return mach;
> +	}

that's not really testing if there are actual HDaudio devices, is this 
loop just there to point to a firmware file?

> +	return NULL;
> +}
> +
>   static int skl_find_machine(struct skl *skl, void *driver_data)
>   {
>   	struct hdac_bus *bus = skl_to_bus(skl);
> @@ -450,8 +468,12 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
>   
>   	mach = snd_soc_acpi_find_machine(mach);
>   	if (mach == NULL) {
> -		dev_err(bus->dev, "No matching machine driver found\n");
> -		return -ENODEV;
> +		dev_dbg(bus->dev, "No matching I2S machine driver found\n");
> +		mach = skl_find_hda_machine(skl, driver_data);
> +		if (mach == NULL) {
> +			dev_err(bus->dev, "No matching machine driver found\n");
> +			return -ENODEV;
> +		}
>   	}
>   
>   	skl->mach = mach;
> @@ -466,8 +488,9 @@ static int skl_find_machine(struct skl *skl, void *driver_data)
>   
>   static int skl_machine_device_register(struct skl *skl)
>   {
> -	struct hdac_bus *bus = skl_to_bus(skl);
>   	struct snd_soc_acpi_mach *mach = skl->mach;
> +	struct hdac_bus *bus = skl_to_bus(skl);
> +	struct skl_machine_pdata *pdata;
>   	struct platform_device *pdev;
>   	int ret;
>   
> @@ -484,8 +507,11 @@ static int skl_machine_device_register(struct skl *skl)
>   		return -EIO;
>   	}
>   
> -	if (mach->pdata)
> +	if (mach->pdata) {
> +		pdata = (struct skl_machine_pdata *)mach->pdata;
> +		pdata->platform = dev_name(bus->dev);
>   		dev_set_drvdata(&pdev->dev, mach->pdata);
> +	}
>   
>   	skl->i2s_dev = pdev;
>   
> @@ -1030,6 +1056,14 @@ static struct snd_soc_acpi_mach sst_skl_devdata[] = {
>   		.quirk_data = &skl_codecs,
>   		.pdata = &skl_dmic_data
>   	},
> +	{
> +		.id = "HDA_GEN",
> +		.drv_name = "skl_hda_generic",
> +		.fw_filename = "intel/dsp_fw_release.bin",
> +		.machine_quirk = NULL,
> +		.quirk_data = NULL,
> +		.pdata = &cnl_pdata,

this is odd, the cnl_pdata says the topology_pcm is used, I thought this 
was not applicable for SKL/KBL. Or put differently, why is this used for 
the hda case only?

> +	},
>   	{}
>   };
>   
> @@ -1046,6 +1080,14 @@ static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
>   		.machine_quirk = snd_soc_acpi_codec_list,
>   		.quirk_data = &bxt_codecs,
>   	},
> +	{
> +		.id = "HDA_GEN",
> +		.drv_name = "skl_hda_generic",
> +		.fw_filename = "intel/dsp_fw_bxtn.bin",
> +		.machine_quirk = NULL,
> +		.quirk_data = NULL,
> +		.pdata = &cnl_pdata,
> +	},
>   	{}
>   };
>   
> @@ -1100,7 +1142,14 @@ static struct snd_soc_acpi_mach sst_kbl_devdata[] = {
>   		.quirk_data = &kbl_7219_98357_codecs,
>   		.pdata = &skl_dmic_data
>   	},
> -
> +	{
> +		.id = "HDA_GEN",
> +		.drv_name = "skl_hda_generic",
> +		.fw_filename = "intel/dsp_fw_kbl.bin",
> +		.machine_quirk = NULL,
> +		.quirk_data = NULL,
> +		.pdata = &cnl_pdata,
> +	},
>   	{}
>   };
>   
> 
