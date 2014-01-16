From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Use devm_kzalloc() instead
	kzalloc()
Date: Thu, 16 Jan 2014 22:52:35 +0100
Message-ID: <52D854A3.5090109@metafoo.de>
References: <1389861887-32721-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 109AA261B20
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 22:50:23 +0100 (CET)
In-Reply-To: <1389861887-32721-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/16/2014 09:44 AM, Xiubo Li wrote:
> Makes the code slightly shorter
>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

I don't like this. I don't think it is a good design pattern to call devm 
function from within (especial non-devm) library functions. It creates an 
asymmetric API. The memory is allocated when snd_dmaengine_pcm_register() is 
called, but it is not freed when  snd_dmaengine_pcm_unregister() is called. 
This goes against the principle of least surprise.

- Lars

> ---
>   sound/soc/soc-generic-dmaengine-pcm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 5bace12..bfb012f 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -388,7 +388,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>   	struct dmaengine_pcm *pcm;
>   	int ret;
>
> -	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
> +	pcm = devm_kzalloc(dev, sizeof(*pcm), GFP_KERNEL);
>   	if (!pcm)
>   		return -ENOMEM;
>
> @@ -408,7 +408,6 @@ int snd_dmaengine_pcm_register(struct device *dev,
>
>   err_free_dma:
>   	dmaengine_pcm_release_chan(pcm);
> -	kfree(pcm);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
> @@ -433,7 +432,6 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
>
>   	snd_soc_remove_platform(platform);
>   	dmaengine_pcm_release_chan(pcm);
> -	kfree(pcm);
>   }
>   EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
>
>
