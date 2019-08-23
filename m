From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Make some functions static
Date: Fri, 23 Aug 2019 16:19:17 +0300
Message-ID: <CAEnQRZA3reBF=H58596-e1xRLHLz5pVHZVhVgiXEmbV-wwOctg@mail.gmail.com>
References: <20190823125939.30012-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823125939.30012-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 23, 2019 at 4:12 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> sound/soc/sof/imx/imx8.c:104:6: warning: symbol 'imx8_dsp_handle_reply' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:115:6: warning: symbol 'imx8_dsp_handle_request' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:336:5: warning: symbol 'imx8_get_bar_index' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:341:6: warning: symbol 'imx8_ipc_msg_data' was not declared. Should it be static?
> sound/soc/sof/imx/imx8.c:348:5: warning: symbol 'imx8_ipc_pcm_params' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/sof/imx/imx8.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index e502f58..6404724 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -101,7 +101,7 @@ static int imx8_get_window_offset(struct snd_sof_dev *sdev, u32 id)
>         return MBOX_OFFSET;
>  }
>
> -void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
> +static void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
>  {
>         struct imx8_priv *priv = imx_dsp_get_data(ipc);
>         unsigned long flags;
> @@ -112,7 +112,7 @@ void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
>         spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
>  }
>
> -void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
> +static void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
>  {
>         struct imx8_priv *priv = imx_dsp_get_data(ipc);
>
> @@ -333,21 +333,21 @@ static int imx8_remove(struct snd_sof_dev *sdev)
>  }
>
>  /* on i.MX8 there is 1 to 1 match between type and BAR idx */
> -int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
> +static int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
>  {
>         return type;
>  }
>
> -void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
> -                      struct snd_pcm_substream *substream,
> -                      void *p, size_t sz)
> +static void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
> +                             struct snd_pcm_substream *substream,
> +                             void *p, size_t sz)
>  {
>         sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
>  }
>
> -int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
> -                       struct snd_pcm_substream *substream,
> -                       const struct sof_ipc_pcm_params_reply *reply)
> +static int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
> +                              struct snd_pcm_substream *substream,
> +                              const struct sof_ipc_pcm_params_reply *reply)
>  {
>         return 0;
>  }
> --
> 2.7.4
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
