From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/19] ASoC: atmel: Don't set unused struct
 snd_pcm_hardware fields
Date: Sat, 04 Jan 2014 19:15:31 +0100
Message-ID: <52C84FC3.9010501@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-079.synserver.de (smtp-out-240.synserver.de
 [212.40.185.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 77F85261AA4
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2014 19:15:11 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

On 12/20/2013 02:20 PM, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Bo Shen <voice.shen@atmel.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  sound/soc/atmel/atmel-pcm-dma.c | 1 -
>  sound/soc/atmel/atmel-pcm-pdc.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
> index 06082e5..b79a2a8 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -50,7 +50,6 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
>  				  SNDRV_PCM_INFO_INTERLEAVED |
>  				  SNDRV_PCM_INFO_RESUME |
>  				  SNDRV_PCM_INFO_PAUSE,
> -	.formats		= SNDRV_PCM_FMTBIT_S16_LE,

Atmel is one of the few platforms where the formats specified for the DMA
controller are more restrictive than the formats specified for the DAI. As
the restrictions specified by the PCM part have been ignored so far I'm
wondering if this is a real restriction and things have only worked by
chance or whether the restriction should be removed?

- Lars
