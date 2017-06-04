From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: add bytcr-wm5102 machine
	driver
Date: Sun, 4 Jun 2017 17:27:51 -0500
Message-ID: <df6f715c-5f63-9403-8dd0-13dad8f62fa6@linux.intel.com>
References: <593313f5.3636c80a.50e05.47e9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <593313f5.3636c80a.50e05.47e9@mx.google.com>
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
To: pstglia@android-x86.org, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Paulo Sergio Travaglia <pstglia@gmail.com>
List-Id: alsa-devel@alsa-project.org


> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index dd250b8..1669c46 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -240,10 +240,17 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
>   }
>   
>   
> -static int is_byt_cr(struct device *dev, bool *bytcr)
> +static int is_byt_cr(struct device *dev, struct sst_acpi_mach *mach, bool *bytcr)
>   {
>   	int status = 0;
>   
> +	/* Lenovo Yoga2 exception - acpi_ipc_irq_index is the 1st index,
> +	   but iosf_mbi_read (bios_status) returns 0 for bits 26:27 */
> +	if (!strcmp(mach->drv_name, "bytcr_wm5102")) {
> +		*bytcr = true;
> +		return status;
> +	}

well no, this isn't the right way to do this. quirks need to be based on 
real hardware information (e.g. DMI) and not a driver name.

The rest looks more of less ok, it's not clear to me if all the quirks 
are needed and make sense.
