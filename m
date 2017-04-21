From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: bytcr_rt5640: Allow quirk set via
	module option
Date: Fri, 21 Apr 2017 15:45:29 -0500
Message-ID: <68226428-2f85-b70f-c916-a32ec7487eee@linux.intel.com>
References: <20170421203856.4134-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AA5926727F
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 22:45:31 +0200 (CEST)
In-Reply-To: <20170421203856.4134-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 04/21/2017 03:38 PM, Takashi Iwai wrote:
> The bytcr-rt5640 driver has a few quirk setups depending on the board,
> where the quirk value is set by DMI matching.  When you have a new
> device to add the support, you often experience to try the different
> quirk by trial-and-error.  Or, you may have a development model that
> still has no proper DMI string.  In either case, you'd need to compile
> the driver at each time.
>
> This patch introduces a module option to override the quirk value on
> the fly.  User can boot like snd-soc-sst-bytcr-rt5640.quirk=0x4004 to
> override the default value without recompilation.  It's a raw value,
> so user needs to check the source code for the meaning of each bit.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: override the quirk value completely
>
>   sound/soc/intel/boards/bytcr_rt5640.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 5c7219fb3aa8..23f5ffdb3731 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -19,6 +19,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/module.h>
> +#include <linux/moduleparam.h>
>   #include <linux/platform_device.h>
>   #include <linux/acpi.h>
>   #include <linux/device.h>
> @@ -58,6 +59,9 @@ struct byt_rt5640_private {
>   };
>   
>   static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
> +static unsigned int quirk_override;
> +module_param_named(quirk, quirk_override, int, 0444);
> +MODULE_PARM_DESC(quirk, "Board-specific quirk override");
>   
>   static void log_quirks(struct device *dev)
>   {
> @@ -806,6 +810,8 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>   
>   	/* check quirks before creating card */
>   	dmi_check_system(byt_rt5640_quirk_table);
> +	if (quirk_override)
> +		byt_rt5640_quirk = quirk_override;
>   	log_quirks(&pdev->dev);
sounds fine.
I would also change this log_quirks function to signal if the bits set 
by the user aren't aligned with the driver known quirks or are inconsistent.
I can add a patch if you want.

>   
>   	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
