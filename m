From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: spdif: Add Vybird and LS1+
 compatibles support.
Date: Thu, 3 Apr 2014 11:46:11 -0300
Message-ID: <CAOMZO5DPbzK6_M=jzFGMKv1CFRd2xOYSEfyAUNi-XgKo17553Q@mail.gmail.com>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-5-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
 [74.125.82.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AC8C2655B6
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 16:46:12 +0200 (CEST)
Received: by mail-we0-f181.google.com with SMTP id q58so1942766wes.40
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 07:46:11 -0700 (PDT)
In-Reply-To: <1396516257-25354-5-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 3, 2014 at 6:10 AM, Xiubo Li <Li.Xiubo@freescale.com> wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  sound/soc/fsl/fsl_spdif.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 173553c..5c958ca 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1186,6 +1186,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>
>  static const struct of_device_id fsl_spdif_dt_ids[] = {
>         { .compatible = "fsl,imx35-spdif", },
> +       { .compatible = "fsl,vybird-spdif", },

I think you mean vybrid ;-)
