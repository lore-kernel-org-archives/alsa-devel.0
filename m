From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [PATCH 03/23] ASoC: tegra: tegra_pcm.c: use
 devm_snd_dmaengine_pcm_register()
Date: Thu, 27 Jun 2019 09:43:26 +0200
Message-ID: <20190627094326.7f8c0c60@xxx>
References: <8736jvkcy1.wl-kuninori.morimoto.gx@renesas.com>
 <87y31niycl.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA5A4F896FC
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:39:30 +0200 (CEST)
In-Reply-To: <87y31niycl.wl-kuninori.morimoto.gx@renesas.com>
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

On 27 Jun 2019 11:00:10 +0900
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We have devm_xxx version of snd_dmaengine_pcm_register,
> let's use it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/tegra/tegra_pcm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
> index f246df8..1814791 100644
> --- a/sound/soc/tegra/tegra_pcm.c
> +++ b/sound/soc/tegra/tegra_pcm.c
> @@ -44,7 +44,8 @@ static const struct snd_dmaengine_pcm_config
> tegra_dmaengine_pcm_config = { 
>  int tegra_pcm_platform_register(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_register(dev,
> &tegra_dmaengine_pcm_config, 0);
> +	return devm_snd_dmaengine_pcm_register(dev,
> +					&tegra_dmaengine_pcm_config,
> 0); }
>  EXPORT_SYMBOL_GPL(tegra_pcm_platform_register);
>  
> @@ -57,13 +58,12 @@ int
> tegra_pcm_platform_register_with_chan_names(struct device *dev,
> config->chan_names[0] = txdmachan; config->chan_names[1] = rxdmachan;
>  
> -	return snd_dmaengine_pcm_register(dev, config, 0);
> +	return devm_snd_dmaengine_pcm_register(dev, config, 0);
>  }
>  EXPORT_SYMBOL_GPL(tegra_pcm_platform_register_with_chan_names);
>  
>  void tegra_pcm_platform_unregister(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_unregister(dev);
>  }
>  EXPORT_SYMBOL_GPL(tegra_pcm_platform_unregister);
>  

Again, do we need to keep empty function?
