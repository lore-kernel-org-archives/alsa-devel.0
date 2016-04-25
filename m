From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 6/6] ASoC: fsl_ssi: Fix channel slipping
 on capture (or playback) restart in full duplex.
Date: Mon, 25 Apr 2016 10:22:42 -0700
Message-ID: <CAG5mAdxC4FhxXMT3Z-mXEtA+20SH8WOogP=Y8Y7RFZ4uwJr+tw@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-7-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D91A265344
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 19:23:02 +0200 (CEST)
Received: by mail-oi0-f50.google.com with SMTP id r78so183868430oie.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 10:23:02 -0700 (PDT)
In-Reply-To: <1453130771-24419-7-git-send-email-arnaud.mouiche@invoxia.com>
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
> Happened when the Playback (or Capture) is running continuously
> and Capture (or Playback) is restarted (xrun, manual stop/start...)
>
> Since the RX (or TX) FIFO are only reset when the whole SSI is disabled,
> pending samples from previous capture (or playback) session may still
> be present. They must be erased to not introduce channel slipping.
>
> FIFO Clear register fields are documented in IMX51, IMX35 reference manual.
> They are not documented in IMX50 or IMX6 RM, despite they are
> working as expected on IMX6SL and IMX6solo.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 530d592..50218ed 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -146,6 +146,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
>         case CCSR_SSI_SRX1:
>         case CCSR_SSI_SISR:
>         case CCSR_SSI_SFCSR:
> +       case CCSR_SSI_SOR:
>         case CCSR_SSI_SACNT:
>         case CCSR_SSI_SACADD:
>         case CCSR_SSI_SACDAT:
> @@ -414,6 +415,26 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
>  }
>
>  /*
> + * Clear RX or TX FIFO to remove samples from the previous
> + * stream session which may be still present in the FIFO and
> + * may introduce bad samples and/or channel slipping.
> + *
> + * Note: The SOR is not documented in recent IMX datasheet, but
> + * is described in IMX51 reference manual at section 56.3.3.15.
> + */
> +static void fsl_ssi_fifo_clear(struct fsl_ssi_private *ssi_private,
> +               bool is_rx)
> +{
> +       if (is_rx) {
> +               regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
> +                       CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
> +       } else {
> +               regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
> +                       CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
> +       }
> +}
> +
> +/*
>   * Calculate the bits that have to be disabled for the current stream that is
>   * getting disabled. This keeps the bits enabled that are necessary for the
>   * second stream to work if 'stream_active' is true.
> @@ -488,6 +509,8 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>          * (online configuration)
>          */
>         if (enable) {
> +               fsl_ssi_fifo_clear(ssi_private, vals->scr & CCSR_SSI_SCR_RE);
> +
>                 regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
>                 regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
>                 regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
> --
> 1.9.1
>

Tested-By: Caleb Crome <caleb@crome.org>
Reviewed-"By: Caleb Crome <caleb@crome.org>
