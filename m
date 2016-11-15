From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: wm8580: tidyup Kconfig tristate title
Date: Tue, 15 Nov 2016 15:06:05 +1100
Message-ID: <f38ba5ba-56f6-52ce-43f5-e51fb0fc0d50@flatmax.org>
References: <8737it9z67.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas05p.mx.bigpond.com (nskntmtas05p.mx.bigpond.com
 [61.9.168.149]) by alsa0.perex.cz (Postfix) with ESMTP id E555F2654BE
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 05:06:09 +0100 (CET)
Received: from nskntcmgw05p ([61.9.169.165]) by nskntmtas05p.mx.bigpond.com
 with ESMTP
 id <20161115040607.PWHF2855.nskntmtas05p.mx.bigpond.com@nskntcmgw05p>
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 04:06:07 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1c6V53-0006C5-3w
 for alsa-devel@alsa-project.org; Tue, 15 Nov 2016 15:10:45 +1100
In-Reply-To: <8737it9z67.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 15/11/16 14:54, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> It is WM8580, not WM8523
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/codecs/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c67667b..f1c48d2 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -914,7 +914,7 @@ config SND_SOC_WM8523
>   	depends on I2C
>   
>   config SND_SOC_WM8580
> -	tristate "Wolfson Microelectronics WM8523 CODEC"
> +	tristate "Wolfson Microelectronics WM8580 CODEC"

I think this was fixed in this patch :

https://patchwork.kernel.org/patch/9385575/


>   	depends on I2C
>   
>   config SND_SOC_WM8711
