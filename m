From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 5/6] ASoC: fsl_ssi: Fix channel slipping
 in Playback at startup
Date: Mon, 25 Apr 2016 10:22:29 -0700
Message-ID: <CAG5mAdw6AgH__kYV6u465E+bfHfW6D6icRgtWVE6_e-1M_dZqw@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-6-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 10D59265068
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 19:22:49 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id x19so49471228oix.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 10:22:49 -0700 (PDT)
In-Reply-To: <1453130771-24419-6-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 7:26 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> Previously, SCR.SSIEN and SCR.TE were enabled at once if no capture
> stream was also running.
> This may not give a chance for the DMA to write the first sample in
> TX FIFO before the streaming starts on the PCM bus, inserting void
> samples first.
> Those void samples are then responsible for slipping the channels.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index c9ba8ca..530d592 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -520,8 +520,40 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>
>  config_done:
>         /* Enabling of subunits is done after configuration */
> -       if (enable)
> +       if (enable) {
> +               if (ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
> +                       /*
> +                        * Be sure the Tx FIFO is filled when TE is set.
> +                        * Otherwise, there are some chances to start the
> +                        * playback with some void samples inserted first,
> +                        * generating a channel slip.
> +                        *
> +                        * First, SSIEN must be set, to let the FIFO be filled.
> +                        *
> +                        * Notes:
> +                        * - Limit this fix to the DMA case until FIQ cases can
> +                        *   be tested.
> +                        * - Limit the length of the busy loop to not lock the
> +                        *   system too long, even if 1-2 loops are sufficient
> +                        *   in general.
> +                        */
> +                       int i;
> +                       int max_loop = 100;
> +                       regmap_update_bits(regs, CCSR_SSI_SCR,
> +                                       CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
> +                       for (i = 0; i < max_loop; i++) {
> +                               u32 sfcsr;
> +                               regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
> +                               if (CCSR_SSI_SFCSR_TFCNT0(sfcsr))
> +                                       break;
> +                       }
> +                       if (i == max_loop) {
> +                               dev_err(ssi_private->dev,
> +                                       "Timeout waiting TX FIFO filling\n");
> +                       }
> +               }
>                 regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
> +       }
>  }
>
>
> --
> 1.9.1
>

Tested-By: Caleb Crome <caleb@crome.org>
Reviewed-"By: Caleb Crome <caleb@crome.org>
