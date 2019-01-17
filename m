From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/5] ASoC: imx-sgtl5000: put of nodes if
 finding codec fails
Date: Thu, 17 Jan 2019 12:04:05 +0200
Message-ID: <CAEnQRZDUYGnU5+G0jd_o0yH4qYjrWtdPEB7O4TfMvtpYzJPO1Q@mail.gmail.com>
References: <20190117090640.12972-1-stefan@agner.ch> <20190117090640.12972-4-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190117090640.12972-4-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 17, 2019 at 11:07 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Make sure to properly put the of node in case finding the codec
> fails.
>
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index e1e20499b2f1..45969e6dfad7 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -111,7 +111,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>         codec_dev = of_find_i2c_device_by_node(codec_np);
>         if (!codec_dev) {
>                 dev_err(&pdev->dev, "failed to find codec platform device\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;
> +               goto fail;
>         }
>
>         data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> --
> 2.20.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
