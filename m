From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] sound: soc: cygnus: add depends on HAS_DMA
Date: Sat, 8 Oct 2016 13:26:13 -0700
Message-ID: <caa6a348-9a5f-7f08-ea24-35c3e9d78b31@broadcom.com>
References: <1475868258-10689-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475868258-10689-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On 10/7/2016 12:24 PM, Scott Branden wrote:
> add depends on HAS_DMA to Kconfig.  This fixes error reported
> by kbuild test robot when building for ARCH=m32r:
> ERROR: "bad_dma_ops" [sound/soc/bcm/snd-soc-cygnus.ko] undefined!
>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   sound/soc/bcm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
> index d528aac..edf3671 100644
> --- a/sound/soc/bcm/Kconfig
> +++ b/sound/soc/bcm/Kconfig
> @@ -11,6 +11,7 @@ config SND_BCM2835_SOC_I2S
>   config SND_SOC_CYGNUS
>   	tristate "SoC platform audio for Broadcom Cygnus chips"
>   	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> +	depends on HAS_DMA
>   	help
>   	  Say Y if you want to add support for ASoC audio on Broadcom
>   	  Cygnus chips (bcm958300, bcm958305, bcm911360)
Looks good to me.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
