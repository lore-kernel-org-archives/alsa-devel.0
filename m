From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/8] [media] v4l: rcar_fdp1: Change platform dependency to ARCH_RENESAS
Date: Sat, 21 Apr 2018 11:07:11 +0300
Message-ID: <3039853.rivznOVBTv@avalon>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be> <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524230914-10175-4-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger
List-Id: alsa-devel@alsa-project.org

Hi Geert,

Thank you for the patch.

On Friday, 20 April 2018 16:28:29 EEST Geert Uytterhoeven wrote:
> The Renesas Fine Display Processor driver is used on Renesas R-Car SoCs
> only.  Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce
> ARCH_RENESAS") is ARCH_RENESAS a more appropriate platform dependency
> than the legacy ARCH_SHMOBILE, hence use the former.
> 
> This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
> future.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

How would you like to get this merged ?

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f9235e8f8e962d2e..7ad4725f9d1f9627 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -396,7 +396,7 @@ config VIDEO_SH_VEU
>  config VIDEO_RENESAS_FDP1
>  	tristate "Renesas Fine Display Processor"
>  	depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
> -	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on (!ARCH_RENESAS && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV

-- 
Regards,

Laurent Pinchart
