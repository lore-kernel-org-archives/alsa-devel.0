From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - JACK PCM 1/1] jack: Use correct parameter
 order for snd_pcm_areas_silence()
Date: Wed, 21 Mar 2018 13:11:04 +0100
Message-ID: <463bf5ea-bfa1-42cc-ba22-5d8561c8c9d5@perex.cz>
References: <1521632552-24858-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 050052672B9
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 13:11:07 +0100 (CET)
In-Reply-To: <1521632552-24858-1-git-send-email-twischer@de.adit-jv.com>
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
To: twischer@de.adit-jv.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 21.3.2018 v 12:42 twischer@de.adit-jv.com napsal(a):
> From: Timo Wischer <twischer@de.adit-jv.com>
> 
> Without this fix it will sometimes fail with a segmentation fault.
Applied. Thanks.

					Jaroslav


> 
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> 
> diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
> index a655668..e3df4d2 100644
> --- a/jack/pcm_jack.c
> +++ b/jack/pcm_jack.c
> @@ -200,7 +200,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
>  		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
>  			const snd_pcm_uframes_t frames = nframes - xfer;
>  
> -			snd_pcm_areas_silence(jack->areas, io->channels, xfer,
> +			snd_pcm_areas_silence(jack->areas, xfer, io->channels,
>  					      frames, io->format);
>  		}


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
