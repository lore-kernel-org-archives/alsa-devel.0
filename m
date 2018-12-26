From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/7] ASoC: Intel: common: Add quirk for PoV
	P1006W tablet
Date: Wed, 26 Dec 2018 12:03:10 -0600
Message-ID: <d7462d30-da71-304b-3c8b-abd96776eb3f@linux.intel.com>
References: <20181224150037.20275-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 32FD2267AF7
 for <alsa-devel@alsa-project.org>; Wed, 26 Dec 2018 19:03:13 +0100 (CET)
In-Reply-To: <20181224150037.20275-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/24/18 9:00 AM, Hans de Goede wrote:
> The Point of View TAB-P1006W-232 (v1.0) tablet uses 10EC5640 as
> ACPI HID, but it has a rt5651 codec add a quirk for this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

All patches in this series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for all this work, I am still surprised by the "creativity" of 
hardware folks.


> ---
>   .../intel/common/soc-acpi-intel-byt-match.c   | 35 +++++++++++++++++--
>   1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> index 097dc06377ba..027dc27262b7 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> @@ -21,6 +21,7 @@
>   static unsigned long byt_machine_id;
>   
>   #define BYT_THINKPAD_10  1
> +#define BYT_POV_P1006W   2
>   
>   static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
>   {
> @@ -28,6 +29,11 @@ static int byt_thinkpad10_quirk_cb(const struct dmi_system_id *id)
>   	return 1;
>   }
>   
> +static int byt_pov_p1006w_quirk_cb(const struct dmi_system_id *id)
> +{
> +	byt_machine_id = BYT_POV_P1006W;
> +	return 1;
> +}
>   
>   static const struct dmi_system_id byt_table[] = {
>   	{
> @@ -58,6 +64,17 @@ static const struct dmi_system_id byt_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
>   		},
>   	},
> +	{
> +		/* Point of View mobii wintab p1006w (v1.0) */
> +		.callback = byt_pov_p1006w_quirk_cb,
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
> +			/* Note 105b is Foxcon's USB/PCI vendor id */
> +			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
> +		},
> +	},
>   	{ }
>   };
>   
> @@ -71,16 +88,30 @@ static struct snd_soc_acpi_mach byt_thinkpad_10 = {
>   	.asoc_plat_name = "sst-mfld-platform",
>   };
>   
> +static struct snd_soc_acpi_mach byt_pov_p1006w = {
> +	.id = "10EC5640",
> +	.drv_name = "bytcr_rt5651",
> +	.fw_filename = "intel/fw_sst_0f28.bin",
> +	.board = "bytcr_rt5651",
> +	.sof_fw_filename = "intel/sof-byt.ri",
> +	.sof_tplg_filename = "intel/sof-byt-rt5651.tplg",
> +	.asoc_plat_name = "sst-mfld-platform",
> +};
> +
>   static struct snd_soc_acpi_mach *byt_quirk(void *arg)
>   {
>   	struct snd_soc_acpi_mach *mach = arg;
>   
>   	dmi_check_system(byt_table);
>   
> -	if (byt_machine_id == BYT_THINKPAD_10)
> +	switch (byt_machine_id) {
> +	case BYT_THINKPAD_10:
>   		return &byt_thinkpad_10;
> -	else
> +	case BYT_POV_P1006W:
> +		return &byt_pov_p1006w;
> +	default:
>   		return mach;
> +	}
>   }
>   
>   struct snd_soc_acpi_mach snd_soc_acpi_intel_baytrail_legacy_machines[] = {
