From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] Rename exports in mpc5200_dma.c
Date: Mon, 27 Apr 2009 20:35:34 +0100
Message-ID: <20090427193534.GA23567@rakim.wolfsonmicro.main>
References: <20090427164108.18211.44680.stgit@terra>
	<20090427164447.18211.42851.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 330F11037ED
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 21:35:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090427164447.18211.42851.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 12:44:47PM -0400, Jon Smirl wrote:
> Rename the public DMA exports into the global name space so that the DMA code can be built as a module.

> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_startup);
> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_hw_free);
> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_trigger);
> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_shutdown);

Why are you exporting these?  They should all be accessed via...

> -struct snd_soc_platform psc_dma_pcm_soc_platform = {
> +struct snd_soc_platform mpc5200_audio_dma_platform = {
>  	.name		= "mpc5200-psc-audio",
>  	.pcm_ops	= &psc_dma_pcm_ops,
>  	.pcm_new	= &psc_dma_pcm_new,
>  	.pcm_free	= &psc_dma_pcm_free,
>  };
> -
> +EXPORT_SYMBOL_GPL(mpc5200_audio_dma_platform);

...this unless there's a reason not to do so.

> -int psc_dma_startup(struct snd_pcm_substream *substream,
> +int mpc5200_audio_dma_startup(struct snd_pcm_substream *substream,
>  			   struct snd_soc_dai *dai);

These should go.
