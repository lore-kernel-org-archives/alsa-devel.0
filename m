From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 1/2] ASoC: ak4458: rstn_control - return a
 non-zero on error only
Date: Mon, 13 May 2019 14:12:22 +0300
Message-ID: <CAEnQRZAwz+g_-xKwhECYz=Zc6phFrfj0PE22qXJa2sfAAci7JQ@mail.gmail.com>
References: <1557741724-6859-1-git-send-email-viorel.suman@nxp.com> <1557741724-6859-2-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557741724-6859-2-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Colin Ian King <colin.king@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 13, 2019 at 1:04 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> snd_soc_component_update_bits() may return 1 if operation
> was successful and the value of the register changed.
> Return a non-zero in ak4458_rstn_control for an error only.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  sound/soc/codecs/ak4458.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
> index eab7c76..baf990a 100644
> --- a/sound/soc/codecs/ak4458.c
> +++ b/sound/soc/codecs/ak4458.c
> @@ -304,7 +304,10 @@ static int ak4458_rstn_control(struct snd_soc_component *component, int bit)
>                                           AK4458_00_CONTROL1,
>                                           AK4458_RSTN_MASK,
>                                           0x0);
> -       return ret;
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
>  }
>
>  static int ak4458_hw_params(struct snd_pcm_substream *substream,
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
