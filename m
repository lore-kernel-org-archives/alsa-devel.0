From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Medfield: Delete an error message for a failed
 memory allocation in snd_mfld_mc_probe()
Date: Wed, 16 Aug 2017 10:28:53 +0530
Message-ID: <20170816045853.GP3053@localhost>
References: <161e9c4c-1c97-d06f-35ec-3f165ad9e52e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <161e9c4c-1c97-d06f-35ec-3f165ad9e52e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 11, 2017 at 11:33:56AM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 11 Aug 2017 11:25:41 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/intel/boards/mfld_machine.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
> index 4e08885f37aa..6f44acfb4aae 100644
> --- a/sound/soc/intel/boards/mfld_machine.c
> +++ b/sound/soc/intel/boards/mfld_machine.c
> @@ -376,10 +376,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
>  	/* audio interrupt base of SRAM location where
>  	 * interrupts are stored by System FW */
>  	mc_drv_ctx = devm_kzalloc(&pdev->dev, sizeof(*mc_drv_ctx), GFP_ATOMIC);
> -	if (!mc_drv_ctx) {
> -		pr_err("allocation failed\n");
> +	if (!mc_drv_ctx)
>  		return -ENOMEM;
> -	}
>  
>  	irq_mem = platform_get_resource_byname(
>  				pdev, IORESOURCE_MEM, "IRQ_BASE");
> -- 
> 2.14.0
> 

-- 
~Vinod
