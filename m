From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: aloop: Support S24 sample formats
Date: Mon, 25 Mar 2019 16:35:20 +0100
Message-ID: <5e015489-8705-0aa4-dfde-78854a49f6be@perex.cz>
References: <1553526854-16921-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1553526854-16921-1-git-send-email-twischer@de.adit-jv.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: twischer@de.adit-jv.com, patch@alsa-project.org, broonie@kernel.org, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dne 25. 03. 19 v 16:14 twischer@de.adit-jv.com napsal(a):
> From: Timo Wischer <twischer@de.adit-jv.com>
> 
> Currently snd_aloop supports only S16 and S32 audio sample formats. With
> this patch the S24 formats are also supported.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> 
> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
> ---
>  sound/drivers/aloop.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
> index 8c3fbe1..c14e57b 100644
> --- a/sound/drivers/aloop.c
> +++ b/sound/drivers/aloop.c
> @@ -337,7 +337,7 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
>  
>  	loopback_timer_stop_sync(dpcm);
>  
> -	salign = (snd_pcm_format_width(runtime->format) *
> +	salign = (snd_pcm_format_physical_width(runtime->format) *
>  						runtime->channels) / 8;
>  	bps = salign * runtime->rate;
>  	if (bps <= 0 || salign <= 0)
> @@ -562,6 +562,8 @@ static const struct snd_pcm_hardware loopback_pcm_hardware =
>  			 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE |
>  			 SNDRV_PCM_INFO_RESUME),
>  	.formats =	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |
> +			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_3BE |
>  			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |
>  			 SNDRV_PCM_FMTBIT_FLOAT_LE | SNDRV_PCM_FMTBIT_FLOAT_BE),
>  	.rates =	SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_192000,
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
