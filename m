From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] ASoC: amd: added error checks in dma driver
Date: Thu, 23 Nov 2017 08:59:43 -0800
Message-ID: <CABXOdTezJbmEU=Oa+G1NN+WHoZqJERH8DAapJqgbPXkLnyweLw@mail.gmail.com>
References: <1511454602-7259-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511454602-7259-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, perex@perex.cz, Alex Deucher <Alexander.Deucher@amd.com>, Akshu.Agrawal@amd.com, Guenter Roeck <linux@roeck-us.net>, linux-kernel <linux-kernel@vger.kernel.org>, Dominik Behr <dbehr@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Guenter Roeck <groeck@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 23, 2017 at 8:30 AM, Vijendar Mukunda
<Vijendar.Mukunda@amd.com> wrote:
> added error checks in acp dma driver
>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Akshu Agrawal <Akshu.Agrawal@amd.com>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>

This is inappropriate.

Guenter

> ---
>  sound/soc/amd/acp-pcm-dma.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 17d76fa..804e659 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -848,6 +848,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
>         struct snd_pcm_runtime *runtime = substream->runtime;
>         struct audio_substream_data *rtd = runtime->private_data;
>
> +       if (!rtd)
> +               return -EINVAL;
> +
>         buffersize = frames_to_bytes(runtime, runtime->buffer_size);
>         bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
>
> @@ -873,6 +876,8 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
>         struct snd_pcm_runtime *runtime = substream->runtime;
>         struct audio_substream_data *rtd = runtime->private_data;
>
> +       if (!rtd)
> +               return -EINVAL;
>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                 config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
>                                         PLAYBACK_START_DMA_DESCR_CH12,
> @@ -1066,6 +1071,10 @@ static int acp_audio_probe(struct platform_device *pdev)
>         struct resource *res;
>         const u32 *pdata = pdev->dev.platform_data;
>
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "Missing platform data\n");
> +               return -ENODEV;
> +       }
>         audio_drv_data = devm_kzalloc(&pdev->dev, sizeof(struct audio_drv_data),
>                                         GFP_KERNEL);
>         if (audio_drv_data == NULL)
> @@ -1074,6 +1083,8 @@ static int acp_audio_probe(struct platform_device *pdev)
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         audio_drv_data->acp_mmio = devm_ioremap_resource(&pdev->dev, res);
>
> +       if (IS_ERR(audio_drv_data->acp_mmio))
> +               return PTR_ERR(audio_drv_data->acp_mmio);
>         /* The following members gets populated in device 'open'
>          * function. Till then interrupts are disabled in 'acp_init'
>          * and device doesn't generate any interrupts.
> @@ -1099,7 +1110,11 @@ static int acp_audio_probe(struct platform_device *pdev)
>         dev_set_drvdata(&pdev->dev, audio_drv_data);
>
>         /* Initialize the ACP */
> -       acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
> +       status = acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
> +       if (status) {
> +               dev_err(&pdev->dev, "ACP Init failed\n");
> +               return status;
> +       }
>
>         status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
>         if (status != 0) {
> @@ -1116,9 +1131,14 @@ static int acp_audio_probe(struct platform_device *pdev)
>
>  static int acp_audio_remove(struct platform_device *pdev)
>  {
> +       int status;
>         struct audio_drv_data *adata = dev_get_drvdata(&pdev->dev);
>
> -       acp_deinit(adata->acp_mmio);
> +       status = acp_deinit(adata->acp_mmio);
> +       if (status) {
> +               dev_err(&pdev->dev, "ACP Deinit failed\n");
> +               return status;
> +       }
>         snd_soc_unregister_platform(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
>
> @@ -1128,9 +1148,14 @@ static int acp_audio_remove(struct platform_device *pdev)
>  static int acp_pcm_resume(struct device *dev)
>  {
>         u16 bank;
> +       int status;
>         struct audio_drv_data *adata = dev_get_drvdata(dev);
>
> -       acp_init(adata->acp_mmio, adata->asic_type);
> +       status = acp_init(adata->acp_mmio, adata->asic_type);
> +       if (status) {
> +               dev_err(dev, "ACP Init failed\n");
> +               return status;
> +       }
>
>         if (adata->play_stream && adata->play_stream->runtime) {
>                 /* For Stoney, Memory gating is disabled,i.e SRAM Banks
> @@ -1162,18 +1187,28 @@ static int acp_pcm_resume(struct device *dev)
>
>  static int acp_pcm_runtime_suspend(struct device *dev)
>  {
> +       int status;
>         struct audio_drv_data *adata = dev_get_drvdata(dev);
>
> -       acp_deinit(adata->acp_mmio);
> +       status = acp_deinit(adata->acp_mmio);
> +       if (status) {
> +               dev_err(dev, "ACP Deinit failed\n");
> +               return status;
> +       }
>         acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
>         return 0;
>  }
>
>  static int acp_pcm_runtime_resume(struct device *dev)
>  {
> +       int status;
>         struct audio_drv_data *adata = dev_get_drvdata(dev);
>
> -       acp_init(adata->acp_mmio, adata->asic_type);
> +       status = acp_init(adata->acp_mmio, adata->asic_type);
> +       if (status) {
> +               dev_err(dev, "ACP Init failed\n");
> +               return status;
> +       }
>         acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
>         return 0;
>  }
> --
> 2.7.4
>
