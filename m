From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: Re: SALSA-Lib: Playback overrun on initial PCM start
Date: Fri, 29 Jun 2007 13:33:46 -0400
Message-ID: <20070629133346.74ab86b7.alsauser@pragmasoft.com>
References: <20070628150108.271f4493.alsauser@pragmasoft.com>
	<s5hmyyjcdtv.wl%tiwai@suse.de>
	<20070629112409.27e67cea.alsauser@pragmasoft.com>
	<s5hbqeyd9s7.wl%tiwai@suse.de>
	<20070629122645.13f25b63.Scott@PragmaSoft.com>
	<s5h7ipmd6nf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 43C0B2455A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 19:30:40 +0200 (CEST)
In-Reply-To: <s5h7ipmd6nf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Jun 2007 19:15:00 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 29 Jun 2007 12:26:45 -0400,
> J. Scott Merritt wrote:
> > 
> > I no longer get the PlayBack overrun on PCM start.  However, it appears
> > that "poll" or the snd_pcm_sw_params_set_avail_min (=4096) is not being
> > properly honored.  With the normal alsa-lib, when the "poll" returns
> > snd_pcm_avail_update reports that space is available for 4096 frames.
> > However, in my initial testing, when running with SALSA lib, only about
> > 100 frames or so are available when the poll returns.
> > 
> > I will examine this more closely.
> 
> Found out another bug.  Try the patch below.
> 
> Thanks for reporting!
> 
> 
> Takashi
> 
> diff -r ad2c81608e10 src/pcm.c
> --- a/src/pcm.c	Fri Jun 29 17:59:52 2007 +0200
> +++ b/src/pcm.c	Fri Jun 29 19:12:04 2007 +0200
> @@ -857,6 +857,7 @@ static int snd_pcm_hw_mmap_status(snd_pc
>  		pcm->mmap_status = NULL;
>  		goto no_mmap;
>  	}
> +	pcm->mmap_control->avail_min = 1;
>  	return 0;
>  
>   no_mmap:
> @@ -865,6 +866,7 @@ static int snd_pcm_hw_mmap_status(snd_pc
>  		return -ENOMEM;
>  	pcm->mmap_status = &pcm->sync_ptr->s.status;
>  	pcm->mmap_control = &pcm->sync_ptr->c.control;
> +	pcm->mmap_control->avail_min = 1;
>  	_snd_pcm_sync_ptr(pcm, 0);
>  	return 0;
>  }
> diff -r ad2c81608e10 src/pcm_params.c
> --- a/src/pcm_params.c	Fri Jun 29 17:59:52 2007 +0200
> +++ b/src/pcm_params.c	Fri Jun 29 19:12:04 2007 +0200
> @@ -1052,6 +1052,7 @@ int snd_pcm_sw_params(snd_pcm_t *pcm, sn
>  	if (ioctl(pcm->fd, SNDRV_PCM_IOCTL_SW_PARAMS, params) < 0)
>  		return -errno;
>  	pcm->sw_params = *params;
> +	pcm->mmap_control->avail_min = params->avail_min;
>  	return 0;
>  }

That did the trick :)

Many thanks for the extremely quick and accurate assistance !

Best regards, Scott.
