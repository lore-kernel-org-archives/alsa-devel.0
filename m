From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 01/23] ASoC: atmel: atmel-pcm:dma.c: use
 devm_snd_dmaengine_pcm_register()
Date: Thu, 27 Jun 2019 09:43:16 +0200
Message-ID: <20190627094316.35057063@xxx>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <871rzfkcxb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D76CAF89678
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:39:20 +0200 (CEST)
In-Reply-To: <871rzfkcxb.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 27 Jun 2019 11:00:01 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_dmaengine_pcm_register,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/atmel/atmel-pcm-dma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm-dma.c
> b/sound/soc/atmel/atmel-pcm-dma.c index 042e593..9abf072 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -111,13 +111,13 @@ static const struct snd_dmaengine_pcm_config
> atmel_dmaengine_pcm_config = { 
>  int atmel_pcm_dma_platform_register(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_register(dev,
> &atmel_dmaengine_pcm_config, 0);
> +	return devm_snd_dmaengine_pcm_register(dev,
> +					&atmel_dmaengine_pcm_config,
> 0); }
>  EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
>  
>  void atmel_pcm_dma_platform_unregister(struct device *dev)
>  {
> -	snd_dmaengine_pcm_unregister(dev);
>  }
>  EXPORT_SYMBOL(atmel_pcm_dma_platform_unregister);
>  

Do we need to keep empty function?
