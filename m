From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: pcm_dmaengine: Run complete cb only
 if runtime check passes
Date: Wed, 15 Jul 2015 22:05:19 +0200
Message-ID: <55A6BCFF.2030302@metafoo.de>
References: <1436980994-29340-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-023.synserver.de (smtp-out-023.synserver.de
 [212.40.185.23])
 by alsa0.perex.cz (Postfix) with ESMTP id A4648265DAB
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 22:05:21 +0200 (CEST)
In-Reply-To: <1436980994-29340-1-git-send-email-misael.lopez@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/15/2015 07:23 PM, Misael Lopez Cruz wrote:
> The DMA complete callback uses substream's runtime data, so make
> sure the runtime check passes before going forward.
>
> The callback could run while the stream is closing or after it's
> already closed.  By then, the substream's runtime data might already
> been freed and cause NULL pointer dereferences.

If the callback runs after the stream has been closed that's a bug in the 
DMAengine driver. This patch does not fix the issue, the sub-stream itself 
might have been freed as well, so things will still crash.

To fix a potential race condition that can happen if one cpu is running the 
callback handlers and the stream is closed from another see this thread: 
http://www.spinics.net/lists/dmaengine/msg05126.html

- Lars

>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   sound/core/pcm_dmaengine.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> index fba365a..061a8f7 100644
> --- a/sound/core/pcm_dmaengine.c
> +++ b/sound/core/pcm_dmaengine.c
> @@ -133,7 +133,12 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
>   static void dmaengine_pcm_dma_complete(void *arg)
>   {
>   	struct snd_pcm_substream *substream = arg;
> -	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> +	struct dmaengine_pcm_runtime_data *prtd;
> +
> +	if (PCM_RUNTIME_CHECK(substream))
> +		return;
> +
> +	prtd = substream_to_prtd(substream);
>
>   	prtd->pos += snd_pcm_lib_period_bytes(substream);
>   	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
>
