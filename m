From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Mon, 6 Jan 2014 15:00:30 +0800
Message-ID: <20140106070028.GF26128@S2101-09.ap.freescale.net>
References: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 48324261600
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 07:59:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1388903726-2053-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 05, 2014 at 10:35:26AM +0400, Alexander Shiyan wrote:
> This patch adds new Kconfig symbol to allow using generic sound
> cards/codecs based on DT description.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  sound/soc/fsl/Kconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index bb4ab96..51fabc6 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -126,6 +126,16 @@ config SND_SOC_IMX_PCM_DMA
>  config SND_SOC_IMX_AUDMUX
>  	tristate
>  
> +config SND_SOC_IMX_DT
> +	tristate "SoC Audio support for i.MX DT boards"

"i.MX ASoC generic sound card support" would be better?

> +	depends on OF

It seems to me that we should depend on SND_SIMPLE_CARD and add OF
dependency for SND_SIMPLE_CARD symbol?

Shawn

> +	select SND_SOC_FSL_SSI
> +	select SND_SOC_IMX_AUDMUX
> +	select SND_SOC_IMX_PCM_DMA
> +	help
> +	  Say Y if you want to add support for SoC audio on an i.MX boards
> +	  described in devicetree.
> +
>  config SND_MXC_SOC_WM1133_EV1
>  	tristate "Audio on the i.MX31ADS with WM1133-EV1 fitted"
>  	depends on MACH_MX31ADS_WM1133_EV1
> -- 
> 1.8.3.2
> 
