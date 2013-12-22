From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 11/19] ASoC: omap: Don't set unused struct
 snd_pcm_hardware fields
Date: Sun, 22 Dec 2013 19:19:37 +0200
Message-ID: <20131222191937.a052d297b58bb6d06aead382@bitmer.com>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 68432261A3B
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2013 18:20:19 +0100 (CET)
In-Reply-To: <1387545625-19240-11-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Dec 2013 14:20:17 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  sound/soc/omap/omap-pcm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index b8fa986..07b8b7b 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -45,8 +45,6 @@ static const struct snd_pcm_hardware omap_pcm_hardware = {
>  				  SNDRV_PCM_INFO_PAUSE |
>  				  SNDRV_PCM_INFO_RESUME |
>  				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> -	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
> -				  SNDRV_PCM_FMTBIT_S32_LE,
Ok, I see it's overwritten here:

soc_pcm_init_runtime_hw()
hw->formats = codec_stream->formats & cpu_stream->formats;

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
