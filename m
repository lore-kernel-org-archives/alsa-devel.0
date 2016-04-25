From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 4/6] ASoC: fsl_ssi: Fix samples being
 dropped as Playback startup
Date: Mon, 25 Apr 2016 10:22:11 -0700
Message-ID: <CAG5mAdzh+uK3EhbxCq6vHx940PDsgdpaxccCMHDdccpqr98sFg@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-5-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B54EB2656EB
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 19:22:31 +0200 (CEST)
Received: by mail-oi0-f41.google.com with SMTP id r78so183852677oie.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 10:22:31 -0700 (PDT)
In-Reply-To: <1453130771-24419-5-git-send-email-arnaud.mouiche@invoxia.com>
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
>
> If the capture is already running while playback is started, it is highly
> probable (>80% in a 8 channels scenario) that samples are lost between
> the DMA and TX fifo.
>
> The reason is that SIER.TDMAE is set before STCR.TFEN0, leaving a time
> window where the FIFO doesn't receive the samples written by the DMA.
>
> This particular case happened only if capture is already enabled as
> SCR.SSIEN is already set at the playback startup instant.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 13613fd..c9ba8ca 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -488,9 +488,9 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
>          * (online configuration)
>          */
>         if (enable) {
> -               regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
>                 regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
>                 regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
> +               regmap_update_bits(regs, CCSR_SSI_SIER, vals->sier, vals->sier);
>         } else {
>                 u32 sier;
>                 u32 srcr;
> --
> 1.9.1
>


Tested-By: Caleb Crome <caleb@crome.org>
Reviewed-"By: Caleb Crome <caleb@crome.org>
