From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH v3 1/2] ASoC: mxs-saif: Remove platform data
Date: Thu, 1 Nov 2012 18:08:55 +0800
Message-ID: <CAP1dx+zuQwY+-oMe1KAcKFEEnKt6Jr8OSaFYsEoJUFPKG=Qjwg@mail.gmail.com>
References: <1351698925-25530-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F0FE26171F
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 11:08:56 +0100 (CET)
Received: by mail-ia0-f179.google.com with SMTP id k25so1716662iah.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 03:08:55 -0700 (PDT)
In-Reply-To: <1351698925-25530-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 31 October 2012 23:55, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> All MXS users have been converted to device tree and the board files have been
> removed.
>
> No need to keep platform data in the driver.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Only one minor comment, otherwise,
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

> ---
> Changes since v2:
> - Also remove 'if (np)' as dt is the only probing mechanism.
> Changes since v1:
> - Also remove mxs_saif_platform_data and sound/saif.h, which was used only
> to include mxs_saif_platform_data definition.
>  include/sound/saif.h     |   16 ----------------
>  sound/soc/mxs/mxs-saif.c |   42 +++++++++++++++---------------------------
>  2 files changed, 15 insertions(+), 43 deletions(-)
>  delete mode 100644 include/sound/saif.h
>
> diff --git a/include/sound/saif.h b/include/sound/saif.h
> deleted file mode 100644
> index f22f3e1..0000000
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index aa037b2..ab5bdec 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -32,7 +32,6 @@
>  #include <sound/pcm.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> -#include <sound/saif.h>
>  #include <asm/mach-types.h>
>  #include <mach/hardware.h>
>  #include <mach/mxs.h>
> @@ -652,10 +651,9 @@ static int __devinit mxs_saif_probe(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         struct resource *iores, *dmares;
>         struct mxs_saif *saif;
> -       struct mxs_saif_platform_data *pdata;
>         struct pinctrl *pinctrl;
>         int ret = 0;
> -
> +       struct device_node *master;
>
>         if (!np && pdev->id >= ARRAY_SIZE(mxs_saif))

Can we also clean up this line?
It seems pdev->id checking is also needless after converting to dt only.

>                 return -EINVAL;

Regards
Dong Aisheng
