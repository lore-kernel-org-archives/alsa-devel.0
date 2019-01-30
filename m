From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm: Drop unused
 snd_pcm_substream.file field
Date: Wed, 30 Jan 2019 09:18:48 +0100
Message-ID: <f8b6fc13-dd3f-d7bb-9e4f-e55cbbe1d736@perex.cz>
References: <20190123143802.32123-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D8826785F
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 09:18:50 +0100 (CET)
In-Reply-To: <20190123143802.32123-1-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 23.1.2019 v 15:38 Takashi Iwai napsal(a):
> It's assigned but nowhere used.  Let's remove it.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>  include/sound/pcm.h      | 1 -
>  sound/core/oss/pcm_oss.c | 1 -
>  sound/core/pcm_native.c  | 4 +---
>  3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 2c30c1ad1b0d..a20d3a48df00 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -470,7 +470,6 @@ struct snd_pcm_substream {
>  	struct snd_pcm_group self_group;	/* fake group for non linked substream (with substream lock inside) */
>  	struct snd_pcm_group *group;		/* pointer to current group */
>  	/* -- assigned files -- */
> -	void *file;
>  	int ref_count;
>  	atomic_t mmap_count;
>  	unsigned int f_flags;
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index 467039b342b5..d5b0d7ba83c4 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -2427,7 +2427,6 @@ static int snd_pcm_oss_open_file(struct file *file,
>  		}
>  
>  		pcm_oss_file->streams[idx] = substream;
> -		substream->file = pcm_oss_file;
>  		snd_pcm_oss_init_substream(substream, &setup[idx], minor);
>  	}
>  	
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 26afb6b0889a..63640d3af9db 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2452,10 +2452,8 @@ static int snd_pcm_open_file(struct file *file,
>  		return -ENOMEM;
>  	}
>  	pcm_file->substream = substream;
> -	if (substream->ref_count == 1) {
> -		substream->file = pcm_file;
> +	if (substream->ref_count == 1)
>  		substream->pcm_release = pcm_release_private;
> -	}
>  	file->private_data = pcm_file;
>  
>  	return 0;
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
