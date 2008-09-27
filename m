From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] ASoC Blackfin: fix bug - Audio Latency
	on AD1981 with MMAP enabled
Date: Sat, 27 Sep 2008 21:53:25 +0800
Message-ID: <386072610809270653p2d6cf75u40dc6816cb8a99cc@mail.gmail.com>
References: <1222523356-710-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17]) by alsa0.perex.cz (Postfix) with ESMTP id D7BBF243AF
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 15:53:26 +0200 (CEST)
Received: by gxk10 with SMTP id 10so10756627gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 06:53:26 -0700 (PDT)
In-Reply-To: <1222523356-710-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

sorry for this mess. Please ignore this one. My script made some mistake.

-Bryan

On Sat, Sep 27, 2008 at 9:49 PM, Bryan Wu <cooloney@kernel.org> wrote:
> From: Cliff Cai <cliff.cai@analog.com>
>
> With MMAP enabled (DMA mode) on the AD1981, there is +/- 250ms of delay between
> writing data to alsa and audio starts coming out of the AD1981.
>
> Copy more data to local buffer before starting DMA
>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> ---
>  sound/soc/blackfin/bf5xx-ac97-pcm.c |   42 +++++++++++++++++++++++++++++-----
>  sound/soc/blackfin/bf5xx-ac97.c     |    1 -
>  sound/soc/blackfin/bf5xx-sport.h    |    2 +
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
> index 51f4907..25e50d2 100644
> --- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
> +++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
> @@ -56,6 +56,7 @@ static void bf5xx_mmap_copy(struct snd_pcm_substream *substream,
>                sport->tx_pos += runtime->period_size;
>                if (sport->tx_pos >= runtime->buffer_size)
>                        sport->tx_pos %= runtime->buffer_size;
> +               sport->tx_delay_pos = sport->tx_pos;
>        } else {
>                bf5xx_ac97_to_pcm(
>                        (struct ac97_frame *)sport->rx_dma_buf + sport->rx_pos,
> @@ -72,7 +73,15 @@ static void bf5xx_dma_irq(void *data)
>        struct snd_pcm_substream *pcm = data;
>  #if defined(CONFIG_SND_MMAP_SUPPORT)
>        struct snd_pcm_runtime *runtime = pcm->runtime;
> +       struct sport_device *sport = runtime->private_data;
>        bf5xx_mmap_copy(pcm, runtime->period_size);
> +       if (pcm->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               if (sport->once == 0) {
> +                       snd_pcm_period_elapsed(pcm);
> +                       bf5xx_mmap_copy(pcm, runtime->period_size);
> +                       sport->once = 1;
> +               }
> +       }
>  #endif
>        snd_pcm_period_elapsed(pcm);
>  }
> @@ -114,6 +123,10 @@ static int bf5xx_pcm_hw_params(struct snd_pcm_substream *substream,
>
>  static int bf5xx_pcm_hw_free(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +       memset(runtime->dma_area, 0, runtime->buffer_size);
>        snd_pcm_lib_free_pages(substream);
>        return 0;
>  }
> @@ -127,16 +140,11 @@ static int bf5xx_pcm_prepare(struct snd_pcm_substream *substream)
>         * SPORT working in TMD mode(include AC97).
>         */
>  #if defined(CONFIG_SND_MMAP_SUPPORT)
> -       size_t size = bf5xx_pcm_hardware.buffer_bytes_max
> -                       * sizeof(struct ac97_frame) / 4;
> -       /*clean up intermediate buffer*/
>        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               memset(sport->tx_dma_buf, 0, size);
>                sport_set_tx_callback(sport, bf5xx_dma_irq, substream);
>                sport_config_tx_dma(sport, sport->tx_dma_buf, runtime->periods,
>                        runtime->period_size * sizeof(struct ac97_frame));
>        } else {
> -               memset(sport->rx_dma_buf, 0, size);
>                sport_set_rx_callback(sport, bf5xx_dma_irq, substream);
>                sport_config_rx_dma(sport, sport->rx_dma_buf, runtime->periods,
>                        runtime->period_size * sizeof(struct ac97_frame));
> @@ -164,8 +172,12 @@ static int bf5xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>        pr_debug("%s enter\n", __func__);
>        switch (cmd) {
>        case SNDRV_PCM_TRIGGER_START:
> -               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +                       bf5xx_mmap_copy(substream, runtime->period_size);
> +                       snd_pcm_period_elapsed(substream);
> +                       sport->tx_delay_pos = 0;
>                        sport_tx_start(sport);
> +               }
>                else
>                        sport_rx_start(sport);
>                break;
> @@ -198,7 +210,7 @@ static snd_pcm_uframes_t bf5xx_pcm_pointer(struct snd_pcm_substream *substream)
>
>  #if defined(CONFIG_SND_MMAP_SUPPORT)
>        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -               curr = sport->tx_pos;
> +               curr = sport->tx_delay_pos;
>        else
>                curr = sport->rx_pos;
>  #else
> @@ -237,6 +249,21 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
>        return ret;
>  }
>
> +static int bf5xx_pcm_close(struct snd_pcm_substream *substream)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       struct sport_device *sport = runtime->private_data;
> +
> +       pr_debug("%s enter\n", __func__);
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               sport->once = 0;
> +               memset(sport->tx_dma_buf, 0, runtime->buffer_size * sizeof(struct ac97_frame));
> +       } else
> +               memset(sport->rx_dma_buf, 0, runtime->buffer_size * sizeof(struct ac97_frame));
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_SND_MMAP_SUPPORT
>  static int bf5xx_pcm_mmap(struct snd_pcm_substream *substream,
>        struct vm_area_struct *vma)
> @@ -272,6 +299,7 @@ static      int bf5xx_pcm_copy(struct snd_pcm_substream *substream, int channel,
>
>  struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
>        .open           = bf5xx_pcm_open,
> +       .close          = bf5xx_pcm_close,
>        .ioctl          = snd_pcm_lib_ioctl,
>        .hw_params      = bf5xx_pcm_hw_params,
>        .hw_free        = bf5xx_pcm_hw_free,
> diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
> index c782e31..5e5aafb 100644
> --- a/sound/soc/blackfin/bf5xx-ac97.c
> +++ b/sound/soc/blackfin/bf5xx-ac97.c
> @@ -129,7 +129,6 @@ static void enqueue_cmd(struct snd_ac97 *ac97, __u16 addr, __u16 data)
>        struct ac97_frame *nextwrite;
>
>        sport_incfrag(sport, &nextfrag, 1);
> -       sport_incfrag(sport, &nextfrag, 1);
>
>        nextwrite = (struct ac97_frame *)(sport->tx_buf + \
>                        nextfrag * sport->tx_fragsize);
> diff --git a/sound/soc/blackfin/bf5xx-sport.h b/sound/soc/blackfin/bf5xx-sport.h
> index 4c16345..fcadcc0 100644
> --- a/sound/soc/blackfin/bf5xx-sport.h
> +++ b/sound/soc/blackfin/bf5xx-sport.h
> @@ -123,6 +123,8 @@ struct sport_device {
>        int rx_pos;
>        unsigned int tx_buffer_size;
>        unsigned int rx_buffer_size;
> +       int tx_delay_pos;
> +       int once;
>  #endif
>        void *private_data;
>  };
> --
> 1.5.6
>
>
