From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v4 3/6] ASoC: fsl_ssi: Save a dev reference
 for dev_err() purpose.
Date: Tue, 10 May 2016 09:34:02 -0700
Message-ID: <CAG5mAdy=g+MrWFP2DCZOkEU=1_ZYKWWUjY9aqAqQXXA8NtWcLQ@mail.gmail.com>
References: <1462277640-20052-1-git-send-email-arnaud.mouiche@invoxia.com>
 <1462277640-20052-4-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 338F3265E22
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:34:22 +0200 (CEST)
Received: by mail-oi0-f46.google.com with SMTP id k142so24614043oib.1
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 09:34:22 -0700 (PDT)
In-Reply-To: <1462277640-20052-4-git-send-email-arnaud.mouiche@invoxia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2016 at 5:13 AM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
> Most of functions only receive the ssi_private reference and don't have
> a knowledge of 'dev' pointer, even for debug purpose.
>
> Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 1a9d0ad..695f041 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -262,6 +262,7 @@ struct fsl_ssi_private {
>         struct fsl_ssi_dbg dbg_stats;
>
>         const struct fsl_ssi_soc_data *soc;
> +       struct device *dev;
>  };
>
>  /*
> @@ -1405,6 +1406,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
Tested-by: Caleb Crome <caleb@crome.org>
