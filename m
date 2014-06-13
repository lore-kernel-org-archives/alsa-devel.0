From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/4] pcm: rate: add rewindable and
 forwardable callbacks
Date: Fri, 13 Jun 2014 09:13:52 +0200
Message-ID: <539AA4B0.2050005@perex.cz>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
 <1402569264-2789-3-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id CAD5F261703
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 09:13:53 +0200 (CEST)
In-Reply-To: <1402569264-2789-3-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 12.6.2014 12:34, Alexander E. Patrakov wrote:
> This commit does not fix nonsense values returned by the rewind and
> forward callbacks. E.g., with period_size = 1024 and buffer_size = 4096,
> an attempt to rewind 1024 samples from the nearly-full buffer returns
> 4090.
> 
> Due to these nonsense values, the current rate plugin should be treated
> as non-rewindable. That's why the new callbacks return 0.
> 
> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>

I don't agree. The snd_pcm_rate_move_applptr() should be fixed instead
this blocking attempt. Do you have any simple use case?

                                       Jaroslav

> ---
>  src/pcm/pcm_rate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
> index 2eb4b1b..58ed842 100644
> --- a/src/pcm/pcm_rate.c
> +++ b/src/pcm/pcm_rate.c
> @@ -689,6 +689,16 @@ static int snd_pcm_rate_reset(snd_pcm_t *pcm)
>  	return 0;
>  }
>  
> +static snd_pcm_sframes_t snd_pcm_rate_rewindable(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
> +{
> +	return 0;
> +}
> +
> +static snd_pcm_sframes_t snd_pcm_rate_forwardable(snd_pcm_t *pcm ATTRIBUTE_UNUSED)
> +{
> +	return 0;
> +}
> +
>  static snd_pcm_sframes_t snd_pcm_rate_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t frames)
>  {
>  	snd_pcm_rate_t *rate = pcm->private_data;
> @@ -1221,7 +1231,9 @@ static const snd_pcm_fast_ops_t snd_pcm_rate_fast_ops = {
>  	.drop = snd_pcm_generic_drop,
>  	.drain = snd_pcm_rate_drain,
>  	.pause = snd_pcm_generic_pause,
> +	.rewindable = snd_pcm_rate_rewindable,
>  	.rewind = snd_pcm_rate_rewind,
> +	.forwardable = snd_pcm_rate_forwardable,
>  	.forward = snd_pcm_rate_forward,
>  	.resume = snd_pcm_generic_resume,
>  	.writei = snd_pcm_mmap_writei,
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
