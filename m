From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/4] ALSA: compress: Don't allow drain
 operations on capture streams
Date: Tue, 9 Jul 2019 17:06:33 +0530
Message-ID: <20190709113633.GL2911@vkoul-mobl>
References: <20190709105211.11741-1-ckeepax@opensource.cirrus.com>
 <20190709105211.11741-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 250C6F800E0
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 13:39:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190709105211.11741-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 09-07-19, 11:52, Charles Keepax wrote:
> Partial drain and next track are intended for gapless playback and
> don't really have an obvious interpretation for a capture stream, so
> makes sense to not allow those operations on capture streams. Drain

Sounds right

> would make sense on a capture stream but currently the implementation
> of drain involves the kernel waiting for the DSP to consume its
> available data, whereas a capture drain would involve waiting for
> user-space to consume the data available on the DSP. Disallow drain
> on capture streams until that is implemented.

Well it in unclear to me about the support required in kernel! Kernel
issues drain request to DSP and waits for that to be done. When DSP has
encoded and copied the data the notification should make drain complete.
So I dont see anything in kernel required for that

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  sound/core/compress_offload.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index e1a216fd832f9..c7d56cee0d510 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -829,6 +829,10 @@ static int snd_compr_drain(struct snd_compr_stream *stream)
>  		break;
>  	}
>  
> +	/* drain not implemented for capture streams yet */
> +	if (stream->direction == SND_COMPRESS_CAPTURE)
> +		return -EPERM;
> +
>  	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
>  	if (retval) {
>  		pr_debug("SND_COMPR_TRIGGER_DRAIN failed %d\n", retval);
> @@ -847,6 +851,10 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
>  	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
>  		return -EPERM;
>  
> +	/* next track doesn't have any meaning for capture streams */
> +	if (stream->direction == SND_COMPRESS_CAPTURE)
> +		return -EPERM;
> +
>  	/* you can signal next track if this is intended to be a gapless stream
>  	 * and current track metadata is set
>  	 */
> @@ -874,6 +882,10 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
>  		break;
>  	}
>  
> +	/* partial drain doesn't have any meaning for capture streams */
> +	if (stream->direction == SND_COMPRESS_CAPTURE)
> +		return -EPERM;
> +
>  	/* stream can be drained only when next track has been signalled */
>  	if (stream->next_track == false)
>  		return -EPERM;
> -- 
> 2.11.0

-- 
~Vinod
