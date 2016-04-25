From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 3/6] ASoC: fsl_ssi: Save a dev reference
 for dev_err() purpose.
Date: Mon, 25 Apr 2016 10:21:48 -0700
Message-ID: <CAG5mAdyUQ9UjA2WBchZhBZnH_+ReFYUFAkvToAbXj=xHy7SLhA@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1453130771-24419-4-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7433F265789
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 19:22:08 +0200 (CEST)
Received: by mail-oi0-f47.google.com with SMTP id r78so183840825oie.0
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 10:22:08 -0700 (PDT)
In-Reply-To: <1453130771-24419-4-git-send-email-arnaud.mouiche@invoxia.com>
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

On Mon, Jan 18, 2016 at 7:26 AM, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
wrote:
>
> Most of functions only receive the ssi_private reference and don't have
> a knowledge of 'dev' pointer, even for debug purpose.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index dbd5f10..13613fd 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -275,6 +275,7 @@ struct fsl_ssi_private {
>         struct fsl_ssi_dbg dbg_stats;
>
>         const struct fsl_ssi_soc_data *soc;
> +       struct device *dev;
>  };
>
>  /*
> @@ -1412,6 +1413,7 @@ static int fsl_ssi_probe(struct platform_device
*pdev)
>         }
>
>         ssi_private->soc = of_id->data;
> +       ssi_private->dev = &pdev->dev;
>
>         sprop = of_get_property(np, "fsl,mode", NULL);
>         if (sprop) {
> --
> 1.9.1
>


Tested-By: Caleb Crome <caleb@crome.org>
Reviewed-"By: Caleb Crome <caleb@crome.org>
