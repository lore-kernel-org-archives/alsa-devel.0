From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH RFC alsa-lib 1/5] pcm: Add thread-safety
	to	PCM API
Date: Tue, 5 Jul 2016 18:30:36 +0200
Message-ID: <9a7af148-48cf-cb92-7e91-9dce9de7c381@ladisch.de>
References: <20160705152024.20152-1-tiwai@suse.de>
 <20160705152024.20152-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1007026682B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 18:31:22 +0200 (CEST)
In-Reply-To: <20160705152024.20152-2-tiwai@suse.de>
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

Takashi Iwai wrote:
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -686,6 +686,8 @@ snd_pcm_stream_t snd_pcm_stream(snd_pcm_t *pcm)
>   *
>   * Closes the specified PCM handle and frees all associated
>   * resources.
> + *
> + * The function is thread-safe when built with the proper option.
>   */
>  int snd_pcm_close(snd_pcm_t *pcm)
>  {
> @@ -697,6 +699,7 @@ int snd_pcm_close(snd_pcm_t *pcm)
>  		if (err < 0)
>  			res = err;
>  	}
> +	snd_pcm_lock(pcm);
>  	if (pcm->mmap_channels)
>  		snd_pcm_munmap(pcm);
>  	while (!list_empty(&pcm->async_handlers)) {
> @@ -704,6 +707,7 @@ int snd_pcm_close(snd_pcm_t *pcm)
>  		snd_async_del_handler(h);
>  	}
>  	err = pcm->ops->close(pcm->op_arg);
> +	snd_pcm_unlock(pcm);
>  	if (err < 0)
>  		res = err;
>  	err = snd_pcm_free(pcm);

Thread safety does not really make sense for a destructor like
snd_pcm_close().  If any other code is accessing the device at the same
time, the freeing will make it crash anyway.

What would make sense would be to output a debug warning if the device
is locked, and/or to poison the device (maybe ->ops = NULL).


Regards,
Clemens
