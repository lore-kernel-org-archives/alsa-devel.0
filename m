From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 11/19] ASoC: omap: Don't set unused struct
 snd_pcm_hardware fields
Date: Mon, 23 Dec 2013 09:04:35 +0200
Message-ID: <52B7E083.8000001@ti.com>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FE48260202
 for <alsa-devel@alsa-project.org>; Mon, 23 Dec 2013 08:04:41 +0100 (CET)
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
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 12/20/2013 03:20 PM, Lars-Peter Clausen wrote:
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
>  	.period_bytes_min	= 32,
>  	.period_bytes_max	= 64 * 1024,
>  	.periods_min		= 2,

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
