From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: sst: Fallback to BYT-CR
 if IRQ 5 is missing
Date: Mon, 31 Dec 2018 09:38:21 -0600
Message-ID: <42aa8bbb-433e-6eb7-e3ff-a52c14d87b61@linux.intel.com>
References: <20181222144708.121732-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 759E026789E
 for <alsa-devel@alsa-project.org>; Mon, 31 Dec 2018 16:38:25 +0100 (CET)
In-Reply-To: <20181222144708.121732-1-stephan@gerhold.net>
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
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/22/18 8:47 AM, Stephan Gerhold wrote:
> Some devices detected as BYT-T by the PMIC-type based detection
> have only a single IRQ listed in the 80860F28 ACPI device. This
> causes -ENXIO later when attempting to get the IRQ at index 5.
> It turns out these devices behave more like BYT-CR devices,
> and using the IRQ at index 0 makes sound work correctly.
>
> This patch adds a fallback for these devices to is_byt_cr():
> If there is no IRQ resource at index 5, treating the device
> as BYT-T is guaranteed to fail later, so we can safely treat
> these devices as BYT-CR without breaking any working device.
>
> Link: http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143176.html
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Moved the "Detected Baytrail-CR platform" message to is_byt_cr()
> so we can log a different message if the fallback is used.
>
> Tested this on my device as-is, and simulated a "normal"
> BYT-T and BYT-CR device (copied their IRQs to a custom DSDT).
>
>   sound/soc/intel/atom/sst/sst_acpi.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 3a95ebbfc45d..755a396121ff 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -255,10 +255,22 @@ static int is_byt(void)
>   	return status;
>   }
>   
> -static int is_byt_cr(struct device *dev, bool *bytcr)
> +static int is_byt_cr(struct platform_device *pdev, bool *bytcr)
>   {
> +	struct device *dev = &pdev->dev;
>   	int status = 0;
>   
> +	if (platform_get_resource(pdev, IORESOURCE_IRQ, 5) == NULL) {
> +		/*
> +		 * Some devices detected as BYT-T have only a single IRQ listed,
> +		 * causing platform_get_irq with index 5 to return -ENXIO.
> +		 * The correct IRQ in this case is at index 0, as used on BYT-CR.
> +		 */
> +		dev_info(dev, "Falling back to Baytrail-CR platform\n");
> +		*bytcr = true;
> +		return status;
> +	}
> +

Isn't this going to bypass the PMIC-based detection on all BYT-CR 
devices? Maybe move this code as a fallback used when the PMIC-based 
detection isn't positive?


>   	if (IS_ENABLED(CONFIG_IOSF_MBI)) {
>   		u32 bios_status;
>   
> @@ -278,10 +290,12 @@ static int is_byt_cr(struct device *dev, bool *bytcr)
>   			/* bits 26:27 mirror PMIC options */
>   			bios_status = (bios_status >> 26) & 3;
>   
> -			if ((bios_status == 1) || (bios_status == 3))
> +			if ((bios_status == 1) || (bios_status == 3)) {
> +				dev_info(dev, "Detected Baytrail-CR platform\n");
>   				*bytcr = true;
> -			else
> +			} else {
>   				dev_info(dev, "BYT-CR not detected\n");
> +			}
>   		}
>   	} else {
>   		dev_info(dev, "IOSF_MBI not enabled, no BYT-CR detection\n");
> @@ -333,10 +347,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = is_byt_cr(dev, &bytcr);
> +	ret = is_byt_cr(pdev, &bytcr);
>   	if (!(ret < 0 || !bytcr)) {
> -		dev_info(dev, "Detected Baytrail-CR platform\n");
> -
>   		/* override resource info */
>   		byt_rvp_platform_data.res_info = &bytcr_res_info;
>   	}
