From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: oss: consolidate kmalloc/memset 0
 call to kzalloc
Date: Fri, 18 Dec 2015 17:08:49 -0500
Message-ID: <20151218170849.2a287c40.drivshin.allworx@gmail.com>
References: <1450468917-32150-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450468917-32150-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 18 Dec 2015 21:01:57 +0100
Nicholas Mc Guire <hofrat@osadl.org> wrote:

> This is an API consolidation only. The use of kmalloc + memset to 0
> is equivalent to kzalloc.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Found by coccinelle script (relaxed version of
> scripts/coccinelle/api/alloc/kzalloc-simple.cocci)
> 
> Patch was compile tested with: x86_64_defconfig
> CONFIG_SND_PCM_OSS=y
> 
> Patch is against linux-next (localversion-next is -next-20150518)
> 
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index e557dbe..8cdd06f 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -850,7 +850,7 @@ static int snd_pcm_oss_change_params(struct
> snd_pcm_substream *substream) 
>  	if (mutex_lock_interruptible(&runtime->oss.params_lock))
>  		return -EINTR;
> -	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
> +	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
                     ^
Something odd (manual edit?) seems to have happened to this hunk, 
making it a no-op. I presume that 'm' was supposed to be a 'z'.

>  	params = kmalloc(sizeof(*params), GFP_KERNEL);
>  	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
>  	if (!sw_params || !params || !sparams) {
> @@ -988,7 +988,6 @@ static int snd_pcm_oss_change_params(struct
> snd_pcm_substream *substream) goto failure;
>  	}
>  
> -	memset(sw_params, 0, sizeof(*sw_params));
>  	if (runtime->oss.trigger) {
>  		sw_params->start_threshold = 1;
>  	} else {
