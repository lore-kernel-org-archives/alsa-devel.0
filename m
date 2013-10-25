From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dmaengine: Use SNDRV_PCM_STREAM_LAST
 for array size
Date: Fri, 25 Oct 2013 18:07:39 +0200
Message-ID: <526A974B.3050802@metafoo.de>
References: <s5hfvrpl4i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-057.synserver.de
 [212.40.185.57])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F37E26568A
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 18:12:58 +0200 (CEST)
In-Reply-To: <s5hfvrpl4i6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/25/2013 06:06 PM, Takashi Iwai wrote:
> ... to make the meaning more obvious.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 0c469cb..ee07903 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -25,7 +25,7 @@
>  #include <sound/dmaengine_pcm.h>
>  
>  struct dmaengine_pcm {
> -	struct dma_chan *chan[SNDRV_PCM_STREAM_CAPTURE + 1];
> +	struct dma_chan *chan[SNDRV_PCM_STREAM_LAST + 1];
>  	const struct snd_dmaengine_pcm_config *config;
>  	struct snd_soc_platform platform;
>  	unsigned int flags;
> 
