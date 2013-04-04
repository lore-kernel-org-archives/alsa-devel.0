From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v5 2/2] ALSA: ASoC: davinci-mcasp: don't
	overwrite DIT settings
Date: Thu, 4 Apr 2013 12:50:50 +0200
Message-ID: <CAGm1_kvPVzesxxUWt2Ao4VNhCJt8j3vc1kOGUinFQ5N2jFQB9w@mail.gmail.com>
References: <1362663483-5886-1-git-send-email-yegorslists@googlemail.com>
 <1362663483-5886-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DB6265E9D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 12:51:10 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id i18so1409595bkv.28
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 03:51:10 -0700 (PDT)
In-Reply-To: <1362663483-5886-2-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: tiwai@suse.de, Yegor Yefremov <yegorslists@googlemail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 7, 2013 at 2:38 PM,  <yegorslists@googlemail.com> wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>
> Channel size settings will be made at the end of
> davinci_mcasp_hw_params() routine and thus overwrite frame
> format settings made for DIT mode. This patch fixes this issue
> by taking op_mode into account. Tested with official PSP 3.2
> kernel and sii9022a HDMI transmitter.
>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> Tested-by: Daniel Mack <zonque@gmail.com>
> ---
> v5: add Daniel's Tested-by
> v4: change subjuct to include "ALSA: ASoC: "
> v3: don't set mask in davinci_hw_dit_param()
> v2: fix checkpatch.pl warnings
>
>  sound/soc/davinci/davinci-mcasp.c |   25 +++++++++++++------------
>  1 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
> index 90a9b99..dcd56f2 100644
> --- a/sound/soc/davinci/davinci-mcasp.c
> +++ b/sound/soc/davinci/davinci-mcasp.c
> @@ -643,16 +643,20 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
>         /* mapping of the XSSZ bit-field as described in the datasheet */
>         fmt = (word_length >> 1) - 1;
>
> -       mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> -                                       RXSSZ(fmt), RXSSZ(0x0F));
> -       mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> -                                       TXSSZ(fmt), TXSSZ(0x0F));
> -       mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
> -                                                       TXROT(7));
> -       mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
> -                                                       RXROT(7));
> +       if (dev->op_mode != DAVINCI_MCASP_DIT_MODE) {
> +               mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +                               RXSSZ(fmt), RXSSZ(0x0F));
> +               mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> +                               TXSSZ(fmt), TXSSZ(0x0F));
> +               mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> +                               TXROT(rotate), TXROT(7));
> +               mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
> +                               RXROT(rotate), RXROT(7));
> +               mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG,
> +                               mask);
> +       }
> +
>         mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
> -       mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
>
>         return 0;
>  }
> @@ -772,9 +776,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
>  /* S/PDIF */
>  static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
>  {
> -       /* TXMASK for 24 bits */
> -       mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
> -
>         /* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
>            and LSB first */
>         mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> --
> 1.7.7
>

Same for this patch.

Yegor
