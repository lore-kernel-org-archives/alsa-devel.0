From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/5] ASoC: SPEAr: get rid of
	spear-pcm-audio struct device
Date: Mon, 09 Dec 2013 21:48:11 +0100
Message-ID: <52A62C8B.2050308@metafoo.de>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-4-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-215.synserver.de
 [212.40.185.215])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C03F261A1D
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 21:47:22 +0100 (CET)
In-Reply-To: <1386620656-18391-4-git-send-email-swarren@wwwdotorg.org>
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
> -static int spear_soc_platform_probe(struct platform_device *pdev)
> +int spear_pcm_platform_register(struct device *dev)
>  {
> -	return snd_dmaengine_pcm_register(&pdev->dev,
> +	return snd_dmaengine_pcm_register(dev,

Same conflict as with the ep93xx patch.

>  		&spear_dmaengine_pcm_config,
>  		SND_DMAENGINE_PCM_FLAG_NO_DT |
>  		SND_DMAENGINE_PCM_FLAG_COMPAT);
>  }
> +EXPORT_SYMBOL_GPL(spear_pcm_platform_register);
