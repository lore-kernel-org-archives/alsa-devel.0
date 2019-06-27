From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 04/23] ASoC: ux500: ux500_pcm.c: use
 devm_snd_dmaengine_pcm_register()
Date: Thu, 27 Jun 2019 09:43:35 +0200
Message-ID: <20190627094335.6c564e46@xxx>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <87woh7iych.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 594CCF8972F
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:39:38 +0200 (CEST)
In-Reply-To: <87woh7iych.wl-kuninori.morimoto.gx@renesas.com>
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

On 27 Jun 2019 11:00:14 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_dmaengine_pcm_register,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/ux500/ux500_pcm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
> index 9445dbe..05ae02c 100644
> --- a/sound/soc/ux500/ux500_pcm.c
> +++ b/sound/soc/ux500/ux500_pcm.c
> @@ -143,7 +143,7 @@ int ux500_pcm_register_platform(struct
> platform_device *pdev) else
>  		pcm_config = &ux500_dmaengine_pcm_config;
>  
> -	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
> +	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
>  					 SND_DMAENGINE_PCM_FLAG_COMPAT);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev,
> @@ -158,7 +158,6 @@ EXPORT_SYMBOL_GPL(ux500_pcm_register_platform);
>  
>  int ux500_pcm_unregister_platform(struct platform_device *pdev)
>  {
> -	snd_dmaengine_pcm_unregister(&pdev->dev);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);

Can also be removed?
