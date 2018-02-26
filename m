From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: soc-generic-dmaengine-pcm: Fix
 error handling
Date: Mon, 26 Feb 2018 15:25:05 +0100
Message-ID: <d9a1ebd2-b64b-3f2d-7d7d-27e0678cdaa7@metafoo.de>
References: <1519326142-26421-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A9802267563
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 15:25:34 +0100 (CET)
In-Reply-To: <1519326142-26421-1-git-send-email-festevam@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/22/2018 08:02 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> When dmaengine_pcm_request_chan_of() fails it should release
> the previously acquired resources, which in this case is to
> call kfree(pcm), so jump to the correct point in the error
> path.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

This creates a resource leak. dmaengine_pcm_request_chan_of() requests both
transmit and receive channels. It might return with an error if one of them
fails, but the other one succeeded. In this case we need to call
dmaengine_pcm_release_chan() to free the requested channel.

> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 768247f..32ea16d 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -450,7 +450,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>  
>  	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
>  	if (ret)
> -		goto err_free_dma;
> +		goto err_free_pcm;
>  
>  	ret = snd_soc_add_component(dev, &pcm->component,
>  				    &dmaengine_pcm_component, NULL, 0);
> @@ -461,6 +461,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>  
>  err_free_dma:
>  	dmaengine_pcm_release_chan(pcm);
> +err_free_pcm:
>  	kfree(pcm);
>  	return ret;
>  }
> 
