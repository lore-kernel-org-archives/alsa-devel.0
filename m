From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Mon, 09 Dec 2013 21:44:51 +0100
Message-ID: <52A62BC3.1050807@metafoo.de>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-215.synserver.de
 [212.40.185.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 38064261A1D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:44:00 +0100 (CET)
In-Reply-To: <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/09/2013 09:24 PM, Stephen Warren wrote:
[...]
>  
> -static int ep93xx_soc_platform_probe(struct platform_device *pdev)
> +int ep93xx_pcm_platform_register(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_register(&pdev->dev,
> +	return snd_dmaengine_pcm_register(dev,

This will have a conflict with the "ASoC: ep93xx: Use
devm_snd_dmaengine_pcm_register()" patch from the topic/ep93xx branch.
Otherwise the patch looks fine to me.

>  		&ep93xx_dmaengine_pcm_config,
>  		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
>  		SND_DMAENGINE_PCM_FLAG_NO_DT |
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
> +EXPORT_SYMBOL_GPL(ep93xx_pcm_platform_register);
>  
