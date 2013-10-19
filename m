From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: ep93xx: Open code dma channel
 request
Date: Sat, 19 Oct 2013 19:19:41 +0200
Message-ID: <5262BF2D.1080104@metafoo.de>
References: <1382188384-18063-1-git-send-email-broonie@kernel.org>
 <1382188384-18063-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-103.synserver.de
 [212.40.185.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 781242608ED
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 19:19:48 +0200 (CEST)
In-Reply-To: <1382188384-18063-2-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 03:13 PM, Mark Brown wrote:
[...]
>  static const struct snd_dmaengine_pcm_config ep93xx_dmaengine_pcm_config = {
>  	.pcm_hardware = &ep93xx_pcm_hardware,
>  	.compat_filter_fn = ep93xx_pcm_dma_filter,

The compat_filter_fn attribute should probably removed

> +	.compat_request_channel = ep93xx_compat_request_channel,
>  	.prealloc_buffer_size = 131072,
>  };

Otherwise it looks fine
