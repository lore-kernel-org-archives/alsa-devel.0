From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 2/2] ALSA: sound/atmel-ac97c.h: Remove
 unused flags from platform data
Date: Wed, 16 Apr 2014 09:39:25 +0200
Message-ID: <534E33AD.8060403@atmel.com>
References: <1397293707-26890-1-git-send-email-alexanders83@web.de>
 <1397583537-4222-1-git-send-email-alexanders83@web.de>
 <1397583537-4222-2-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AA1092616E9
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 09:39:27 +0200 (CEST)
In-Reply-To: <1397583537-4222-2-git-send-email-alexanders83@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexanders83@web.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On 15/04/2014 19:38, Alexander Stein :
> This platform data member is unused, so remove it.
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  include/sound/atmel-ac97c.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/sound/atmel-ac97c.h b/include/sound/atmel-ac97c.h
> index e6aabdb..00e6c289 100644
> --- a/include/sound/atmel-ac97c.h
> +++ b/include/sound/atmel-ac97c.h
> @@ -23,7 +23,6 @@
>   * @reset_pin: GPIO pin wired to the reset input on the external AC97 codec,
>   *             optional to use, set to -ENODEV if not in use. AC97 layer will
>   *             try to do a software reset of the external codec anyway.
> - * @flags: Flags for which directions should be enabled.
>   *
>   * If the user do not want to use a DMA channel for playback or capture, i.e.
>   * only one feature is required on the board. The slave for playback or capture
> @@ -33,7 +32,6 @@
>  struct ac97c_platform_data {
>  	struct dw_dma_slave	rx_dws;
>  	struct dw_dma_slave	tx_dws;
> -	unsigned int 		flags;
>  	int			reset_pin;
>  };
>  
> 


-- 
Nicolas Ferre
