From: Dong Aisheng <dong.aisheng@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: mxs-saif: Add MODULE_ALIAS
Date: Wed, 31 Oct 2012 16:51:28 +0800
Message-ID: <CAP1dx+x_OcbJPZECtBVf5awPrW_NUXhPXcp8w85iYF-i0b_Qvg@mail.gmail.com>
References: <1351653605-30512-1-git-send-email-festevam@gmail.com>
 <1351653605-30512-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BA7A32615FE
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 09:51:29 +0100 (CET)
Received: by mail-ia0-f179.google.com with SMTP id k25so813645iah.38
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 01:51:29 -0700 (PDT)
In-Reply-To: <1351653605-30512-2-git-send-email-festevam@gmail.com>
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

On 31 October 2012 11:20, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Add MODULE_ALIAS information.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/mxs/mxs-saif.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
> index 7c3154d..fe260c1 100644
> --- a/sound/soc/mxs/mxs-saif.c
> +++ b/sound/soc/mxs/mxs-saif.c
> @@ -804,3 +804,4 @@ module_platform_driver(mxs_saif_driver);
>  MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>  MODULE_DESCRIPTION("MXS ASoC SAIF driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxs-saif");
> --
> 1.7.9.5
>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
