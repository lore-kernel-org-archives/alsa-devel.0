From: Liam Girdwood <lrg@ti.com>
Subject: Re: Recording doesn't end gracefully
Date: Tue, 5 Jul 2011 12:21:24 +0100
Message-ID: <4E12F3B4.7030408@ti.com>
References: <20110705102521.GB10296@santoshs.mistral.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E50D2461C
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 13:21:31 +0200 (CEST)
In-Reply-To: <20110705102521.GB10296@santoshs.mistral.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Santosh Sivaraj <santoshs@fossix.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 05/07/11 11:25, Santosh Sivaraj wrote:
> Hi all,
> 
> We were working on 1.0.23 version of the ALSA driver. In the following
> scenario we are getting some issues with recording.
> 

It's helpful also to state which platform and codec drivers you are using here.

> * Play some music in the sound player in the background
> * Open recorder and start recording
> * Since playback and recording can't happen simultaneously, we explicitly
>   reset the codec device and configure it for recording.
> * In this case, after some time the codec driver is powered off by the
>   soc-core and only silence is recorded.
> 
> All this were done from the Android UI. When the same is repeated from the
> command line with aplay and arecord we see that aplay is stopped and
> recording works fine.
> 

Ok, can you trace the android alsa calls ? Do you know what is different ?

> When we debugged the problem, we found that the following diff seems to get rid
> of the above problem:
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index c984996..247f4ee 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -773,7 +773,8 @@ int snd_soc_pcm_close(struct snd_pcm_substream *substream)
>         /* Muting the DAC suppresses artifacts caused during digital
>          * shutdown, for example from stopping clocks.
>          */
> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +       if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
> +           (substream->stream == SNDRV_PCM_STREAM_CAPTURE))
>                 snd_soc_dai_digital_mute(codec_dai, 1);
>  

Ok, this check is so that we only mute the DAC when we are shutting down a playback stream. This change would always mute the DAC (even when playback is active and closing a capture stream).

>         if (cpu_dai->driver->ops->shutdown)
> @@ -869,7 +870,8 @@ int snd_soc_pcm_prepare(struct snd_pcm_substream *substream)
>         }
>  
>         /* cancel any delayed stream shutdown that is pending */
> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
> +       if (((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
> +            (substream->stream == SNDRV_PCM_STREAM_CAPTURE))  &&
>             codec_dai->pop_wait) {
>                 codec_dai->pop_wait = 0;
>                 cancel_delayed_work(&rtd->delayed_work);
> 
> I am not aware of what consequences/side effects these changes can cause,
> please advice, whether it is a problem elsewhere
> 

Again this creates a conflict between any playback and capture streams. i.e. starting a new capture stream will stop an old playback stream from shutting down correctly.

I think the issue here may either be with your component drivers or your Android userspace is doing something different with it's alsa-lib calls.

Regards

Liam
