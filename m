From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] ALSA: compress: Reduce the scope for two variables
 in snd_compr_set_params()
Date: Sun, 21 Aug 2016 16:36:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1608211635480.3119@hadrien>
References: <566ABCD9.1060404@users.sourceforge.net> <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net> <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Sun, 21 Aug 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 21 Aug 2016 21:26:18 +0200
>
> Reduce the scope for the local variables to an if branch.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/core/compress_offload.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 583d407..b43aec5 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -545,14 +545,14 @@ static int snd_compress_check_input(struct snd_compr_params *params)
>  static int
>  snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
>  {
> -	struct snd_compr_params *params;
> -	int retval;
> -
>  	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
>  		/*
>  		 * we should allow parameter change only when stream has been
>  		 * opened not in other cases
>  		 */
> +		int retval;
> +		struct snd_compr_params *params;

I don't like this at all.  Local variables should be at the top of the
function, not hiding under 4 lines of comments in the middle of the code.

julia


> +
>  		params = memdup_user((void __user *)arg, sizeof(*params));
>  		if (IS_ERR(params))
>  			return PTR_ERR(params);
> @@ -578,12 +578,12 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
>  			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
>  		else
>  			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
> +out:
> +		kfree(params);
> +		return retval;
>  	} else {
>  		return -EPERM;
>  	}
> -out:
> -	kfree(params);
> -	return retval;
>  }
>
>  static int
> --
> 2.9.3
>
>
