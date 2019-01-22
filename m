From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: Common: Enable
 kbl_da7219_max98373 ACPI match
Date: Tue, 22 Jan 2019 13:51:03 -0600
Message-ID: <f3f06348-7229-83f9-d927-cbb2f3a55de8@linux.intel.com>
References: <1548096190-24584-1-git-send-email-jenny.tc@intel.com>
 <1548096190-24584-3-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 212582674E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 20:51:05 +0100 (CET)
In-Reply-To: <1548096190-24584-3-git-send-email-jenny.tc@intel.com>
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
To: Jenny TC <jenny.tc@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, yang.jie@linux.intel.com
Cc: harshapriya.n@intel.com
List-Id: alsa-devel@alsa-project.org


> diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> index e6fa6f4..cab841d 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
> @@ -37,6 +37,11 @@
>   	.codecs = {"MX98927"}
>   };
>   
> +static struct snd_soc_acpi_codecs kbl_7219_98373_codecs = {
> +	.num_codecs = 1,
> +	.codecs = {"MX98373"}
> +};
> +
>   struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
>   	{
>   		.id = "INT343A",
> @@ -106,6 +111,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
>   		.drv_name = "kbl_rt5660",
>   		.fw_filename = "intel/dsp_fw_kbl.bin",
>   	},
> +	{
> +		.id = "DLGS7219",
> +		.drv_name = "kbl_da7219_max98373",
> +		.fw_filename = "intel/dsp_fw_kbl.bin",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &kbl_7219_98373_codecs,
> +		.pdata = &skl_dmic_data

You provided a machine driver that can work with or without DA7219, so 
can you please clarify how the model without DA7219 is handled if you 
use the DA7219 as a primary key for the ACPI search? My current 
understanding is that the driver name "kbl_max98373" will never be used.
