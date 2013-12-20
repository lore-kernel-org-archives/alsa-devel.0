From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 02/19] ASoC: au1x: Don't set unused struct
 snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 16:24:26 +0100
Message-ID: <CAOLZvyEs+KE0XVvKeocOj-VmAgR0mpPz0nRUQUmWZDUq_qe6kQ@mail.gmail.com>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AF2C26084B
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 16:25:07 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id w61so2640898wes.28
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 07:25:07 -0800 (PST)
In-Reply-To: <1387545625-19240-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: alsa-devel@alsa-project.org

My Alchemy hardware likes it.

Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

On Fri, Dec 20, 2013 at 2:20 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
>  sound/soc/au1x/dbdma2.c |  9 ---------
>  sound/soc/au1x/dma.c    | 14 --------------
>  2 files changed, 23 deletions(-)
>
> diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
> index 3b4eafa..17a24d8 100644
> --- a/sound/soc/au1x/dbdma2.c
> +++ b/sound/soc/au1x/dbdma2.c
> @@ -65,19 +65,10 @@ struct au1xpsc_audio_dmadata {
>  #define AU1XPSC_PERIOD_MIN_BYTES       1024
>  #define AU1XPSC_BUFFER_MIN_BYTES       65536
>
> -#define AU1XPSC_PCM_FMTS                                       \
> -       (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |        \
> -        SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |    \
> -        SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |    \
> -        SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |    \
> -        SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |    \
> -        0)
> -
>  /* PCM hardware DMA capabilities - platform specific */
>  static const struct snd_pcm_hardware au1xpsc_pcm_hardware = {
>         .info             = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>                             SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BATCH,
> -       .formats          = AU1XPSC_PCM_FMTS,
>         .period_bytes_min = AU1XPSC_PERIOD_MIN_BYTES,
>         .period_bytes_max = 4096 * 1024 - 1,
>         .periods_min      = 2,
> diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
> index befd107..e920b60 100644
> --- a/sound/soc/au1x/dma.c
> +++ b/sound/soc/au1x/dma.c
> @@ -21,14 +21,6 @@
>
>  #include "psc.h"
>
> -#define ALCHEMY_PCM_FMTS                                       \
> -       (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |        \
> -        SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |    \
> -        SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |    \
> -        SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |    \
> -        SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |    \
> -        0)
> -
>  struct pcm_period {
>         u32 start;
>         u32 relative_end;       /* relative to start of buffer */
> @@ -171,12 +163,6 @@ static irqreturn_t au1000_dma_interrupt(int irq, void *ptr)
>  static const struct snd_pcm_hardware alchemy_pcm_hardware = {
>         .info             = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>                             SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BATCH,
> -       .formats          = ALCHEMY_PCM_FMTS,
> -       .rates            = SNDRV_PCM_RATE_8000_192000,
> -       .rate_min         = SNDRV_PCM_RATE_8000,
> -       .rate_max         = SNDRV_PCM_RATE_192000,
> -       .channels_min     = 2,
> -       .channels_max     = 2,
>         .period_bytes_min = 1024,
>         .period_bytes_max = 16 * 1024 - 1,
>         .periods_min      = 4,
> --
> 1.8.0
>
