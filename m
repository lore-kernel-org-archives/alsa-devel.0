From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: bytcr_rt5640: Allow quirk set via
 module option
Date: Fri, 21 Apr 2017 15:28:05 -0500
Message-ID: <5ead5593-62c6-21cd-f0da-3b807013aa85@linux.intel.com>
References: <20170421201544.28156-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EAA826727F
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 22:28:07 +0200 (CEST)
In-Reply-To: <20170421201544.28156-1-tiwai@suse.de>
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



On 04/21/2017 03:15 PM, Takashi Iwai wrote:
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
I am doing similar things at the moment, I folded IN1 and IN3 quirks 
together and was about to add a control to force 
single-ended/differential mics. The use of a parameter is not bad, we 
could stick it in a modprobe file and avoid writing more code.

That said, unless I am missing something, the problem with this 
parameter is that it will be overwritten by
DMI quirks or the settings detected by the driver, see e.g. this code.

         /* change defaults for Baytrail-CR capture */
         byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
         byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
     } else {
         byt_rt5640_quirk |= (BYT_RT5640_DMIC1_MAP |
                 BYT_RT5640_DMIC_EN);
     }

     /* check quirks before creating card */
     dmi_check_system(byt_rt5640_quirk_table);
     log_quirks(&pdev->dev);

We may need a second variable to force the .quirk parameter to be used 
as is and avoid applying changes done at run-time.

>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 5c7219fb3aa8..b848cbf575a1 100644
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
> @@ -57,7 +58,9 @@ struct byt_rt5640_private {
>   	struct clk *mclk;
>   };
>   
> -static unsigned long byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
> +static unsigned int byt_rt5640_quirk = BYT_RT5640_MCLK_EN;
> +module_param_named(quirk, byt_rt5640_quirk, int, 0444);
> +MODULE_PARM_DESC(quirk, "Board-specific quirk override");
>   
>   static void log_quirks(struct device *dev)
>   {
