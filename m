From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: davinci_voicecodec: tidyup header difinitions
Date: Wed, 9 Nov 2016 16:54:25 +0000
Message-ID: <20161109165425.GK13127@dell>
References: <878ttafb84.wl%kuninori.morimoto.gx@renesas.com>
 <877f8ufb6b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877f8ufb6b.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Jeremy McDermond <nh6z@nh6z.net>, Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Oct 2016, Kuninori Morimoto wrote:

> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Please use `git send-mail` to submit your patches.

> mach/hardware.h is needed on C source code side, not header.
> And struct davinci_vc is duplicated definition.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mfd/davinci_voicecodec.c       | 1 +
>  include/linux/mfd/davinci_voicecodec.h | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)

Nice.

Applied, thanks.

> diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
> index dff2f19..4d0a5f3 100644
> --- a/drivers/mfd/davinci_voicecodec.c
> +++ b/drivers/mfd/davinci_voicecodec.c
> @@ -32,6 +32,7 @@
>  #include <sound/pcm.h>
>  
>  #include <linux/mfd/davinci_voicecodec.h>
> +#include <mach/hardware.h>
>  
>  static const struct regmap_config davinci_vc_regmap = {
>  	.reg_bits = 32,
> diff --git a/include/linux/mfd/davinci_voicecodec.h b/include/linux/mfd/davinci_voicecodec.h
> index 8e1cdbe..2c0127c 100644
> --- a/include/linux/mfd/davinci_voicecodec.h
> +++ b/include/linux/mfd/davinci_voicecodec.h
> @@ -28,8 +28,6 @@
>  #include <linux/mfd/core.h>
>  #include <linux/platform_data/edma.h>
>  
> -#include <mach/hardware.h>
> -
>  struct regmap;
>  
>  /*
> @@ -99,8 +97,6 @@ struct davinci_vcif {
>  	dma_addr_t dma_rx_addr;
>  };
>  
> -struct davinci_vc;
> -
>  struct davinci_vc {
>  	/* Device data */
>  	struct device *dev;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
